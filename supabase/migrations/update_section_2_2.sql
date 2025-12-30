-- ============================================================================
-- UPDATE SECTION 2.2: Task Templates & Instruction Systems
-- ============================================================================
-- Run this to update Section 2.2 with modernized content
-- Reframes "prompt patterns" as "task templates" for consistency with Module 1
-- ============================================================================

-- First, delete old quiz questions for this quiz and re-insert
DELETE FROM quiz_questions WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Prompt Patterns Quiz');

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Prompt Patterns Quiz'), 1,
'What is the main benefit of building reusable task templates?',
'["They sound more professional", "They produce consistent, testable, and improvable outputs", "They impress clients", "They make instructions longer"]',
1,
'Reusable templates create consistency, enable testing, and allow systematic improvement over time.'),

((SELECT id FROM quizzes WHERE title = 'Prompt Patterns Quiz'), 2,
'What are the five components of a well-structured task template?',
'["Role, Goal, Context, Constraints, Format", "Introduction, Body, Conclusion, References, Appendix", "Who, What, When, Where, Why", "Input, Process, Output, Error, Log"]',
0,
'Effective task templates have: Role (who the AI is), Goal (what success looks like), Context (what it needs to know), Constraints (limits), and Format (output structure).'),

((SELECT id FROM quizzes WHERE title = 'Prompt Patterns Quiz'), 3,
'Why should every task template include evaluation criteria?',
'["To make templates longer", "So you can objectively measure if outputs meet your standards", "Clients require it", "AI models demand it"]',
1,
'Evaluation criteria let you objectively test whether outputs meet your standards - essential for improvement and quality control.'),

((SELECT id FROM quizzes WHERE title = 'Prompt Patterns Quiz'), 4,
'What should you do when a task template produces inconsistent results?',
'["Abandon it and write a new one", "Add more constraints, examples, or context to reduce ambiguity", "Use a more expensive model", "Make the template shorter"]',
1,
'Inconsistent results usually mean the template has ambiguity. Add constraints, examples, or clearer context to get consistent outputs.'),

((SELECT id FROM quizzes WHERE title = 'Prompt Patterns Quiz'), 5,
'How does the I→T→O framework apply to task templates?',
'["It does not apply", "Input is context, Transformation is the AI task, Output is the structured result", "I→T→O is only for automation tools", "Templates replace I→T→O"]',
1,
'Task templates follow I→T→O: Input (context you provide), Transformation (what the AI does), Output (structured result). This mental model helps design better templates.');

-- Update the section content
UPDATE sections
SET
  title = 'Task Templates & Instruction Systems',
  content_markdown = '# Task Templates & Instruction Systems

Random one-off instructions produce random results. Operators build **task templates**—reusable instruction systems that give consistent, testable outputs.

> **Note:** Some call this "prompt engineering." We call it task design. The skill is clear thinking, not clever wording.

---

## Why Task Templates Matter

| Without Templates | With Templates |
|-------------------|----------------|
| Different results each time | Consistent, predictable outputs |
| Can''t measure quality | Testable with clear criteria |
| Start from scratch each time | Build on proven patterns |
| Hard to improve | Systematic iteration |
| Knowledge stays in your head | Documented and shareable |

Templates turn ad-hoc AI usage into a professional system.

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

When you design a template, think:
- **What inputs does the AI need?** (Context, examples, constraints)
- **What transformation should it perform?** (Analyze, classify, generate, debug)
- **What output format do I need?** (JSON, markdown, specific structure)

---

## The Five Components of a Task Template

Every effective template has:

### 1. Role — Who the AI Is

Sets the expertise and perspective.

```
You are a senior systems architect who specializes in
automation for small businesses.
```

**Why it matters:** Roles shape vocabulary, depth, and approach.

### 2. Goal — What Success Looks Like

Clear definition of the task and success criteria.

```
Your job is to analyze this business process and identify:
- Bottlenecks that cause delays
- Steps that could be automated
- Quick wins (implementable in < 1 week)
```

**Why it matters:** Without a clear goal, outputs wander.

### 3. Context — What the AI Needs to Know

Background information for the specific task.

```
CONTEXT:
- Business: Local gym with 3 locations
- Current tools: Google Sheets, Gmail, paper sign-in
- Budget: $200/month for new tools
- Team: Non-technical, 2 hours/week for maintenance
```

**Why it matters:** Context prevents generic answers.

### 4. Constraints — What to Avoid

Boundaries and limitations.

```
CONSTRAINTS:
- No custom code (must be no-code tools only)
- Must integrate with existing Google Workspace
- No tools requiring > 1 hour training
- Avoid enterprise-priced solutions
```

**Why it matters:** Constraints focus the solution space.

### 5. Format — How to Structure Output

Exact output structure you need.

```
FORMAT:
Return your analysis as:

## Current Process Summary
[2-3 sentences]

## Bottlenecks Identified
1. [Bottleneck]: [Impact] → [Suggested fix]
2. ...

## Quick Wins (< 1 week to implement)
| Win | Tool | Effort | Impact |
|-----|------|--------|--------|

## Recommended Prioritization
[Numbered list]
```

**Why it matters:** Format enables parsing and consistency.

---

## Complete Template Example: Process Analyzer

```
ROLE:
You are a business process analyst specializing in
automation for small businesses using no-code tools.

GOAL:
Analyze the process I describe and provide:
1. A clear rewrite of the current process
2. I→T→O breakdown (inputs, transformations, outputs)
3. 4-layer architecture mapping (Interface, Automation, Data, AI)
4. Three improvement options ranked by complexity

CONTEXT:
[User provides process description here]

CONSTRAINTS:
- All solutions must use no-code tools
- Budget: under $100/month
- Implementable within 1 week
- No coding required from business owner
- Must work for non-technical users

FORMAT:
## Current Process (Rewritten)
[Clear, step-by-step description]

## I→T→O Breakdown
- **Inputs:** [List]
- **Transformations:** [List]
- **Outputs:** [List]

## 4-Layer Architecture
| Layer | Current State | Recommended |
|-------|---------------|-------------|
| Interface | | |
| Automation | | |
| Data | | |
| AI | | |

## Improvement Options
### Option 1: Quick Win (Simplest)
- **Change:** [What to do]
- **Tools:** [Specific tools]
- **Effort:** [Time estimate]
- **Impact:** [Expected improvement]

### Option 2: Moderate (Balanced)
[Same structure]

### Option 3: Comprehensive (Most Impact)
[Same structure]

## Recommendation
[Which option and why, given the context]

EVALUATION CRITERIA:
- Did it correctly identify the I→T→O flow?
- Are tool recommendations appropriate for the constraints?
- Is the format followed exactly?
- Are options genuinely ranked by complexity?
```

---

## Adding Evaluation Criteria

Every production template should include evaluation criteria:

```
EVALUATION CRITERIA:
□ Output follows the exact format specified
□ All constraints were respected
□ Recommendations are actionable (specific tools named)
□ I→T→O breakdown is accurate
□ Options are genuinely different in complexity
```

This lets you:
- **Test** the template systematically
- **Grade** outputs objectively
- **Improve** based on failures
- **Train** others to verify quality

---

## Template Categories for Operators

### Process & Systems

| Template | Purpose | Output |
|----------|---------|--------|
| Process Analyzer | Break down business processes | I→T→O mapping, improvements |
| System Designer | Design new automation systems | 4-layer architecture |
| Integration Planner | Plan tool connections | Data flow diagram, steps |
| Bottleneck Finder | Identify efficiency problems | Prioritized issue list |

### Technical

| Template | Purpose | Output |
|----------|---------|--------|
| Code Generator | Write code with context | Commented, tested code |
| Code Reviewer | Analyze code quality | Issues, suggestions, rating |
| Debugger | Find and fix bugs | Root cause, fix, explanation |
| Schema Designer | Design data structures | Schema with relationships |

### Content & Communication

| Template | Purpose | Output |
|----------|---------|--------|
| Documentation Writer | Create user docs | Structured documentation |
| Email Drafter | Write professional emails | Ready-to-send drafts |
| Error Message Improver | Make errors helpful | User-friendly messages |
| Meeting Summarizer | Extract action items | Structured summary |

---

## Template Versioning

Treat templates like code—version them:

```markdown
# Process Analyzer Template

**Version:** 2.3
**Last Updated:** 2025-01-15
**Author:** [Name]
**Tested With:** Claude Sonnet, GPT-4o

## Changelog
- v2.3: Added constraint for non-technical users
- v2.2: Improved format for 4-layer mapping
- v2.1: Added evaluation criteria
- v2.0: Complete rewrite with I→T→O framework
- v1.0: Initial version

## Template
[Full template text]

## Test Cases
1. [Input] → [Expected output characteristics]
2. [Input] → [Expected output characteristics]

## Known Limitations
- Struggles with highly technical processes
- May suggest tools outside constraint budget if not explicit
```

---

## Debugging Templates

When a template produces bad outputs:

### Problem: Inconsistent Results

**Symptom:** Same input gives different outputs each time

**Fixes:**
- Add more constraints to narrow solution space
- Include examples of good outputs
- Make format more specific
- Reduce ambiguity in goal statement

### Problem: Ignoring Constraints

**Symptom:** Output violates rules you set

**Fixes:**
- Move constraints earlier in template (after goal)
- Make constraints explicit with "NEVER" and "ALWAYS"
- Add evaluation criteria that check constraints
- Use structured output (JSON) to force compliance

### Problem: Generic/Shallow Outputs

**Symptom:** Answers are too high-level or obvious

**Fixes:**
- Add more specific context
- Request "specific examples" or "concrete steps"
- Add constraint: "Be specific. Name tools, time estimates, costs."
- Include few-shot examples showing desired depth

### Problem: Wrong Format

**Symptom:** Output doesn''t match requested structure

**Fixes:**
- Use markdown headers in format section
- Show exact template with placeholders
- Add "Follow this format exactly" instruction
- Request JSON for strict structure

---

## Template Performance Tracking

Track how templates perform over time:

| Metric | What It Measures | Target |
|--------|------------------|--------|
| **Consistency Rate** | Same quality across uses | > 90% |
| **Constraint Compliance** | Follows all rules | 100% |
| **Format Accuracy** | Matches expected structure | > 95% |
| **Evaluation Pass Rate** | Meets all criteria | > 85% |
| **Revision Rate** | Needs human editing | < 20% |

If metrics drop, the template needs improvement.

---

## Storing Your Template Library

### Option 1: Structured Document

```markdown
# Operator Template Library

## Process Templates
### Process Analyzer (v2.3)
[Full template]
[Test cases]
[Evaluation criteria]

### System Designer (v1.5)
[Full template]
...

## Technical Templates
...
```

### Option 2: Template Database

| Name | Category | Version | Last Used | Success Rate |
|------|----------|---------|-----------|--------------|
| Process Analyzer | Process | 2.3 | Today | 94% |
| Code Reviewer | Technical | 1.2 | Yesterday | 89% |

### Option 3: Tool-Specific

- **Claude Projects:** Store as project instructions
- **Custom GPTs:** Build as custom GPT
- **API:** Store in configuration/database

---

## Template Design Principles

### 1. Specificity Over Flexibility

Bad: "Analyze this and give suggestions"
Good: "Analyze this process for bottlenecks. For each bottleneck, identify: cause, impact (time/money), and one fix using no-code tools."

### 2. Format Enables Automation

Bad: "Write a report about the findings"
Good: Return as JSON with structure:
```json
{
  "bottlenecks": [{"name": "", "impact": "", "fix": ""}],
  "priority_order": [],
  "estimated_time_saved": ""
}
```

### 3. Constraints Prevent Hallucination

More constraints = more focused output = fewer errors

### 4. Examples Beat Descriptions

Instead of describing what you want, show it:
```
EXAMPLE OUTPUT:
## Bottleneck: Manual Data Entry
- **Impact:** 4 hours/week wasted
- **Fix:** Zapier connection from form to spreadsheet
- **Effort:** 30 minutes to set up
```

### 5. Evaluation Enables Improvement

If you can''t evaluate it, you can''t improve it.

---

## Key Takeaways

1. **Templates are systems** — Not one-off instructions, but tested, versioned tools
2. **I→T→O applies** — Input (context), Transformation (AI task), Output (structured result)
3. **Five components** — Role, Goal, Context, Constraints, Format
4. **Evaluation is required** — Every template needs criteria to test against
5. **Version your templates** — Track changes, test systematically, improve over time
6. **Debug systematically** — When outputs fail, diagnose and fix the template
7. **Clear thinking > clever wording** — This is task design, not magic',

  exercise_markdown = '## Exercise: Build Your Task Template Library

Complete the interactive exercise below to create and test your first production-ready templates.',

  exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Template Design Fundamentals",
      "description": "Demonstrate understanding of the five template components.",
      "fields": [
        {
          "id": "ito_explanation",
          "type": "textarea",
          "label": "Explain how the I→T→O framework applies to task templates. Give a specific example:",
          "placeholder": "Input: The context I provide (e.g., process description)\nTransformation: What the AI does (e.g., analyze for bottlenecks)\nOutput: The structured result (e.g., prioritized improvement list)\n\nExample: For a lead classifier template...",
          "required": true,
          "rows": 6
        },
        {
          "id": "component_purpose",
          "type": "textarea",
          "label": "For each of the 5 template components, explain why it matters:",
          "placeholder": "1. Role: Sets expertise and vocabulary because...\n2. Goal: Defines success so the AI knows when...\n3. Context: Prevents generic answers by...\n4. Constraints: Focuses the solution space by...\n5. Format: Enables consistency and parsing by...",
          "required": true,
          "rows": 8
        },
        {
          "id": "bad_template_diagnosis",
          "type": "textarea",
          "label": "This template produces inconsistent results. Diagnose the problems:\n\n\"Analyze this business process and tell me how to improve it. Be helpful.\"",
          "placeholder": "Problems I identified:\n1. Missing Role: ...\n2. Vague Goal: ...\n3. No Context requirements: ...\n4. No Constraints: ...\n5. No Format: ...\n\nHow I would fix it: ...",
          "required": true,
          "rows": 6
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
            "Process Analyzer - Breaks down business processes using I→T→O and 4-layer model",
            "Code Reviewer - Analyzes code for bugs, style issues, and improvements",
            "Meeting Summarizer - Extracts decisions, action items, and follow-ups",
            "Lead Qualifier - Classifies leads with confidence scores and next actions",
            "Custom - I have a different use case"
          ]
        },
        {
          "id": "custom_usecase",
          "type": "text",
          "label": "If you chose Custom, describe your use case:",
          "placeholder": "e.g., Customer complaint analyzer, Content brief generator, etc.",
          "required": false
        },
        {
          "id": "template_role",
          "type": "textarea",
          "label": "Write the ROLE section of your template:",
          "placeholder": "You are a [specific expertise] who specializes in [domain]. You have experience with [relevant background].",
          "required": true,
          "rows": 3
        },
        {
          "id": "template_goal",
          "type": "textarea",
          "label": "Write the GOAL section of your template:",
          "placeholder": "Your job is to [specific task]. You will:\n1. [First thing to do]\n2. [Second thing to do]\n3. [Third thing to do]",
          "required": true,
          "rows": 5
        },
        {
          "id": "template_context",
          "type": "textarea",
          "label": "Write the CONTEXT section (what information will users provide?):",
          "placeholder": "CONTEXT:\n[User provides: description of X]\n[User provides: relevant background Y]\n[User provides: specific constraints Z]",
          "required": true,
          "rows": 4
        },
        {
          "id": "template_constraints",
          "type": "textarea",
          "label": "Write the CONSTRAINTS section (at least 4 constraints):",
          "placeholder": "CONSTRAINTS:\n- NEVER [thing to avoid]\n- ALWAYS [thing to include]\n- Maximum [limit]\n- Must be [requirement]",
          "required": true,
          "rows": 5
        },
        {
          "id": "template_format",
          "type": "textarea",
          "label": "Write the FORMAT section (exact output structure):",
          "placeholder": "FORMAT:\nReturn your analysis as:\n\n## Section 1: [Name]\n[What goes here]\n\n## Section 2: [Name]\n| Column | Column |\n|--------|--------|\n\n## Section 3: [Name]\n[Structure]",
          "required": true,
          "rows": 8
        },
        {
          "id": "template_evaluation",
          "type": "textarea",
          "label": "Write EVALUATION CRITERIA (at least 5 checkboxes):",
          "placeholder": "EVALUATION CRITERIA:\n□ Output follows the exact format specified\n□ All constraints were respected\n□ [Specific quality check]\n□ [Specific quality check]\n□ [Specific quality check]",
          "required": true,
          "rows": 6
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
            "Not yet, I will test after this exercise"
          ]
        },
        {
          "id": "test_input_1",
          "type": "textarea",
          "label": "Test Case 1: Describe the input you used and summarize the output quality:",
          "placeholder": "Input: [Brief description of what you provided]\nOutput Quality: [Did it meet evaluation criteria? What worked? What didn''t?]\nScore: [X/5 evaluation criteria passed]",
          "required": true,
          "rows": 5
        },
        {
          "id": "test_input_2",
          "type": "textarea",
          "label": "Test Case 2: Different input, document results:",
          "placeholder": "Input: [Brief description]\nOutput Quality: [Assessment]\nScore: [X/5 criteria passed]",
          "required": true,
          "rows": 5
        },
        {
          "id": "template_issues",
          "type": "textarea",
          "label": "What issues did you discover during testing? How will you fix them?",
          "placeholder": "Issue 1: [Problem observed]\nFix: [How I will modify the template]\n\nIssue 2: [Problem observed]\nFix: [How I will modify the template]",
          "required": true,
          "rows": 5
        },
        {
          "id": "template_v2",
          "type": "textarea",
          "label": "Based on testing, what specific changes will you make for Version 2?",
          "placeholder": "Version 2 changes:\n1. Role: [Change or keep]\n2. Goal: [Change or keep]\n3. Context: [Change or keep]\n4. Constraints: [Add/modify X]\n5. Format: [Change or keep]\n6. Evaluation: [Add/modify X]",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Build Your Template Library",
      "description": "Create two more templates and document your library.",
      "fields": [
        {
          "id": "template_2_summary",
          "type": "textarea",
          "label": "Template #2: Provide a summary (name, purpose, key components):",
          "placeholder": "Name: [Template Name]\nPurpose: [What it does]\nRole: [Brief]\nGoal: [Brief]\nKey Constraints: [2-3 main ones]\nOutput Format: [Brief description]\nEvaluation: [2-3 key criteria]",
          "required": true,
          "rows": 8
        },
        {
          "id": "template_3_summary",
          "type": "textarea",
          "label": "Template #3: Provide a summary (name, purpose, key components):",
          "placeholder": "Name: [Template Name]\nPurpose: [What it does]\nRole: [Brief]\nGoal: [Brief]\nKey Constraints: [2-3 main ones]\nOutput Format: [Brief description]\nEvaluation: [2-3 key criteria]",
          "required": true,
          "rows": 8
        },
        {
          "id": "library_location",
          "type": "radio",
          "label": "Where will you store your template library?",
          "required": true,
          "options": [
            "Notion or similar documentation tool",
            "Markdown file in a repository",
            "Dedicated template database/spreadsheet",
            "Claude Projects / Custom GPTs",
            "Other system"
          ]
        },
        {
          "id": "library_structure",
          "type": "textarea",
          "label": "Describe your library structure (how will you organize and version templates?):",
          "placeholder": "Organization:\n- Categories: [Process, Technical, Content, etc.]\n- Each template includes: [Version, changelog, test cases, etc.]\n- Version numbering: [How I will track versions]\n- Testing process: [How I will validate before using in production]",
          "required": true,
          "rows": 6
        }
      ]
    }
  ],
  "deliverables": [
    "Explained I→T→O framework for templates with examples",
    "Created a complete 5-component template with evaluation criteria",
    "Tested template and documented results",
    "Identified issues and planned improvements for Version 2",
    "Designed a library structure for organizing templates"
  ],
  "success_criteria": [
    "Templates include all 5 components (Role, Goal, Context, Constraints, Format)",
    "Every template has testable evaluation criteria",
    "You tested with real inputs and documented quality",
    "You identified issues and have a plan to fix them",
    "You have a system for storing, versioning, and improving templates"
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
