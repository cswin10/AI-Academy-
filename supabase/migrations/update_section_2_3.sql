-- ============================================================================
-- UPDATE SECTION 2.3: Structured Reasoning & Verification Patterns
-- ============================================================================
-- Run this in Supabase SQL Editor to update Section 2.3 content
-- Modernizes Chain-of-Thought content with reasoning budget, verification,
-- and connection to compute allocation concepts from 2.1
-- ============================================================================

-- First, rename the quiz
UPDATE quizzes
SET title = 'Structured Reasoning & Verification Quiz'
WHERE title = 'Chain-of-Thought Quiz';

-- Update the section title and content
UPDATE sections
SET
  title = 'Structured Reasoning & Verification Patterns',
  content_markdown = '# Structured Reasoning & Verification Patterns

The quality of AI outputs depends on how you structure the reasoning process. This isn''t about making AI "think"—it''s about allocating compute budget to decompose problems and verify solutions.

## The Core Insight: Reasoning Has a Cost

Every reasoning step uses tokens. More tokens = more compute = higher cost and latency.

### Reasoning Budget Costs

More reasoning steps usually means more tokens, higher latency, higher cost.

**Exact costs vary by provider and model—check current pricing before you productionize.**

| Task Type | Token Usage | Relative Cost |
|-----------|-------------|---------------|
| Simple extraction | Low (~50 tokens) | Baseline |
| Structured reasoning | Medium (~500 tokens) | ~10x baseline |
| Deep verification | High (~2000+ tokens) | ~40x baseline |

**The question isn''t "should I use reasoning?"—it''s "does this task justify the reasoning budget?"**

## When Reasoning Budget Is Worth It

| Task Type | Reasoning Budget | Why |
|-----------|------------------|-----|
| Simple extraction | None | Pattern matching, no ambiguity |
| Classification with edge cases | Low | Need to handle ambiguous inputs |
| Multi-step analysis | Medium | Must decompose to get correct answer |
| Complex decisions with tradeoffs | High | Wrong answer has significant cost |
| Irreversible actions | Maximum | Verification prevents costly mistakes |

**Rule of thumb:** Reasoning budget should match the cost of being wrong.

## Structured Decomposition

Break complex tasks into explicit steps. This isn''t "prompting"—it''s defining the transformation pipeline.

### Without Decomposition
```
Task: Decide which automation platform to use

Result: "Use Make, it''s better."
(No reasoning visible, can''t verify, can''t trust)
```

### With Decomposition
```
Task: Decide which automation platform to use

Structure your analysis:
1. List our requirements (from context)
2. Evaluate each platform against requirements
3. Calculate cost at our volume
4. Assess migration/lock-in risk
5. Provide recommendation with confidence level

Result: Visible reasoning you can verify at each step
```

**Key principle:** Decomposition makes reasoning auditable.

> Auditable does not mean correct—it means you can inspect and catch errors.

## Verification Patterns

Verification is not optional for high-stakes outputs. Build it into your task templates.

### Pattern 1: Self-Check

Include verification as a required step:

```
After generating your response:

VERIFY:
□ Does this match all stated requirements?
□ Are there any logical inconsistencies?
□ What assumptions did I make?
□ Confidence level: [High/Medium/Low]

If confidence < High, note what would increase it.
```

### Pattern 2: Adversarial Review

Ask the model to critique its own output:

```
[After initial output]

Now review your answer as a skeptical expert:
- What could go wrong with this approach?
- What did you not consider?
- What would you challenge if someone else proposed this?
- Rate robustness: 1-10

If robustness < 7, provide improved version.
```

### Pattern 3: Constraint Verification

Explicitly check constraints are met:

```
REQUIRED CONSTRAINTS:
1. Response under 200 words
2. No technical jargon
3. Actionable next steps included
4. No promises about timelines

After responding, verify:
☑ Word count: [X] (under 200? Y/N)
☑ Jargon check: [list any technical terms used]
☑ Next steps: [list them]
☑ Timeline promises: [none/found: X]
```

### Pattern 4: Independent Cross-Check

Self-verification can fail in correlated ways. For high-stakes decisions, use independent verification:

```
Run the same task through:
- A second model (e.g., GPT vs Claude)
- A second template with different framing
  (one: "explain your assumptions", another: "attack this proposal")

Compare outputs:
- If they agree → higher confidence
- If they disagree → route to human review
```

This connects to the fallback patterns from Section 2.1 and confidence gates from Section 2.2.

## Example-Driven Specifications

Provide examples to establish patterns. This is about input-output specification, not tricks.

(This technique is sometimes called "few-shot" in ML literature.)

### Effective Structure

```
Task: Classify customer messages

Examples (showing the pattern):

Input: "Just browsing your site"
→ Classification: COLD
→ Reasoning: No specific need expressed, passive browsing
→ Confidence: HIGH

Input: "We need a solution for our 50-person team by Q2"
→ Classification: HOT
→ Reasoning: Specific team size, timeline given, using "need"
→ Confidence: HIGH

Input: "Interesting product. What''s the pricing?"
→ Classification: WARM
→ Reasoning: Active interest but no urgency signals
→ Confidence: MEDIUM

---
Now classify:
Input: "[new message]"
```

**Why this works:** You''re defining the transformation, not hoping the model figures it out.

### Failure Modes

| Problem | Cause | Fix |
|---------|-------|-----|
| Inconsistent outputs | Too few examples | Add 3-5 examples per category |
| Wrong confidence levels | Examples don''t show edge cases | Add ambiguous examples |
| Format drift | Examples inconsistent | Standardize example format exactly |

## Trade-Off Analysis Structure

For decisions, always structure trade-off analysis explicitly.

### Decision Matrix Template

```
Decision: [What are we deciding?]

Options:
1. [Option A]
2. [Option B]
3. [Option C]

Evaluation criteria (weighted):
- Cost (30%)
- Ease of implementation (25%)
- Scalability (20%)
- Vendor risk (15%)
- Team expertise (10%)

For each option, score 1-5 on each criterion:

| Criterion | Option A | Option B | Option C |
|-----------|----------|----------|----------|
| Cost      |          |          |          |
| Ease      |          |          |          |
| Scale     |          |          |          |
| Risk      |          |          |          |
| Expertise |          |          |          |
| WEIGHTED  |          |          |          |

Recommendation: [Option] with confidence [H/M/L]
Key risks: [What could make this wrong?]

---
REQUIRED CHECKS:

Unknowns: What information would most change these scores?
[List the key unknowns]

Sensitivity check: If you change the top 1-2 weights by ±10%, does the winner change?
[Yes/No - if Yes, note which weights are critical]
```

**This isn''t optional for significant decisions.** Unstructured "recommendations" can''t be verified.

## Connecting to Extended Compute Modes

Some models offer modes that spend more compute before responding (sometimes called "extended thinking," "reasoning mode," or similar).

**Use them when complexity and stakes justify it:**

| Scenario | Extra Compute? | Why |
|----------|----------------|-----|
| Simple classification | No | Overhead not justified |
| Code generation | Sometimes | Complex logic benefits |
| Multi-step debugging | Yes | Need to trace through possibilities |
| Architecture decisions | Yes | Many interacting tradeoffs |
| Irreversible actions | Yes | Verification critical |

### Extra Compute ≠ Magic

Allocating more compute runs more reasoning steps. It''s not "making the AI think harder."

**Still required:**
- Clear task structure
- Explicit verification steps
- Defined output format
- Constraint specification

Extra compute without structure = expensive rambling.

## Reasoning for Confidence Calibration

Use reasoning to determine action path:

```
After your analysis, provide:

CONFIDENCE: [0-100]%

If confidence >= 85%:
  → Ready for auto-execution

If confidence 60-84%:
  → Flag for human review
  → Note: What would increase confidence?

If confidence < 60%:
  → Do not proceed
  → Note: What additional information is needed?
```

**Thresholds are risk-dependent.** Higher risk requires higher confidence—and often a human gate even at high confidence:

- Auto-tagging internal tickets: 75% threshold may be fine
- Customer communications or money: always review, even at 95%+

This connects reasoning to the execution boundaries from Section 2.2.

## Phased Reasoning for Complex Projects

Don''t try to solve everything at once. Structure reasoning in phases:

```
Project: Customer success automation

PHASE 1: Understand
- What problem are we solving?
- Who is affected?
- What''s the current state?
→ Done when: Problem and stakeholders are clearly defined

PHASE 2: Define
- What does success look like?
- What are the constraints?
- What''s out of scope?
→ Done when: Success metrics and constraints are written

PHASE 3: Design
- What are the options?
- Trade-off analysis
- Recommendation
→ Done when: Options scored and recommendation exists

PHASE 4: Validate
- What could go wrong?
- How do we verify?
- What''s the rollback plan?
→ Done when: Failure modes and rollback are defined
```

Each phase completes before the next begins. No "god prompts" trying to do everything.

## Anti-Patterns: When Reasoning Hurts

### Over-Reasoning Simple Tasks

```
❌ Bad: "Think step by step about whether this email contains an order number"

✓ Good: "Extract the order number from this email. Return JSON: {order_number: string | null}"
```

Simple extraction doesn''t need reasoning overhead.

### Reasoning Without Verification

```
❌ Bad: "Think through this problem step by step" (no verification)

✓ Good: "Think through this problem step by step. Then verify your logic is sound."
```

Unverified reasoning can be confidently wrong.

### Vague Reasoning Requests

```
❌ Bad: "Think carefully about this"

✓ Good: "Evaluate options A, B, C on cost, speed, and reliability. Score each 1-5."
```

Structure the reasoning or you get unstructured output.

### Copy-Pasting Hidden Assumptions

```
❌ Bad: Trusting default assumptions (budget, team size, tooling)
   "Design an automation system" → AI assumes enterprise budget, large team

✓ Good: Require explicit "Assumptions" field and confirm unknowns before final recommendation

ASSUMPTIONS (confirm these):
- Budget: [stated or unknown?]
- Team size: [stated or unknown?]
- Technical skills: [stated or unknown?]
- Timeline: [stated or unknown?]

If any are unknown, ask before proceeding.
```

This pairs with the self-check verification pattern.

## Key Takeaways

1. **Reasoning has a cost** - Budget it like you budget compute
2. **Match reasoning to stakes** - Simple tasks don''t need deep analysis
3. **Decomposition enables verification** - But auditable ≠ correct
4. **Verification is not optional** - Build it into the task template
5. **Use independent cross-checks** - Self-verification can fail in correlated ways
6. **Example-driven specs define transformations** - Examples are specifications
7. **Extra compute needs structure** - More tokens without direction = waste
8. **Connect to execution boundaries** - Confidence determines action path
9. **Thresholds depend on risk** - Higher stakes = higher bar',

  exercise_markdown = '## Exercise: Structured Reasoning in Practice

Complete the interactive exercise below to practice reasoning patterns.'

WHERE slug = 'chain-of-thought';

-- Update quiz questions
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Structured Reasoning & Verification Quiz');

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Structured Reasoning & Verification Quiz'), 1,
'When should you allocate significant "reasoning budget" to a task?',
'["Always - more reasoning is always better", "When the cost of being wrong is high", "Only for math problems", "Never - reasoning is a waste of tokens"]',
1,
'Reasoning budget should match the cost of being wrong. High-stakes decisions justify the extra compute cost.'),

((SELECT id FROM quizzes WHERE title = 'Structured Reasoning & Verification Quiz'), 2,
'What is the primary purpose of decomposing tasks into steps?',
'["To make prompts longer", "To make reasoning auditable and verifiable", "To slow down the AI", "To use more expensive models"]',
1,
'Decomposition makes each reasoning step visible, allowing you to verify the logic and catch errors. But remember: auditable does not mean correct.'),

((SELECT id FROM quizzes WHERE title = 'Structured Reasoning & Verification Quiz'), 3,
'Which verification pattern asks the model to critique its own output?',
'["Self-Check", "Adversarial Review", "Constraint Verification", "Independent Cross-Check"]',
1,
'Adversarial Review asks the model to critique its own answer as a skeptical expert, finding weaknesses.'),

((SELECT id FROM quizzes WHERE title = 'Structured Reasoning & Verification Quiz'), 4,
'What is example-driven specification (few-shot) really about?',
'["Using very few words", "Defining the input-output transformation through examples", "Making prompts shorter", "Using cheap models"]',
1,
'Examples are specifications of the transformation you want. They define the pattern explicitly.'),

((SELECT id FROM quizzes WHERE title = 'Structured Reasoning & Verification Quiz'), 5,
'Why might self-verification (patterns 1-3) not be enough for high-stakes decisions?',
'["It takes too long", "Self-verification can fail in correlated ways - use independent cross-checks", "Models cannot verify themselves", "It is too expensive"]',
1,
'Self-verification can have blind spots. Independent cross-checks (different model or different framing) catch errors that self-review misses.'),

((SELECT id FROM quizzes WHERE title = 'Structured Reasoning & Verification Quiz'), 6,
'What is wrong with this request: "Think step by step about whether this email has an order number"?',
'["Nothing, it is perfect", "Over-reasoning a simple extraction task", "Not enough steps", "Wrong model choice"]',
1,
'Simple extraction does not need reasoning overhead. A direct extraction task would be faster and cheaper.'),

((SELECT id FROM quizzes WHERE title = 'Structured Reasoning & Verification Quiz'), 7,
'What two checks should follow every decision matrix?',
'["Spell check and grammar check", "Unknowns (what would change scores) and Sensitivity check (do weights matter)", "Cost check and time check", "Manager approval and legal review"]',
1,
'Unknowns identify missing information that could change the decision. Sensitivity checks reveal if the recommendation is fragile to weight changes.'),

((SELECT id FROM quizzes WHERE title = 'Structured Reasoning & Verification Quiz'), 8,
'How should confidence thresholds connect to risk?',
'["Higher risk means lower threshold", "Higher risk requires higher confidence AND often a human gate", "Risk and confidence are unrelated", "Always use 85% regardless of risk"]',
1,
'Thresholds are risk-dependent. Customer communications or money decisions need review even at 95%+ confidence.');

-- Update exercise schema
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Reasoning Budget Analysis",
      "description": "Determine appropriate reasoning budgets for different tasks.",
      "fields": [
        {
          "id": "task_classification",
          "type": "checkbox_group",
          "label": "Which tasks justify HIGH reasoning budget? Select all that apply:",
          "required": true,
          "options": [
            "Extracting order numbers from emails",
            "Designing a new microservices architecture",
            "Classifying support tickets as Billing/Technical/General",
            "Deciding whether to approve a $50,000 vendor contract",
            "Converting CSV data to JSON format",
            "Debugging a production outage with multiple possible causes"
          ]
        },
        {
          "id": "budget_reasoning",
          "type": "textarea",
          "label": "Explain your reasoning: Why do some tasks need more reasoning budget than others?",
          "placeholder": "Consider: cost of being wrong, complexity, reversibility, verification needs...",
          "required": true,
          "rows": 4
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Decomposition Practice",
      "description": "Break down a complex task into verifiable steps.",
      "fields": [
        {
          "id": "complex_task",
          "type": "text",
          "label": "Choose a complex decision you face (business or personal):",
          "placeholder": "e.g., Which CRM should we adopt? Should I change jobs? Which cloud provider?",
          "required": true
        },
        {
          "id": "decomposed_steps",
          "type": "textarea",
          "label": "Decompose this into 5-7 explicit reasoning steps:",
          "placeholder": "1. Define the criteria that matter most\\n2. List the options under consideration\\n3. Research each option against criteria\\n4. Score options on each criterion\\n5. Identify risks and unknowns\\n6. Make recommendation with confidence level\\n7. Define what would change the decision",
          "required": true,
          "rows": 8
        },
        {
          "id": "verification_step",
          "type": "textarea",
          "label": "Add a verification step. Remember: auditable ≠ correct. How will you check if the reasoning is sound?",
          "placeholder": "Verification:\\n□ Did I consider all major options?\\n□ Are my criteria weighted appropriately?\\n□ What am I assuming?\\n□ What would a skeptic challenge?\\n□ Would an independent cross-check (different model/framing) agree?",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Example-Driven Specification",
      "description": "Create examples that define a transformation.",
      "fields": [
        {
          "id": "transformation_goal",
          "type": "text",
          "label": "What transformation do you want to define? (e.g., classify leads, extract entities, assess risk)",
          "placeholder": "e.g., Classify customer feedback as Positive/Neutral/Negative with reasoning",
          "required": true
        },
        {
          "id": "few_shot_examples",
          "type": "textarea",
          "label": "Write 4 examples that define the pattern (including at least one edge case):",
          "placeholder": "Example 1:\\nInput: \"Your product saved us hours every week!\"\\n→ Classification: POSITIVE\\n→ Reasoning: Explicit benefit statement, enthusiasm\\n→ Confidence: HIGH\\n\\nExample 2 (edge case):\\nInput: \"It works but could be better\"\\n→ Classification: NEUTRAL\\n→ Reasoning: Functional but with reservations\\n→ Confidence: MEDIUM\\n...",
          "required": true,
          "rows": 12
        },
        {
          "id": "edge_case_handling",
          "type": "textarea",
          "label": "What edge cases did you include and why?",
          "placeholder": "I included an edge case where... This is important because...",
          "required": true,
          "rows": 3
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Trade-Off Decision Matrix",
      "description": "Create a structured trade-off analysis with required checks.",
      "fields": [
        {
          "id": "decision_context",
          "type": "text",
          "label": "What decision are you analyzing?",
          "placeholder": "e.g., Which project management tool should our team adopt?",
          "required": true
        },
        {
          "id": "options_list",
          "type": "textarea",
          "label": "List 3-4 options you are considering:",
          "placeholder": "1. Option A: [description]\\n2. Option B: [description]\\n3. Option C: [description]",
          "required": true,
          "rows": 4
        },
        {
          "id": "criteria_weights",
          "type": "textarea",
          "label": "Define your evaluation criteria with weights (must total 100%):",
          "placeholder": "- Cost (25%)\\n- Ease of use (30%)\\n- Integration capabilities (20%)\\n- Vendor stability (15%)\\n- Team expertise (10%)",
          "required": true,
          "rows": 5
        },
        {
          "id": "decision_matrix",
          "type": "textarea",
          "label": "Score each option 1-5 on each criterion and calculate weighted total:",
          "placeholder": "| Criterion | Weight | Opt A | Opt B | Opt C |\\n|-----------|--------|-------|-------|-------|\\n| Cost      | 25%    | 4     | 3     | 5     |\\n| Ease      | 30%    | 5     | 4     | 3     |\\n...\\n| WEIGHTED  | 100%   | 4.2   | 3.7   | 3.9   |",
          "required": true,
          "rows": 8
        },
        {
          "id": "unknowns_check",
          "type": "textarea",
          "label": "UNKNOWNS: What information would most change these scores?",
          "placeholder": "1. We don''t know the actual migration cost for Option B\\n2. Team expertise with Option C is assumed, not tested\\n3. ...",
          "required": true,
          "rows": 3
        },
        {
          "id": "sensitivity_check",
          "type": "textarea",
          "label": "SENSITIVITY CHECK: If you change the top 1-2 weights by ±10%, does the winner change?",
          "placeholder": "If Ease of use drops from 30% to 20%, Option C ties with Option A.\\nConclusion: The recommendation is [robust/fragile] because...",
          "required": true,
          "rows": 3
        },
        {
          "id": "recommendation",
          "type": "textarea",
          "label": "Final recommendation with confidence level and key risks:",
          "placeholder": "Recommendation: [Option X]\\nConfidence: [High/Medium/Low]\\nKey risks that could change this decision:\\n1. ...\\n2. ...",
          "required": true,
          "rows": 4
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Verification Patterns",
      "description": "Practice multiple verification approaches.",
      "fields": [
        {
          "id": "sample_output",
          "type": "textarea",
          "label": "Paste an AI-generated output you want to verify (code, analysis, recommendation, etc.):",
          "placeholder": "Paste any AI output here that you want to review critically...",
          "required": true,
          "rows": 6
        },
        {
          "id": "adversarial_critique",
          "type": "textarea",
          "label": "Adversarial Review: What could be wrong? What assumptions were made?",
          "placeholder": "Potential issues:\\n1. ...\\n2. ...\\n\\nHidden assumptions:\\n1. ...\\n2. ...",
          "required": true,
          "rows": 5
        },
        {
          "id": "cross_check_design",
          "type": "textarea",
          "label": "Independent Cross-Check: How would you verify this with a different approach?",
          "placeholder": "Option 1: Run through different model (e.g., Claude vs GPT)\\nOption 2: Use different framing (e.g., ''attack this proposal'' vs ''explain assumptions'')\\nWhat I would compare: ...",
          "required": true,
          "rows": 4
        },
        {
          "id": "robustness_score",
          "type": "radio",
          "label": "Rate the robustness of the original output (1-10):",
          "required": true,
          "options": [
            "1-3: Major issues, needs complete rework",
            "4-5: Significant gaps, needs substantial revision",
            "6-7: Acceptable but improvements needed",
            "8-9: Good, minor improvements possible",
            "10: Excellent, no issues found"
          ]
        },
        {
          "id": "improvement_needed",
          "type": "textarea",
          "label": "What specific improvements would you make?",
          "placeholder": "1. Add consideration of...\\n2. Verify the assumption that...\\n3. Include fallback for...",
          "required": true,
          "rows": 4
        }
      ]
    }
  ],
  "deliverables": [
    "Correctly identified tasks requiring high vs low reasoning budget",
    "Decomposed a complex task into verifiable steps",
    "Created example-driven specifications for a transformation",
    "Built a decision matrix with unknowns and sensitivity checks",
    "Applied multiple verification patterns including cross-checks"
  ],
  "success_criteria": [
    "You can match reasoning budget to task stakes",
    "You understand auditable ≠ correct",
    "You can write examples including edge cases",
    "You can structure trade-off analysis with robustness checks",
    "You can design independent cross-checks for verification"
  ]
}'::jsonb
WHERE slug = 'chain-of-thought';

-- Verify the update
SELECT slug, title,
       LENGTH(content_markdown) as content_length,
       exercise_schema IS NOT NULL as has_schema
FROM sections
WHERE slug = 'chain-of-thought';
