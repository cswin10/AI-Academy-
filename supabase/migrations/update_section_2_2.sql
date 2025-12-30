-- ============================================================================
-- UPDATE SECTION 2.2: Task Templates & Instruction Systems
-- ============================================================================
-- Run this to update Section 2.2 with modernized content
-- Reframes "prompt patterns" as "task templates" for consistency with Module 1
-- ============================================================================

-- First, rename the quiz
UPDATE quizzes
SET title = 'Task Templates Quiz'
WHERE title = 'Prompt Patterns Quiz';

-- Delete old quiz questions and re-insert
DELETE FROM quiz_questions WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Task Templates Quiz');

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Task Templates Quiz'), 1,
'What is the main benefit of building reusable task templates?',
'["They sound more professional", "They produce consistent, testable, and improvable outputs", "They impress clients", "They make instructions longer"]',
1,
'Reusable templates create consistency, enable testing, and allow systematic improvement over time.'),

((SELECT id FROM quizzes WHERE title = 'Task Templates Quiz'), 2,
'What are the five components of a well-structured task template?',
'["Role, Goal, Context, Constraints, Format", "Introduction, Body, Conclusion, References, Appendix", "Who, What, When, Where, Why", "Input, Process, Output, Error, Log"]',
0,
'Effective task templates have: Role (who the AI is), Goal (what success looks like), Context (what it needs to know), Constraints (limits), and Format (output structure).'),

((SELECT id FROM quizzes WHERE title = 'Task Templates Quiz'), 3,
'What is an "execution boundary" in the context of AI task templates?',
'["The maximum length of a prompt", "Whether AI output is informational, draft-only, or safe to auto-execute", "How many times you can run a template", "The edge of the context window"]',
1,
'Execution boundaries define what AI is allowed to do: informational only, draft requiring approval, safe to auto-execute, or never auto-execute. This prevents unsafe automation.'),

((SELECT id FROM quizzes WHERE title = 'Task Templates Quiz'), 4,
'Why should you separate "thinking templates" from "execution templates"?',
'["To make more templates", "To prevent god prompts that try to analyze, decide, and act in one step", "AI cannot think and execute", "It is required by all APIs"]',
1,
'Separating thinking (analyze, recommend) from doing (execute, send) prevents dangerous god prompts and keeps humans in control of decisions.'),

((SELECT id FROM quizzes WHERE title = 'Task Templates Quiz'), 5,
'What should you do when a template produces inconsistent results?',
'["Abandon it and write a new one", "Add relevant constraints, examples, or context to reduce ambiguity", "Use a more expensive model", "Make the template shorter"]',
1,
'Inconsistent results usually mean the template has ambiguity. Add relevant constraints, examples, or clearer context to get consistent outputs.');

-- Update the section content
UPDATE sections
SET
  title = 'Task Templates & Instruction Systems',
  content_markdown = '# Task Templates & Instruction Systems

Random one-off instructions produce random results. Operators build **task templates**—reusable instruction systems that give consistent, testable outputs.

> **The skill is clear thinking, not clever wording.**

---

## Why Task Templates Matter

| Without Templates | With Templates |
|-------------------|----------------|
| Different results each time | Consistent, predictable outputs |
| Can''t measure quality | Testable with clear criteria |
| Start from scratch each time | Build on proven patterns |
| Hard to improve | Systematic iteration |
| Knowledge stays in your head | Documented and shareable |

### When Templates Work Best

Templates work best when:
- The task repeats
- Success can be defined
- Output can be checked
- You can provide consistent context

**Avoid templating:**
- One-off strategy decisions
- Novel creative direction with no criteria
- High-risk decisions without a human gate

---

## The I→T→O Framework for Templates

Every task template follows the I→T→O pattern from Module 1:

```
INPUT (Context you provide)
    ↓
TRANSFORMATION (What the AI does)
    ↓
OUTPUT (Structured result)
```

When designing a template, think:
- **What inputs does the AI need?**
- **What transformation should it perform?**
- **What output format do I need?**

**If you can''t clearly write the I→T→O for a task, you are not ready to template it yet.**

---

## The Five Components of a Task Template

### 1. Role — Who the AI Is

Sets the expertise and perspective.

```
You are a senior systems architect who specializes in
automation for small businesses.
```

> The role sets perspective and vocabulary, not authority or correctness. AI can still be wrong regardless of role.

### 2. Goal — What Success Looks Like

Clear definition of the task and success criteria.

```
Your job is to analyze this business process and identify:
- Bottlenecks that cause delays
- Steps that could be automated
- Quick wins (implementable in < 1 week)
```

### 3. Context — What the AI Needs to Know

Background information for the specific task.

```
CONTEXT:
- Business: Local gym with 3 locations
- Current tools: Google Sheets, Gmail
- Budget: $200/month for new tools
- Team: Non-technical
```

### 4. Constraints — What to Avoid

Boundaries and limitations.

```
CONSTRAINTS:
- No custom code (no-code tools only)
- Must integrate with Google Workspace
- No enterprise-priced solutions
```

> **Put the most important constraints first.** LLMs are more likely to follow constraints when they appear early and are written explicitly.

More relevant constraints reduce ambiguity and error rates.

### 5. Format — How to Structure Output

Exact output structure you need.

```
FORMAT:
## Summary
[2-3 sentences]

## Bottlenecks
| Issue | Impact | Fix |
|-------|--------|-----|

## Recommendation
[Numbered list]
```

---

## Execution Boundaries: What AI Is Allowed to Do

**Critical:** A task template must define whether AI output is:

| Boundary | Meaning | Example |
|----------|---------|---------|
| **Informational only** | Output is for human reading | Analysis reports, explanations |
| **Draft (approval required)** | Human must approve before action | Email drafts, response suggestions |
| **Auto-execute with guardrails** | System can act within safe limits | Auto-tag tickets, but never close them |
| **Safe to auto-execute** | System can act on output directly | Classification tags, data extraction |
| **Never auto-execute** | Always requires human decision | Financial changes, customer deletions |

### Examples

```
Template: Email Drafter
Execution Boundary: DRAFT ONLY
→ Human approves before sending

Template: Lead Classifier
Execution Boundary: SAFE TO AUTO-EXECUTE
→ System can tag leads automatically

Template: Support Ticket Router
Execution Boundary: AUTO-EXECUTE WITH GUARDRAILS
→ Auto-assign team and priority, never auto-send the response

Template: Refund Recommender
Execution Boundary: NEVER AUTO-EXECUTE
→ Human makes final decision
```

**Default assumption:** If not specified, treat output as draft-only.

---

## Separate Thinking from Doing

Operators never build "god prompts" that try to analyze, decide, and act in one step.

### The Pattern

```
THINKING TEMPLATE (Analysis)
    ↓
DECISION (Human or separate template)
    ↓
EXECUTION TEMPLATE (Action)
```

### Example: Lead Follow-up

**Wrong (god prompt):**
```
Analyze this lead, decide if they''re qualified,
and draft an email to send them.
```

**Right (separated):**
```
Template 1: Lead Analyzer
→ Output: Qualification score, reasoning

Human Decision: Approve follow-up?

Template 2: Email Drafter
→ Output: Draft email (requires approval)

Human Action: Send
```

This prevents dangerous automation and keeps humans accountable.

---

## Adding Evaluation Criteria

Every production template needs testable criteria:

```
EVALUATION CRITERIA:
□ Output follows the exact format specified
□ All constraints were respected
□ Recommendations are specific (tools named)
□ Reasoning is provided for each suggestion
□ Output includes specific next steps (not just suggestions)
```

This lets you:
- **Test** the template systematically
- **Grade** outputs objectively
- **Improve** based on failures

---

## Template Performance Tracking

Track how templates perform over time:

| Metric | What It Measures | Target |
|--------|------------------|--------|
| **Consistency Rate** | Same quality across uses | > 90% |
| **Constraint Compliance** | Follows all rules | 100% |
| **Format Accuracy** | Matches expected structure | > 95% |
| **Revision Rate** | Needs human editing | < 20% |
| **False Positive Rate** | Wrong confident outputs that slip through | < 5% |

If metrics drop, the template needs improvement.

---

## Confidence Thresholds in Templates

Some templates should include confidence scores:

```json
{
  "classification": "hot_lead",
  "confidence": 0.87,
  "reasoning": "Budget confirmed, timeline urgent"
}
```

Use confidence for execution decisions:
- **High confidence (>85%):** Safe to auto-execute
- **Medium confidence (60-85%):** Queue for review
- **Low confidence (<60%):** Fallback or manual

**Thresholds depend on risk.** The higher the risk, the higher the confidence required:
- Tagging leads: 0.75 might be fine
- Auto-emailing customers: even 0.95 may not be enough without review

This connects directly to the confidence thresholds from Section 2.1.

---

## Template Versioning

Treat templates like code:

```markdown
# Process Analyzer Template

**Version:** 2.3
**Last Updated:** 2025-01-15

## Changelog
- v2.3: Added execution boundary
- v2.2: Improved format constraints
- v2.1: Added evaluation criteria

## Template
[Full template text]

## Test Cases
1. [Input] → [Expected output]
2. [Input] → [Expected output]
```

---

## Debugging Templates

When a template produces bad outputs:

### Inconsistent Results
**Fix:** Add relevant constraints, examples, or clearer context

### Ignoring Constraints
**Fix:** Move constraints earlier in template, use "NEVER" and "ALWAYS"

### Generic/Shallow Outputs
**Fix:** Add specific context, request "specific examples" and "concrete steps"

### Wrong Format
**Fix:** Show exact template with placeholders, request JSON for strict structure

### Quality Degraded After Changes
**Fix:** Revert to previous version and retest before modifying again

---

## Template Categories

**Process & Systems:**
- Process Analyzer (I→T→O mapping)
- System Designer (4-layer architecture)
- Integration Planner (data flow)

**Technical:**
- Code Generator, Code Reviewer, Debugger

**Content:**
- Documentation Writer, Email Drafter, Meeting Summarizer

**Classification:**
- Lead Qualifier, Support Ticket Router, Sentiment Analyzer

---

## Storing Your Template Library

The principle: **findable and versioned**.

**Options:**
1. **Structured document** (Notion, markdown file)
2. **Template database** (spreadsheet with version tracking)
3. **Tool-specific** (Claude Projects, Custom GPTs)

What matters:
- Can you find it quickly?
- Is it versioned?
- Are test cases documented?

---

## Key Takeaways

1. **Templates are systems** — Tested, versioned, improvable
2. **I→T→O applies** — Input, Transformation, Output
3. **Five components** — Role, Goal, Context, Constraints, Format
4. **Define execution boundaries** — Informational, draft, auto-execute, never
5. **Separate thinking from doing** — No god prompts
6. **Evaluation is required** — Can''t improve what you can''t measure
7. **Track performance** — Consistency, compliance, revision rate
8. **Include confidence** — For execution decisions
9. **Version everything** — Treat templates like code',

  exercise_markdown = '## Exercise: Build Your Task Template Library

Complete the interactive exercise below to create and test your first production-ready templates.',

  exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Template Design Fundamentals",
      "description": "Demonstrate understanding of the core concepts.",
      "fields": [
        {
          "id": "ito_explanation",
          "type": "textarea",
          "label": "Explain how the I→T→O framework applies to task templates with a specific example:",
          "placeholder": "Input: [what context I provide]\nTransformation: [what the AI does]\nOutput: [the structured result]\n\nExample: For a lead classifier template...",
          "required": true,
          "rows": 5
        },
        {
          "id": "execution_boundaries",
          "type": "textarea",
          "label": "For each of these tasks, define the appropriate execution boundary (informational, draft, auto-execute with guardrails, auto-execute, never auto-execute):",
          "placeholder": "1. Lead classification → [boundary] because...\n2. Customer email response → [boundary] because...\n3. Support ticket routing → [boundary] because...\n4. Refund approval → [boundary] because...",
          "required": true,
          "rows": 6
        },
        {
          "id": "god_prompt_fix",
          "type": "textarea",
          "label": "This is a god prompt. Break it into separate thinking and execution templates:\n\n\"Analyze this customer complaint, decide if they deserve a refund, and draft the response email.\"",
          "placeholder": "Template 1: Complaint Analyzer\nPurpose: [thinking only]\nExecution Boundary: Informational\n\nHuman Decision Point: [what human decides]\n\nTemplate 2: Response Drafter\nPurpose: [execution]\nExecution Boundary: Draft only",
          "required": true,
          "rows": 8
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Build Your First Template",
      "description": "Create a complete, production-ready task template.",
      "fields": [
        {
          "id": "template_choice",
          "type": "radio",
          "label": "Choose a template to build:",
          "required": true,
          "options": [
            "Process Analyzer - Breaks down business processes using I→T→O",
            "Lead Qualifier - Classifies leads with confidence scores",
            "Code Reviewer - Analyzes code for issues and improvements",
            "Meeting Summarizer - Extracts decisions and action items",
            "Custom - I have a different use case"
          ]
        },
        {
          "id": "custom_usecase",
          "type": "text",
          "label": "If you chose Custom, describe your use case:",
          "placeholder": "e.g., Customer complaint analyzer, Content brief generator",
          "required": false
        },
        {
          "id": "execution_boundary",
          "type": "radio",
          "label": "What is the execution boundary for this template?",
          "required": true,
          "options": [
            "Informational only - output is for human reading",
            "Draft - requires human approval before action",
            "Auto-execute with guardrails - system can act within safe limits",
            "Safe to auto-execute - system can act directly",
            "Never auto-execute - always requires human decision"
          ]
        },
        {
          "id": "template_role",
          "type": "textarea",
          "label": "Write the ROLE section (remember: sets perspective, not authority):",
          "placeholder": "You are a [specific expertise] who [relevant experience].",
          "required": true,
          "rows": 2
        },
        {
          "id": "template_goal",
          "type": "textarea",
          "label": "Write the GOAL section:",
          "placeholder": "Your job is to [specific task]. You will:\n1. [First deliverable]\n2. [Second deliverable]",
          "required": true,
          "rows": 4
        },
        {
          "id": "template_constraints",
          "type": "textarea",
          "label": "Write the CONSTRAINTS section (most important first, at least 4):",
          "placeholder": "CONSTRAINTS:\n- NEVER [most critical constraint]\n- ALWAYS [important requirement]\n- [Additional constraint]\n- [Additional constraint]",
          "required": true,
          "rows": 5
        },
        {
          "id": "template_format",
          "type": "textarea",
          "label": "Write the FORMAT section (exact output structure):",
          "placeholder": "FORMAT:\n## Section 1\n[What goes here]\n\n## Section 2\n| Column | Column |\n|--------|--------|",
          "required": true,
          "rows": 6
        },
        {
          "id": "template_evaluation",
          "type": "textarea",
          "label": "Write EVALUATION CRITERIA (at least 5 checkboxes, including specific next steps):",
          "placeholder": "EVALUATION CRITERIA:\n□ Output follows exact format\n□ All constraints respected\n□ [Specific quality check]\n□ [Specific quality check]\n□ Output includes specific next steps",
          "required": true,
          "rows": 6
        },
        {
          "id": "confidence_output",
          "type": "textarea",
          "label": "If applicable, show the JSON structure for confidence scoring in your template output:",
          "placeholder": "{\n  \"result\": \"...\",\n  \"confidence\": 0.85,\n  \"reasoning\": \"...\"\n}",
          "required": false,
          "rows": 5
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Test Your Template",
      "description": "Test your template and document the results.",
      "fields": [
        {
          "id": "test_completed",
          "type": "radio",
          "label": "Have you tested your template with real inputs?",
          "required": true,
          "options": [
            "Yes, I tested it 3+ times",
            "Yes, I tested it 1-2 times",
            "Not yet, I will test after"
          ]
        },
        {
          "id": "test_results",
          "type": "textarea",
          "label": "Document your test results (at least 2 test cases):",
          "placeholder": "Test 1:\nInput: [brief description]\nResult: [passed/failed] - [what worked/didn''t]\n\nTest 2:\nInput: [brief description]\nResult: [passed/failed] - [what worked/didn''t]",
          "required": true,
          "rows": 6
        },
        {
          "id": "metrics",
          "type": "textarea",
          "label": "Estimate your template''s current metrics:",
          "placeholder": "Consistency Rate: [X]% (same quality each time)\nConstraint Compliance: [X]% (follows all rules)\nFormat Accuracy: [X]% (matches structure)\nRevision Rate: [X]% (needs human editing)\nFalse Positive Rate: [X]% (wrong outputs that passed)",
          "required": true,
          "rows": 6
        },
        {
          "id": "v2_changes",
          "type": "textarea",
          "label": "Based on testing, what specific changes for Version 2?",
          "placeholder": "1. [Change to constraints because...]\n2. [Change to format because...]\n3. [Add/modify evaluation criteria...]",
          "required": true,
          "rows": 5
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Build Your Library",
      "description": "Create a second template and document your library structure.",
      "fields": [
        {
          "id": "template_2",
          "type": "textarea",
          "label": "Template #2 Summary (different category from Template #1):",
          "placeholder": "Name: [Template Name]\nCategory: [Process/Technical/Content/Classification]\nExecution Boundary: [informational/draft/guardrails/auto-execute/never]\nPurpose: [What it does]\nKey Constraints: [2-3 main ones]",
          "required": true,
          "rows": 7
        },
        {
          "id": "library_structure",
          "type": "textarea",
          "label": "Describe your library structure:",
          "placeholder": "Storage: [Where - Notion/Markdown/etc.]\nOrganization: [By category/use case]\nVersioning: [How I track versions]\nTest cases: [Where documented]",
          "required": true,
          "rows": 5
        },
        {
          "id": "thinking_vs_doing",
          "type": "textarea",
          "label": "For a complex workflow in your domain, show how you would separate thinking templates from execution templates:",
          "placeholder": "Workflow: [Describe the workflow]\n\nThinking Template: [What it analyzes]\n→ Execution Boundary: Informational\n\nHuman Decision: [What human decides]\n\nExecution Template: [What it does]\n→ Execution Boundary: [Draft/Guardrails/Auto-execute]",
          "required": true,
          "rows": 8
        }
      ]
    }
  ],
  "deliverables": [
    "Explained I→T→O and execution boundaries",
    "Broke down a god prompt into separate templates",
    "Created a complete template with all 5 components",
    "Tested and documented results with metrics",
    "Designed a library structure with versioning"
  ],
  "success_criteria": [
    "Templates include all 5 components plus execution boundary",
    "You can identify and fix god prompts",
    "You tested with real inputs and tracked metrics",
    "You separate thinking templates from execution templates",
    "You have a versioned, findable library structure"
  ]
}'::jsonb
WHERE slug = 'prompt-patterns';

-- Update external resources to remove "prompt engineering" / "prompting" language
UPDATE external_resources
SET title = 'LLM Task Design - Complete Guide'
WHERE section_id = (SELECT id FROM sections WHERE slug = 'prompt-patterns')
AND title LIKE '%Prompt%';

-- Verify the update
SELECT slug, title,
  CASE WHEN exercise_schema IS NOT NULL THEN 'Has Schema' ELSE 'No Schema' END as schema_status,
  LENGTH(content_markdown) as content_length
FROM sections
WHERE slug = 'prompt-patterns';
