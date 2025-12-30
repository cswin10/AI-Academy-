-- ============================================================================
-- UPDATE SECTION 2.5: Model Selection & Cost Management
-- ============================================================================
-- Run this in Supabase SQL Editor to update Section 2.5 content
-- Uses capability tiers instead of specific model names
-- Removes specific prices (go stale), uses relative costs
-- ============================================================================

-- First, rename the quiz
UPDATE quizzes
SET title = 'Model Selection & Routing Quiz'
WHERE title = 'Model Selection Quiz';

-- Update the section title and content
UPDATE sections
SET
  title = 'Model Selection & Cost Management',
  content_markdown = '# Model Selection & Cost Management

Not every task needs maximum capability. Operators match models to tasks, manage costs, and build systems that route intelligently.

## Capability Tiers (Not Model Names)

From Section 2.1, we use **capability tiers** instead of specific model names. Model SKUs change; capabilities are stable.

| Tier | Characteristics | Use Cases |
|------|-----------------|-----------|
| **Fast/Cheap** | Low latency, low cost, good for patterns | Classification, extraction, format conversion |
| **Balanced** | Good reasoning, moderate cost | Most operator work, code generation, drafting |
| **Deep Reasoning** | Extended thinking, highest capability | Architecture, complex debugging, high-stakes decisions |

**Check current pricing before you productionize.** Exact costs vary by provider and change over time.

## The Cost Equation

LLM APIs charge per token (roughly 4 characters = 1 token).

```
Total Cost = (Input Tokens × Input Price) + (Output Tokens × Output Price)
```

**Relative costs (order of magnitude):**

| Tier | Relative Input Cost | Relative Output Cost |
|------|---------------------|----------------------|
| Fast/Cheap | 1x (baseline) | 1x |
| Balanced | 10-20x | 10-20x |
| Deep Reasoning | 50-100x+ | 50-100x+ |

**Example:** If Fast/Cheap costs $0.10 per 1M tokens, Balanced might cost $2, and Deep Reasoning might cost $10+.

> Always verify current pricing with your provider. These ratios are approximate.

## Model Selection Framework

### Match Capability to Task Complexity

| Task Type | Tier | Why |
|-----------|------|-----|
| Classification (hot/warm/cold) | Fast/Cheap | Pattern matching, no reasoning needed |
| Simple extraction (order number) | Fast/Cheap | Regex-like, deterministic |
| Format conversion (CSV → JSON) | Fast/Cheap | Structural transformation |
| Email drafting | Balanced | Needs coherence, context |
| Code generation | Balanced | Needs correctness, patterns |
| Architecture design | Deep Reasoning | Many interacting tradeoffs |
| Debugging complex issues | Deep Reasoning | Needs exploration, verification |

### The Decision Rule

**Use the cheapest tier that reliably completes the task.**

"Reliably" means:
- Passes your test cases (from Section 2.3)
- Meets your confidence thresholds (from Section 2.1)
- Stays within execution boundary constraints (from Section 2.2)

## Cost Optimization Strategies

### 1. Right-Size Your Models

Audit every API integration:

```
For each task:
□ What tier is currently used?
□ What tier is actually needed?
□ Have we tested with a cheaper tier?
□ What is the quality difference?
```

**Common over-provisioning:**
- Using Balanced tier for classification
- Using Deep Reasoning for simple drafting
- Using any LLM for regex-possible extraction

### 2. Optimize Input Length

Shorter inputs = lower costs.

**Before (wasteful):**
```
Hello AI assistant, I would like to ask for your help
with something. I need you to please take a look at
this customer inquiry and classify it into one of
several categories. The categories are as follows:
the first category is "Hot Lead" which means...
[500+ tokens of explanation]
```

**After (efficient):**
```
Classify as Hot/Warm/Cold/Unqualified.

Hot: Decision maker, budget, urgency
Warm: Interest, no timeline
Cold: Research phase
Unqualified: Wrong fit

Inquiry: [paste]
```

Same accuracy, ~80% fewer tokens.

### 3. Optimize Output Length

Set `max_tokens` to prevent runaway generation:

```javascript
{
  model: "balanced-tier-model",
  max_tokens: 100,  // Classification needs ~20 tokens
  messages: [...]
}
```

For classification, you need the label and maybe one sentence. Not 500 words.

### 4. Use Prompt Caching

If your system instructions are large and static, caching reduces costs dramatically.

**Without caching:** Pay for system prompt on every call
**With caching:** Pay once, reuse across calls

```
1000 calls with 2000-token system prompt:
- Without cache: 2M input tokens
- With cache: ~200k tokens (90% reduction)
```

Check if your provider supports prompt caching. Most do for production use.

### 5. Batch When Possible

Instead of 1000 individual API calls:

```
Option A: 1000 calls × overhead = high latency + cost
Option B: 50 batches × 20 items = lower overhead
```

Batching works when:
- Items are independent
- Combined input fits in context
- Latency is acceptable

### 6. Cache Responses

For deterministic tasks, cache outputs:

```
Input: "Classify: [exact text]"
→ Check cache first
→ If hit: return cached response (free)
→ If miss: call API, cache result
```

Works well for:
- Repeated queries
- Reference data enrichment
- Static document processing

## Model Routing

Production systems often route dynamically based on task characteristics.

### Simple Routing

```
IF task_type == "classification":
    use Fast/Cheap tier
ELSE IF task_type == "drafting":
    use Balanced tier
ELSE IF task_type == "architecture":
    use Deep Reasoning tier
```

### Confidence-Based Routing

From Section 2.1: use confidence to trigger escalation.

```
Step 1: Try Fast/Cheap tier
Step 2: Check confidence score

IF confidence >= 85%:
    return response
ELSE IF confidence >= 60%:
    retry with Balanced tier
ELSE:
    escalate to Deep Reasoning or human
```

This captures most requests cheaply while ensuring quality for edge cases.

### Complexity-Based Routing

Estimate complexity before choosing tier:

```
Complexity signals:
- Input length (long = harder)
- Domain specificity (technical = harder)
- Ambiguity (unclear = harder)
- Stakes (high-risk = use better tier)

Route based on estimated complexity.
```

## Latency Considerations

Cost isn''t the only factor. Latency matters for user experience.

| Tier | Typical Latency | When Latency Matters |
|------|-----------------|----------------------|
| Fast/Cheap | 100-500ms | Real-time chat, live UI |
| Balanced | 500ms-2s | Interactive applications |
| Deep Reasoning | 2-30s+ | Background processing, async |

**Trade-off:** Cheaper models are often faster. Deep Reasoning is slow.

For real-time applications:
- Start with Fast/Cheap tier
- Use confidence routing to escalate
- Accept that some requests take longer

## Testing Before Switching

Never switch tiers without testing. From Section 2.3:

```
Before downgrading tier:

1. Run your test matrix on new tier
2. Compare quality metrics
3. Check edge case handling
4. Verify confidence calibration
5. Measure any quality degradation

If quality drops > acceptable threshold:
    stay with current tier
Else:
    deploy with monitoring
```

## Cost Monitoring

### What to Track

```
PER TASK TYPE:
- Model tier used
- Average input tokens
- Average output tokens
- Cost per request
- Requests per day/week/month
- Total cost per period

PER SYSTEM:
- Total API spend
- Cost by tier
- Cost by task type
- Cost trend over time
```

### Alert Thresholds

```
ALERT WHEN:
- Daily spend > budget × 1.5
- Single task type > 50% of total cost
- Cost per request > expected × 2
- Tier usage doesn''t match task complexity
```

### Monthly Review

```
REVIEW MONTHLY:
□ Which tasks cost the most?
□ Are we using appropriate tiers?
□ Can any tasks be downgraded?
□ Are prompts optimized?
□ Is caching being used?
□ What''s the cost trend?
```

## When to Use Expensive Tiers

Sometimes higher tiers are worth it:

**High-value output:**
- Designing systems worth $10k+
- Strategic analysis driving decisions
- Code that will be used for years

**High-risk tasks:**
- Anything affecting money
- Security-sensitive analysis
- Compliance-relevant processing

**Cost-benefit rule:**
```
If (model_cost < time_saved × hourly_rate):
    use the better model

If (model_cost < error_cost × error_probability):
    use the better model
```

## Connecting to Earlier Sections

Model selection integrates with everything:

**From 2.1 (Capability Tiers):**
- Use tier framework, not model names
- Apply confidence thresholds
- Implement fallback patterns

**From 2.2 (Task Templates):**
- Template specifies acceptable tiers
- Execution boundary affects tier choice
- Higher-risk boundaries → higher tiers

**From 2.3 (Structured Reasoning):**
- Deep Reasoning tier for complex analysis
- Test before switching tiers
- Verify quality with test matrix

**From 2.4 (System Instructions):**
- Log model tier in operator metadata
- Alert on unexpected tier usage
- Include tier in versioning

## Key Takeaways

1. **Use capability tiers** - Not model names (they change)
2. **Use cheapest tier that works** - Test to verify
3. **Optimize inputs and outputs** - Fewer tokens = lower cost
4. **Cache aggressively** - Prompts and responses
5. **Route dynamically** - Based on task type, complexity, confidence
6. **Consider latency** - Not just cost
7. **Test before switching** - Quality must be verified
8. **Monitor continuously** - Track spend by task type
9. **Review monthly** - Identify optimization opportunities
10. **Splurge when justified** - High value or high risk = higher tier',

  exercise_markdown = '## Exercise: Model Selection & Cost Optimization

Complete the interactive exercise below to practice model selection and cost management.'

WHERE slug = 'model-selection';

-- Update quiz questions
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz');

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz'), 1,
'Why should you use capability tiers instead of specific model names?',
'["Model names are harder to remember", "Model SKUs change but capability tiers are stable", "Tiers are cheaper", "There is no difference"]',
1,
'Model names and versions change frequently. Capability tiers (Fast/Cheap, Balanced, Deep Reasoning) describe what you need and remain stable over time.'),

((SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz'), 2,
'What is the main cost driver for LLM API usage?',
'["Number of API calls only", "Tokens processed (input + output)", "Time of day", "Your geographic location"]',
1,
'LLM APIs charge based on tokens processed - both what you send (input) and what the model generates (output).'),

((SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz'), 3,
'What tier should you use for simple classification tasks like hot/warm/cold lead scoring?',
'["Deep Reasoning - classification is important", "Balanced - safe middle ground", "Fast/Cheap - pattern matching does not need complex reasoning", "Alternate between all three"]',
2,
'Classification is pattern matching. Fast/Cheap tier handles it reliably at a fraction of the cost.'),

((SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz'), 4,
'What is confidence-based routing?',
'["Always using the most confident model", "Starting cheap, escalating to higher tiers if confidence is low", "Routing based on user confidence", "A way to avoid API calls"]',
1,
'Confidence-based routing tries Fast/Cheap first, then escalates to Balanced or Deep Reasoning if confidence is below threshold. This captures most requests cheaply.'),

((SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz'), 5,
'What should you do BEFORE switching from a higher tier to a lower tier?',
'["Just switch and monitor", "Run your test matrix on the new tier and verify quality", "Ask the vendor", "Nothing - cheaper is always better"]',
1,
'Always test before switching tiers. Run your test matrix, compare quality metrics, and verify edge case handling before deploying.'),

((SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz'), 6,
'What is prompt caching?',
'["Storing prompts in a database for backup", "Reusing large unchanging prompt parts to reduce input token costs", "Making prompts shorter", "A way to speed up responses"]',
1,
'Prompt caching lets you pay once for large system prompts and reuse them across many calls, dramatically reducing input token costs.'),

((SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz'), 7,
'When is it justified to use an expensive Deep Reasoning tier?',
'["Always - quality matters", "Never - it is too expensive", "For high-value or high-risk tasks where the cost of errors exceeds model cost", "Only for coding tasks"]',
2,
'Use expensive tiers when the value of the output is high (strategic decisions, complex architecture) or when errors are costly (financial, security, compliance).'),

((SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz'), 8,
'What should you track for cost monitoring?',
'["Only total monthly spend", "Model tier, tokens, cost per request, cost by task type, trends", "Just the number of API calls", "Only errors"]',
1,
'Effective cost monitoring tracks tier usage, token counts, cost per request, cost by task type, and trends over time to identify optimization opportunities.');

-- Update exercise schema
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Tier Selection Practice",
      "description": "Match tasks to appropriate capability tiers.",
      "fields": [
        {
          "id": "tier_matching",
          "type": "textarea",
          "label": "For each task, choose the appropriate tier (Fast/Cheap, Balanced, Deep Reasoning) and explain why:",
          "placeholder": "1. Classify 5000 emails/month as Support/Sales/Billing\\n   Tier: Fast/Cheap\\n   Why: Pattern matching, no complex reasoning needed\\n\\n2. Design a multi-system automation architecture\\n   Tier: [?]\\n   Why: [?]\\n\\n3. Extract order numbers from confirmation emails (50k/month)\\n   Tier: [?]\\n   Why: [?]\\n\\n4. Write an authentication system for a SaaS app\\n   Tier: [?]\\n   Why: [?]\\n\\n5. Convert CSV rows to JSON (100k/month)\\n   Tier: [?]\\n   Why: [?]",
          "required": true,
          "rows": 15
        },
        {
          "id": "over_provisioning",
          "type": "textarea",
          "label": "Identify a common over-provisioning mistake and explain why it wastes money:",
          "placeholder": "Common mistake: Using [tier] for [task type]\\nWhy this wastes money: [explanation]\\nCorrect tier: [tier]\\nCost difference: [rough estimate]",
          "required": true,
          "rows": 5
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Prompt Optimization",
      "description": "Optimize a bloated prompt for efficiency.",
      "fields": [
        {
          "id": "original_analysis",
          "type": "textarea",
          "label": "Analyze this bloated prompt - what makes it wasteful?\n\n\"Hello AI assistant, I would like to ask for your help with something. I need you to please take a look at this customer inquiry that I am going to provide to you below and I need you to classify it into one of several categories. The categories are as follows: the first category is Hot Lead which means the customer is very interested and ready to buy soon, the second category is Warm Lead which means they are interested but need more time, the third category is Cold Lead which means they are just browsing, and the fourth category is Not Qualified which means they are not a good fit. Please analyze carefully and provide your classification.\"",
          "placeholder": "Problems with this prompt:\\n1. [Issue]\\n2. [Issue]\\n3. [Issue]\\n\\nEstimated token count: ~[X] tokens",
          "required": true,
          "rows": 6
        },
        {
          "id": "optimized_prompt",
          "type": "textarea",
          "label": "Write an optimized version of the prompt:",
          "placeholder": "Classify as Hot/Warm/Cold/Unqualified.\\n\\nHot: [criteria]\\nWarm: [criteria]\\nCold: [criteria]\\nUnqualified: [criteria]\\n\\nInquiry: {input}",
          "required": true,
          "rows": 8
        },
        {
          "id": "token_savings",
          "type": "textarea",
          "label": "Estimate the token savings:",
          "placeholder": "Original: ~[X] tokens\\nOptimized: ~[X] tokens\\nSavings: ~[X]% reduction\\n\\nAt 10,000 requests/month, this saves approximately: [calculation]",
          "required": true,
          "rows": 4
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Routing Strategy",
      "description": "Design a model routing strategy.",
      "fields": [
        {
          "id": "routing_scenario",
          "type": "textarea",
          "label": "Design a confidence-based routing strategy for a customer support system:",
          "placeholder": "Step 1: Try [tier] first\\n\\nStep 2: Check confidence score\\n  IF confidence >= [X]%: return response\\n  ELSE IF confidence >= [Y]%: [action]\\n  ELSE: [action]\\n\\nRationale: [why these thresholds]",
          "required": true,
          "rows": 8
        },
        {
          "id": "routing_benefits",
          "type": "textarea",
          "label": "What percentage of requests do you expect each tier to handle? What are the cost implications?",
          "placeholder": "Expected distribution:\\n- Fast/Cheap: [X]% of requests\\n- Balanced: [X]% of requests\\n- Deep Reasoning: [X]% of requests\\n\\nCost comparison:\\n- All Balanced: [baseline]\\n- With routing: [estimated savings]",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Cost Calculation",
      "description": "Calculate and compare costs for a real scenario.",
      "fields": [
        {
          "id": "scenario_setup",
          "type": "textarea",
          "label": "Define a use case with volume estimates:",
          "placeholder": "Use case: [description]\\nMonthly volume: [X] requests\\nAverage input: [X] tokens\\nAverage output: [X] tokens\\nSystem prompt: [X] tokens",
          "required": true,
          "rows": 5
        },
        {
          "id": "cost_comparison",
          "type": "textarea",
          "label": "Calculate relative monthly costs for three approaches:",
          "placeholder": "Approach A: All Deep Reasoning tier\\n  Input tokens: [calculation]\\n  Output tokens: [calculation]\\n  Relative cost: [X] units\\n\\nApproach B: All Balanced tier\\n  Relative cost: [X] units\\n\\nApproach C: Optimized (right tier + caching + routing)\\n  Relative cost: [X] units\\n\\nSavings A→C: [X]%",
          "required": true,
          "rows": 12
        },
        {
          "id": "optimization_plan",
          "type": "textarea",
          "label": "List specific optimizations you would apply:",
          "placeholder": "1. Tier selection: Use [tier] because [reason]\\n2. Prompt optimization: Reduce from [X] to [Y] tokens by [how]\\n3. Caching: Cache [what] to save [estimate]\\n4. Output limiting: Set max_tokens to [X] because [reason]\\n5. Routing: Implement [strategy] to handle [X]% cheaply",
          "required": true,
          "rows": 8
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Monitoring Setup",
      "description": "Design cost monitoring for production.",
      "fields": [
        {
          "id": "metrics_definition",
          "type": "textarea",
          "label": "Define the metrics you would track for cost monitoring:",
          "placeholder": "PER REQUEST:\\n- [metric 1]\\n- [metric 2]\\n\\nPER TASK TYPE:\\n- [metric 1]\\n- [metric 2]\\n\\nPER SYSTEM:\\n- [metric 1]\\n- [metric 2]",
          "required": true,
          "rows": 8
        },
        {
          "id": "alert_thresholds",
          "type": "textarea",
          "label": "Define alert thresholds for your use case:",
          "placeholder": "ALERT WHEN:\\n- Daily spend exceeds: $[X] (reason: [budget context])\\n- Cost per request exceeds: $[X] (reason: [expected baseline])\\n- [Additional alert]\\n- [Additional alert]",
          "required": true,
          "rows": 6
        },
        {
          "id": "review_checklist",
          "type": "textarea",
          "label": "Create a monthly cost review checklist:",
          "placeholder": "MONTHLY REVIEW:\\n□ Total spend vs budget: [how to check]\\n□ Tier usage appropriateness: [how to verify]\\n□ Prompt optimization opportunities: [how to identify]\\n□ Caching effectiveness: [how to measure]\\n□ [Additional check]",
          "required": true,
          "rows": 7
        }
      ]
    }
  ],
  "deliverables": [
    "Matched tasks to appropriate capability tiers with reasoning",
    "Optimized a bloated prompt with measurable token savings",
    "Designed a confidence-based routing strategy",
    "Calculated relative costs for multiple approaches",
    "Created monitoring setup with metrics and alerts"
  ],
  "success_criteria": [
    "Tier selections are justified by task complexity",
    "Optimized prompt is at least 50% shorter",
    "Routing strategy includes confidence thresholds",
    "Cost calculations show clear optimization path",
    "Monitoring includes per-request and system-level metrics"
  ]
}'::jsonb
WHERE slug = 'model-selection';

-- Verify the update
SELECT slug, title,
       LENGTH(content_markdown) as content_length,
       exercise_schema IS NOT NULL as has_schema
FROM sections
WHERE slug = 'model-selection';
