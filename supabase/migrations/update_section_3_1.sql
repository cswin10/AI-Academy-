-- ============================================================================
-- UPDATE SECTION 3.1: Example-Driven Specifications
-- ============================================================================
-- Run this in Supabase SQL Editor to update Section 3.1 content
-- Removes code blocks, adds example drift, break-even framing
-- ============================================================================

-- First, rename the quiz
UPDATE quizzes
SET title = 'Example-Driven Specifications Quiz'
WHERE title = 'Zero-Shot Few-Shot Quiz';

-- Update the section title and content
UPDATE sections
SET
  title = 'Example-Driven Specifications',
  content_markdown = '# Example-Driven Specifications

Examples in your task specification teach the model the pattern you want. This section covers when to include examples, how many, and how to maintain them.

## Definitions

These terms describe the number of examples in your specification:

**Zero examples:** No examples provided. The model uses training knowledge only.

**Few examples (2-5):** A small set demonstrating the pattern.

**Many examples (10+):** A larger set for maximum consistency.

These are not universal categories or techniques. They are simply counts of how many examples you include.

## The Decision Rule

**Start with zero examples. Add one example per failure mode until verification passes.**

This connects to Section 2.3: Test your specification against your verification matrix. When a test fails, add an example that demonstrates the correct handling. Repeat until verification passes.

Do not add examples speculatively. Add them in response to specific failures.

## When Zero Examples Work

Zero examples work when:
- The task is common (summarization, translation, basic Q&A)
- The output format is simple and obvious
- You are prototyping to test baseline capability
- Token budget is extremely constrained

Example (zero examples, classification):

Classify this email as Spam or Not Spam:
"Congratulations! You have won $1,000,000! Click here to claim."
Classification:

If this produces inconsistent results across runs, add examples.

## When to Add Examples

Add examples when:
- Zero examples produces inconsistent results (verification fails)
- Output format is specific and must be consistent
- Categories are custom or domain-specific
- The task requires a specific reasoning style
- Tone or voice matters

**The signal:** When you catch yourself explaining what "good output" looks like, you need an example instead.

## How Many Examples

| Scenario | Examples Needed |
|----------|-----------------|
| Simple, common task | 0-1 |
| Custom format or categories | 2-3 |
| Multiple output categories | 1 per category minimum |
| Domain-specific reasoning | 3-5 |
| Maximum consistency required | 5-10+ |

**Diminishing returns:** After 5-7 examples, improvement slows. More examples cost more tokens without proportional quality gains.

## Choosing Effective Examples

### Cover the Output Space

If you have 4 categories, include at least one example per category.

- Example 1: Input showing "Hot" lead classification
- Example 2: Input showing "Warm" lead classification
- Example 3: Input showing "Cold" lead classification
- Example 4: Input showing "Unqualified" lead classification

### Include Edge Cases

Your examples should include at least one ambiguous or tricky case.

- Standard examples: Clear-cut cases where the answer is obvious
- Edge case example: Ambiguous input that could go either way, with explicit reasoning

This teaches the model how to handle uncertainty rather than guessing.

### Use Real Data

Fabricated "ideal" examples often fail on real inputs.

Better: "ugh this broke after 2 days smh" → Negative
Worse: "I am extremely dissatisfied with this product." → Negative

Real data includes the messiness, abbreviations, and patterns your system will actually see.

### Consistent Format

Every example must follow the same structure exactly. The model learns from format as much as content.

Consistent (good):
- Input: [text] / Output: [category]
- Input: [text] / Output: [category]

Inconsistent (bad):
- Text: [text] → [category]
- [text] is [category]
- The answer is [category]

## Example Structure Pattern

Use this consolidated pattern for all example-driven specifications:

Task description and output requirements

Example 1:
Input: [realistic input demonstrating category A]
Output: [expected output for category A]
Reasoning: [brief explanation, optional]

Example 2:
Input: [realistic input demonstrating category B]
Output: [expected output for category B]

Example 3 (edge case):
Input: [ambiguous input]
Output: [correct handling]
Reasoning: [how to handle ambiguity]

Now process:
Input: [actual input]
Output:

Include reasoning only when the mapping is not obvious.

## Many Examples: When and How

Many examples (10+) is justified when:
- You need near-deterministic consistency
- The system will process thousands of requests
- Errors have high cost
- Categories are nuanced or numerous

### Diversity Matters

Avoid near-duplicate examples. Each example should cover a distinct case.

Bad: 5 examples of angry customers with slightly different wording
Good: 5 examples covering angry, confused, satisfied, neutral, and mixed sentiment

### Held-Out Testing

Reserve some examples for testing, not training. If your prompt has 10 examples, test with 5 held-out cases the model has not seen. This reveals whether the model generalizes or just memorizes.

### Trade-offs

- Higher token cost per request
- Slower responses (longer context)
- Risk of overfitting to examples (memorization instead of generalization)

## Example Poisoning and Drift

Examples degrade over time. This happens through:

**Poisoning:** Examples that were once accurate become incorrect as your product, categories, or requirements change.

**Drift:** Real-world inputs shift away from what your examples represent. New patterns emerge that your examples do not cover.

**Symptoms of example drift:**
- Accuracy drops gradually over time
- New failure modes appear that verification did not catch before
- Edge cases increase as a percentage of inputs

**Maintenance practices:**
- Review examples quarterly or after major product changes
- Track failure modes in production and add examples for new patterns
- Remove or update examples that no longer represent current requirements
- Version your example sets with dates

## Cost: Break-Even Framing

More examples cost more tokens. The question is whether they pay for themselves.

**Break-even calculation:**

Extra cost per request = (example tokens) × (requests per month) × (cost per token)

Cost of an error = (error rate reduction) × (cost per error)

If cost of errors avoided > extra token cost, examples pay for themselves.

**Example:**
- 5 examples add 250 tokens per request
- 10,000 requests per month = 2.5M extra tokens
- At $0.10 per 1M tokens = $0.25/month extra cost
- If examples reduce errors by 5%, and each error costs $1 to fix manually
- Error savings = 500 errors × $1 = $500/month
- Break-even is obvious: $0.25 cost vs $500 savings

For most cases, examples that improve accuracy are worth the tokens. Calculate your own break-even.

## Connecting to Earlier Sections

**From 2.1 (Capability Tiers):**
- Fast/Cheap tier often needs more examples (less inherent reasoning)
- Balanced tier can work with fewer examples
- Use examples to reduce ambiguity, which allows cheaper models

**From 2.2 (Task Templates):**
- Examples are part of the task specification
- Place examples in the template, not dynamically added
- Version your example sets with your templates

**From 2.3 (Verification):**
- Test your specification against your verification matrix
- Add examples for cases that fail verification
- Held-out test cases verify generalization, not memorization

## Common Mistakes

### Too Few Examples for Complex Categories

If you have 8 output categories and only 2 examples, the model guesses for 6 categories.

Fix: At least one example per category, ideally two.

### All Examples Are Easy Cases

If all examples are clear-cut, the model fails on ambiguous inputs.

Fix: Include at least one ambiguous example with explicit reasoning.

### Inconsistent Example Format

The model learns from format as much as content.

Fix: Use exact same structure for every example.

### Fabricated Examples

Made-up examples often miss real-world patterns.

Fix: Use actual production data, sanitized as needed.

### No Versioning or Maintenance

Examples go stale. Losing track causes regressions.

Fix: Version example sets with your task templates. Review quarterly. Log which version produced each output.

---

## Key Takeaways

1. **Examples count:** zero, few, many describes how many examples you include
2. **Decision rule:** Start with zero, add one per failure mode until verification passes
3. **Cover the output space:** At least one example per category
4. **Include edge cases:** Teach handling of ambiguity
5. **Use real data:** Fabricated examples often fail
6. **Consistent format:** Model mirrors your structure
7. **Diversity in many-shot:** Avoid near-duplicates, use held-out testing
8. **Examples drift:** Review quarterly, update for new patterns
9. **Break-even framing:** Extra tokens vs cost of errors avoided
10. **Version your examples:** They evolve with your system',

  exercise_markdown = '## Exercise: Example-Driven Specification Design

Complete the interactive exercise below to practice designing effective example sets.'

WHERE slug = 'zero-shot-few-shot';

-- Update quiz questions
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Example-Driven Specifications Quiz');

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Example-Driven Specifications Quiz'), 1,
'What is the decision rule for adding examples?',
'["Always add 5 examples", "Start with zero, add one per failure mode until verification passes", "Use as many examples as possible", "Copy examples from documentation"]',
1,
'Start with zero examples. When verification fails, add one example that demonstrates correct handling. Repeat until verification passes. Do not add examples speculatively.'),

((SELECT id FROM quizzes WHERE title = 'Example-Driven Specifications Quiz'), 2,
'How many examples should you include for a task with 4 output categories?',
'["1 example total", "At least 1 per category (4 minimum)", "Exactly 10", "As many as possible"]',
1,
'Include at least one example per output category. With 4 categories, you need minimum 4 examples so the model sees each possibility.'),

((SELECT id FROM quizzes WHERE title = 'Example-Driven Specifications Quiz'), 3,
'Why should examples include edge cases?',
'["Edge cases are more interesting", "To teach the model how to handle ambiguous inputs", "They use fewer tokens", "Edge cases are required by the API"]',
1,
'Edge case examples teach the model how to handle ambiguous or tricky inputs. Without them, the model may fail on anything that is not clear-cut.'),

((SELECT id FROM quizzes WHERE title = 'Example-Driven Specifications Quiz'), 4,
'What is example drift?',
'["Examples moving to different files", "Real-world inputs shifting away from what examples represent over time", "Examples becoming longer", "Using too many examples"]',
1,
'Example drift occurs when real-world inputs change but examples stay static. New patterns emerge that examples do not cover, causing accuracy to degrade.'),

((SELECT id FROM quizzes WHERE title = 'Example-Driven Specifications Quiz'), 5,
'What is the break-even framing for example cost?',
'["Examples should be free", "Extra token cost should be less than cost of errors avoided", "Always use the cheapest option", "Token cost does not matter"]',
1,
'Examples pay for themselves when extra token cost is less than cost of errors avoided. Calculate: extra tokens vs error rate reduction times cost per error.'),

((SELECT id FROM quizzes WHERE title = 'Example-Driven Specifications Quiz'), 6,
'Why is held-out testing important for many-shot specifications?',
'["It uses fewer tokens", "It verifies the model generalizes rather than memorizes examples", "Held-out testing is not important", "It makes examples longer"]',
1,
'Held-out testing uses examples the model has not seen to verify it generalizes the pattern rather than just memorizing the specific examples in the prompt.'),

((SELECT id FROM quizzes WHERE title = 'Example-Driven Specifications Quiz'), 7,
'What is wrong with using fabricated ideal examples?',
'["Nothing, ideal examples are best", "They often miss real-world patterns like abbreviations and informal language", "They cost more tokens", "Models reject fabricated examples"]',
1,
'Fabricated ideal examples often miss the messiness of real data: abbreviations, typos, informal language. Use actual production data for examples.'),

((SELECT id FROM quizzes WHERE title = 'Example-Driven Specifications Quiz'), 8,
'How often should you review your example sets?',
'["Never, examples are permanent", "Quarterly or after major product changes", "Daily", "Only when the system breaks completely"]',
1,
'Review examples quarterly or after major product changes. Examples drift as requirements and real-world patterns change. Regular review prevents gradual accuracy decay.');

-- Update exercise schema
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Zero-Example Baseline",
      "description": "Test when zero examples is sufficient.",
      "fields": [
        {
          "id": "zero_example_tests",
          "type": "textarea",
          "label": "Test these 3 tasks with zero examples. Document whether they work:",
          "placeholder": "Task 1: Summarize a paragraph\n  Specification (no examples): [your prompt]\n  Test input: [sample paragraph]\n  Result: [output]\n  Consistent across 3 tries? [Yes/No]\n  Verification passed? [Yes/No]\n\nTask 2: Classify email as Support/Sales/Billing\n  Specification: [your prompt]\n  Test input: [sample email]\n  Result: [output]\n  Consistent? [Yes/No]\n  Verification passed? [Yes/No]\n\nTask 3: Extract company name from text\n  Specification: [your prompt]\n  Test input: [sample text]\n  Result: [output]\n  Consistent? [Yes/No]\n  Verification passed? [Yes/No]\n\nWhich tasks need examples added?",
          "required": true,
          "rows": 24
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Adding Examples for Failures",
      "description": "Add examples to fix verification failures.",
      "fields": [
        {
          "id": "add_examples",
          "type": "textarea",
          "label": "For tasks that failed verification in Part 1, add examples one at a time:",
          "placeholder": "Task: [which task failed]\n\nFailure mode 1: [describe what went wrong]\nExample added:\n  Input: [realistic input]\n  Output: [correct output]\n  Reasoning: [if needed]\n\nRetest result: [did this fix it?]\n\nFailure mode 2 (if still failing): [describe]\nExample added:\n  Input: [realistic input]\n  Output: [correct output]\n\nRetest result: [did this fix it?]\n\nFinal example count: [X]\nVerification now passes? [Yes/No]",
          "required": true,
          "rows": 22
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Lead Classifier Design",
      "description": "Design a complete example set for lead classification.",
      "fields": [
        {
          "id": "lead_classifier",
          "type": "textarea",
          "label": "Design a lead classifier with 4 categories. Include one example per category plus one edge case:",
          "placeholder": "Categories:\n- Hot: [criteria]\n- Warm: [criteria]\n- Cold: [criteria]\n- Unqualified: [criteria]\n\nExample 1 (Hot):\n  Input: [realistic messy input, not idealized]\n  Output: Hot\n  Reasoning: [brief]\n\nExample 2 (Warm):\n  Input: [realistic input]\n  Output: Warm\n\nExample 3 (Cold):\n  Input: [realistic input]\n  Output: Cold\n\nExample 4 (Unqualified):\n  Input: [realistic input]\n  Output: Unqualified\n\nExample 5 (Edge case - ambiguous):\n  Input: [genuinely ambiguous input]\n  Output: [correct classification]\n  Reasoning: [how to resolve ambiguity]\n\nFormat consistency check:\n- All examples use same structure? [Yes/No]\n- All inputs are realistic (not fabricated ideal)? [Yes/No]\n- Edge case teaches ambiguity handling? [Yes/No]",
          "required": true,
          "rows": 32
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Held-Out Testing",
      "description": "Test generalization with held-out cases.",
      "fields": [
        {
          "id": "held_out_test",
          "type": "textarea",
          "label": "Test your lead classifier with 5 held-out inputs (cases NOT in your examples):",
          "placeholder": "Held-out test cases (not in your examples):\n\n1. Input: \"Budget approved, need demo by Friday\"\n   Expected: Hot\n   Actual output: [result]\n   Correct? [Yes/No]\n\n2. Input: \"Just browsing, no timeline\"\n   Expected: Cold\n   Actual output: [result]\n   Correct? [Yes/No]\n\n3. Input: \"Student working on class project\"\n   Expected: Unqualified\n   Actual output: [result]\n   Correct? [Yes/No]\n\n4. Input: \"Interested but checking with team first\"\n   Expected: Warm\n   Actual output: [result]\n   Correct? [Yes/No]\n\n5. Input: \"Maybe, not sure, could be useful\"\n   Expected: [your prediction - ambiguous]\n   Actual output: [result]\n   Handled ambiguity well? [Yes/No]\n\nHeld-out accuracy: [X/5]\n\nDoes the model generalize or just memorize?\n- Evidence of generalization: [describe]\n- Evidence of memorization: [describe if any]\n\nIf accuracy < 4/5, what example would you add?",
          "required": true,
          "rows": 28
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Break-Even Analysis",
      "description": "Calculate whether examples pay for themselves.",
      "fields": [
        {
          "id": "break_even",
          "type": "textarea",
          "label": "Calculate the break-even for your example set:",
          "placeholder": "Token cost calculation:\n- Example 1: ~[X] tokens\n- Example 2: ~[X] tokens\n- Example 3: ~[X] tokens\n- Example 4: ~[X] tokens\n- Example 5: ~[X] tokens\nTotal example tokens: ~[X]\n\nMonthly volume: [X] requests\nExtra tokens per month: [X]\nCost per 1M tokens: $[X] (use provider pricing)\nMonthly token cost: $[X]\n\nError cost calculation:\n- Without examples, estimated error rate: [X]%\n- With examples, estimated error rate: [X]%\n- Error rate reduction: [X]%\n- Errors avoided per month: [X]\n- Cost per error (manual review, customer impact, etc.): $[X]\n- Monthly error cost avoided: $[X]\n\nBreak-even analysis:\n- Extra token cost: $[X]/month\n- Error cost avoided: $[X]/month\n- Net benefit: $[X]/month\n\nConclusion: [Examples worth it? Why/why not?]",
          "required": true,
          "rows": 28
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: Drift Prevention Plan",
      "description": "Plan for maintaining examples over time.",
      "fields": [
        {
          "id": "drift_plan",
          "type": "textarea",
          "label": "Create a maintenance plan to prevent example drift:",
          "placeholder": "Example Maintenance Plan:\n\nReview schedule:\n- Frequency: [quarterly / after major changes / other]\n- Trigger events: [list events that require immediate review]\n\nMonitoring for drift:\n- Metric to track: [accuracy, error rate, edge case frequency]\n- Alert threshold: [when to investigate]\n- Data source: [where to find production failures]\n\nUpdate process:\n1. [Step 1: How to identify stale examples]\n2. [Step 2: How to gather new example candidates]\n3. [Step 3: How to test updated examples]\n4. [Step 4: How to deploy and version]\n\nVersioning:\n- Version format: [e.g., lead_classifier_v3_2024Q4]\n- What to log: [version used for each output]\n- Rollback plan: [how to revert if new examples perform worse]\n\nOwnership:\n- Who reviews: [role/person]\n- Who approves changes: [role/person]",
          "required": true,
          "rows": 28
        }
      ]
    }
  ],
  "deliverables": [
    "Zero-example baseline tests for 3 tasks",
    "Examples added iteratively to fix specific failures",
    "Lead classifier with 5 examples including edge case",
    "Held-out test results showing generalization",
    "Break-even cost analysis",
    "Drift prevention and maintenance plan"
  ],
  "success_criteria": [
    "Decision rule applied: examples added only for failures",
    "Examples cover all 4 categories plus edge case",
    "Examples use realistic language, not fabricated ideal",
    "Held-out testing demonstrates generalization",
    "Break-even calculation shows cost vs error savings",
    "Maintenance plan includes review schedule and versioning"
  ]
}'::jsonb
WHERE slug = 'zero-shot-few-shot';

-- Verify the update
SELECT slug, title,
       LENGTH(content_markdown) as content_length,
       exercise_schema IS NOT NULL as has_schema
FROM sections
WHERE slug = 'zero-shot-few-shot';
