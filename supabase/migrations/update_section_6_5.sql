-- ============================================================================
-- UPDATE SECTION 6.5: Optimization & Performance
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, remove any existing questions 5-8 to allow clean re-runs, then add 4 more to reach 8 total
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Optimization Quiz')
AND order_index IN (5, 6, 7, 8);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Optimization Quiz'), 5,
'How does I-T-O thinking from Module 2 help with optimization?',
'["I-T-O is unrelated to optimization", "I-T-O helps identify which transformations are bottlenecks and which outputs can be cached or batched", "Only the output layer matters for optimization", "I-T-O slows down optimization"]',
1,
'I-T-O breaks down each step so you can identify expensive transformations (slow API calls, heavy AI processing) and optimize specific parts of the chain.'),

((SELECT id FROM quizzes WHERE title = 'Optimization Quiz'), 6,
'How do capability tiers from Module 3 apply to AI optimization?',
'["Use the most powerful model for everything", "Match model tier to task complexity: Fast/Cheap for extraction, Balanced for analysis, Deep Reasoning only when required", "Capability tiers only apply to non-AI tasks", "Always use the cheapest model"]',
1,
'Right-sizing AI means using Fast/Cheap models for simple extraction, Balanced models for moderate analysis, and reserving expensive Deep Reasoning models for complex tasks.'),

((SELECT id FROM quizzes WHERE title = 'Optimization Quiz'), 7,
'What is the relationship between the 4-layer model and performance bottlenecks?',
'["The 4-layer model does not help with performance", "Each layer can have bottlenecks: slow triggers, inefficient logic, expensive execution, or delayed outputs", "Only the execution layer matters for performance", "The trigger layer is always the bottleneck"]',
1,
'Bottlenecks can occur at any layer. Polling triggers create trigger layer delays, complex conditions slow the logic layer, API calls slow execution, and synchronous outputs delay completion.'),

((SELECT id FROM quizzes WHERE title = 'Optimization Quiz'), 8,
'What is the 80/20 rule as applied to optimization?',
'["Optimize 80% of your code", "80% of performance problems come from 20% of the code, so focus optimization efforts on the critical few bottlenecks", "Spend 80% of time optimizing", "20% improvement is good enough"]',
1,
'The Pareto principle applies to performance: a small number of operations typically cause most of the delay or cost. Find those bottlenecks first.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Optimization & Performance

**This is how automations scale.**

A working automation is not necessarily a good automation. Good automations run fast, cost little, and scale smoothly. Optimization is about making your automations better without changing what they do. This section connects directly to Module 2''s I-T-O framework and Module 3''s capability tiers for AI right-sizing.

## Definitions

**Optimization**: The process of making an automation faster, cheaper, or more reliable without changing its core functionality.

**Bottleneck**: The slowest or most expensive step that limits overall system performance. Optimizing anything other than the bottleneck has minimal impact.

**Latency**: The time from trigger firing to automation completion. Lower latency means faster response to events.

**Throughput**: The number of operations an automation can process in a given time period. Higher throughput means handling more volume.

**Caching**: Storing computed results so subsequent requests for the same data can be served without recomputing.

**Batching**: Grouping multiple operations into a single request to reduce overhead and improve efficiency.

**Parallel Execution**: Running independent operations simultaneously rather than sequentially.

**Right-Sizing**: Matching resource allocation (including AI model tier) to actual task requirements.

**Premature Optimization**: Optimizing before understanding where the actual problems are. Always measure first.

## Why Optimize?

**Cost Reduction**

Fewer API calls mean lower platform costs. Less compute time means lower processing costs. Efficient prompts using appropriate capability tiers from Module 3 mean lower AI costs. A 50% reduction in AI costs can save thousands monthly at scale.

**Speed Improvement**

Faster processing means better user experience. Quicker responses mean happier customers. Reduced latency means higher throughput. An automation that takes 2 seconds instead of 30 seconds feels instantaneous.

**Reliability Enhancement**

Simpler automations have fewer failure points. Less strain on systems means less likely to hit rate limits. Efficient use of resources provides headroom for spikes.

**Scalability**

Handle more volume with the same resources. Grow without proportional cost increase. Avoid expensive redesigns as you scale.

## The Optimization Mindset

### Rule 1: Measure First

Do not guess where the problems are. Measure actual performance before optimizing.

Before optimizing any automation, follow this sequence: First, measure current performance for each step. Second, identify the slowest or most expensive parts. Third, calculate the potential impact of improving each part. Fourth, focus optimization efforts on the highest-impact opportunities.

You might be optimizing the wrong thing. A step that feels slow might only take 200 milliseconds while another step quietly takes 5 seconds.

### Rule 2: Optimize the Bottleneck

The slowest step limits overall speed. Using I-T-O thinking from Module 2, identify which part of the Input-Transform-Output chain is the constraint.

Consider this workflow timing example: Step 1 takes 0.5 seconds, Step 2 takes 0.5 seconds, Step 3 takes 10 seconds (this is the bottleneck), Step 4 takes 0.5 seconds, Step 5 takes 0.5 seconds. Total time is 12 seconds.

If you optimize Step 1 from 0.5 seconds to 0.1 seconds, the new total is 11.6 seconds. That is barely better because the bottleneck still controls the flow.

If you optimize Step 3 from 10 seconds to 2 seconds, the new total is 4 seconds. That is a 67% improvement because you addressed the actual bottleneck.

### Rule 3: Good Enough is Good Enough

Know when to stop optimizing. Stop when the cost savings are less than the optimization effort cost. Stop when performance is already meeting requirements. Stop when further optimization would add significant complexity. Stop when reliability might suffer.

An automation that runs in 3 seconds instead of 2 seconds is rarely worth another week of optimization work.

## Optimization Order

Optimize in this sequence for maximum impact with minimum wasted effort.

**First: Make it work.** An automation that does not function correctly cannot be optimized. Fix bugs and handle errors before thinking about performance.

**Second: Make it right.** Clean up the design. Ensure clarity and maintainability. An optimized mess is still a mess.

**Third: Make it fast.** Only now optimize for speed. You understand what the automation does and can measure accurately.

**Fourth: Make it cheap.** With a working, well-designed, fast automation, reduce costs. Right-size AI tiers, consolidate API calls, eliminate waste.

**Fifth: Make it scale.** Prepare for growth. Add caching, batching, and parallel execution for volume that does not exist yet only when you have evidence it will.

Skipping steps costs more time overall. Optimizing broken code means re-optimizing after fixing. Optimizing messy code means fighting the design while tuning.

## Cost as a Metric

Cost is a performance metric. Treat it with the same rigor as speed.

**Measure cost per operation.** Know exactly what each automation run costs. Platform fees, API calls, AI tokens, storage, compute. Sum them.

**Set cost budgets.** Just like you have latency targets, set cost targets. "This automation should cost less than $0.05 per run."

**Alert on cost anomalies.** A sudden 10x cost increase is a bug. Detect it like you would detect an error spike.

**Include cost in optimization decisions.** A 2x speed improvement that costs 5x more is rarely worth it. A 50% cost reduction that adds 1 second latency might be.

**Track cost trends.** Monthly cost for each automation. Cost per thousand operations. Cost as percentage of value generated.

## What to Measure

### Execution Time

Measure per-step timing to identify bottlenecks. Example breakdown: Get data takes 200 milliseconds, validate takes 50 milliseconds, API call takes 1500 milliseconds (this is slow and needs attention), transform takes 100 milliseconds, save takes 300 milliseconds. Total is 2150 milliseconds, with the API call consuming 70% of the time.

Also measure end-to-end latency from trigger to completion, including any queue wait time.

### Cost Metrics

Track per-operation costs across all resources. Example calculation: Each workflow run costs 0.01 dollars for the platform, 0.005 dollars for API calls, and 0.02 dollars for AI tokens. Total per run is 0.035 dollars. At 1000 daily runs, that is 35 dollars per day or approximately 1000 dollars per month.

Use Module 3''s capability tiers to right-size AI costs. A task using a Deep Reasoning tier at 0.03 dollars per call might work equally well with a Fast/Cheap tier at 0.001 dollars per call.

### Throughput

Track operations per time period. Example: Current throughput is 100 items per hour. After optimization, throughput is 400 items per hour. That is a 4x improvement without adding resources.

### Error Rate

Track failures per operations. Example: Before optimization, 5 failures per 100 runs equals a 5% error rate. After optimization, 1 failure per 100 runs equals a 1% error rate. Often, optimization also improves reliability.

## Optimization Strategies

### Strategy 1: Parallel Execution

Run independent operations simultaneously instead of sequentially. This applies I-T-O thinking: if operations do not share inputs or dependencies, they can run in parallel.

Sequential example (slow): Get CRM data takes 500 milliseconds, then get Email data takes 400 milliseconds, then get Slack data takes 300 milliseconds, then process takes 100 milliseconds. Total is 1300 milliseconds.

Parallel example (fast): Get CRM data, get Email data, and get Slack data all run simultaneously. The slowest takes 500 milliseconds. Then process takes 100 milliseconds. Total is 600 milliseconds. That is 54% faster.

When to parallelize: Operations do not depend on each other. Order does not matter for correctness. Your platform supports parallel execution.

### Strategy 2: Batch Processing

Process multiple items together instead of one at a time. This connects to Module 2''s execution layer optimization.

Individual processing (slow): For each of 100 items, make an API call to create a record. That is 100 API calls at 200 milliseconds each, totaling 20 seconds.

Batched processing (fast): Collect 100 items and make one API call to create all of them. That is 1 API call at 500 milliseconds. That is 40x faster.

Batch opportunities include database inserts and updates, API calls that support bulk operations, file operations, and notifications.

### Strategy 3: Caching

Store results to avoid recomputing or refetching. This is especially valuable for repeated lookups in the logic layer.

Without caching: User A requests company info, triggering an API call taking 500 milliseconds. User B requests the same company info, triggering another API call taking 500 milliseconds. User C requests the same company info, triggering a third API call taking 500 milliseconds. Total is 1500 milliseconds.

With caching: User A requests company info, triggering an API call taking 500 milliseconds, and the result is cached. User B requests company info and gets a cache hit in 10 milliseconds. User C requests company info and gets a cache hit in 10 milliseconds. Total is 520 milliseconds. That is 65% faster.

When to cache: Data does not change frequently. Same data is requested multiple times. Fetching is expensive in time or cost.

Cache considerations include how long before data goes stale, how much memory or storage is needed for the cache, and how to invalidate when source data changes.

### Strategy 4: Reduce API Calls

Every API call has overhead. Minimize calls by consolidating requests.

Request all fields at once. Instead of making three separate calls for name, email, and company, make one call requesting all three fields together.

Use bulk endpoints. Instead of making three separate calls for contacts 1, 2, and 3, make one call requesting all three contacts by their IDs.

### Strategy 5: Optimize AI Usage

AI calls are often the most expensive part. Apply Module 3''s capability tiers for right-sizing.

Use cheaper models for simple tasks. Task: Extract name from email. Before: Using a Deep Reasoning tier at 0.03 dollars per call. After: Using a Fast/Cheap tier at 0.001 dollars per call for the same result. That is 30x cheaper.

Shorten prompts. Before: 500 tokens prompt. After: 200 tokens prompt with the same result. That is 60% cheaper.

Batch AI requests. Before: Analyze 10 leads with 10 separate API calls. After: Analyze all 10 leads in one call with a structured prompt. That is 10x fewer calls.

Match model to task complexity using the capability tier framework: Fast/Cheap tier for extraction, classification, and simple formatting. Balanced tier for summarization, moderate analysis, and content generation. Deep Reasoning tier for complex multi-step reasoning where cheaper models fail.

### Strategy 6: Filter Early

Do not process what you do not need. This optimizes the trigger and logic layers from Module 2''s 4-layer model.

Before optimization: Get all 1000 records. For each record, enrich with API, transform, check if relevant, and if relevant save. Result: Processed 1000 records, saved 50.

After optimization: Get only relevant records using a filtered query, returning 50. For each record, enrich with API, transform, and save. Result: Processed 50 records, saved 50. That is 20x less processing.

### Strategy 7: Schedule Non-Urgent Work

Batch non-time-sensitive operations for off-peak processing.

Real-time approach (expensive): Each lead immediately triggers enrichment and analysis.

Scheduled approach (cheaper): Each lead goes into a queue. Every hour, batch enrich all queued leads and batch analyze them.

Benefits include using batch APIs, lower rate limiting issues, running during cheaper periods if applicable, and reduced peak load.

### Strategy 8: Use Webhooks Over Polling

Webhooks push data to you. Polling requires you to repeatedly ask. This optimizes the trigger layer from Module 2.

Polling (inefficient): Every 5 minutes ask if there are any new orders. With 288 API calls per day, most return no results.

Webhook (efficient): The service pushes a notification when a new order occurs. Only 2 API calls for 2 actual orders.

Webhooks provide real-time response, fewer API calls, lower costs, and more reliable event capture.

### Strategy 9: Eliminate Redundancy

Do not duplicate work or data within a workflow.

Redundant approach: Step 1 fetches customer data. Step 3 fetches customer data again. Step 7 fetches customer data again. That is 3 API calls for the same data.

Optimized approach: Step 1 fetches customer data and stores it in a variable. Step 3 uses the variable. Step 7 uses the variable. That is 1 API call.

### Strategy 10: Right-Size Resources

Do not over-provision or under-provision.

Under-provisioned: Hitting rate limits and experiencing slowdowns.

Over-provisioned: Paying for unused capacity.

Right-sized: Enough capacity for peak load plus a reasonable buffer.

## Hidden Loops

Some of the worst performance problems come from loops you did not know you had.

**Nested API calls.** For each customer, fetch their orders. For each order, fetch its items. For each item, fetch its details. What looks like 3 API calls is actually customers times orders times items. 100 customers with 10 orders each with 5 items equals 5000 API calls.

**Recursive triggers.** Automation A updates a record. That update triggers Automation B. Automation B updates a record. That update triggers Automation A. Infinite loop until rate limits stop it.

**Retry amplification.** A failing step retries 3 times. That step is called 10 times per run. 30 retries per run. With 100 runs per hour during an outage: 3000 failed retry attempts.

**Lookup multiplication.** Each record does a lookup. With 1000 records, that is 1000 lookups. Often the same lookup repeated. Cache eliminates this.

**Finding hidden loops:** Look for "for each" patterns with API calls inside. Check if any automation output can trigger itself or another automation that triggers it. Count actual API calls during a sample run, not the expected number. Multiply: if step X happens Y times, the time for step X is actually X times Y.

## Connection to Module 2 and Module 3

This section connects optimization to earlier module concepts.

**I-T-O Framework for Optimization**

Each step in your automation is an I-T-O operation. Optimization means examining each: Are the inputs already available or do they require expensive fetching? Is the transformation efficient or can it be simplified? Are the outputs being used or generated unnecessarily?

**4-Layer Model for Bottleneck Analysis**

The trigger layer may have bottlenecks from polling intervals or slow webhook processing. The logic layer may have bottlenecks from complex condition evaluation or unnecessary branching. The execution layer may have bottlenecks from slow API calls, unoptimized AI usage, or sequential processing. The output layer may have bottlenecks from synchronous notification sending or redundant data formatting.

**Capability Tiers for AI Right-Sizing**

Apply Module 3''s tier framework to every AI operation. Fast/Cheap tier handles extraction, classification, and simple formatting. Balanced tier handles summarization, moderate analysis, and content generation. Deep Reasoning tier handles only tasks where cheaper models produce unacceptable results. Most automations can run 80% of AI tasks on the Fast/Cheap tier.

## Optimization Anti-Patterns

**Premature optimization**: Do not optimize until the automation works correctly. Working and slow is better than broken and fast.

**Optimizing the wrong thing**: That 50 millisecond step does not matter when another step takes 5 seconds.

**Over-engineering**: A simple solution that is 2x slower might be better than a complex solution that is unmaintainable.

**Sacrificing reliability**: Do not remove error handling or retries to save time. Section 6.3''s error handling patterns matter.

**One-time optimization**: Performance degrades over time. Monitor and re-optimize regularly.

## Measuring Improvement

Track before and after metrics for each optimization.

Example comparison: Execution time before was 30 seconds, after is 8 seconds, representing 73% faster. Cost per run before was 0.05 dollars, after is 0.02 dollars, representing 60% cheaper. Throughput before was 100 per hour, after is 400 per hour, representing 4x higher. Error rate before was 3%, after is 1%, representing 67% lower.

Calculate ROI for optimization effort. Example: Optimization effort was 10 hours. At 100 dollars per hour, the investment was 1000 dollars. Monthly savings are 500 dollars. Payback period is 2 months. 12-month ROI is 500% based on 6000 dollars saved minus 1000 dollars invested.

## Optimization Checklist

Before optimizing, ensure you have measured current performance, identified bottlenecks, quantified potential savings, estimated optimization effort, and calculated ROI.

Optimization techniques to consider include parallelizing independent operations, batching similar operations, caching repeated lookups, reducing API calls, using cheaper AI models where appropriate, shortening prompts, filtering data early, scheduling non-urgent work, using webhooks over polling, and eliminating redundant operations.

After optimizing, ensure you have measured improvement, verified no functionality is broken, updated documentation, and set up ongoing monitoring.

## Module 6 Recap

This module covered the operational fundamentals of automation: building, running, and maintaining production systems.

**Section 6.1: Triggers & Workflow Initiation.** This is how automations begin and move. Trigger types, idempotency, execution flow, and conditions. Automation flows where you intend, when you intend.

**Section 6.2: Conditional Logic & Branching.** This is how automations decide. Boolean logic, priority rules, truth tables, and readability. Decisions are explicit, documented, and correct.

**Section 6.3: Error Handling & Graceful Failures.** This is how automations survive failure. Error types, recovery strategies, severity levels, and human handoff. Failures are contained and recoverable.

**Section 6.4: Testing & Debugging.** This is how automations earn trust. Test types, debugging patterns, minimum viable test suites. Quality is verified before deployment.

**Section 6.5: Optimization & Performance.** This is how automations scale. Measurement, bottleneck analysis, optimization strategies, and cost tracking. Performance is managed as a feature.

The production mindset: Every automation you build will eventually face unexpected data, failing dependencies, and scale beyond your initial design. Module 6 prepares you to handle these realities.

## Operator Principles

**Follow the optimization order.** Make it work, make it right, make it fast, make it cheap, make it scale. In that sequence.

**Treat cost as a performance metric.** Measure, budget, alert, and optimize cost with the same rigor as speed and reliability.

**Find and eliminate hidden loops.** Nested API calls, recursive triggers, and lookup multiplication are the most common sources of unexpected cost and latency.

**Measure before and after.** Optimization without measurement is guessing. Quantify improvements to prove they worked.',

exercise_markdown = '## Exercise: Optimize an Automation

**Objective:** Apply optimization techniques to make your automations faster, cheaper, and more reliable, using I-T-O analysis and capability tier right-sizing.

**Scope Note:** Parts 1-5 are core optimization skills. Parts 6-7 are for production-scale optimization.

### Part 1: Establish Baseline

Choose an existing automation (or use your lead intake automation from Section 6.1) and measure current performance.

**Execution Time Measurement**

For each step in your automation, record the description and duration in milliseconds. Include trigger, validation, CRM creation, enrichment, email, and notification steps. Calculate the total execution time and identify which step is the bottleneck.

**Cost Analysis**

For each cost component, record the cost per run and multiply by runs per month for monthly cost. Include platform costs, API call costs, and AI costs if applicable. Calculate total cost per run and total monthly cost.

**Throughput Measurement**

Record current capacity in runs per hour and current volume in runs per day.

### Part 2: Identify Optimization Opportunities

Analyze each step using I-T-O thinking from Module 2.

For each step, identify the current time, the optimization opportunity, the technique you would apply, and the potential savings percentage.

Example opportunities: CRM creation at 1500 milliseconds could use batch API for 80% savings. Enrichment at 2000 milliseconds could use caching for 70% savings. Email and Slack at 1000 milliseconds each could run in parallel for 50% savings.

**Prioritize by impact**

Rank your optimization opportunities from highest impact to lowest. Focus on the top 3 for implementation.

### Part 3: Implement Optimizations

Apply at least 3 optimization techniques from the strategies covered.

**Optimization 1**

Document the technique name, current state, proposed change, implementation steps, and measured result.

**Optimization 2**

Document the technique name, current state, proposed change, implementation steps, and measured result.

**Optimization 3**

Document the technique name, current state, proposed change, implementation steps, and measured result.

### Part 4: Measure Improvements

Re-measure after optimizations.

**Execution Time After**

For each step, record before time, after time, and improvement percentage. Calculate total improvement.

**Cost Analysis After**

For each component, record before cost, after cost, and savings. Calculate total savings.

**Throughput After**

Record before throughput, after throughput, and improvement multiplier.

### Part 5: Cost-Benefit Analysis

For each optimization, calculate ROI.

For each of your 3 optimizations, record time to implement in hours, monthly savings, and payback period in months.

Answer these questions: Which optimization had the best ROI? Were any optimizations not worth the effort in retrospect? What would you do differently?

### Part 6: AI Optimization (Advanced)

If your automation uses AI, apply capability tier right-sizing from Module 3.

**Current AI Usage**

Record current model, average prompt tokens, and cost per call.

**Tier Analysis**

For each AI task in your automation, identify the current tier, minimum tier required for acceptable quality, and potential savings from switching.

**Optimization Attempts**

First, test a cheaper model tier. Record the current tier, test tier, quality comparison (acceptable or not acceptable), and cost savings.

Second, shorten your prompt. Record original tokens, shortened tokens, and whether quality was maintained.

Third, attempt batch processing. Record number of separate calls before, number of batched calls after, and savings.

### Part 7: Create Optimization Playbook (Advanced)

Document reusable optimization strategies for future use.

**Quick Wins (less than 1 hour to implement)**

List 3 optimization techniques that can be applied quickly to most automations.

**Medium Effort (1-4 hours)**

List 2 optimization techniques that require moderate effort.

**Major Optimizations (4+ hours)**

List 1 optimization technique that requires significant effort but provides substantial benefits.

**Ongoing Monitoring Checklist**

Weekly: Check execution times and error rates.

Monthly: Review costs and compare to baseline.

Quarterly: Re-evaluate optimization opportunities as volume changes.

### Deliverables

Baseline measurements documented for an existing automation.

At least 3 optimizations implemented with before and after measurements.

Cost-benefit analysis with ROI calculations.

### Success Criteria

Measurable improvement in at least one metric (speed, cost, or throughput).

All functionality still works correctly after optimization.

Documentation shows clear before and after comparison.

Connection to I-T-O framework and capability tiers explicit in analysis.',

exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Establish Baseline",
      "description": "Measure current performance of an existing automation.",
      "fields": [
        {
          "id": "execution_time",
          "type": "textarea",
          "label": "Measure execution time per step:",
          "placeholder": "| Step | Description | Duration (ms) |\n| 1 | Trigger | 100 |\n| 2 | Validation | 50 |\n| 3 | CRM creation | 1500 |\n| 4 | Enrichment | 2000 |\n| 5 | Email send | 800 |\n| 6 | Slack notify | 500 |\n| TOTAL | | 4950 |\n\nBottleneck: Step 4 (Enrichment) - 40% of total time",
          "required": true,
          "rows": 12
        },
        {
          "id": "cost_analysis",
          "type": "textarea",
          "label": "Calculate costs:",
          "placeholder": "| Component | Cost/Run | Runs/Month | Monthly Cost |\n| Platform | $0.01 | 1000 | $10 |\n| API calls | $0.005 | 1000 | $5 |\n| AI (if used) | $0.02 | 1000 | $20 |\n| TOTAL | $0.035 | | $35 |",
          "required": true,
          "rows": 8
        },
        {
          "id": "throughput",
          "type": "textarea",
          "label": "Measure throughput:",
          "placeholder": "Current capacity: X runs/hour\nCurrent volume: X runs/day",
          "required": true,
          "rows": 3
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Identify Opportunities",
      "description": "Analyze each step using I-T-O thinking.",
      "fields": [
        {
          "id": "opportunities",
          "type": "textarea",
          "label": "Identify optimization opportunities:",
          "placeholder": "| Step | Current | Opportunity | Technique | Savings |\n| CRM | 1500ms | Use batch API | Batching | 80% |\n| Enrichment | 2000ms | Add caching | Caching | 70% |\n| Email+Slack | 1300ms | Run together | Parallel | 50% |\n| Validation | 50ms | N/A | Already fast | 0% |\n\nTop 3 to implement:\n1. Caching for enrichment (highest impact)\n2. Parallel email+slack (easy win)\n3. Batch CRM (for high volume)",
          "required": true,
          "rows": 14
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Implement Optimizations",
      "description": "Apply at least 3 optimization techniques.",
      "fields": [
        {
          "id": "optimization1",
          "type": "textarea",
          "label": "Optimization 1:",
          "placeholder": "Technique: [name]\nCurrent state: ...\nProposed change: ...\nImplementation steps:\n1. ...\n2. ...\nMeasured result: [before] -> [after]",
          "required": true,
          "rows": 8
        },
        {
          "id": "optimization2",
          "type": "textarea",
          "label": "Optimization 2:",
          "placeholder": "Technique: [name]\nCurrent state: ...\nProposed change: ...\nImplementation steps:\n1. ...\n2. ...\nMeasured result: [before] -> [after]",
          "required": true,
          "rows": 8
        },
        {
          "id": "optimization3",
          "type": "textarea",
          "label": "Optimization 3:",
          "placeholder": "Technique: [name]\nCurrent state: ...\nProposed change: ...\nImplementation steps:\n1. ...\n2. ...\nMeasured result: [before] -> [after]",
          "required": true,
          "rows": 8
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Measure Improvements",
      "description": "Re-measure after optimizations.",
      "fields": [
        {
          "id": "improvements",
          "type": "textarea",
          "label": "Compare before and after:",
          "placeholder": "Execution Time:\n| Step | Before | After | Improvement |\n| CRM | 1500ms | 300ms | 80% |\n| Enrichment | 2000ms | 600ms | 70% |\n| Email+Slack | 1300ms | 650ms | 50% |\n| TOTAL | 4950ms | 1700ms | 66% |\n\nCost:\n| Component | Before | After | Savings |\n| API | $5/mo | $2/mo | 60% |\n| TOTAL | $35/mo | $22/mo | 37% |\n\nThroughput:\n- Before: 100/hour\n- After: 300/hour\n- Improvement: 3x",
          "required": true,
          "rows": 18
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Cost-Benefit Analysis",
      "description": "Calculate ROI for each optimization.",
      "fields": [
        {
          "id": "roi_analysis",
          "type": "textarea",
          "label": "Calculate ROI:",
          "placeholder": "| Optimization | Time (hrs) | Monthly Savings | Payback |\n| Caching | 2 | $10 | 0.2 months |\n| Parallel | 0.5 | $3 | 0.17 months |\n| Batching | 4 | $5 | 0.8 months |\n\nBest ROI: Parallel (easiest, fastest payback)\nNot worth it: None\nWould do differently: Start with parallel first",
          "required": true,
          "rows": 12
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: AI Optimization (Advanced)",
      "description": "Apply capability tier right-sizing if using AI.",
      "fields": [
        {
          "id": "ai_optimization",
          "type": "textarea",
          "label": "Optimize AI usage:",
          "placeholder": "Current AI usage:\n- Model: [tier]\n- Avg tokens: X\n- Cost/call: $X\n\nTier analysis:\n| Task | Current | Min Required | Savings |\n| Lead scoring | Balanced | Fast/Cheap | 90% |\n| Enrichment | Deep | Balanced | 50% |\n\nTests:\n1. Cheaper tier: [acceptable quality? savings?]\n2. Shorter prompt: [X tokens -> Y tokens, quality?]\n3. Batching: [X calls -> Y calls, savings?]",
          "required": false,
          "rows": 14
        }
      ]
    },
    {
      "id": "part7",
      "title": "Part 7: Optimization Playbook (Advanced)",
      "description": "Document reusable strategies.",
      "fields": [
        {
          "id": "playbook",
          "type": "textarea",
          "label": "Create your optimization playbook:",
          "placeholder": "Quick Wins (<1 hour):\n1. Parallelize independent actions\n2. Add simple caching\n3. Remove unused steps\n\nMedium Effort (1-4 hours):\n1. Implement batching\n2. Add smart retries\n\nMajor (4+ hours):\n1. Architecture redesign\n\nOngoing monitoring:\n- Weekly: Check times and errors\n- Monthly: Review costs\n- Quarterly: Re-evaluate opportunities",
          "required": false,
          "rows": 14
        }
      ]
    }
  ],
  "deliverables": [
    "Baseline measurements documented",
    "3+ optimizations implemented",
    "Before/after measurements",
    "ROI analysis"
  ],
  "success_criteria": [
    "Measurable improvement in at least one metric",
    "Functionality still works correctly",
    "Clear before/after comparison",
    "I-T-O and capability tier connections explicit"
  ]
}'

WHERE slug = 'optimization-performance';
