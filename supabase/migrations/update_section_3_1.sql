-- ============================================================================
-- UPDATE SECTION 3.1: Example-Driven Specifications
-- ============================================================================
-- Run this in Supabase SQL Editor to update Section 3.1 content
-- Renames from "Zero-Shot, Few-Shot..." to connect with 2.3 terminology
-- Removes code blocks, uses capability tiers, connects to earlier sections
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

From Section 2.3, we learned that examples in prompts are called "example-driven specifications." They teach the model the pattern you want. This section covers when to include examples, how many, and how to choose them.

## The Spectrum: Zero Examples to Many

**Zero-shot:** No examples provided. The model uses training knowledge only.

**Few-shot:** 2-5 examples demonstrating the pattern.

**Many-shot:** 10+ examples for maximum consistency.

The right choice depends on task complexity, output format requirements, and consistency needs.

## When Zero Examples Work

Zero-shot works when:
- The task is common (summarization, translation, basic Q&A)
- The output format is simple and obvious
- You are prototyping and want to test baseline capability
- Token budget is extremely constrained

**Example (zero-shot classification):**
```
Classify this email as Spam or Not Spam:

"Congratulations! You have won $1,000,000! Click here to claim."

Classification:
```

If zero-shot gives inconsistent results, add examples.

## When to Add Examples

Add examples when:
- Output format is specific and must be consistent
- Categories are custom or domain-specific
- Zero-shot produces inconsistent results across runs
- The task requires a specific reasoning style
- Tone or voice matters

**The rule from Section 2.3:** When you catch yourself explaining what "good output" looks like, you need an example instead.

## How Many Examples?

| Scenario | Examples Needed |
|----------|-----------------|
| Simple, common task | 0-1 |
| Custom format or categories | 2-3 |
| Multiple output categories | 1 per category minimum |
| Domain-specific reasoning | 3-5 |
| Maximum consistency required | 5-10+ |

**Diminishing returns:** After 5-7 examples, improvement slows. More examples cost more tokens without proportional quality gains.

## Choosing Effective Examples

### 1. Cover the Output Space

If you have 4 categories, include at least one example per category.

```
Example 1: Input showing "Hot" lead
Example 2: Input showing "Warm" lead
Example 3: Input showing "Cold" lead
Example 4: Input showing "Unqualified" lead
```

### 2. Include Edge Cases

Your examples should include at least one ambiguous or tricky case.

```
Standard examples: Clear-cut cases
Edge case example: Ambiguous input that could go either way
```

This teaches the model how to handle uncertainty.

### 3. Use Real Data

Fabricated "ideal" examples often fail on real inputs.

```
Better: "ugh this broke after 2 days smh" → Negative
Worse: "I am extremely dissatisfied with this product." → Negative
```

Real data includes the messiness, abbreviations, and patterns your system will actually see.

### 4. Consistent Format

Every example must follow the same structure exactly.

```
Consistent:
Input: [text]
Output: [category]

Input: [text]
Output: [category]

Inconsistent:
Text: [text] → [category]
[text] is [category]
The answer is [category]
```

The model mirrors your format. Inconsistent examples produce inconsistent outputs.

## Example Structure Patterns

### Pattern 1: Input/Output Pairs

```
Input: [example input 1]
Output: [expected output 1]

Input: [example input 2]
Output: [expected output 2]

Input: [actual input]
Output:
```

### Pattern 2: Labeled Examples

```
Example 1:
Query: "Need demo this week, budget approved"
Classification: Hot
Reasoning: Urgency + budget = high intent

Example 2:
Query: "Just researching options"
Classification: Cold
Reasoning: No timeline, early stage

Now classify:
Query: [actual input]
Classification:
Reasoning:
```

### Pattern 3: Before/After

For transformation tasks:

```
Before: "The product is good but expensive"
After: {"sentiment": "mixed", "positive": ["quality"], "negative": ["price"]}

Before: "Absolutely love this!"
After: {"sentiment": "positive", "positive": ["overall satisfaction"], "negative": []}

Before: [actual input]
After:
```

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
- Test your examples against your verification matrix
- If examples pass but real inputs fail, your examples are not representative
- Add examples for cases that fail verification

## Example Selection Workflow

```
1. Start with zero examples
2. Test with 5-10 representative inputs
3. If inconsistent or wrong:
   - Add one example per failure mode
   - Retest
4. If still failing:
   - Add edge case examples
   - Check example quality (are they realistic?)
5. Stop when accuracy meets threshold
```

## Cost Tradeoff

More examples = more tokens per request.

**Rough calculation:**
- 3 examples at 50 tokens each = 150 tokens per request
- At 10,000 requests/month = 1.5M extra tokens

From Section 2.5: Consider whether increased consistency justifies the token cost. Often it does, but measure.

## Many-Shot: When to Use

Many-shot (10-20+ examples) is justified when:
- You need near-deterministic consistency
- The system will process thousands of requests
- Errors have high cost
- Categories are nuanced or numerous

**Trade-offs:**
- Higher token cost per request
- Slower responses (longer context)
- Risk of overfitting to examples

**Mitigation:** Use diverse examples, test with held-out data, monitor for drift.

## Common Mistakes

### 1. Too Few Examples for Complex Categories

If you have 8 output categories and only 2 examples, the model guesses for 6 categories.

**Fix:** At least one example per category, ideally two.

### 2. All Examples Are Easy Cases

If all examples are clear-cut, the model fails on ambiguous inputs.

**Fix:** Include at least one ambiguous example with explicit reasoning.

### 3. Inconsistent Example Format

The model learns from format as much as content.

**Fix:** Use exact same structure for every example.

### 4. Fabricated Examples

Made-up examples often miss real-world patterns.

**Fix:** Use actual production data, sanitized as needed.

### 5. No Versioning

Examples evolve. Losing track causes regressions.

**Fix:** Version example sets with your task templates. Log which version produced each output.

---

## Key Takeaways

1. **Start zero-shot**, add examples only when needed
2. **Cover the output space**, at least one example per category
3. **Include edge cases**, teach handling of ambiguity
4. **Use real data**, fabricated examples often fail
5. **Consistent format** across all examples
6. **Version your examples** with your task templates
7. **Measure the tradeoff**, more examples = more tokens
8. **Many-shot for high stakes**, when consistency matters more than cost',

  exercise_markdown = '## Exercise: Example-Driven Specification Design

Complete the interactive exercise below to practice designing effective example sets.'

WHERE slug = 'zero-shot-few-shot';

-- Update quiz questions
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Example-Driven Specifications Quiz');

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Example-Driven Specifications Quiz'), 1,
'When should you add examples to a task specification?',
'["Always, examples are mandatory", "When zero-shot produces inconsistent results or custom formats are required", "Never, examples waste tokens", "Only for creative writing"]',
1,
'Add examples when zero-shot is inconsistent, when you need specific output formats, or when categories are custom. Start without examples and add as needed.'),

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
'What is wrong with using fabricated "ideal" examples?',
'["Nothing, ideal examples are best", "They often miss real-world patterns and fail on actual production data", "They cost more tokens", "Models reject fabricated examples"]',
1,
'Fabricated ideal examples often miss the messiness of real data: abbreviations, typos, informal language. Use actual production data for examples.'),

((SELECT id FROM quizzes WHERE title = 'Example-Driven Specifications Quiz'), 5,
'When does many-shot (10+ examples) make sense?',
'["Always use many-shot", "When you need near-deterministic consistency and errors have high cost", "Never, it is too expensive", "Only for translation tasks"]',
1,
'Many-shot is justified when you need maximum consistency, the system handles thousands of requests, and errors are costly. The extra tokens are worth the reliability.'),

((SELECT id FROM quizzes WHERE title = 'Example-Driven Specifications Quiz'), 6,
'Why is consistent example format important?',
'["It looks more professional", "The model learns format from examples and mirrors inconsistency", "It saves tokens", "APIs require consistent format"]',
1,
'The model learns from both content and format. If your examples use different structures, your outputs will be inconsistent too.');

-- Update exercise schema
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Zero-Shot Baseline",
      "description": "Test when zero-shot is sufficient.",
      "fields": [
        {
          "id": "zero_shot_tests",
          "type": "textarea",
          "label": "Test these 3 tasks with zero-shot prompts. Document whether they work:",
          "placeholder": "Task 1: Summarize a paragraph\\n  Zero-shot prompt: [your prompt]\\n  Result: [did it work? consistent across 3 tries?]\\n\\nTask 2: Classify email as Support/Sales/Billing\\n  Zero-shot prompt: [your prompt]\\n  Result: [did it work?]\\n\\nTask 3: Extract company name from text\\n  Zero-shot prompt: [your prompt]\\n  Result: [did it work?]\\n\\nWhich tasks need examples?",
          "required": true,
          "rows": 16
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Example Set Design",
      "description": "Design examples for a lead classifier.",
      "fields": [
        {
          "id": "lead_examples",
          "type": "textarea",
          "label": "Design a lead classifier with 4 categories (Hot/Warm/Cold/Unqualified). Write 5 examples including one edge case:",
          "placeholder": "Categories:\\n- Hot: [criteria]\\n- Warm: [criteria]\\n- Cold: [criteria]\\n- Unqualified: [criteria]\\n\\nExample 1 (Hot):\\nInput: [realistic input]\\nOutput: Hot\\nReasoning: [why]\\n\\nExample 2 (Warm):\\n...\\n\\nExample 3 (Cold):\\n...\\n\\nExample 4 (Unqualified):\\n...\\n\\nExample 5 (Edge case):\\nInput: [ambiguous input]\\nOutput: [classification]\\nReasoning: [how to handle ambiguity]",
          "required": true,
          "rows": 24
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Example Quality Check",
      "description": "Validate your examples against real data patterns.",
      "fields": [
        {
          "id": "quality_check",
          "type": "textarea",
          "label": "Review your Part 2 examples. Check each quality criterion:",
          "placeholder": "Quality checklist:\\n\\n1. Cover output space: [do you have at least 1 example per category?]\\n\\n2. Include edge cases: [is there an ambiguous example?]\\n\\n3. Use realistic data: [do examples reflect actual messy inputs?]\\n   - Any examples too polished? Rewrite with realistic language.\\n\\n4. Consistent format: [do all examples follow exact same structure?]\\n   - Any format variations? Fix them.\\n\\nRevised examples (if any changes needed):",
          "required": true,
          "rows": 16
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Testing Example Effectiveness",
      "description": "Test your examples with varied inputs.",
      "fields": [
        {
          "id": "example_testing",
          "type": "textarea",
          "label": "Test your lead classifier with these 5 inputs. Document results:",
          "placeholder": "Test inputs:\\n1. \"Budget approved, need demo by Friday\" - Expected: Hot\\n2. \"Just browsing, no timeline\" - Expected: Cold\\n3. \"Student working on class project\" - Expected: Unqualified\\n4. \"Interested but checking with team first\" - Expected: Warm\\n5. \"Maybe, not sure, could be useful\" - Expected: [ambiguous]\\n\\nResults with your examples:\\n1. Result: [output] - Correct? [y/n]\\n2. Result: [output] - Correct? [y/n]\\n3. Result: [output] - Correct? [y/n]\\n4. Result: [output] - Correct? [y/n]\\n5. Result: [output] - Correct? [y/n]\\n\\nAccuracy: [X/5]\\n\\nIf any failed, what example would you add?",
          "required": true,
          "rows": 18
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Token Cost Analysis",
      "description": "Calculate the cost tradeoff of examples.",
      "fields": [
        {
          "id": "cost_analysis",
          "type": "textarea",
          "label": "Calculate the token cost of your example set:",
          "placeholder": "Example set token estimate:\\n- Example 1: ~[X] tokens\\n- Example 2: ~[X] tokens\\n- Example 3: ~[X] tokens\\n- Example 4: ~[X] tokens\\n- Example 5: ~[X] tokens\\nTotal: ~[X] tokens\\n\\nCost calculation:\\n- Monthly volume: [X] requests\\n- Extra tokens per request: [X]\\n- Total extra tokens/month: [X]\\n- Relative cost impact: [X]%\\n\\nIs this worth it?\\n- Accuracy improvement: [X]% → [X]%\\n- Consistency improvement: [description]\\n- Cost vs error cost: [analysis]\\n\\nConclusion: [worth it or not, and why]",
          "required": true,
          "rows": 16
        }
      ]
    }
  ],
  "deliverables": [
    "Zero-shot baseline tests for 3 tasks",
    "Lead classifier with 5 examples including edge case",
    "Quality-checked examples using all 4 criteria",
    "Test results with 5 varied inputs",
    "Token cost analysis with ROI assessment"
  ],
  "success_criteria": [
    "Correctly identified when zero-shot is sufficient",
    "Examples cover all 4 categories plus edge case",
    "Examples use realistic language, not fabricated ideal",
    "All examples follow consistent format",
    "Cost analysis includes accuracy vs token tradeoff"
  ]
}'::jsonb
WHERE slug = 'zero-shot-few-shot';

-- Verify the update
SELECT slug, title,
       LENGTH(content_markdown) as content_length,
       exercise_schema IS NOT NULL as has_schema
FROM sections
WHERE slug = 'zero-shot-few-shot';
