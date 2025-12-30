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

---

## Definitions

**Pipeline** means a sequence of LLM calls where outputs from earlier steps feed into later steps. Each step has a focused task, and the pipeline as a whole accomplishes something more complex than any single step could.

**Step contract** means the explicit definition of what a step accepts as input and what it produces as output. Contracts include data types, required fields, and validation criteria.

**Error compounding** means that small errors in early steps propagate and amplify through later steps. A slightly wrong extraction becomes a wrong classification becomes a wrong response.

---

## Why Chain Steps?

A single-step approach that asks the model to take raw data, clean it, analyze it, generate insights, create a summary, and format as a report often fails because too many objectives compete for attention, there is no way to validate intermediate results, if one part fails everything fails, and you cannot optimize or debug individual steps.

A multi-step approach separates these into focused steps: (1) clean and structure the raw data, (2) analyze the structured data, (3) generate insights from analysis, (4) format insights as report. Each step is focused, testable, and can use the appropriate capability tier.

---

## Step Contracts

Every step in a pipeline should have an explicit contract defining its input and output.

**Input contract**: What the step receives. Define the schema, required fields, and any preconditions. For example, Step 2 (classification) receives a JSON object with sentiment (string, one of positive/negative/neutral/mixed), topics (array of strings), and specific_issues (array of strings).

**Output contract**: What the step produces. Define the schema, required fields, and any guarantees. For example, Step 2 produces a JSON object with priority (string, one of critical/high/medium/low) and reasoning (string, max 50 characters).

**Validation at boundaries**: Check that input meets input contract before running the step. Check that output meets output contract before passing to next step. This catches errors at the source rather than letting them propagate.

Step contracts enable independent testing. You can test Step 2 with mocked inputs that match its input contract without running Step 1.

---

## Error Compounding in Chains

Errors in early steps compound through the chain. This is a fundamental risk of pipelines.

**Example**: In a feedback processing pipeline, Step 1 extracts sentiment as "neutral" when the customer is actually frustrated (extraction error). Step 2 sees "neutral" and classifies priority as "low" (correct given input, wrong given reality). Step 3 generates a generic response (appropriate for low priority). Step 4 sends the generic response to a frustrated customer (outcome: escalation).

The initial small error (sentiment misclassified) propagated through every subsequent step. By the end, the pipeline produced a confidently wrong result.

**Mitigations**:
- Validate aggressively between steps. Catch errors before they propagate.
- Include confidence scores. Low confidence in Step 1 should propagate as a warning.
- Pass original context forward. Later steps can sometimes catch earlier errors if they see the original input.
- Design for graceful degradation. If extraction confidence is low, flag for human review rather than proceeding automatically.

---

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

---

## Pipeline Patterns

### Pattern 1: Sequential Processing

Each step feeds the next. Input flows through Step 1 to Step 2 to Step 3 to Output.

Example for document processing: Raw document goes to Step 1 (extract facts, Fast/Cheap tier) then to Step 2 (categorize facts, Fast/Cheap tier) then to Step 3 (generate summary, Balanced tier) producing the final summary.

Implementation notes: Step 1 output becomes Step 2 input. Validate output between steps. If any step fails, retry before proceeding.

### Pattern 2: Analyze Then Act

First understand, then decide, then execute.

Example for customer support: Customer email goes to Step 1 (understand: what is the request, what is the emotional state) then to Step 2 (classify: category, priority, sentiment) then to Step 3 (generate response: appropriate tone and content) producing a response ready for review.

Why this works: Step 1 can focus entirely on comprehension. Step 2 makes decisions based on clean analysis. Step 3 crafts output informed by classification.

### Pattern 3: Generate and Refine

Create draft, critique it, improve it.

Example for content creation: Topic and requirements go to Step 1 (write first draft) then to Step 2 (identify issues: clarity, accuracy, engagement) then to Step 3 (rewrite addressing issues) producing polished content.

This is the self-critique pattern from Section 3.4, structured as a pipeline.

### Pattern 4: Parallel Analysis

Multiple analyses run simultaneously, then synthesize.

Example for competitive analysis: Company to analyze goes to parallel branches (product analysis, market analysis, financial analysis running simultaneously) then to a synthesis step that combines them into a comprehensive report.

Benefits: Faster than sequential (parallel execution). Each analysis can be specialized. Synthesis step combines perspectives.

### Pattern 5: Branch and Converge

Different paths for different cases.

Example for support ticket processing: Ticket goes to classification (Billing, Technical, or General) then routes to the specialized handler for that type. Each path has its own steps. All paths converge at a quality check before final response.

---

## Passing Context Forward

Each step needs enough context to do its job.

**Bad approach**: Step 2 receives only Step 1 output. It does not know the original goal.

**Good approach**: Step 2 receives the original input, the original goal, and the analysis from Step 1. Now it can perform its task with full context.

**Rule**: Each step should have access to original context, not just previous step output. This also helps catch error compounding because later steps can sometimes identify when earlier analysis contradicts the original input.

**Context envelope pattern**: Pass a consistent structure through the pipeline containing original_input, original_goal, and step_outputs (keyed by step name). Each step reads what it needs and adds its output to step_outputs.

---

## Idempotency and Caching

**Idempotent steps** produce the same output for the same input regardless of when or how many times they run. Extraction and classification are typically idempotent. Generation with temperature greater than zero is not idempotent.

**What can be cached**:
- Extraction from the same document (if document unchanged)
- Classification of the same text (if classification logic unchanged)
- Static analysis results
- Outputs from deterministic steps (temperature zero)

**What should not be cached**:
- Results dependent on current time or external state
- Steps with randomness or variation (temperature greater than zero)
- Outputs that must reflect current context or conversation state

**Cache key design**: Include the step version, input hash, and any relevant parameters. When you update a step prompt, increment the version to invalidate old cache entries.

**Partial pipeline runs**: If Step 1 output is cached, you can skip Step 1 and start from Step 2 with the cached result. This is especially valuable for reprocessing scenarios.

---

## Example: Three-Tier Pipeline

A pipeline that uses all three capability tiers appropriately:

**Step 1: Extract (Fast/Cheap tier)**
- Task: Pull structured data from raw input
- Why this tier: Extraction is pattern matching, no complex reasoning needed
- Input: Raw customer feedback email
- Output: JSON with sentiment, topics, issues, urgency_signals

**Step 2: Classify (Fast/Cheap tier)**
- Task: Categorize based on extracted data
- Why this tier: Classification from structured data is straightforward
- Input: Extraction from Step 1
- Output: JSON with priority level and category

**Step 3: Analyze (Balanced tier)**
- Task: Generate insights and root cause analysis
- Why this tier: Requires reasoning about patterns and implications
- Input: Original email, extraction, classification
- Output: JSON with key_insight, root_cause, recommended_action

**Step 4: Respond (Balanced tier)**
- Task: Draft appropriate response
- Why this tier: Requires coherent, contextual generation
- Input: All previous outputs plus original email
- Output: Draft response text

**Optional Step 5: Review (Deep Reasoning tier)**
- Task: Complex cases needing nuanced judgment
- When used: Only for high-priority or edge cases
- Why this tier: May need to reason about policy, precedent, or unusual situations

Cost optimization: Steps 1 and 2 use Fast/Cheap (roughly 1x cost). Steps 3 and 4 use Balanced (roughly 15x cost). Step 5 only runs for complex cases. This is more efficient than running everything through Balanced tier.

---

## Building Reliable Pipelines

### Validate Between Steps

Do not blindly pass output to next step.

Validation points: After Step 1, check if output is valid and has expected structure. Before Step 2, verify input from Step 1 is usable. After each step, log output for debugging.

On validation failure: Retry the step with stricter prompt. If still failing, escalate or abort.

### Handle Errors Gracefully

Steps will fail. Plan for it.

Error handling per step: Attempt the step. On failure, retry with stricter prompt. On second failure, retry with fallback approach. On third failure, abort and escalate.

Circuit breaker: If a step fails repeatedly across multiple inputs, stop processing and alert. This prevents wasting resources on a broken step.

### Log Everything

For debugging, you need visibility into each step.

Log per step: Step name, input (or input hash for large data), output, duration, success/failure, retry count.

Log per pipeline run: Pipeline ID, start/end time, all step logs, final result, overall success/failure.

---

## Cost Optimization

### Use Different Tiers Per Step

Not every step needs the same capability. Match tier to task complexity.

Example for report generation: Step 1 extracts data (Fast/Cheap, deterministic task). Step 2 analyzes patterns (Balanced, needs reasoning). Step 3 generates insights (Balanced, needs coherence). Step 4 formats report (Fast/Cheap, structural task).

Cost comparison: All Balanced tier would be 4 Balanced calls. Optimized mix is 2 Fast/Cheap plus 2 Balanced, roughly 40% cheaper.

### Cache Intermediate Results

If you run similar pipelines, cache steps that do not change. Extraction from the same document, classification of the same text, and static analysis results are all cacheable.

### Parallelize Where Possible

Parallel steps reduce latency (not cost). Independent analyses, multiple classifications, and separate document processing can all run in parallel. Steps that depend on previous output cannot parallelize.

---

## Common Mistakes

**Over-engineering simple tasks**: Do not use 5 steps when 1 would work. Chaining adds latency and complexity. Before adding steps, ask if this genuinely needs separation, whether validation between steps will catch errors, and whether different steps need different tiers.

**Losing context between steps**: Each step operates in isolation. If Step 3 needs information from the original input, you must pass it explicitly.

**Ignoring intermediate failures**: A failed step corrupts all following steps. Validate and handle errors at each step.

**Using expensive tiers for everything**: Not every step needs maximum capability. Match tier to task complexity.

**No observability**: Without logging, pipeline failures are invisible. You cannot optimize what you cannot see.

---

## Connecting to Earlier Sections

**From 2.1 (Capability Tiers):** Choose tier per step based on complexity. Fast/Cheap for extraction/classification. Balanced for reasoning/generation. Deep Reasoning for complex synthesis (usually final step).

**From 2.2 (Task Templates):** Each step has its own task template. Templates are versioned together as a pipeline. Execution boundaries apply per step.

**From 2.4 (System Instructions):** Each step can have different system instructions. Operator metadata tracks pipeline and step. Escalation can happen at any step.

**From 2.5 (Cost Management):** Pipeline cost equals sum of step costs. Optimize most-called steps first. Retries are hidden cost multipliers.

**From 2.6 (Context Management):** Each step has its own context budget. Pass summaries, not full history, between steps. Large intermediate results can exceed context.

---

## Key Takeaways

1. **Define step contracts**, explicit input/output schemas for each step
2. **Understand error compounding**, early errors amplify through the chain
3. **Chain when tasks have distinct phases**, not for simple focused tasks
4. **Pass context forward**, each step needs the original goal, not just previous output
5. **Validate between steps**, do not blindly pass output forward
6. **Design for idempotency**, cache steps that produce same output for same input
7. **Match tier to step complexity**, Fast/Cheap for extraction, Balanced for reasoning
8. **Handle errors per step**, retry then fallback then escalate
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
'What is a step contract?',
'["A legal agreement between steps", "The explicit definition of what a step accepts as input and produces as output", "A way to limit step execution time", "The cost of running a step"]',
1,
'A step contract defines the input schema, output schema, required fields, and validation criteria for a pipeline step. Contracts enable independent testing and catch errors at boundaries.'),

((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 2,
'What is error compounding in pipelines?',
'["Errors that count as multiple failures", "Small errors in early steps propagate and amplify through later steps", "Errors that compound interest costs", "Multiple errors in the same step"]',
1,
'Error compounding means a small mistake in Step 1 (like wrong sentiment extraction) leads to wrong decisions in Step 2, wrong actions in Step 3, and a confidently incorrect final result.'),

((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 3,
'Why should you pass original context to later steps, not just previous step output?',
'["To use more tokens", "Later steps can catch earlier errors and understand the original goal", "It is required by the API", "Context passing is optional"]',
1,
'Passing original context helps later steps understand the full goal and can sometimes catch when earlier analysis contradicts the original input, mitigating error compounding.'),

((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 4,
'Which steps are typically idempotent and cacheable?',
'["All steps are idempotent", "Extraction and classification steps with temperature zero", "Only the final step", "Steps with high temperature settings"]',
1,
'Extraction and classification are typically idempotent because the same input produces the same output. Steps with temperature greater than zero have randomness and should not be cached.'),

((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 5,
'Which capability tier should you use for extraction and classification steps?',
'["Deep Reasoning for accuracy", "Fast/Cheap tier, these are pattern matching tasks", "Always use the same tier for all steps", "The most expensive tier available"]',
1,
'Extraction and classification are pattern matching tasks that do not require complex reasoning. Fast/Cheap tier handles them reliably at lower cost.'),

((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 6,
'What should happen when validation fails between steps?',
'["Continue anyway and hope it works", "Retry with stricter prompt, then fallback approach, then escalate", "Immediately abort the entire pipeline", "Skip the failing step and continue"]',
1,
'On validation failure, retry with stricter prompt. On second failure, try a fallback approach. On third failure, abort and escalate. Never continue with invalid output.'),

((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 7,
'What is the Parallel Analysis pattern?',
'["Running steps one after another", "Running multiple independent analyses simultaneously, then synthesizing results", "Using multiple LLMs at once", "Repeating the same step multiple times"]',
1,
'Parallel Analysis runs independent analyses simultaneously (like product, market, and financial analysis), then synthesizes them into a combined result. This is faster than sequential.'),

((SELECT id FROM quizzes WHERE title = 'Multi-Step Task Pipelines Quiz'), 8,
'What should you include in a cache key for pipeline steps?',
'["Only the input", "Step version, input hash, and relevant parameters", "Just the timestamp", "The output only"]',
1,
'Include step version (to invalidate when prompt changes), input hash (to match same inputs), and relevant parameters. This ensures cache hits only when appropriate.');

-- Update exercise schema
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Step Contracts",
      "description": "Define explicit contracts for each step in a feedback processing pipeline.",
      "fields": [
        {
          "id": "step_contracts",
          "type": "textarea",
          "label": "Define input and output contracts for a 4-step feedback processing pipeline:",
          "placeholder": "STEP 1: Extract Information\n\nInput Contract:\n  - raw_email: string (the customer email text)\n  - Preconditions: non-empty string\n\nOutput Contract:\n  - sentiment: string, one of [positive, negative, neutral, mixed]\n  - topics: array of strings (may be empty)\n  - specific_issues: array of strings (may be empty)\n  - urgency_signals: array of strings (may be empty)\n  - Guarantees: all fields present, valid enum for sentiment\n\nValidation:\n  - Parse as JSON\n  - Check sentiment in allowed values\n  - Check all arrays are arrays (not strings or null)\n\n---\n\nSTEP 2: Classify Priority\n\nInput Contract:\n  - extraction: object matching Step 1 output contract\n  - Preconditions: extraction passed Step 1 validation\n\nOutput Contract:\n  - priority: string, one of [critical, high, medium, low]\n  - reasoning: string, max 50 characters\n  - Guarantees: valid enum for priority, reasoning within length limit\n\n[Continue for Steps 3 and 4]",
          "required": true,
          "rows": 40
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Error Compounding Analysis",
      "description": "Trace how an error in Step 1 would propagate through your pipeline.",
      "fields": [
        {
          "id": "error_trace",
          "type": "textarea",
          "label": "Trace an error scenario: Step 1 incorrectly extracts sentiment as \"neutral\" when the customer is actually angry. Show how this compounds:",
          "placeholder": "ERROR COMPOUNDING TRACE:\n\nOriginal input: \"This is absolutely unacceptable! I have been waiting for 3 weeks and still no response. I am going to cancel my subscription and tell everyone I know.\"\n\nStep 1 Error:\n  Correct extraction: sentiment = negative, urgency_signals = [\"waiting 3 weeks\", \"cancel subscription\"]\n  Actual extraction: sentiment = neutral, urgency_signals = []\n  Why it happened: Model focused on informational content, missed emotional language\n\nStep 2 Propagation:\n  Input received: sentiment = neutral, no urgency signals\n  Logic applied: neutral + no urgency = routine inquiry\n  Output: priority = low\n  Correct output would have been: priority = critical (cancellation threat)\n\nStep 3 Propagation:\n  Input received: priority = low\n  Logic applied: low priority = standard analysis\n  Output: generic insights about \"customer inquiry\"\n  Missing: retention risk, urgency, emotional context\n\nStep 4 Propagation:\n  Input received: low priority, generic insights\n  Logic applied: low priority = template response\n  Output: \"Thank you for your feedback. We will review your inquiry.\"\n  Correct response: Immediate escalation, personalized apology, retention offer\n\nFinal outcome:\n  Customer receives dismissive template response\n  Customer follows through on cancellation threat\n  Company loses customer + negative word of mouth\n\nMitigations that could have helped:\n1. [describe mitigation]\n2. [describe mitigation]\n3. [describe mitigation]",
          "required": true,
          "rows": 40
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Context Envelope Design",
      "description": "Design the context structure passed through your pipeline.",
      "fields": [
        {
          "id": "context_envelope",
          "type": "textarea",
          "label": "Design a context envelope that passes original context and step outputs through the pipeline:",
          "placeholder": "CONTEXT ENVELOPE STRUCTURE:\n\nenvelope = {\n  \"original\": {\n    \"input\": \"[the raw customer email]\",\n    \"goal\": \"Process feedback and generate appropriate response\",\n    \"received_at\": \"[timestamp]\",\n    \"customer_id\": \"[if known]\"\n  },\n  \"step_outputs\": {\n    \"extraction\": null,     // filled after Step 1\n    \"classification\": null, // filled after Step 2\n    \"analysis\": null,       // filled after Step 3\n    \"response\": null        // filled after Step 4\n  },\n  \"metadata\": {\n    \"pipeline_id\": \"[unique run ID]\",\n    \"pipeline_version\": \"v2.1\",\n    \"started_at\": \"[timestamp]\",\n    \"current_step\": 1\n  },\n  \"flags\": {\n    \"low_confidence\": false,\n    \"needs_human_review\": false,\n    \"error_occurred\": false\n  }\n}\n\nHow each step uses the envelope:\n\nStep 1:\n  Reads: envelope.original.input\n  Writes: envelope.step_outputs.extraction\n\nStep 2:\n  Reads: envelope.step_outputs.extraction\n  Writes: envelope.step_outputs.classification\n\nStep 3:\n  Reads: envelope.original.input (for full context)\n         envelope.step_outputs.extraction\n         envelope.step_outputs.classification\n  Writes: envelope.step_outputs.analysis\n  Note: Can flag if analysis contradicts original input\n\nStep 4:\n  Reads: all of envelope.original and envelope.step_outputs\n  Writes: envelope.step_outputs.response",
          "required": true,
          "rows": 40
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Idempotency and Caching",
      "description": "Design caching strategy for your pipeline.",
      "fields": [
        {
          "id": "caching_strategy",
          "type": "textarea",
          "label": "Identify which steps can be cached and design cache keys:",
          "placeholder": "CACHING ANALYSIS:\n\nStep 1 (Extraction):\n  Idempotent: Yes (same email always extracts same data)\n  Cacheable: Yes\n  Cache key: hash(step_version + email_text)\n  TTL: 24 hours (or until step prompt changes)\n  Invalidation: When step version changes\n\nStep 2 (Classification):\n  Idempotent: Yes (same extraction always classifies same way)\n  Cacheable: Yes\n  Cache key: hash(step_version + extraction_json)\n  TTL: 24 hours\n  Invalidation: When classification logic changes\n\nStep 3 (Analysis):\n  Idempotent: Depends on temperature setting\n  Cacheable: Only if temperature = 0\n  Cache key: hash(step_version + original_input + extraction + classification)\n  TTL: 24 hours\n  Note: May want variation for different analyses, so caching less valuable\n\nStep 4 (Response):\n  Idempotent: No (responses should feel fresh)\n  Cacheable: No\n  Reason: Want variation in responses, personalization matters\n\nPartial pipeline runs:\n  Scenario: Same email reprocessed after Step 1 prompt update\n  Action: Use cached extraction from v1, but re-run with v2 prompt\n  \nCache key format:\n  pipeline:v{version}:step{N}:{input_hash}\n  Example: pipeline:v2:step1:abc123def456",
          "required": true,
          "rows": 36
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Tier Assignment",
      "description": "Assign capability tiers to each step with justification.",
      "fields": [
        {
          "id": "tier_assignment",
          "type": "textarea",
          "label": "Assign capability tiers to each step and calculate cost comparison:",
          "placeholder": "TIER ASSIGNMENT:\n\nStep 1: Extract Information\n  Tier: Fast/Cheap\n  Justification: Extraction is pattern matching. The task is to identify sentiment keywords, topic mentions, and issue descriptions. No complex reasoning required.\n  Cost factor: 1x\n\nStep 2: Classify Priority\n  Tier: Fast/Cheap\n  Justification: Classification from structured data is rule-like. Given sentiment = negative and urgency_signals present, priority = high. Simple decision tree.\n  Cost factor: 1x\n\nStep 3: Analyze and Generate Insights\n  Tier: Balanced\n  Justification: Requires synthesizing information, identifying root causes, and generating actionable recommendations. This needs reasoning capability.\n  Cost factor: 15x\n\nStep 4: Draft Response\n  Tier: Balanced\n  Justification: Requires coherent, contextual generation with appropriate tone. Must address specific issues while maintaining professionalism.\n  Cost factor: 15x\n\nCOST COMPARISON:\n\nAll Balanced approach:\n  4 steps × Balanced tier = 4 × 15x = 60x relative cost\n\nOptimized approach:\n  2 steps × Fast/Cheap (1x) + 2 steps × Balanced (15x)\n  = 2x + 30x = 32x relative cost\n\nSavings: (60 - 32) / 60 = 47% cost reduction\n\nAt 10,000 emails/month:\n  [Calculate actual dollar amounts based on your pricing]",
          "required": true,
          "rows": 36
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: Full Pipeline Test",
      "description": "Test your complete pipeline design.",
      "fields": [
        {
          "id": "pipeline_test",
          "type": "textarea",
          "label": "Trace a real example through your pipeline with all steps, contracts, and context envelope:",
          "placeholder": "FULL PIPELINE TRACE:\n\nInput email: \"I love your product but the mobile app keeps crashing. Already reinstalled twice. Need this fixed for my presentation tomorrow.\"\n\nInitial envelope:\n  original.input: [email text]\n  original.goal: \"Process feedback and generate appropriate response\"\n  step_outputs: all null\n  flags: all false\n\nSTEP 1: Extract\n  Tier: Fast/Cheap\n  Input: envelope.original.input\n  Output: {\n    \"sentiment\": \"mixed\",\n    \"topics\": [\"mobile app\", \"crashes\"],\n    \"specific_issues\": [\"app crashing\", \"reinstalled twice without fix\"],\n    \"urgency_signals\": [\"presentation tomorrow\"]\n  }\n  Validation: PASS (all fields present, valid values)\n  Envelope updated: step_outputs.extraction = [output]\n\nSTEP 2: Classify\n  Tier: Fast/Cheap\n  Input: envelope.step_outputs.extraction\n  Output: {\n    \"priority\": \"high\",\n    \"reasoning\": \"Technical issue with deadline urgency\"\n  }\n  Validation: PASS\n  Envelope updated: step_outputs.classification = [output]\n\nSTEP 3: Analyze\n  Tier: Balanced\n  Input: envelope.original + envelope.step_outputs\n  Output: {\n    \"key_insight\": \"Positive user frustrated by recurring technical issue\",\n    \"root_cause\": \"Mobile app stability problem affecting loyal users\",\n    \"recommended_action\": \"Expedite technical support, offer workaround\"\n  }\n  Validation: PASS\n  Envelope updated: step_outputs.analysis = [output]\n\nSTEP 4: Respond\n  Tier: Balanced\n  Input: full envelope\n  Output: [Draft response acknowledging issue, providing immediate workaround for presentation, promising priority fix]\n  Validation: PASS\n  Envelope updated: step_outputs.response = [output]\n\nFinal result: Response ready for review\nTotal cost: 2x + 15x + 15x = 32x relative units\nTotal latency: [estimate based on your setup]",
          "required": true,
          "rows": 50
        }
      ]
    }
  ],
  "deliverables": [
    "Step contracts for all 4 steps with input/output schemas",
    "Error compounding trace showing propagation and mitigations",
    "Context envelope design with passing strategy",
    "Caching analysis with idempotency assessment per step",
    "Tier assignment with cost comparison",
    "Full pipeline trace with real example"
  ],
  "success_criteria": [
    "Each step has explicit input and output contracts",
    "Error compounding scenario identifies realistic propagation path",
    "Context envelope includes original input accessible to all steps",
    "Caching strategy correctly identifies idempotent steps",
    "Tier assignments match task complexity with justification",
    "Full trace demonstrates all concepts working together"
  ]
}'::jsonb
WHERE slug = 'prompt-chaining';

-- Verify the update
SELECT slug, title,
       LENGTH(content_markdown) as content_length,
       exercise_schema IS NOT NULL as has_schema
FROM sections
WHERE slug = 'prompt-chaining';
