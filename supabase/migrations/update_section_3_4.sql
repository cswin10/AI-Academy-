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

---

## Definitions

**Self-critique** means asking the model to evaluate its own output against specific criteria, then improve based on that evaluation. The pattern is: generate, critique, improve.

**Rubber-stamp critique** means a critique that approves everything without identifying real issues. This is a common failure mode when critique instructions are vague.

**Stopping rules** are explicit criteria for when to stop iterating. Without them, you waste tokens on diminishing improvements or loop indefinitely.

---

## The Case for Self-Critique

First attempts are rarely the best. By asking the LLM to generate initial output, critique that output against specific criteria, and improve based on the critique, you often get dramatically better results. This is especially true for high-stakes content where polish matters.

---

## Warning: Self-Critique Does Not Add Knowledge

Self-critique improves style, structure, and adherence to criteria. It does not add new facts the model does not know. If the model makes a factual error in the first draft, self-critique will not reliably catch it because the model is using the same knowledge base to critique as it used to generate.

For factual accuracy, you need external verification: retrieval from authoritative sources, human review, or cross-referencing with known data. Self-critique is powerful for form but limited for substance.

---

## Basic Self-Critique Pattern

### Step 1: Generate

Ask for an initial output. Example: Write a product description for a productivity app that helps remote teams stay aligned.

### Step 2: Critique

Evaluate the output against specific criteria. Example: Review this product description and evaluate against these criteria: clarity (is the value proposition immediately clear?), benefits (are concrete benefits stated, not just features?), call to action (is there a clear next step?), length (is it appropriate?), jargon (is language accessible to the target audience?). For each criterion, rate 1 to 5 and explain.

### Step 3: Improve

Rewrite addressing the issues identified. Example: Rewrite the product description addressing these issues. Fix all areas rated below 4. Keep what scored well.

---

## Independence in Self-Critique

A key question: does the critique step provide genuinely independent evaluation, or is it just the same reasoning patched to look like review?

**Single-prompt self-critique** (generate, critique, and improve all in one prompt) is convenient but provides less independence. The model may anchor on its first draft and produce superficial critiques.

**Multi-call self-critique** (separate API calls for generate, critique, improve) provides more independence. Each call starts fresh without seeing its own reasoning process.

**Split-model critique** provides the most independence. Use one model instance to generate, a separate call (possibly different tier or temperature) to critique. The critic has no memory of the generation process.

For high-stakes content, prefer multi-call or split-model critique. For routine improvement, single-prompt is acceptable.

---

## Single-Prompt Self-Critique

For convenience, you can combine all steps in one prompt. Ask the model to write the first draft, then critique it against specified criteria with scores, then write an improved version addressing any criterion below 4. Specify the format: First Draft section, Critique section with scores, Improved Version section.

Trade-off: Single-prompt is faster and cheaper but provides less genuine independence. The model may produce shallower critiques.

---

## Preventing Rubber-Stamp Critiques

A common failure: the model says everything looks good and makes no changes. This wastes tokens and produces no improvement.

**Prevention strategies:**

1. Require specific issues. "Identify at least 2 areas for improvement, even if minor. No output is perfect."

2. Force scoring granularity. Instead of "rate 1-5", use "rate 1-10 where 10 is publishable without changes and 6 is typical first draft quality."

3. Ask for weakest element. "Which criterion scored lowest? That must be improved regardless of absolute score."

4. Use adversarial framing. "Find problems with this. What would a harsh editor criticize?"

5. Separate critique from generation. If the same call generates and critiques, the model may be biased toward approval. Separate calls reduce this.

If critique consistently produces no actionable feedback, your criteria are too vague or you need a different approach.

---

## Stopping Rules

Without explicit stopping criteria, iteration can continue indefinitely or waste tokens on marginal improvements.

**Explicit stopping rules:**

1. **Score threshold**: "Stop when all criteria score 4 or higher."

2. **Maximum iterations**: "Improve through a maximum of 3 rounds. If still not satisfactory, flag for human review."

3. **Improvement magnitude**: "If the critique identifies only minor issues (all scores 4+), stop. Further iteration is not needed."

4. **Time/token budget**: "Spend no more than X tokens total on this generation including critique rounds."

**Diminishing returns pattern**: Usually 2-3 rounds capture most improvement. Round 1 to 2 often shows large gains. Round 2 to 3 shows smaller gains. Round 3 to 4 typically shows minimal gains. Measure improvement per round to find your stopping point.

Include stopping rules in your prompts: "Run a maximum of 2 improvement iterations. Stop early if all criteria score 4 or higher."

---

## Critique Dimensions by Task Type

### For Writing/Content
Clarity and readability, logical flow and structure, audience appropriateness, engagement and hooks, grammar and style, call to action strength, factual accuracy (limited by model knowledge), appropriate length.

### For Code
Correctness (does it work?), edge case handling, error handling, security vulnerabilities, performance considerations, readability and naming, documentation, test coverage.

### For Analysis
Logical consistency, evidence quality, missing considerations, unstated assumptions, alternative interpretations, actionability, confidence calibration.

### For Decisions/Recommendations
Criteria completeness, option coverage, bias identification, risk consideration, stakeholder impact, reversibility, implementation feasibility.

---

## Reflection Prompts

Reflection asks the model to examine its own reasoning. After generating an answer, ask: What assumptions did you make? What information would increase your confidence? What might you be wrong about? Are there alternative interpretations? What did you not consider?

This connects to Section 2.3 verification patterns: Make reasoning visible for inspection.

---

## Constitutional Critique Pattern

Set criteria upfront, then check against them. Example: Write a customer support response that must (1) be empathetic and professional, (2) address the specific complaint directly, (3) offer a concrete solution or next step, (4) stay under 150 words, and (5) end with a clear action item.

Then instruct: First write your response. Then score it 1-5 against each criterion. If any criterion scores below 4, rewrite to fix it. Format as Response section, Scores section with each criterion rated and noted, Revised Response section if needed.

The "constitution" defines success upfront. The model checks its own work against these explicit criteria.

---

## Adversarial Self-Critique

Play devil''s advocate against your own output. Ask the model to argue against a proposed solution: What could go wrong? What are you not considering? Who might disagree and why? What is the strongest counter-argument? Then respond to these objections with an improved solution.

This is particularly valuable for strategic recommendations, architecture decisions, policy proposals, and risk assessments.

---

## Iterative Improvement with Measurement

Track improvement across rounds:

Round 1: Generate initial output.
Round 2: Identify top 3 issues, fix them. Measure improvement (large, medium, small, none).
Round 3: Identify remaining issues, fix them. Measure improvement.
Round 4: Final polish if needed. Measure improvement.

When improvement drops to "small" or "none", stop. You have reached diminishing returns.

---

## When to Use Self-Critique

### Good Use Cases
Reports or documents that matter, customer-facing content, code going to production, analysis informing decisions, creative content needing polish, high-stakes communications, complex reasoning tasks.

### Skip When
Simple or low-stakes tasks, speed is the priority, task is classification or extraction (use verification instead), token budget is extremely constrained, first draft is good enough.

---

## Cost-Benefit Analysis

**Cost:** 2-3x more tokens per output.

**Benefit:** Higher quality outputs, fewer errors and oversights, more polished results, catches issues before human review.

**Worth it when:** Quality improvement justifies token cost. Errors are expensive (bad customer impression, bugs in code). Human review time saved exceeds API cost.

From Section 2.5: Calculate cost per successful outcome. If self-critique increases success rate, the extra tokens may reduce overall cost.

---

## Connecting to Earlier Sections

**From 2.3 (Verification Patterns):** Self-critique is verification applied to generation. Use the same independent check principle. Critique step should evaluate, not just approve.

**From 2.4 (System Instructions):** Include critique criteria in task specifications. Log both original and critiqued versions. Escalate if critique cannot be resolved.

**From 2.5 (Cost Management):** Self-critique costs 2-3x tokens. Justified for high-value or high-stakes outputs. Consider tier selection: critique can run on cheaper tier.

**From 3.3 (Pipelines):** Self-critique can be a pipeline step. Generate, Critique, Improve is a three-step pipeline. Each step can be validated independently.

---

## Practical Tips

### Be Specific About Criteria
Vague: "Review this and improve it."
Specific: "Evaluate for logical consistency, unsupported claims, and missing alternatives. List 3 specific improvements."

### Use Scoring with Granularity
"Rate each section 1-10 where 10 is ready for publication and 6 is typical first draft. Explain any score below 7. Improve anything scoring below 7."

### Limit Iterations Explicitly
"Improve through a maximum of 2 iterations. Stop early if all criteria score 4+. If still not satisfactory after 2 iterations, flag for human review."

### Compare Versions
"Compare the original and improved version. What specifically is better? Is anything lost?"

### Consider Split-Model Critique
Generate with Balanced tier. Critique with separate call (same or different tier). Improve with Balanced tier. This provides more independent verification.

---

## Common Mistakes

**Vague critique instructions**: "Review and improve" gives generic, unhelpful critiques. Fix by specifying exact criteria and scoring method.

**Rubber-stamp critiques**: Model says everything is fine. Fix by requiring at least 2 improvements and using adversarial framing.

**Too many iterations**: Diminishing returns after 2-3 rounds. Fix by setting maximum iterations and measuring improvement per round.

**Ignoring what is lost**: Improvement can remove good elements. Fix by asking "What, if anything, was better in the original?"

**Using self-critique for classification**: Self-critique is for generation. Classification should use verification patterns from Section 2.3.

**Expecting factual correction**: Self-critique does not add new knowledge. Fix by using external verification for facts.

---

## Key Takeaways

1. **Self-critique significantly improves output quality**, especially for high-stakes content
2. **Three steps**: Generate, Critique, Improve
3. **Independence matters**, multi-call or split-model provides more genuine evaluation
4. **Prevent rubber-stamps**, require specific issues and use granular scoring
5. **Define stopping rules**, maximum iterations and score thresholds
6. **2-3 iterations max**, measure improvement per round to find diminishing returns
7. **Self-critique does not add facts**, use external verification for factual accuracy
8. **Constitutional pattern** sets criteria upfront and checks against them
9. **Adversarial critique** catches what regular critique misses
10. **Skip for classification**, use verification patterns instead',

  exercise_markdown = '## Exercise: Self-Critique Mastery

Complete the interactive exercise below to practice self-critique techniques.'

WHERE slug = 'self-critique';

-- Update quiz questions
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz');

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 1,
'What is a rubber-stamp critique?',
'["A critique that uses stamps for scoring", "A critique that approves everything without identifying real issues", "A critique from an external model", "A critique that is too harsh"]',
1,
'A rubber-stamp critique says everything looks good and makes no changes. This is a common failure when critique instructions are vague. Prevent it by requiring specific issues and using adversarial framing.'),

((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 2,
'Why does self-critique not reliably catch factual errors?',
'["The model is lazy", "The model uses the same knowledge base to critique as it used to generate", "Factual errors are rare", "Self-critique only looks at style"]',
1,
'Self-critique uses the same model knowledge for both generation and critique. If the model does not know a fact is wrong, it cannot catch the error. Use external verification for factual accuracy.'),

((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 3,
'What provides more independent critique: single-prompt or multi-call?',
'["Single-prompt provides more independence", "Multi-call provides more independence because each call starts fresh without seeing its own reasoning", "They are equivalent", "Neither provides independence"]',
1,
'Multi-call self-critique provides more independence because each API call starts fresh. Single-prompt may anchor on the first draft and produce superficial critiques.'),

((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 4,
'How do you prevent rubber-stamp critiques?',
'["Use vague criteria", "Require specific issues (at least 2), use granular scoring, ask for weakest element", "Always agree with the first draft", "Skip the critique step"]',
1,
'Prevent rubber-stamps by requiring at least 2 improvements, using granular scoring (1-10 not 1-5), asking for the weakest element, and using adversarial framing.'),

((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 5,
'What are stopping rules in self-critique?',
'["Rules about when to stop using the model", "Explicit criteria for when to stop iterating, like score thresholds or maximum iterations", "Rules about what topics to avoid", "Rules for ending conversations"]',
1,
'Stopping rules define when to stop iterating: all criteria score 4+, maximum iterations reached, or improvement magnitude drops to minimal. Without them, you waste tokens on diminishing improvements.'),

((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 6,
'How many improvement iterations are typically useful?',
'["As many as possible", "2-3 iterations, then diminishing returns", "Exactly 1", "At least 10"]',
1,
'Usually 2-3 iterations capture most improvement. Round 1 to 2 shows large gains. Beyond round 3, returns typically diminish. Measure improvement per round to find your stopping point.'),

((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 7,
'What is adversarial self-critique?',
'["Attacking the LLM", "Having the model argue against its own output to find weaknesses", "Using adversarial examples", "Critique from competing models"]',
1,
'Adversarial self-critique asks the model to argue against its own proposal: What could go wrong? What are you not considering? What is the strongest counter-argument?'),

((SELECT id FROM quizzes WHERE title = 'Self-Critique & Verification Quiz'), 8,
'When should you NOT use self-critique?',
'["Never, always use it", "For classification tasks, extraction, or when speed is critical", "For any important task", "When quality matters"]',
1,
'Self-critique is for generation tasks. Classification and extraction should use verification patterns. Skip when speed is critical, tokens are constrained, or first draft is good enough.');

-- Update exercise schema
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Basic Self-Critique Flow",
      "description": "Practice the three-step self-critique pattern with attention to independence.",
      "fields": [
        {
          "id": "generate_step",
          "type": "textarea",
          "label": "Step 1 - Generate: Write a LinkedIn post about the importance of automation for small businesses.",
          "placeholder": "Generate prompt:\n[Write your generate prompt here]\n\nGenerated output:\n[Paste the first draft here]",
          "required": true,
          "rows": 12
        },
        {
          "id": "critique_step",
          "type": "textarea",
          "label": "Step 2 - Critique: In a SEPARATE API call, evaluate the output against 5 specific criteria. Note: This should be a new call, not part of the generation prompt.",
          "placeholder": "Critique prompt (sent as new API call):\n\nReview this LinkedIn post. Score 1-10 for each criterion (10 = publishable, 6 = typical first draft):\n\n1. Hook strength: Does the opening grab attention?\n2. Value delivered: Is there actionable insight?\n3. Call to action: Is there a clear next step?\n4. Appropriate length: LinkedIn-appropriate?\n5. Professional tone: Credible without being stiff?\n\nYou MUST identify at least 2 areas for improvement, even if minor. No post is perfect.\n\nWhich criterion scored lowest? That must be improved.\n\nPost to review:\n[paste generated output]\n\nCritique output:\n[Paste the critique here with scores and specific issues]",
          "required": true,
          "rows": 22
        },
        {
          "id": "improve_step",
          "type": "textarea",
          "label": "Step 3 - Improve: Rewrite addressing issues identified, especially the lowest-scoring criterion.",
          "placeholder": "Improve prompt:\nRewrite this LinkedIn post addressing the issues identified:\n[paste critique]\n\nOriginal:\n[paste original]\n\nFix all criteria scored below 7. Pay special attention to [lowest scoring criterion].\n\nImproved output:\n[Paste the improved version here]\n\nComparison:\n- What improved? [list specific changes]\n- What, if anything, was lost? [list]\n- All criteria now 7+? [yes/no]",
          "required": true,
          "rows": 18
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Preventing Rubber-Stamp Critiques",
      "description": "Practice techniques to get genuine, actionable critiques.",
      "fields": [
        {
          "id": "rubber_stamp_prevention",
          "type": "textarea",
          "label": "Generate a piece of content, then try two different critique approaches - one vague and one specific. Compare the results:",
          "placeholder": "CONTENT TO CRITIQUE:\n[Write or generate a short email announcing a product feature]\n\n---\n\nVAGUE CRITIQUE PROMPT:\n\"Review this email and improve it.\"\n\nVague critique output:\n[Paste result - likely generic/approving]\n\n---\n\nSPECIFIC CRITIQUE PROMPT:\n\"Review this email. Score 1-10 on:\n1. Subject line impact\n2. Value clarity in first sentence\n3. Specific benefit articulation\n4. Call to action strength\n5. Appropriate length\n\nYou MUST identify the 2 weakest aspects. What would a harsh editor cut or change? What would make a busy reader delete this?\"\n\nSpecific critique output:\n[Paste result - should be more actionable]\n\n---\n\nCOMPARISON:\n- Vague critique: [number] of actionable issues identified\n- Specific critique: [number] of actionable issues identified\n- Which led to better improvement? [analysis]",
          "required": true,
          "rows": 36
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Stopping Rules",
      "description": "Practice defining and applying stopping rules.",
      "fields": [
        {
          "id": "stopping_rules",
          "type": "textarea",
          "label": "Run iterative improvement with explicit stopping rules. Track improvement magnitude per round:",
          "placeholder": "TASK: Write an explanation of API rate limiting for developers new to the concept.\n\nSTOPPING RULES:\n- Stop when all criteria score 7+ (on 1-10 scale)\n- Maximum 3 iterations\n- Stop early if improvement magnitude is \"small\" or \"none\"\n\n---\n\nROUND 1 - Initial generation:\n[Generate explanation]\n\nCritique scores: [list all 5 criteria with scores]\nLowest score: [which criterion]\n\n---\n\nROUND 2 - First improvement:\nIssues addressed: [list]\n\nImproved version:\n[Paste]\n\nNew critique scores: [list all]\nImprovement magnitude: [Large/Medium/Small/None]\nContinue? [Yes because X / No because Y]\n\n---\n\nROUND 3 (if needed):\nIssues addressed: [list]\n\nImproved version:\n[Paste]\n\nNew critique scores: [list all]\nImprovement magnitude: [Large/Medium/Small/None]\nStopping rule triggered? [which one]\n\n---\n\nFINAL ANALYSIS:\n- Stopped after round: [X]\n- Which stopping rule triggered: [rule]\n- Total improvement from round 1: [assessment]\n- Was additional iteration worth the tokens? [yes/no, why]",
          "required": true,
          "rows": 44
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Constitutional Critique",
      "description": "Practice the constitutional critique pattern with explicit requirements.",
      "fields": [
        {
          "id": "constitutional",
          "type": "textarea",
          "label": "Use constitutional critique for a customer support response:",
          "placeholder": "TASK: Write a support response to this complaint:\n\"Your product crashed and I lost 2 hours of work. This is unacceptable.\"\n\nCONSTITUTION (requirements that must be met):\n1. Acknowledge the frustration specifically (empathy)\n2. Apologize for the specific issue (not generic \"sorry for inconvenience\")\n3. Offer concrete next step or solution\n4. Keep under 100 words\n5. Professional but warm tone (not robotic)\n\nPrompt:\n[Write your constitutional critique prompt]\n\nOutput:\n## Response\n[generated response]\n\n## Constitution Check\n1. Empathy: [1-5] - [specific note]\n2. Specific apology: [1-5] - [specific note]\n3. Concrete solution: [1-5] - [specific note]\n4. Length: [1-5] - [word count]\n5. Tone: [1-5] - [specific note]\n\nLowest score: [which one]\n\n## Revised Response (required if any score < 4)\n[improved version addressing specifically the lowest-scoring criterion]",
          "required": true,
          "rows": 32
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Adversarial Critique",
      "description": "Practice adversarial self-critique for a recommendation.",
      "fields": [
        {
          "id": "adversarial",
          "type": "textarea",
          "label": "Use adversarial critique for a business recommendation:",
          "placeholder": "TASK: Propose a solution to reduce customer churn for a SaaS company.\n\nSTEP 1 - Generate proposal:\n[Your solution proposal]\n\nSTEP 2 - Adversarial critique (separate API call):\n\nPrompt: \"Argue against this proposal as harshly as possible:\n- What could go catastrophically wrong?\n- What assumptions are you making that might be completely false?\n- Who would object and what would they say?\n- What is the strongest counter-argument that would make someone reject this?\n- What obvious alternatives are you ignoring?\n\nBe harsh. Find real problems.\"\n\nAdversarial output:\n[Paste the counter-arguments]\n\nSTEP 3 - Improved proposal:\nAddress each objection explicitly:\n\nObjection 1: [objection]\nResponse: [how addressed]\n\nObjection 2: [objection]\nResponse: [how addressed]\n\n[Continue for all major objections]\n\nRevised proposal:\n[Improved solution that addresses the objections]",
          "required": true,
          "rows": 38
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: Factual Limitation Awareness",
      "description": "Understand when self-critique cannot help.",
      "fields": [
        {
          "id": "factual_limits",
          "type": "textarea",
          "label": "For each scenario, identify whether self-critique will help or whether external verification is needed:",
          "placeholder": "SCENARIO ANALYSIS:\n\n1. Blog post has awkward phrasing and weak introduction\n   Self-critique effective? [Yes - style issue]\n   External verification needed? [No]\n   Reasoning: [explain]\n\n2. Technical article claims a specific library supports feature X\n   Self-critique effective? [Limited - cannot verify fact]\n   External verification needed? [Yes - check documentation]\n   Reasoning: [explain]\n\n3. Marketing copy is too long and lacks clear CTA\n   Self-critique effective? [Yes/No]\n   External verification needed? [Yes/No]\n   Reasoning: [explain]\n\n4. Financial report cites specific revenue figures\n   Self-critique effective? [Yes/No]\n   External verification needed? [Yes/No]\n   Reasoning: [explain]\n\n5. Code explanation has confusing structure\n   Self-critique effective? [Yes/No]\n   External verification needed? [Yes/No]\n   Reasoning: [explain]\n\n6. Historical summary includes dates and events\n   Self-critique effective? [Yes/No]\n   External verification needed? [Yes/No]\n   Reasoning: [explain]\n\nPATTERN IDENTIFIED:\n- Self-critique is effective for: [summary]\n- External verification is needed for: [summary]\n- Red flags that require external verification: [list]",
          "required": true,
          "rows": 36
        }
      ]
    }
  ],
  "deliverables": [
    "Three-step self-critique with separate API calls showing independence",
    "Vague vs specific critique comparison with actionable issue counts",
    "Iterative improvement with explicit stopping rules and magnitude tracking",
    "Constitutional critique with all criteria scored and addressed",
    "Adversarial critique with objections explicitly addressed",
    "Factual limitation analysis distinguishing style issues from knowledge gaps"
  ],
  "success_criteria": [
    "Critique uses granular scoring (1-10) with specific notes",
    "Rubber-stamp prevention techniques produce actionable feedback",
    "Stopping rules are explicit and applied correctly",
    "Constitutional critique scores all criteria and revises low scores",
    "Adversarial critique identifies substantive objections with explicit responses",
    "Factual limitations correctly identified as needing external verification"
  ]
}'::jsonb
WHERE slug = 'self-critique';

-- Verify the update
SELECT slug, title,
       LENGTH(content_markdown) as content_length,
       exercise_schema IS NOT NULL as has_schema
FROM sections
WHERE slug = 'self-critique';
