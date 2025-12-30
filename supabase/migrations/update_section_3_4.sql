-- ============================================================================
-- UPDATE SECTION 3.4: Self-Critique & Iterative Improvement
-- ============================================================================
-- Run this in Supabase SQL Editor to update Section 3.4 content
-- Removes code blocks, uses capability tiers, connects to earlier sections
-- ============================================================================

-- First, rename the quiz
UPDATE quizzes
SET title = 'Self-Critique & Verification Quiz'
WHERE title = 'Self-Critique Quiz';

-- Update the section title and content
UPDATE sections
SET
  title = 'Self-Critique & Iterative Improvement',
  content_markdown = '# Self-Critique & Iterative Improvement

LLM outputs can often be significantly improved by asking the model to critique and refine its own work. This is the "verification loop" from Section 2.3 applied to generation tasks.

## The Case for Self-Critique

First attempts are rarely the best. By asking the LLM to:
1. Generate initial output
2. Critique that output against specific criteria
3. Improve based on the critique

You often get dramatically better results, especially for high-stakes content.

## Basic Self-Critique Pattern

### Step 1: Generate

```
Write a product description for a productivity app that helps remote teams stay aligned.
```

### Step 2: Critique

```
Review this product description. Evaluate against these criteria:
- Clarity: Is the value proposition immediately clear?
- Benefits: Are concrete benefits stated, not just features?
- CTA: Is there a clear call to action?
- Length: Is it appropriate (not too long, not too short)?
- Jargon: Is language accessible to the target audience?

For each criterion, rate 1-5 and explain.

Description to review:
[output from Step 1]
```

### Step 3: Improve

```
Rewrite the product description addressing these issues:
[critique from Step 2]

Original:
[output from Step 1]

Requirements: Fix all issues rated below 4.
```

## Single-Prompt Self-Critique

You can combine all three steps into one prompt:

```
Write a product description for a productivity app for remote teams.

Then, critique your description against these criteria:
- Clarity (1-5)
- Benefits (1-5)
- CTA (1-5)
- Length (1-5)

Finally, write an improved version addressing any criterion below 4.

Format:
## First Draft
[your initial version]

## Critique
[your evaluation with scores]

## Improved Version
[refined version]
```

**Trade-off:** Single-prompt is faster and cheaper, but multi-step gives you visibility into each stage for debugging.

## Critique Dimensions by Task Type

### For Writing/Content

- Clarity and readability
- Logical flow and structure
- Audience appropriateness
- Engagement and hooks
- Grammar and style
- Call to action strength
- Factual accuracy
- Appropriate length

### For Code

- Correctness (does it work?)
- Edge case handling
- Error handling
- Security vulnerabilities
- Performance considerations
- Readability and naming
- Documentation
- Test coverage

### For Analysis

- Logical consistency
- Evidence quality
- Missing considerations
- Unstated assumptions
- Alternative interpretations
- Actionability
- Confidence calibration

### For Decisions/Recommendations

- Criteria completeness
- Option coverage
- Bias identification
- Risk consideration
- Stakeholder impact
- Reversibility
- Implementation feasibility

## Reflection Prompts

Reflection asks the model to examine its own reasoning:

```
Answer this question: [question]

Then reflect:
- What assumptions did you make?
- What information would increase your confidence?
- What might you be wrong about?
- Are there alternative interpretations?
- What did you not consider?
```

This connects to Section 2.3''s verification patterns: Make reasoning visible for inspection.

## Constitutional Critique Pattern

Set criteria upfront, then check against them:

```
Write a customer support response that must:
1. Be empathetic and professional
2. Address the specific complaint directly
3. Offer a concrete solution or next step
4. Stay under 150 words
5. End with a clear action item

Customer complaint: [complaint]

---

First, write your response.
Then, score it 1-5 against each criterion.
If any criterion scores below 4, rewrite to fix it.

Format:
## Response
[your response]

## Scores
1. Empathy: [1-5] - [brief note]
2. Addresses complaint: [1-5] - [brief note]
3. Concrete solution: [1-5] - [brief note]
4. Length: [1-5] - [word count]
5. Clear action: [1-5] - [brief note]

## Revised Response (if needed)
[improved version if any score < 4]
```

## Adversarial Self-Critique

Play devil''s advocate against your own output:

```
You proposed this solution: [solution]

Now argue against it:
- What could go wrong?
- What are you not considering?
- Who might disagree and why?
- What is the strongest counter-argument?

Then, respond to these objections with an improved solution that addresses them.
```

This is particularly valuable for:
- Strategic recommendations
- Architecture decisions
- Policy proposals
- Risk assessments

## Iterative Improvement

Multiple rounds of critique and improvement:

```
Round 1: Generate initial output
Round 2: Identify top 3 issues → Fix them
Round 3: Identify remaining issues → Fix them
Round 4: Final polish
```

**Diminishing returns:** Usually 2-3 rounds capture most improvement. Beyond that, returns diminish rapidly. Measure improvement per round to find your stopping point.

## When to Use Self-Critique

### Good Use Cases

- Reports or documents that matter
- Customer-facing content
- Code going to production
- Analysis informing decisions
- Creative content needing polish
- High-stakes communications
- Complex reasoning tasks

### Skip When

- Simple, low-stakes tasks
- Speed is the priority
- Task is classification or extraction (use verification instead)
- Token budget is extremely constrained
- First draft is good enough

## Cost-Benefit Analysis

**Cost:** 2-3x more tokens per output

**Benefit:**
- Higher quality outputs
- Fewer errors and oversights
- More polished results
- Catches issues before human review

**Worth it when:**
- Quality improvement justifies token cost
- Errors are expensive (bad customer impression, bugs in code)
- Human review time saved exceeds API cost

**From Section 2.5:** Calculate cost per successful outcome. If self-critique increases success rate, the extra tokens may reduce overall cost.

## Connecting to Earlier Sections

**From 2.3 (Verification Patterns):**
- Self-critique is verification applied to generation
- Use the same independent check principle
- Critique step should evaluate, not just approve

**From 2.4 (System Instructions):**
- Include critique criteria in task specifications
- Log both original and critiqued versions
- Escalate if critique cannot be resolved

**From 2.5 (Cost Management):**
- Self-critique costs 2-3x tokens
- Justified for high-value or high-stakes outputs
- Consider tier selection: critique can run on cheaper tier

**From 3.3 (Pipelines):**
- Self-critique can be a pipeline step
- Generate → Critique → Improve is a three-step pipeline
- Each step can be validated independently

## Practical Tips

### 1. Be Specific About Criteria

**Vague:** "Review this and improve it"

**Specific:** "Evaluate for logical consistency, unsupported claims, and missing alternatives. List 3 specific improvements."

### 2. Use Scoring

Scores make evaluation concrete:

"Rate each section 1-10. Explain scores below 7. Improve anything scoring below 7."

### 3. Limit Iterations

Set a maximum to prevent infinite loops:

"Improve through a maximum of 2 iterations. If still not satisfactory, flag for human review."

### 4. Compare Versions

Ask for explicit comparison:

"Compare the original and improved version. What specifically is better? Is anything lost?"

### 5. Consider Split-Model Critique

Use a different model instance (or tier) for critique to get independent perspective:

- Generate with Balanced tier
- Critique with separate call (same or different tier)
- Improve with Balanced tier

This provides more independent verification than single-prompt self-critique.

## Common Mistakes

### 1. Vague Critique Instructions

"Review and improve" gives you generic, unhelpful critiques.

**Fix:** Specify exact criteria and scoring method.

### 2. Rubber-Stamp Critiques

Model says everything is fine and makes no changes.

**Fix:** Require the model to identify at least 2 areas for improvement, even if minor.

### 3. Too Many Iterations

Diminishing returns after 2-3 iterations.

**Fix:** Set maximum iterations. Measure improvement per round.

### 4. Ignoring What Is Lost

Improvement can remove good elements.

**Fix:** Ask "What, if anything, was better in the original?"

### 5. Using Self-Critique for Classification

Self-critique is for generation. Classification should use verification patterns from Section 2.3.

---

## Key Takeaways

1. **Self-critique significantly improves output quality**, especially for high-stakes content
2. **Three steps**: Generate → Critique → Improve
3. **Be specific about criteria**, vague instructions get vague critiques
4. **Use scoring**, it makes evaluation concrete and actionable
5. **2-3 iterations max**, diminishing returns beyond that
6. **Cost is 2-3x tokens**, justified when quality matters
7. **Adversarial critique** catches what regular critique misses
8. **Constitutional pattern** sets criteria upfront and checks against them
9. **Compare versions** to ensure improvement does not remove good elements
10. **Skip for classification**, use verification patterns instead',

  exercise_markdown = '## Exercise: Self-Critique Mastery

Complete the interactive exercise below to practice self-critique techniques.'

WHERE slug = 'self-critique';

-- Update quiz questions
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz');

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 1,
'What is the self-critique pattern?',
'["Criticizing the LLM for bad outputs", "Generate output, critique it against criteria, improve based on critique", "Using negative prompts", "Having humans critique LLM output"]',
1,
'Self-critique means generating initial output, critiquing it against specific criteria, then improving based on that critique. It is the model evaluating and refining its own work.'),

((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 2,
'When is self-critique most valuable?',
'["For simple classification tasks", "When output quality matters more than cost, like reports or customer-facing content", "Never, it wastes tokens", "Only for creative writing"]',
1,
'Self-critique is most valuable for high-stakes outputs where quality matters: reports, customer-facing content, code, and analysis informing decisions.'),

((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 3,
'Why should critique criteria be specific rather than vague?',
'["Vague criteria are easier", "Specific criteria produce actionable critiques, vague criteria produce generic feedback", "It does not matter", "Vague criteria use fewer tokens"]',
1,
'Vague instructions like \"improve this\" produce generic, unhelpful critiques. Specific criteria like \"evaluate clarity, check for unsupported claims\" produce actionable feedback.'),

((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 4,
'How many improvement iterations are typically useful?',
'["As many as possible", "2-3 iterations, then diminishing returns", "Exactly 1", "At least 10"]',
1,
'Usually 2-3 iterations capture most of the improvement. Beyond that, returns diminish rapidly. Measure improvement per round to find your stopping point.'),

((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 5,
'What is the Constitutional Critique pattern?',
'["A legal review process", "Setting criteria upfront, generating output, then scoring against those criteria", "Using multiple LLMs", "Critique by constitutional scholars"]',
1,
'Constitutional Critique sets specific criteria upfront, generates output, then scores the output against each criterion. If any criterion scores below threshold, revision is required.'),

((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 6,
'What is adversarial self-critique?',
'["Attacking the LLM", "Having the model argue against its own output to find weaknesses", "Using adversarial examples", "Critique from competing models"]',
1,
'Adversarial self-critique asks the model to argue against its own proposal: What could go wrong? What are you not considering? What is the strongest counter-argument?'),

((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 7,
'Why should you compare original and improved versions?',
'["To count tokens", "To ensure improvement does not remove good elements from the original", "Comparison is not necessary", "To use more API calls"]',
1,
'Improvement can inadvertently remove good elements. Asking \"what was better in the original?\" ensures you keep the good parts while fixing the bad.'),

((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 8,
'When should you NOT use self-critique?',
'["Never, always use it", "For classification tasks, simple extraction, or when speed is critical", "For any important task", "When quality matters"]',
1,
'Self-critique is for generation tasks. Classification and extraction should use verification patterns instead. Skip when speed is critical or tokens are extremely constrained.');

-- Update exercise schema
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Basic Self-Critique Flow",
      "description": "Practice the three-step self-critique pattern.",
      "fields": [
        {
          "id": "generate_step",
          "type": "textarea",
          "label": "Step 1 - Generate: Write a LinkedIn post about the importance of automation for small businesses.",
          "placeholder": "Generate prompt:\\n[Write your generate prompt here]\\n\\nGenerated output:\\n[Paste the first draft here]",
          "required": true,
          "rows": 12
        },
        {
          "id": "critique_step",
          "type": "textarea",
          "label": "Step 2 - Critique: Evaluate the output against 5 specific criteria.",
          "placeholder": "Critique prompt:\\nReview this LinkedIn post. Score 1-5 for each criterion:\\n1. Hook strength: Does the opening grab attention?\\n2. Value delivered: Is there actionable insight?\\n3. Call to action: Is there a clear next step?\\n4. Appropriate length: LinkedIn-appropriate (not too long)?\\n5. Professional tone: Credible without being stiff?\\n\\nPost to review:\\n[paste generated output]\\n\\nCritique output:\\n[Paste the critique here with scores]",
          "required": true,
          "rows": 18
        },
        {
          "id": "improve_step",
          "type": "textarea",
          "label": "Step 3 - Improve: Rewrite addressing issues rated below 4.",
          "placeholder": "Improve prompt:\\nRewrite this LinkedIn post addressing the issues identified:\\n[paste critique]\\n\\nOriginal:\\n[paste original]\\n\\nFix all criteria scored below 4.\\n\\nImproved output:\\n[Paste the improved version here]\\n\\nComparison:\\n- What improved? [list]\\n- What, if anything, was lost? [list]",
          "required": true,
          "rows": 16
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Single-Prompt vs Multi-Step",
      "description": "Compare single-prompt and multi-step self-critique.",
      "fields": [
        {
          "id": "single_prompt",
          "type": "textarea",
          "label": "Write a single prompt that combines generate, critique, and improve:",
          "placeholder": "Single combined prompt:\\n\\nWrite a LinkedIn post about automation for small businesses.\\n\\nThen critique it against these criteria (score 1-5):\\n1. Hook strength\\n2. Value delivered\\n3. Call to action\\n4. Length\\n5. Tone\\n\\nFinally, write an improved version fixing any criterion below 4.\\n\\nFormat:\\n## First Draft\\n[initial version]\\n\\n## Critique\\n[scores and notes]\\n\\n## Improved Version\\n[final version]\\n\\n---\\n\\nOutput from single prompt:\\n[Paste full output here]",
          "required": true,
          "rows": 26
        },
        {
          "id": "comparison",
          "type": "textarea",
          "label": "Compare the results from Part 1 (multi-step) vs Part 2 (single-prompt):",
          "placeholder": "Comparison Analysis:\\n\\nQuality of final output:\\n- Multi-step result: [assessment]\\n- Single-prompt result: [assessment]\\n- Which is better? [answer with reasoning]\\n\\nCritique quality:\\n- Multi-step critique: [was it thorough?]\\n- Single-prompt critique: [was it thorough?]\\n- Which gave more actionable feedback?\\n\\nCost/Speed tradeoff:\\n- Multi-step: [X] API calls, estimated [X] tokens\\n- Single-prompt: 1 API call, estimated [X] tokens\\n- Token savings: [X]%\\n\\nRecommendation:\\n- When to use multi-step: [situations]\\n- When to use single-prompt: [situations]",
          "required": true,
          "rows": 20
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Constitutional Critique",
      "description": "Practice the constitutional critique pattern.",
      "fields": [
        {
          "id": "constitutional",
          "type": "textarea",
          "label": "Use constitutional critique for a customer support response:",
          "placeholder": "TASK: Write a support response to this complaint:\\n\"Your product crashed and I lost 2 hours of work. This is unacceptable.\"\\n\\nCONSTITUTION (requirements):\\n1. Acknowledge the frustration (empathy)\\n2. Apologize specifically for the issue\\n3. Offer concrete next step or solution\\n4. Keep under 100 words\\n5. Professional but warm tone\\n\\nPrompt:\\n[Write your constitutional critique prompt]\\n\\nOutput:\\n## Response\\n[generated response]\\n\\n## Constitution Check\\n1. Empathy: [1-5] - [note]\\n2. Specific apology: [1-5] - [note]\\n3. Concrete solution: [1-5] - [note]\\n4. Length: [1-5] - [word count]\\n5. Tone: [1-5] - [note]\\n\\n## Revised Response (if any score < 4)\\n[improved version]",
          "required": true,
          "rows": 30
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Adversarial Critique",
      "description": "Practice adversarial self-critique for a recommendation.",
      "fields": [
        {
          "id": "adversarial",
          "type": "textarea",
          "label": "Use adversarial critique for a business recommendation:",
          "placeholder": "TASK: Propose a solution to reduce customer churn for a SaaS company.\\n\\nSTEP 1 - Generate proposal:\\n[Your solution proposal]\\n\\nSTEP 2 - Adversarial critique prompt:\\nArgue against this proposal:\\n- What could go wrong?\\n- What are you assuming that might not be true?\\n- Who might object and why?\\n- What is the strongest counter-argument?\\n- What alternatives are you ignoring?\\n\\nAdversarial output:\\n[Paste the counter-arguments here]\\n\\nSTEP 3 - Improved proposal:\\nAddress the objections with an improved solution:\\n\\nRevised proposal:\\n[Improved solution addressing the objections]\\n\\nWhat changed:\\n- [List specific changes made to address objections]",
          "required": true,
          "rows": 36
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Iterative Improvement",
      "description": "Track improvement across multiple iterations.",
      "fields": [
        {
          "id": "iterative",
          "type": "textarea",
          "label": "Run 3 rounds of improvement on an explanation of prompt engineering for beginners:",
          "placeholder": "ROUND 1 - Initial generation:\\n[Generate explanation of prompt engineering for complete beginners]\\n\\nROUND 1 output:\\n[Paste output]\\n\\n---\\n\\nROUND 2 - First improvement:\\nCritique: Identify top 3 issues\\n[List issues]\\n\\nImproved version:\\n[Paste improved output]\\n\\nImprovement magnitude: [High/Medium/Low]\\n\\n---\\n\\nROUND 3 - Second improvement:\\nCritique: Identify remaining issues\\n[List issues]\\n\\nImproved version:\\n[Paste improved output]\\n\\nImprovement magnitude: [High/Medium/Low]\\n\\n---\\n\\nROUND 4 - Final polish:\\nCritique: Any final issues?\\n[List issues]\\n\\nFinal version:\\n[Paste final output]\\n\\nImprovement magnitude: [High/Medium/Low]\\n\\n---\\n\\nDIMINISHING RETURNS ANALYSIS:\\n- Round 1 → Round 2 improvement: [High/Medium/Low/None]\\n- Round 2 → Round 3 improvement: [High/Medium/Low/None]\\n- Round 3 → Round 4 improvement: [High/Medium/Low/None]\\n\\nOptimal stopping point: [Round X, because...]",
          "required": true,
          "rows": 50
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: When to Skip Self-Critique",
      "description": "Identify when self-critique is not appropriate.",
      "fields": [
        {
          "id": "skip_analysis",
          "type": "textarea",
          "label": "For each task, decide whether to use self-critique and explain why:",
          "placeholder": "Task Analysis:\\n\\n1. Classify email as Support/Sales/Billing\\n   Use self-critique? [Yes/No]\\n   Reasoning: [explain]\\n\\n2. Write investor update email for startup\\n   Use self-critique? [Yes/No]\\n   Reasoning: [explain]\\n\\n3. Extract order numbers from confirmation emails\\n   Use self-critique? [Yes/No]\\n   Reasoning: [explain]\\n\\n4. Draft press release for product launch\\n   Use self-critique? [Yes/No]\\n   Reasoning: [explain]\\n\\n5. Convert CSV to JSON (structural transformation)\\n   Use self-critique? [Yes/No]\\n   Reasoning: [explain]\\n\\n6. Write code for authentication system\\n   Use self-critique? [Yes/No]\\n   Reasoning: [explain]\\n\\n7. Quick response to customer question (high volume)\\n   Use self-critique? [Yes/No]\\n   Reasoning: [explain]\\n\\n8. Strategic recommendation for board\\n   Use self-critique? [Yes/No]\\n   Reasoning: [explain]\\n\\nPattern identified:\\n- Use self-critique when: [summary]\\n- Skip self-critique when: [summary]",
          "required": true,
          "rows": 36
        }
      ]
    }
  ],
  "deliverables": [
    "Three-step self-critique flow with generate, critique, improve",
    "Single-prompt version with comparison analysis",
    "Constitutional critique example with scoring",
    "Adversarial critique for business recommendation",
    "Iterative improvement with diminishing returns analysis",
    "Task-by-task decision framework for when to use self-critique"
  ],
  "success_criteria": [
    "Critique uses specific criteria with scoring",
    "Improved versions address issues identified in critique",
    "Single vs multi-step comparison includes cost analysis",
    "Constitutional critique scores all criteria and revises if needed",
    "Adversarial critique identifies substantive objections",
    "Diminishing returns identified by iteration round",
    "Clear pattern for when to use vs skip self-critique"
  ]
}'::jsonb
WHERE slug = 'self-critique';

-- Verify the update
SELECT slug, title,
       LENGTH(content_markdown) as content_length,
       exercise_schema IS NOT NULL as has_schema
FROM sections
WHERE slug = 'self-critique';
