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

**Capability tiers differ not just in reasoning power, but in latency, determinism, and tolerance for ambiguity.**

- Fast/Cheap models are often more deterministic and predictable
- Deep Reasoning models can be more verbose and less predictable
- This is why cheaper models are often *better* for structured tasks

**Check current pricing before you productionize.** Exact costs vary by provider and change over time.

## The Cost Equation

LLM APIs charge per token (roughly 4 characters = 1 token).

```
Total Cost = (Input Tokens x Input Price) + (Output Tokens x Output Price)
```

**Relative costs (order of magnitude):**

| Tier | Relative Input Cost | Relative Output Cost |
|------|---------------------|----------------------|
| Fast/Cheap | 1x (baseline) | 1x |
| Balanced | 10-20x | 10-20x |
| Deep Reasoning | 50-100x+ | 50-100x+ |

**Example:** If Fast/Cheap costs $0.10 per 1M tokens, Balanced might cost $2, and Deep Reasoning might cost $10+.

> Always verify current pricing with your provider. These ratios are approximate.

### Hidden Cost Multipliers

Your actual bill is often higher than napkin math suggests. Watch for:

- **Large system prompts repeated on every call** (use caching)
- **Retry logic on failures** (each retry costs tokens)
- **Long-tail edge cases escalating to higher tiers** (monitor escalation rate)
- **Streaming vs non-streaming responses** (same tokens, different pricing on some providers)
- **Development and testing calls** (they add up)

Build these into your cost estimates.

## Model Selection Framework

### Match Capability to Task Complexity

| Task Type | Tier | Why |
|-----------|------|-----|
| Classification (hot/warm/cold) | Fast/Cheap | Pattern matching, no reasoning needed |
| Simple extraction (order number) | Fast/Cheap | Regex-like, deterministic |
| Format conversion (CSV to JSON) | Fast/Cheap | Structural transformation |
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
[] What tier is currently used?
[] What tier is actually needed?
[] Have we tested with a cheaper tier?
[] What is the quality difference?
```

**Common over-provisioning:**
- Using Balanced tier for classification
- Using Deep Reasoning for simple drafting
- Using any LLM for regex-possible extraction

### 2. Optimize Input Length

Shorter inputs = lower costs. But structure matters more than compression.

**The biggest token savings usually come from better structure, not shorter wording:**
- Bullet definitions instead of prose
- Fixed schemas instead of freeform
- Removing conversational fluff

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
Option A: 1000 calls x overhead = high latency + cost
Option B: 50 batches x 20 items = lower overhead
```

Batching works when:
- Items are independent
- Combined input fits in context
- Latency is acceptable

### 6. Cache Responses

For deterministic tasks, cache outputs:

```
Input: "Classify: [exact text]"
-> Check cache first
-> If hit: return cached response (free)
-> If miss: call API, cache result
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

### Escalation Guardrails

**Never auto-escalate repeatedly.** Add circuit breakers:

```
IF escalation_count >= 2:
    route to human review
    do not try another tier

This prevents:
- Infinite escalation loops
- Runaway costs on edge cases
- Delays from repeated retries
```

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

Cost is not the only factor. Latency matters for user experience.

| Tier | Typical Latency | When Latency Matters |
|------|-----------------|----------------------|
| Fast/Cheap | 100-500ms | Real-time chat, live UI |
| Balanced | 500ms-2s | Interactive applications |
| Deep Reasoning | 2-30s+ | Background processing, async |

**Trade-off:** Cheaper models are often faster. Deep Reasoning is slow.

**Deep Reasoning tiers should almost always be async or background jobs, not blocking user flows.** Users will not wait 30 seconds for a response in a chat interface.

For real-time applications:
- Start with Fast/Cheap tier
- Use confidence routing to escalate
- Accept that some requests take longer
- Move slow operations to background queues

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
- Cost per successful outcome

PER SYSTEM:
- Total API spend
- Cost by tier
- Cost by task type
- Cost trend over time
- Escalation rate
```

**Cost per successful outcome** is the metric that matters most. It reframes cost from "API spend" to "business value delivered."

Example: If you spend $100 on lead classification and correctly classify 9,500 of 10,000 leads, your cost per successful classification is ~$0.01.

### Alert Thresholds

```
ALERT WHEN:
- Daily spend > budget x 1.5
- Single task type > 50% of total cost
- Cost per request > expected x 2
- Tier usage does not match task complexity
- Escalation rate > 20% (routing not working)
- Cost per successful outcome increasing
```

### Monthly Review

```
REVIEW MONTHLY:
[] Which tasks cost the most?
[] Are we using appropriate tiers?
[] Can any tasks be downgraded?
[] Are prompts optimized?
[] Is caching being used?
[] What is the cost trend?
[] What is the cost per successful outcome trend?
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
If (model_cost < time_saved x hourly_rate):
    use the better model

If (model_cost < error_cost x error_probability):
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
- Higher-risk boundaries mean higher tiers

**From 2.3 (Structured Reasoning):**
- Deep Reasoning tier for complex analysis
- Test before switching tiers
- Verify quality with test matrix

**From 2.4 (System Instructions):**
- Log model tier in operator metadata
- Alert on unexpected tier usage
- Include tier in versioning

---

## The 80/20 Model Cost Playbook

Memorise this. Apply it to every system.

```
1. Start everything on Fast/Cheap tier
2. Add confidence scoring to outputs
3. Escalate only on low confidence (not by default)
4. Cache everything static (prompts and responses)
5. Cap output tokens aggressively
6. Set escalation circuit breakers (max 2 escalations)
7. Review costs monthly by task type
8. Only use Deep Reasoning when error cost > model cost
```

Most systems can run 80%+ of requests on Fast/Cheap tier if you build proper routing and caching.

---

## Key Takeaways

1. **Use capability tiers**, not model names (they change)
2. **Tiers differ in determinism and latency**, not just intelligence
3. **Use the cheapest tier that works**, test to verify
4. **Structure beats compression** for token savings
5. **Cache aggressively**, prompts and responses
6. **Route dynamically** with confidence thresholds
7. **Add escalation guardrails**, never escalate repeatedly
8. **Deep Reasoning should be async**, not blocking UI
9. **Track cost per successful outcome**, not just spend
10. **Review monthly**, identify optimization opportunities',

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
'Besides reasoning power, how else do capability tiers differ?',
'["Only in price", "In latency, determinism, and tolerance for ambiguity", "They do not differ in other ways", "Only in context window size"]',
1,
'Fast/Cheap models are often more deterministic and predictable. Deep Reasoning models can be more verbose and less predictable. This is why cheaper models are often better for structured tasks.'),

((SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz'), 3,
'What is the main cost driver for LLM API usage?',
'["Number of API calls only", "Tokens processed (input + output)", "Time of day", "Your geographic location"]',
1,
'LLM APIs charge based on tokens processed, both what you send (input) and what the model generates (output).'),

((SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz'), 4,
'What tier should you use for simple classification tasks like hot/warm/cold lead scoring?',
'["Deep Reasoning, classification is important", "Balanced, safe middle ground", "Fast/Cheap, pattern matching does not need complex reasoning", "Alternate between all three"]',
2,
'Classification is pattern matching. Fast/Cheap tier handles it reliably at a fraction of the cost, and is often more deterministic.'),

((SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz'), 5,
'What should happen if a request escalates twice through your routing system?',
'["Escalate to an even higher tier", "Route to human review and stop escalating", "Keep retrying until it works", "Return an error"]',
1,
'Never auto-escalate repeatedly. If a request escalates twice, route to human review. This prevents infinite loops and runaway costs.'),

((SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz'), 6,
'Where should Deep Reasoning tier tasks typically run?',
'["In the main user request flow", "As async or background jobs, not blocking user flows", "Only during off-peak hours", "Never in production"]',
1,
'Deep Reasoning tiers can take 2-30+ seconds. They should almost always be async or background jobs, not blocking user interfaces.'),

((SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz'), 7,
'What metric reframes cost from API spend to business value?',
'["Cost per request", "Total monthly spend", "Cost per successful outcome", "Tokens per request"]',
2,
'Cost per successful outcome measures what you actually pay for results delivered, not just API calls made. This is the metric that matters most.'),

((SELECT id FROM quizzes WHERE title = 'Model Selection & Routing Quiz'), 8,
'What gives the biggest token savings in prompt optimization?',
'["Using shorter words", "Better structure: bullets, schemas, removing fluff", "Removing all examples", "Using abbreviations"]',
1,
'The biggest token savings come from better structure, not shorter wording. Bullet definitions, fixed schemas, and removing conversational fluff are more effective than compression.');

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
          "placeholder": "1. Classify 5000 emails/month as Support/Sales/Billing\\n   Tier: Fast/Cheap\\n   Why: Pattern matching, deterministic, no complex reasoning\\n\\n2. Design a multi-system automation architecture\\n   Tier: [?]\\n   Why: [?]\\n\\n3. Extract order numbers from confirmation emails (50k/month)\\n   Tier: [?]\\n   Why: [?]\\n\\n4. Write an authentication system for a SaaS app\\n   Tier: [?]\\n   Why: [?]\\n\\n5. Convert CSV rows to JSON (100k/month)\\n   Tier: [?]\\n   Why: [?]",
          "required": true,
          "rows": 15
        },
        {
          "id": "tier_characteristics",
          "type": "textarea",
          "label": "Explain why Fast/Cheap models are often BETTER (not just cheaper) for structured tasks:",
          "placeholder": "Fast/Cheap models are better for structured tasks because...\\n- Determinism: ...\\n- Predictability: ...\\n- Latency: ...",
          "required": true,
          "rows": 5
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Prompt Optimization",
      "description": "Optimize a bloated prompt using structure, not just compression.",
      "fields": [
        {
          "id": "original_analysis",
          "type": "textarea",
          "label": "Analyze this bloated prompt. What structural problems waste tokens?\\n\\n\"Hello AI assistant, I would like to ask for your help with something. I need you to please take a look at this customer inquiry that I am going to provide to you below and I need you to classify it into one of several categories. The categories are as follows: the first category is Hot Lead which means the customer is very interested and ready to buy soon, the second category is Warm Lead which means they are interested but need more time, the third category is Cold Lead which means they are just browsing, and the fourth category is Not Qualified which means they are not a good fit. Please analyze carefully and provide your classification.\"",
          "placeholder": "Structural problems:\\n1. Conversational fluff: [examples]\\n2. Prose instead of bullets: [examples]\\n3. No fixed schema: [impact]\\n\\nEstimated token count: ~[X] tokens",
          "required": true,
          "rows": 6
        },
        {
          "id": "optimized_prompt",
          "type": "textarea",
          "label": "Write an optimized version using better STRUCTURE (bullets, schema, no fluff):",
          "placeholder": "Classify as Hot/Warm/Cold/Unqualified.\\n\\nHot: [criteria]\\nWarm: [criteria]\\nCold: [criteria]\\nUnqualified: [criteria]\\n\\nInquiry: {input}\\n\\nRespond with: {classification}: {one sentence reason}",
          "required": true,
          "rows": 8
        },
        {
          "id": "token_savings",
          "type": "textarea",
          "label": "Estimate the token savings:",
          "placeholder": "Original: ~[X] tokens\\nOptimized: ~[X] tokens\\nSavings: ~[X]% reduction\\n\\nAt 10,000 requests/month with Fast/Cheap tier, this saves approximately: [calculation]",
          "required": true,
          "rows": 4
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Routing Strategy with Guardrails",
      "description": "Design a routing strategy with proper escalation limits.",
      "fields": [
        {
          "id": "routing_scenario",
          "type": "textarea",
          "label": "Design a confidence-based routing strategy WITH escalation guardrails:",
          "placeholder": "Step 1: Try Fast/Cheap tier\\n\\nStep 2: Check confidence score\\n  IF confidence >= 85%: return response\\n  ELSE IF confidence >= 60%: escalate to Balanced, increment escalation_count\\n  ELSE: escalate to Deep Reasoning, increment escalation_count\\n\\nStep 3: Guardrail\\n  IF escalation_count >= 2: route to human, stop escalating\\n\\nRationale: [why these thresholds and guardrails]",
          "required": true,
          "rows": 12
        },
        {
          "id": "routing_benefits",
          "type": "textarea",
          "label": "What percentage of requests do you expect each tier to handle? Include human escalation:",
          "placeholder": "Expected distribution:\\n- Fast/Cheap: [X]% of requests\\n- Balanced: [X]% of requests\\n- Deep Reasoning: [X]% of requests\\n- Human review: [X]% of requests\\n\\nCost comparison:\\n- All Balanced: [baseline]\\n- With routing + guardrails: [estimated savings]",
          "required": true,
          "rows": 8
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Cost Calculation with Hidden Multipliers",
      "description": "Calculate costs including hidden multipliers.",
      "fields": [
        {
          "id": "scenario_setup",
          "type": "textarea",
          "label": "Define a use case with volume estimates:",
          "placeholder": "Use case: [description]\\nMonthly volume: [X] requests\\nAverage input: [X] tokens\\nAverage output: [X] tokens\\nSystem prompt: [X] tokens\\nExpected retry rate: [X]%\\nExpected escalation rate: [X]%",
          "required": true,
          "rows": 7
        },
        {
          "id": "cost_comparison",
          "type": "textarea",
          "label": "Calculate relative monthly costs INCLUDING hidden multipliers:",
          "placeholder": "Approach A: All Balanced tier (no optimization)\\n  Base tokens: [calculation]\\n  + System prompt repeated: [calculation]\\n  + Retries: [calculation]\\n  Relative cost: [X] units\\n\\nApproach B: Optimized (Fast/Cheap + caching + routing)\\n  Base tokens: [calculation]\\n  + Cached prompts: [calculation]\\n  + Escalations to Balanced: [calculation]\\n  Relative cost: [X] units\\n\\nSavings: [X]%",
          "required": true,
          "rows": 14
        },
        {
          "id": "cost_per_outcome",
          "type": "textarea",
          "label": "Calculate cost per successful outcome:",
          "placeholder": "Total monthly cost: [X] units\\nExpected successful outcomes: [X]\\nCost per successful outcome: [X] units\\n\\nWhat would make this number go up? [factors]\\nWhat would make this number go down? [optimizations]",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: The 80/20 Playbook Application",
      "description": "Apply the 80/20 playbook to a real system.",
      "fields": [
        {
          "id": "playbook_application",
          "type": "textarea",
          "label": "Take a system you are building or planning. Apply each step of the 80/20 playbook:",
          "placeholder": "System: [description]\\n\\n1. Start on Fast/Cheap: [how this applies]\\n2. Add confidence scoring: [implementation plan]\\n3. Escalate only on low confidence: [threshold and logic]\\n4. Cache everything static: [what to cache]\\n5. Cap output tokens: [max_tokens setting]\\n6. Escalation circuit breaker: [max escalations before human]\\n7. Monthly review plan: [what to check]\\n8. Deep Reasoning criteria: [when error cost > model cost]",
          "required": true,
          "rows": 16
        },
        {
          "id": "expected_distribution",
          "type": "textarea",
          "label": "After applying the playbook, what tier distribution do you expect?",
          "placeholder": "Expected distribution:\\n- Fast/Cheap: [X]% (target: 80%+)\\n- Balanced: [X]%\\n- Deep Reasoning: [X]%\\n- Human: [X]%\\n\\nIf Fast/Cheap < 80%, what would need to change?",
          "required": true,
          "rows": 6
        }
      ]
    }
  ],
  "deliverables": [
    "Matched tasks to tiers with understanding of determinism benefits",
    "Optimized prompt using structure, not just compression",
    "Designed routing strategy with escalation guardrails",
    "Calculated costs including hidden multipliers",
    "Applied 80/20 playbook to a real system"
  ],
  "success_criteria": [
    "Tier selections consider determinism and latency, not just cost",
    "Optimized prompt uses bullets and schemas, at least 50% shorter",
    "Routing includes max escalation limit (circuit breaker)",
    "Cost calculations include retries and escalations",
    "80/20 playbook application targets 80%+ on Fast/Cheap tier"
  ]
}'::jsonb
WHERE slug = 'model-selection';

-- Verify the update
SELECT slug, title,
       LENGTH(content_markdown) as content_length,
       exercise_schema IS NOT NULL as has_schema
FROM sections
WHERE slug = 'model-selection';
