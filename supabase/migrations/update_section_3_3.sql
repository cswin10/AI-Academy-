-- ============================================================================
-- UPDATE SECTION 3.3: Multi-Step Task Pipelines
-- ============================================================================
-- Run this in Supabase SQL Editor to update Section 3.3 content
-- Removes code blocks, uses capability tiers, connects to earlier sections
-- ============================================================================

-- First, rename the quiz
UPDATE quizzes
SET title = 'Multi-Step Task Pipelines Quiz'
WHERE title = 'Prompt Chaining Quiz';

-- Update the section title and content
UPDATE sections
SET
  title = 'Multi-Step Task Pipelines',
  content_markdown = '# Multi-Step Task Pipelines

Complex tasks often benefit from being broken into multiple LLM calls. Each step focuses on one thing, making the overall system more reliable, testable, and cost-effective.

## Why Chain Steps?

**Single-step approach:**
```
Take this raw data, clean it, analyze it, generate insights, create a summary, and format as a report.
```

This often fails because:
- Too many objectives compete for attention
- No way to validate intermediate results
- If one part fails, everything fails
- Cannot optimize or debug individual steps

**Multi-step approach:**
```
Step 1: Clean and structure the raw data
Step 2: Analyze the structured data
Step 3: Generate insights from analysis
Step 4: Format insights as report
```

Each step is focused, testable, and can use the appropriate tier.

## When to Chain vs Single Step

### Use Single Step When:
- Task is simple and focused
- All information fits comfortably in context
- Steps are tightly coupled and cannot be separated
- Latency is critical (each step adds latency)

### Use Chaining When:
- Task has distinct phases
- You need to validate intermediate results
- Different steps benefit from different capability tiers
- You want to debug and optimize steps independently
- Failure in one step should not corrupt the whole task

## Pipeline Patterns

### Pattern 1: Sequential Processing

Each step feeds the next.

```
Input → Step 1 → Step 2 → Step 3 → Output
```

**Example: Document Processing**
```
Raw document
  → Step 1: Extract facts (Fast/Cheap tier)
  → Step 2: Categorize facts (Fast/Cheap tier)
  → Step 3: Generate summary (Balanced tier)
  → Final summary
```

**Implementation notes:**
- Step 1 output becomes Step 2 input
- Validate output between steps
- If any step fails, retry before proceeding

### Pattern 2: Analyze Then Act

First understand, then decide, then execute.

```
Input → Understand → Decide → Execute → Output
```

**Example: Customer Support Automation**
```
Customer email
  → Step 1: Understand (what is the request? emotional state?)
  → Step 2: Classify (category, priority, sentiment)
  → Step 3: Generate response (appropriate tone and content)
  → Response ready for review
```

**Why this works:**
- Step 1 can focus entirely on comprehension
- Step 2 makes decisions based on clean analysis
- Step 3 crafts output informed by classification

### Pattern 3: Generate and Refine

Create draft, critique it, improve it.

```
Input → Generate Draft → Critique → Refine → Output
```

**Example: Content Creation**
```
Topic + requirements
  → Step 1: Write first draft
  → Step 2: Identify issues (clarity, accuracy, engagement)
  → Step 3: Rewrite addressing issues
  → Polished content
```

This is the self-critique pattern from Section 3.4, structured as a pipeline.

### Pattern 4: Parallel Analysis

Multiple analyses run simultaneously, then synthesize.

```
Input ─┬→ Analysis A ─┐
       ├→ Analysis B ─┼→ Synthesize → Output
       └→ Analysis C ─┘
```

**Example: Competitive Analysis**
```
Company to analyze
  → [Product analysis] + [Market analysis] + [Financial analysis] (parallel)
  → Synthesize into comprehensive report
  → Final competitive assessment
```

**Benefits:**
- Faster than sequential (parallel execution)
- Each analysis can be specialized
- Synthesis step combines perspectives

### Pattern 5: Branch and Converge

Different paths for different cases.

```
Input → Classify → Branch by type → [Path A | Path B | Path C] → Merge → Output
```

**Example: Support Ticket Processing**
```
Ticket
  → Classify type (Billing | Technical | General)
  → Route to specialized handler
    → Billing path: Check account, draft billing response
    → Technical path: Diagnose issue, draft technical response
    → General path: Standard response
  → Quality check
  → Final response
```

## Building Reliable Pipelines

### 1. Validate Between Steps

Do not blindly pass output to next step.

**Validation points:**
- After Step 1: Is output valid? Does it have expected structure?
- Before Step 2: Is input from Step 1 usable?
- After each step: Log output for debugging

**On validation failure:**
- Retry the step with stricter prompt
- If still failing, escalate or abort

### 2. Pass Context Forward

Each step needs enough context to do its job.

**Bad:**
```
Step 1: Analyze this document [document]
Step 2: Improve this: [step 1 output only]
```
Step 2 does not know the original goal.

**Good:**
```
Step 1: Analyze this document [document]
Step 2:
  Original document: [document]
  Goal: [original goal]
  Analysis from Step 1: [step 1 output]
  Task: Improve based on analysis while meeting goal
```

**Rule:** Each step should have access to original context, not just previous step output.

### 3. Handle Errors Gracefully

Steps will fail. Plan for it.

**Error handling per step:**
- Attempt the step
- On failure: retry with stricter prompt
- On second failure: retry with fallback approach
- On third failure: abort and escalate

**Circuit breaker:** If a step fails repeatedly across multiple inputs, stop processing and alert.

### 4. Log Everything

For debugging, you need visibility into each step.

**Log per step:**
- Step name
- Input (or input hash for large data)
- Output
- Duration
- Success/failure
- Retry count

**Log per pipeline run:**
- Pipeline ID
- Start/end time
- All step logs
- Final result
- Overall success/failure

## Cost Optimization

### Use Different Tiers Per Step

Not every step needs the same capability.

**Example: Report Generation Pipeline**
```
Step 1: Extract data (Fast/Cheap, deterministic task)
Step 2: Analyze patterns (Balanced, needs reasoning)
Step 3: Generate insights (Balanced, needs coherence)
Step 4: Format report (Fast/Cheap, structural task)
```

**Cost comparison:**
- All Balanced: 4 Balanced-tier calls
- Optimized: 2 Fast/Cheap + 2 Balanced = ~40% cheaper

### Cache Intermediate Results

If you run similar pipelines, cache steps that do not change.

**Cacheable:**
- Extraction from same document
- Classification of same text
- Static analysis results

**Not cacheable:**
- Results dependent on current context
- Steps with randomness/variation

### Parallelize Where Possible

Parallel steps reduce latency, not cost, but faster completion means better user experience.

**Can parallelize:**
- Independent analyses
- Multiple classifications
- Separate document processing

**Cannot parallelize:**
- Steps that depend on previous output
- Steps that share state

## Connecting to Earlier Sections

**From 2.1 (Capability Tiers):**
- Choose tier per step based on complexity
- Fast/Cheap for extraction/classification
- Balanced for reasoning/generation
- Deep Reasoning for complex synthesis (usually final step)

**From 2.2 (Task Templates):**
- Each step has its own task template
- Templates are versioned together as a pipeline
- Execution boundaries apply per step

**From 2.4 (System Instructions):**
- Each step can have different system instructions
- Operator metadata tracks pipeline and step
- Escalation can happen at any step

**From 2.5 (Cost Management):**
- Pipeline cost = sum of step costs
- Optimize most-called steps first
- Retries are hidden cost multipliers

**From 2.6 (Context Management):**
- Each step has its own context budget
- Pass summaries, not full history, between steps
- Large intermediate results can exceed context

## Common Mistakes

### 1. Over-Engineering Simple Tasks

Do not use 5 steps when 1 would work. Chaining adds latency and complexity.

**Before adding steps, ask:**
- Does this genuinely need separation?
- Will validation between steps catch errors?
- Do different steps need different tiers?

### 2. Losing Context Between Steps

Each step operates in isolation. If Step 3 needs information from the original input, you must pass it explicitly.

### 3. Ignoring Intermediate Failures

A failed step corrupts all following steps. Validate and handle errors at each step.

### 4. Using Expensive Tiers for Everything

Not every step needs maximum capability. Match tier to task complexity.

### 5. No Observability

Without logging, pipeline failures are invisible. You cannot optimize what you cannot see.

---

## Key Takeaways

1. **Chain when tasks have distinct phases**, not for simple focused tasks
2. **Five patterns**: Sequential, Analyze-then-Act, Generate-and-Refine, Parallel, Branch-and-Converge
3. **Validate between steps**, do not blindly pass output forward
4. **Pass context forward**, each step needs to understand the goal
5. **Handle errors per step**, retry then escalate
6. **Match tier to step complexity**, Fast/Cheap for extraction, Balanced for reasoning
7. **Cache intermediate results** when inputs repeat
8. **Parallelize independent steps** for lower latency
9. **Log everything**, visibility enables optimization
10. **Avoid over-engineering**, only chain when it genuinely helps',

  exercise_markdown = '## Exercise: Multi-Step Pipeline Design

Complete the interactive exercise below to design and optimize multi-step LLM pipelines.'

WHERE slug = 'prompt-chaining';

-- Update quiz questions
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz');

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 1,
'When should you use a multi-step pipeline instead of a single prompt?',
'["Always, pipelines are better", "When the task has distinct phases that benefit from focused processing and validation", "Never, single prompts are more efficient", "Only for very long documents"]',
1,
'Use pipelines when tasks have distinct phases, when you need to validate intermediate results, or when different steps benefit from different capability tiers.'),

((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 2,
'What is the main benefit of validating between pipeline steps?',
'["It uses more tokens", "Errors in one step can be caught before corrupting subsequent steps", "Validation is required by the API", "It makes the pipeline faster"]',
1,
'Validation between steps catches errors early. A failed step that goes unvalidated will corrupt all following steps with bad input.'),

((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 3,
'Why should you pass original context forward to later steps?',
'["To use more tokens", "Each step needs to understand the original goal, not just the previous step output", "Context is required by the API", "It is optional and rarely needed"]',
1,
'Later steps operating only on previous output may lose sight of the original goal. Pass original context so each step understands the full picture.'),

((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 4,
'Which capability tier should you typically use for extraction and classification steps?',
'["Deep Reasoning for accuracy", "Fast/Cheap, these are pattern matching tasks", "Always use the same tier for all steps", "The most expensive tier available"]',
1,
'Extraction and classification are pattern matching tasks that do not require complex reasoning. Fast/Cheap tier handles them reliably at lower cost.'),

((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 5,
'What is the Parallel Analysis pattern?',
'["Running steps one after another", "Running multiple independent analyses simultaneously, then synthesizing results", "Using multiple LLMs at once", "Repeating the same step multiple times"]',
1,
'Parallel Analysis runs independent analyses simultaneously (product analysis, market analysis, financial analysis), then synthesizes them into a combined result.'),

((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 6,
'How should you handle a step that fails after retries?',
'["Keep retrying indefinitely", "Abort the pipeline and escalate or use a fallback", "Ignore the failure and continue", "Failures cannot happen in pipelines"]',
1,
'After retry attempts fail, abort and escalate to human review or use a fallback. Continuing with failed output corrupts the entire pipeline.'),

((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 7,
'What should you log for each pipeline step?',
'["Nothing, logging is expensive", "Step name, input, output, duration, success/failure, retry count", "Only errors", "Only the final result"]',
1,
'Log step name, input (or hash), output, duration, success/failure, and retry count. This visibility enables debugging and optimization.'),

((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 8,
'When is caching intermediate results effective?',
'["Never, caching wastes memory", "When the same inputs produce the same outputs and inputs repeat across pipeline runs", "Always cache everything", "Only for the final step"]',
1,
'Cache intermediate results when inputs repeat (same document processed multiple times, same classification needed). Do not cache when results depend on variable context.');

-- Update exercise schema
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Pipeline Design",
      "description": "Design a multi-step pipeline for customer feedback processing.",
      "fields": [
        {
          "id": "pipeline_design",
          "type": "textarea",
          "label": "Design a pipeline to process customer feedback emails into actionable insights. Define each step:",
          "placeholder": "Pipeline: Customer Feedback Processor\\n\\nStep 1: Extract Information\\n  Input: Raw customer email\\n  Output: Structured extraction {sentiment, topics, specific_issues, customer_type}\\n  Tier: Fast/Cheap (extraction task)\\n  Prompt summary: Extract structured data from email\\n\\nStep 2: Classify Priority\\n  Input: Structured extraction from Step 1\\n  Output: Priority classification {priority: critical|high|medium|low, reasoning}\\n  Tier: Fast/Cheap (classification task)\\n  Prompt summary: Classify based on sentiment and issue severity\\n\\nStep 3: Generate Insights\\n  Input: Original email + extraction + classification\\n  Output: {key_insight, root_cause, recommended_action}\\n  Tier: Balanced (requires reasoning)\\n  Prompt summary: Analyze patterns and recommend actions\\n\\nStep 4: Draft Response\\n  Input: Original email + all previous outputs\\n  Output: Draft response matching tone and addressing issues\\n  Tier: Balanced (requires coherent generation)\\n  Prompt summary: Write appropriate response\\n\\nValidation points:\\n- After Step 1: Check extraction has all fields\\n- After Step 2: Check priority is valid enum\\n- After Step 3: Check insight is actionable\\n- After Step 4: Check response addresses original issues",
          "required": true,
          "rows": 36
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Step Prompts",
      "description": "Write the actual prompts for each step.",
      "fields": [
        {
          "id": "step_prompts",
          "type": "textarea",
          "label": "Write the prompts for Steps 1 and 2 (most critical steps):",
          "placeholder": "STEP 1 PROMPT: Extract Information\\n\\nExtract structured information from this customer email.\\n\\nOutput JSON with this schema:\\n{\\n  \"sentiment\": \"positive|negative|neutral|mixed\",\\n  \"topics\": [\"array of topics mentioned\"],\\n  \"specific_issues\": [\"array of specific problems reported\"],\\n  \"customer_type\": \"new|existing|enterprise|unknown\",\\n  \"urgency_signals\": [\"any urgency indicators\"]\\n}\\n\\nRules:\\n- Respond with ONLY valid JSON\\n- All arrays can be empty if no items found\\n- Be specific in issues, not generic\\n\\nEmail:\\n[EMAIL_CONTENT]\\n\\nJSON:\\n\\n---\\n\\nSTEP 2 PROMPT: Classify Priority\\n\\nBased on this extracted information, classify the priority.\\n\\nExtraction from Step 1:\\n[STEP_1_OUTPUT]\\n\\nClassify priority as:\\n- critical: Service down, data loss, security issue\\n- high: Major functionality broken, angry customer\\n- medium: Feature request, moderate issue\\n- low: Question, minor feedback\\n\\nOutput JSON:\\n{\\n  \"priority\": \"critical|high|medium|low\",\\n  \"reasoning\": \"brief explanation (max 50 chars)\"\\n}\\n\\nJSON:",
          "required": true,
          "rows": 40
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Validation Logic",
      "description": "Define validation between steps.",
      "fields": [
        {
          "id": "validation_logic",
          "type": "textarea",
          "label": "Write validation logic for each step transition:",
          "placeholder": "VALIDATION AFTER STEP 1 (before Step 2):\\n\\nfunction validateStep1Output(output) {\\n  errors = []\\n  \\n  // Parse check\\n  if not valid JSON: errors.push(\"INVALID_JSON\")\\n  \\n  // Required fields\\n  if output.sentiment not in [\"positive\", \"negative\", \"neutral\", \"mixed\"]:\\n    errors.push(\"INVALID_SENTIMENT\")\\n  \\n  if not isArray(output.topics): errors.push(\"TOPICS_NOT_ARRAY\")\\n  if not isArray(output.specific_issues): errors.push(\"ISSUES_NOT_ARRAY\")\\n  \\n  if output.customer_type not in [\"new\", \"existing\", \"enterprise\", \"unknown\"]:\\n    errors.push(\"INVALID_CUSTOMER_TYPE\")\\n  \\n  return errors\\n}\\n\\nVALIDATION AFTER STEP 2 (before Step 3):\\n\\nfunction validateStep2Output(output) {\\n  errors = []\\n  \\n  if not valid JSON: errors.push(\"INVALID_JSON\")\\n  \\n  if output.priority not in [\"critical\", \"high\", \"medium\", \"low\"]:\\n    errors.push(\"INVALID_PRIORITY\")\\n  \\n  if typeof output.reasoning != string or length(output.reasoning) > 50:\\n    errors.push(\"INVALID_REASONING\")\\n  \\n  return errors\\n}\\n\\n[Continue for Steps 3 and 4]",
          "required": true,
          "rows": 36
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Error Handling",
      "description": "Design error handling for pipeline failures.",
      "fields": [
        {
          "id": "error_handling",
          "type": "textarea",
          "label": "Define error handling strategy for each step:",
          "placeholder": "ERROR HANDLING STRATEGY:\\n\\nPer-Step Retry Logic:\\n\\nAttempt 1: Run with standard prompt\\n  → If validation passes: proceed to next step\\n  → If validation fails: go to Attempt 2\\n\\nAttempt 2: Run with stricter prompt\\n  Modifications: Add \"You MUST output valid JSON\" + show the validation error\\n  → If validation passes: proceed\\n  → If fails: go to Attempt 3\\n\\nAttempt 3: Run with example\\n  Modifications: Add concrete example of valid output\\n  → If validation passes: proceed\\n  → If fails: abort step\\n\\nStep Failure Escalation:\\n\\nStep 1 fails (extraction):\\n  → Cannot proceed without extraction\\n  → Return error: \"Unable to process email, routing to human review\"\\n  → Flag for human review\\n\\nStep 2 fails (classification):\\n  → Fallback: Use \"medium\" priority as default\\n  → Flag as \"auto-classified, needs review\"\\n  → Continue with fallback\\n\\nStep 3 fails (insights):\\n  → Fallback: Skip insights, proceed to response\\n  → Flag: \"Response generated without insights\"\\n\\nStep 4 fails (response):\\n  → Fallback: Use template response\\n  → Flag: \"Template response, personalization failed\"\\n\\nCircuit Breaker:\\n  If same step fails 5 times in 10 minutes: disable pipeline, alert on-call",
          "required": true,
          "rows": 40
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Cost Optimization",
      "description": "Optimize the pipeline for cost.",
      "fields": [
        {
          "id": "cost_optimization",
          "type": "textarea",
          "label": "Analyze and optimize the cost of your pipeline:",
          "placeholder": "COST ANALYSIS:\\n\\nPer-step token estimates:\\n\\nStep 1 (Extract): Fast/Cheap tier\\n  Input: ~300 tokens (email) + ~100 tokens (prompt)\\n  Output: ~100 tokens (JSON)\\n  Total: ~500 tokens at 1x cost\\n\\nStep 2 (Classify): Fast/Cheap tier\\n  Input: ~100 tokens (step 1 output) + ~100 tokens (prompt)\\n  Output: ~30 tokens (JSON)\\n  Total: ~230 tokens at 1x cost\\n\\nStep 3 (Insights): Balanced tier\\n  Input: ~300 tokens (original) + ~130 tokens (prev outputs) + ~100 tokens (prompt)\\n  Output: ~150 tokens\\n  Total: ~680 tokens at 15x cost = ~10,200 relative tokens\\n\\nStep 4 (Response): Balanced tier\\n  Input: ~300 tokens (original) + ~280 tokens (all outputs) + ~100 tokens (prompt)\\n  Output: ~200 tokens\\n  Total: ~880 tokens at 15x cost = ~13,200 relative tokens\\n\\nTotal per email: ~500 + ~230 + ~10,200 + ~13,200 = ~24,130 relative tokens\\n\\nOptimization opportunities:\\n1. Step 3 and 4 could potentially use Fast/Cheap if prompts are structured enough\\n   Savings: [calculate]\\n\\n2. Cache Step 1 extraction if same email is reprocessed\\n   Savings: ~500 tokens per cache hit\\n\\n3. Batch similar emails to share prompt tokens\\n   Savings: [estimate]\\n\\nMonthly cost at 10,000 emails:\\n  Before optimization: [calculate]\\n  After optimization: [calculate]\\n  Savings: [X]%",
          "required": true,
          "rows": 40
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: Testing the Pipeline",
      "description": "Test your pipeline with real examples.",
      "fields": [
        {
          "id": "pipeline_testing",
          "type": "textarea",
          "label": "Test your pipeline with these 3 emails. Document each step output:",
          "placeholder": "TEST 1: Negative feedback email\\nInput: \"Your product is terrible. Nothing works. I want a refund NOW.\"\\n\\nStep 1 output: [paste extraction result]\\nValidation: [pass/fail]\\n\\nStep 2 output: [paste classification]\\nValidation: [pass/fail]\\n\\nStep 3 output: [paste insights]\\nValidation: [pass/fail]\\n\\nStep 4 output: [paste response draft]\\nValidation: [pass/fail]\\n\\nFinal result: [summary]\\n\\n---\\n\\nTEST 2: Positive feedback email\\nInput: \"Love the new dashboard! Makes everything so much easier.\"\\n\\n[document all steps]\\n\\n---\\n\\nTEST 3: Mixed feedback email\\nInput: \"The product is great but onboarding was confusing. Took me 20 mins to figure out teams.\"\\n\\n[document all steps]\\n\\n---\\n\\nPipeline performance:\\n- Test 1: [success/failure, any issues]\\n- Test 2: [success/failure, any issues]\\n- Test 3: [success/failure, any issues]\\n\\nIssues identified:\\n- [list any problems found during testing]\\n\\nImprovements needed:\\n- [list fixes to implement]",
          "required": true,
          "rows": 50
        }
      ]
    }
  ],
  "deliverables": [
    "Complete pipeline design with 4 steps",
    "Prompts for Steps 1 and 2",
    "Validation logic for all step transitions",
    "Error handling with retry and fallback strategies",
    "Cost analysis with optimization opportunities",
    "Test results for 3 different email types"
  ],
  "success_criteria": [
    "Each step has clear input, output, and tier assignment",
    "Prompts request structured output with schema",
    "Validation catches invalid outputs before next step",
    "Error handling includes retries, fallbacks, and circuit breaker",
    "Cost analysis includes optimization opportunities",
    "Pipeline tested with varied inputs and issues documented"
  ]
}'::jsonb
WHERE slug = 'prompt-chaining';

-- Verify the update
SELECT slug, title,
       LENGTH(content_markdown) as content_length,
       exercise_schema IS NOT NULL as has_schema
FROM sections
WHERE slug = 'prompt-chaining';
