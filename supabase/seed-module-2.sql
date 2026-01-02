-- ============================================================================
-- MODULE 2: LLM Mastery - GPT & Claude
-- ============================================================================

-- First, remove any existing Module 2 data to avoid duplicates
-- Use PL/pgSQL to properly capture quiz IDs via module association before cleanup
DO $$
DECLARE
  v_quiz_ids UUID[];
BEGIN
  -- Capture quiz IDs linked to this module before cleanup
  SELECT array_agg(s.quiz_id) INTO v_quiz_ids
  FROM sections s
  INNER JOIN modules m ON s.module_id = m.id
  WHERE m.slug = 'llm-mastery' AND s.quiz_id IS NOT NULL;

  -- Delete quiz_questions for captured quizzes
  IF v_quiz_ids IS NOT NULL THEN
    DELETE FROM quiz_questions WHERE quiz_id = ANY(v_quiz_ids);
  END IF;

  -- Delete external_resources
  DELETE FROM external_resources WHERE section_id IN (
    SELECT id FROM sections WHERE module_id IN (
      SELECT id FROM modules WHERE slug = 'llm-mastery'
    )
  );

  -- Delete sections
  DELETE FROM sections WHERE module_id IN (
    SELECT id FROM modules WHERE slug = 'llm-mastery'
  );

  -- Delete quizzes by captured IDs
  IF v_quiz_ids IS NOT NULL THEN
    DELETE FROM quizzes WHERE id = ANY(v_quiz_ids);
  END IF;

  -- Delete module
  DELETE FROM modules WHERE slug = 'llm-mastery';
END $$;

-- Also cleanup any orphaned quizzes by title (in case they exist from failed runs)
DELETE FROM quiz_questions WHERE quiz_id IN (
  SELECT id FROM quizzes WHERE title IN (
    'What LLMs Are Quiz',
    'Prompt Patterns Quiz',
    'Chain-of-Thought Quiz',
    'System Prompts Quiz',
    'Model Selection Quiz',
    'Context Windows Quiz'
  )
);
DELETE FROM quizzes WHERE title IN (
  'What LLMs Are Quiz',
  'Prompt Patterns Quiz',
  'Chain-of-Thought Quiz',
  'System Prompts Quiz',
  'Model Selection Quiz',
  'Context Windows Quiz'
);

-- Insert Module 2
INSERT INTO modules (track_id, slug, title, short_description, order_index, estimated_hours, level, xp_reward, is_active)
SELECT
  id,
  'llm-mastery',
  'LLM Mastery - GPT & Claude',
  'Learn to use large language models as your main collaborators: to think, design, build, debug, and learn faster.',
  2,
  5,
  'Beginner',
  50,
  true
FROM tracks WHERE slug = 'core-foundation';

-- Create quizzes for Module 2
INSERT INTO quizzes (title, description, difficulty, passing_score, xp_reward) VALUES
('What LLMs Are Quiz', 'Test your understanding of LLMs and their role for operators', 'beginner', 70, 10),
('Prompt Patterns Quiz', 'Test your knowledge of effective prompting patterns', 'beginner', 70, 10),
('Chain-of-Thought Quiz', 'Test your understanding of reasoning techniques', 'intermediate', 75, 15),
('System Prompts Quiz', 'Test your knowledge of system prompts and role engineering', 'intermediate', 75, 15),
('Model Selection Quiz', 'Test your understanding of model selection and costs', 'intermediate', 75, 15),
('Context Windows Quiz', 'Test your knowledge of context management', 'intermediate', 75, 15);

-- ============================================================================
-- SECTION 2.1: What LLMs Are and How They Help Operators
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'What LLMs Are Quiz'), 1,
'For an AI operator, which of these is the most accurate description of an LLM?',
'["A tool for generating random text", "A multi-purpose collaborator that can explain, plan, code, and write", "A database of facts", "A graphics engine"]',
1,
'LLMs are versatile collaborators that assist with explanation, planning, coding, writing, and more - not random generators or fact databases.'),

((SELECT id FROM quizzes WHERE title = 'What LLMs Are Quiz'), 2,
'Which model tier should you use for high-volume lead classification (10,000+ per month)?',
'["Claude Opus 4 for best quality", "Claude Haiku or GPT-4o-mini for cost efficiency", "Always use the most expensive model", "It does not matter which model you use"]',
1,
'Simple, repetitive tasks like classification should use fast, cheap models like Haiku or GPT-4o-mini. Save expensive models for complex reasoning.'),

((SELECT id FROM quizzes WHERE title = 'What LLMs Are Quiz'), 3,
'What is "model routing" in the context of LLM operations?',
'["Sending requests to random models", "Directing different task types to appropriate models based on complexity", "Using only one model for everything", "Routing network traffic"]',
1,
'Model routing means matching tasks to the right model - simple tasks to cheap/fast models, complex tasks to powerful models. This optimizes cost and quality.'),

((SELECT id FROM quizzes WHERE title = 'What LLMs Are Quiz'), 4,
'Which of these is a REQUIRED practice for production LLM systems?',
'["Using only the newest models", "Having fallbacks, human override, and observability", "Avoiding structured outputs", "Never logging LLM responses"]',
1,
'Production LLM systems must have fallbacks (for failures), human override (for corrections), and observability (logging/monitoring). These are non-negotiable.'),

((SELECT id FROM quizzes WHERE title = 'What LLMs Are Quiz'), 5,
'Why should you use structured outputs (JSON) instead of free-form text in automation?',
'["JSON looks more professional", "Structured outputs can be reliably parsed and used by downstream systems", "Free-form text is never useful", "It is required by all APIs"]',
1,
'Structured outputs like JSON can be reliably parsed by code. Free-form text is unpredictable and hard to use in automation workflows.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'what-llms-are',
  'What LLMs Are and How They Help Operators',
  1,
  'Beginner',
  '# What LLMs Are and How They Help Operators

Large Language Models (LLMs) like GPT and Claude are your most important tools as an AI operator. Understanding what they are, what they''re good at, and how to use them effectively will 10x your productivity.

## What LLMs Actually Are

Technically, LLMs are neural networks trained to predict the next token (word piece) in text. They''ve learned patterns from massive amounts of human writing, code, and knowledge.

**Practically, they''re your multi-purpose collaborators:**

| Role | What They Do | Example |
|------|--------------|---------|
| **Teacher** | Explain any concept at your level | "Explain webhooks like I''m 10" |
| **Architect** | Design systems and workflows | "Design a lead routing system" |
| **Engineer** | Write and debug code | "Write a Python script to parse this CSV" |
| **Writer** | Create documentation and content | "Write user-facing docs for this API" |
| **Analyst** | Synthesize information and find patterns | "Analyze these support tickets for trends" |
| **Debugger** | Find and fix issues | "Why is this Zapier workflow failing?" |

## The 2024/2025 Model Landscape

The model landscape has evolved significantly. Here''s what you need to know:

### Claude Models (Anthropic)

| Model | Best For | Context | Speed | Cost |
|-------|----------|---------|-------|------|
| **Claude Sonnet 4** | Daily driver - code, analysis, writing | 200K tokens | Fast | Medium |
| **Claude Opus 4** | Complex reasoning, architecture, hard problems | 200K tokens | Slower | Higher |
| **Claude Haiku** | Classification, extraction, high-volume tasks | 200K tokens | Very Fast | Low |

### OpenAI Models

| Model | Best For | Context | Speed | Cost |
|-------|----------|---------|-------|------|
| **GPT-4.1** | Structured outputs, tool use, JSON | 128K tokens | Fast | Medium |
| **o1 / o3** | Complex reasoning, math, logic puzzles | 200K tokens | Slow | High |
| **GPT-4o-mini** | Simple tasks, classification, high volume | 128K tokens | Very Fast | Very Low |

### When to Use Which

**Use Claude Sonnet 4 for:**
- Code generation and refactoring
- Long document analysis (contracts, specs)
- System architecture design
- Detailed explanations
- Most everyday operator work

**Use Claude Opus 4 / o1 for:**
- Complex multi-step reasoning
- Difficult debugging
- Strategic planning
- Problems that require "thinking hard"

**Use Haiku / GPT-4o-mini for:**
- Lead classification (hot/warm/cold)
- Data extraction (pull email from text)
- Format conversion (CSV to JSON)
- Any high-volume, simple task

## Model Routing: A Key Operator Skill

Smart operators don''t use one model for everything. They **route tasks to the right model**:

```
Simple classification → Haiku ($0.25/1M tokens)
Standard code task → Sonnet 4 ($3/1M tokens)
Complex architecture → Opus 4 ($15/1M tokens)
```

**Example routing logic:**
```
IF task is classification or extraction:
    use Haiku
ELSE IF task requires deep reasoning:
    use Opus 4 with extended thinking
ELSE:
    use Sonnet 4 (default)
```

This approach can reduce costs by 80% while maintaining quality where it matters.

## Model Fallbacks: Build Resilient Systems

Production systems need fallbacks. Models have outages, rate limits, and failures.

**Pattern: Primary → Fallback → Manual**
```
1. Try Claude Sonnet 4
2. If fails → Try GPT-4.1
3. If fails → Queue for human review
```

Never build systems that depend on a single model with no backup plan.

## API vs Chat Interface

As an operator, you''ll use LLMs two ways:

### Chat Interface (ChatGPT, Claude.ai)
- **Best for:** Learning, exploration, one-off tasks
- **How it works:** You type, AI responds, back and forth
- **Limitation:** Manual, doesn''t scale

### API (Programmatic Access)
- **Best for:** Production systems, automation, integration
- **How it works:** Your code sends requests, gets responses
- **Advantage:** Scales infinitely, integrates with workflows

**You need both.** Start with chat to learn and prototype. Move to API when you need automation.

## Structured Outputs: Get Predictable Results

Modern LLMs can output structured data (JSON) reliably. This is critical for automation.

**Without structured output:**
```
"The lead seems warm, probably medium priority,
maybe follow up next week..."
```

**With structured output:**
```json
{
  "classification": "warm",
  "priority": "medium",
  "next_action": "follow_up",
  "follow_up_date": "2025-01-06"
}
```

The second version can be parsed and used by your automation. Always request structured output when building systems.

## Extended Thinking for Hard Problems

Claude Opus 4 and o1/o3 support "extended thinking" - they can reason through complex problems step by step before answering.

**When to use extended thinking:**
- Complex debugging with multiple possible causes
- System design with many tradeoffs
- Multi-step logic problems
- Anything where you''d want a human to "think carefully"

**When NOT to use it:**
- Simple classification
- Straightforward code generation
- Anything routine

Extended thinking is slower and more expensive. Use it strategically.

## The Human Override Principle

**Every LLM integration needs a human override path.**

LLMs will make mistakes. Your systems must allow humans to:
1. **Review** - See what the AI decided
2. **Correct** - Fix wrong outputs
3. **Learn** - Feed corrections back to improve prompts

Bad pattern: LLM → Auto-send email to customer (no review)
Good pattern: LLM → Draft email → Human approves → Send

## Observability: Know When Things Go Wrong

Production LLM systems need logging and monitoring:

**Log these for every LLM call:**
- Input (what you sent)
- Output (what you got back)
- Model used
- Latency (how long it took)
- Token count (cost tracking)
- Success/failure

**Alert on:**
- Error rate spikes
- Latency increases
- Unexpected outputs
- Cost anomalies

If you can''t see what''s happening, you can''t fix it when it breaks.

## What LLMs Are NOT

**They are NOT:**
- ❌ Perfect databases of facts (they hallucinate)
- ❌ Replacement for testing (always test their code)
- ❌ Deterministic (same input can give different outputs)
- ❌ Aware of real-time information (knowledge cutoff exists)
- ❌ Able to take actions (they can only suggest, you execute)

**They ARE:**
- ✅ Incredibly fast at research and synthesis
- ✅ Great at pattern recognition and transformation
- ✅ Excellent at explaining complexity simply
- ✅ Tireless - available 24/7
- ✅ Probabilistic reasoning engines

## The Operator + LLM Partnership

Think of LLMs as capable but inexperienced team members who need supervision:

| LLM Strengths | Your Strengths |
|---------------|----------------|
| Speed - instant responses | Judgment - knowing what''s right |
| Breadth - knows many topics | Context - understanding the business |
| Consistency - doesn''t get tired | Verification - checking the work |
| Scale - handles volume | Decision-making - final calls |

**The partnership formula:**
```
You provide: Clear instructions + Context + Verification
LLM provides: Speed + Knowledge + Draft outputs
Result: 10x productivity
```

## Real Example: Time Saved

**Building an Airtable integration WITHOUT LLM:**
1. Research Airtable API docs (2 hours)
2. Figure out authentication (1 hour)
3. Write integration code (2 hours)
4. Debug errors (1.5 hours)
5. Write error handling (1 hour)
6. Test edge cases (1 hour)
**Total: 8.5 hours**

**Building the same integration WITH LLM:**
1. Ask LLM for complete integration code with auth (15 mins)
2. Review and understand the code (30 mins)
3. Ask LLM to add error handling (10 mins)
4. Test and ask LLM to fix issues (30 mins)
5. Final review and deploy (15 mins)
**Total: 1.5 hours**

**7 hours saved** - and you learned more because you focused on understanding rather than syntax debugging.

## Key Takeaways

1. **Match models to tasks** - Don''t use Opus for classification
2. **Build with fallbacks** - Never depend on one model
3. **Use structured outputs** - JSON is your friend for automation
4. **Keep humans in the loop** - Every system needs override capability
5. **Log everything** - Observability is not optional
6. **Verify outputs** - Trust but verify, always',

  '## Exercise: Model Selection and Comparison

This exercise is completed through the interactive form below. Complete all parts to understand when to use each model.',

  50,
  true,
  (SELECT id FROM quizzes WHERE title = 'What LLMs Are Quiz')
FROM modules m
WHERE m.slug = 'llm-mastery';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Prompt Engineering Tutorial – Beginner''s Guide to LLMs',
  'https://www.youtube.com/watch?v=_ZvnD96BXbY',
  'video',
  1
FROM sections WHERE slug = 'what-llms-are'
UNION ALL
SELECT
  id,
  'Introduction to Large Language Models',
  'https://www.youtube.com/watch?v=RBzXsQHjptQ',
  'video',
  2
FROM sections WHERE slug = 'what-llms-are';

-- ============================================================================
-- SECTION 2.2: Prompt Patterns & Prompt Systems
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Prompt Patterns Quiz'), 1,
'What is the benefit of creating reusable prompt patterns?',
'["They sound more professional", "They produce more consistent and reliable outputs", "They impress clients", "They make prompts longer"]',
1,
'Reusable patterns create consistency in outputs, making your work more reliable and predictable.'),

((SELECT id FROM quizzes WHERE title = 'Prompt Patterns Quiz'), 2,
'Which of these is NOT a key element of a well-structured prompt?',
'["Role - who the AI is", "Goal - what success looks like", "Random poetry - for inspiration", "Constraints - what to avoid"]',
2,
'Effective prompts need clear structure (role, goal, context, constraints, format), not unnecessary additions.'),

((SELECT id FROM quizzes WHERE title = 'Prompt Patterns Quiz'), 3,
'When should you save prompts as reusable templates?',
'["Never, always write new prompts", "Only for complex tasks you repeat frequently", "For any task you might do more than once", "Only if a client asks"]',
2,
'Any prompt you might reuse is worth saving. This builds your operator toolkit over time.'),

((SELECT id FROM quizzes WHERE title = 'Prompt Patterns Quiz'), 4,
'What is a "Process Architect" prompt pattern best used for?',
'["Writing social media posts", "Analyzing and designing business processes", "Creating images", "Scheduling meetings"]',
1,
'The Process Architect pattern helps analyze processes and design system improvements - core operator work.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'prompt-patterns',
  'Prompt Patterns & Prompt Systems',
  2,
  'Beginner',
  '# Prompt Patterns & Prompt Systems

Random one-off prompts produce random results. Operators build **prompt systems**—reusable patterns that give consistent outputs.

## The Universal Prompt Pattern

Every good prompt should have:

**1. Role** - Who the AI is
```
"You are my process architect"
"You are a senior Python developer"
```

**2. Goal** - What success looks like
```
"Your job is to redesign this process to be more efficient"
"Help me debug this code and explain what was wrong"
```

**3. Context** - What the AI needs to know
```
"The business is a small gym with 3 locations"
"We use Airtable for CRM and Zapier for automation"
```

**4. Constraints** - What to avoid
```
"Don''t use paid tools over $50/month"
"Keep explanation under 500 words"
"No custom code required"
```

**5. Format** - How to structure output
```
"Return as a numbered list"
"Structure as: Problem, Solution, Steps"
"Give 3 options from simplest to most advanced"
```

## Example: Process Architect Pattern
```
You are my process architect.

GOAL:
I will describe a workflow. Your job is to:
- Rewrite it clearly
- Identify inputs, transformations, outputs
- Map to the 4-layer model
- Suggest 2-3 improvement options

CONTEXT:
[Process description goes here]

CONSTRAINTS:
- Implementable within 1 week
- Budget under $100/month
- No custom development

FORMAT:
1. Current Process (rewrite)
2. Process Breakdown (I→T→O)
3. 4-Layer Architecture
4. Improvement Options (3, ranked by complexity)
```

**Save this.** You''ll use it dozens of times.

## Building Your Prompt Library

Over time, build prompts for:

**Process Design:**
- Process Architect
- Workflow Optimizer
- System Designer

**Technical:**
- Code Writer
- Code Refactorer
- Debugger
- Schema Designer

**Content:**
- Documentation Writer
- Email Copywriter
- Error Message Improver

## Where to Store Prompts

**Option 1:** Notion database with prompt name, category, full text, examples

**Option 2:** Simple markdown file:
```markdown
# My Prompt Library

## Process Architect
[full prompt]

## Code Debugger
[full prompt]
```

**Option 3:** Tool-specific (Claude Projects, GPT Custom Instructions)

## Improving Your Prompts

1. Start with basic version
2. Use it 5-10 times
3. Refine based on gaps
4. Test with edge cases
5. Document what works

## Common Mistakes

**Mistake 1: Too Vague**
Bad: "Make this better"
Good: "Improve this code''s error handling and add comments"

**Mistake 2: Not Enough Context**
Bad: "Why doesn''t this work?"
Good: "This Zapier workflow should trigger on new Airtable records but it''s not. Here''s the config: [paste]"

**Mistake 3: Asking Too Much at Once**
Break complex tasks into steps.

**Mistake 4: Not Iterating**
Always ask follow-ups to refine outputs.',

  '## Exercise: Build Your First 3 Prompt Patterns

**Objective:** Create reusable prompt templates.

**Instructions:**

### Part 1: Create Your First Pattern

Choose one to create:

**Option A: Process Architect**
- Analyzes business processes
- Maps to 4-layer model
- Suggests improvements

**Option B: Code Debugger**
- Identifies bugs
- Explains what''s wrong
- Provides fixes

**Option C: Documentation Writer**
- Takes technical description
- Creates user-friendly docs
- Includes troubleshooting

Using the universal pattern structure (Role, Goal, Context, Constraints, Format), write your complete prompt.

### Part 2: Test It 3 Times

Use your pattern with 3 different inputs.

Note what works and what doesn''t.

### Part 3: Refine

Improve your prompt based on test results. Write "Version 2."

### Part 4: Create Two More

Pick two more common tasks and create prompts for them.

### Part 5: Build Your Library

Create a document with:
```markdown
# My Prompt Library

## [Pattern Name]
**Purpose:** [What this is for]
**Model:** [GPT or Claude]
**Prompt:** [Full text]
**Example:** [One example]
```

**Deliverable:**

Prompt library with 3 tested patterns.

**Success Criteria:**
- Each prompt has all 5 elements
- Tested 3 times each
- Produces consistent results
- Saved and accessible',

  45,
  true,
  (SELECT id FROM quizzes WHERE title = 'Prompt Patterns Quiz')
FROM modules m
WHERE m.slug = 'llm-mastery';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Learn Prompting - Full Course',
  'https://www.youtube.com/watch?v=aOm75o2Z5-o',
  'video',
  1
FROM sections WHERE slug = 'prompt-patterns';

-- ============================================================================
-- SECTION 2.3: Chain-of-Thought & Reasoning Techniques
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Chain-of-Thought Quiz'), 1,
'What is Chain-of-Thought prompting?',
'["Making the AI think faster", "Asking the AI to show its reasoning step-by-step", "Using multiple AI models", "Writing long prompts"]',
1,
'Chain-of-Thought prompting asks the AI to break down reasoning into steps, improving accuracy.'),

((SELECT id FROM quizzes WHERE title = 'Chain-of-Thought Quiz'), 2,
'When should you use Chain-of-Thought prompting?',
'["For simple questions", "For complex problems requiring multi-step reasoning", "Never", "Only for math"]',
1,
'Chain-of-Thought is most valuable for complex problems where you need to verify the reasoning.'),

((SELECT id FROM quizzes WHERE title = 'Chain-of-Thought Quiz'), 3,
'Which phrase effectively triggers Chain-of-Thought reasoning?',
'["Answer quickly", "Let''s think step by step", "Give me the answer only", "Be brief"]',
1,
'Phrases like "Let''s think step by step" explicitly trigger step-by-step thinking.'),

((SELECT id FROM quizzes WHERE title = 'Chain-of-Thought Quiz'), 4,
'What is "few-shot" prompting?',
'["Using very short prompts", "Providing examples of desired input-output patterns", "Only asking a few questions", "Using cheap models"]',
1,
'Few-shot means giving examples, which helps the AI understand the pattern you want.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'chain-of-thought',
  'Chain-of-Thought & Reasoning Techniques',
  3,
  'Intermediate',
  '# Chain-of-Thought & Reasoning Techniques

The quality of your AI outputs depends on how you ask the AI to think.

## What is Chain-of-Thought?

Chain-of-Thought (CoT) means asking the AI to **show its work**—to break down reasoning into steps.

**Without CoT:**
Prompt: "Should I use Zapier or Make?"
Response: "Use Make, it''s more powerful."

**With CoT:**
Prompt: "Should I use Zapier or Make? Think through the trade-offs step by step."
Response:
```
1. Complexity: Your automation needs [X] steps
   - Both can handle it

2. Cost: Zapier $X/mo vs Make $Y/mo = $Z difference

3. Learning curve: You know Zapier (0 hours) vs Make (~5 hours)

4. Future needs: Both scale well

Recommendation: Stick with Zapier because you already know it, cost difference is minimal, and you can migrate later if needed.
```

Now you understand the reasoning.

## How to Trigger Chain-of-Thought

Use these phrases:
- "Let''s think step by step"
- "Show your reasoning"
- "Walk me through your thought process"
- "Break this down into steps"

## Few-Shot Prompting

"Few-shot" means giving examples of what you want.

**Example:**
```
Classify leads as High, Medium, or Low:

Example 1:
Lead: "Just browsing"
Classification: Low
Reason: No urgency

Example 2:
Lead: "Need solution for 50-person team next quarter"
Classification: Medium
Reason: Specific need, reasonable timeline

Example 3:
Lead: "C-level approved budget for 500 users. Need ASAP."
Classification: High
Reason: Decision maker, large deal, urgent

Now classify this lead:
"Interested in your product for my 500-person company. Budget approved."
```

Result: Consistent, reliable classifications.

## Self-Critique Pattern

Ask the AI to critique its own work:
```
Design a customer onboarding workflow.

[AI provides design]

Now critique your design:
- What could go wrong?
- What did you not consider?
- How could it be improved?
```

This catches issues the first response missed.

## Asking for Trade-Offs

Never accept single recommendations without trade-offs.

**Bad:** "Should I use Supabase or Firebase?"

**Good:**
```
Compare Supabase vs Firebase for a small SaaS:
1. Ease of use (for basic SQL knowledge)
2. Cost at 1k, 5k, 20k users
3. Features
4. Vendor lock-in risk
5. Migration difficulty

Give me a decision matrix, not just a recommendation.
```

## Step-by-Step Planning

For complex projects, ask for phased approach:
```
I want to build customer success automation.

Week 1: Simplest useful version?
Week 2: What to add next?
Week 3: After that?
Week 4: Mature version?

For each week: what gets built, what value it delivers, what it doesn''t do yet.
```

Prevents over-engineering.',

  '## Exercise: Advanced Reasoning Practice

**Objective:** Master Chain-of-Thought techniques.

**Instructions:**

### Part 1: Chain-of-Thought Debugging

**Scenario:**
```
Automation: Form → Zapier → Airtable → Email

Problem:
- Airtable record creates ✓
- Email doesn''t send ✗
- Emails with "+" symbol fail completely

Workflow:
1. Trigger: New form submission
2. Action: Create Airtable record
3. Action: Send email (Gmail)
4. Action: Send Slack message
```

Write a prompt using Chain-of-Thought to debug this. Test it with Claude or GPT.

### Part 2: Few-Shot Classification

Create a lead classifier with examples.

Provide 3 examples for each category: Hot, Warm, Cold, Unqualified

Then test with 5 new leads:
1. "Can you send me more info?"
2. "CEO approved $50k budget. Need to onboard 100 users by Q1 end."
3. "Do you offer free trials? Just exploring."
4. "Student doing research for a paper."
5. "Using [competitor] but unhappy. Contract ends next month."

Document accuracy.

### Part 3: Self-Critique Design

Design a gym membership inquiry system.

Then prompt the AI to:
1. Identify 3 failure points
2. Suggest mitigations
3. Rate robustness (1-10)
4. Provide improved version

Compare original vs improved.

### Part 4: Trade-Off Analysis

Choose a tool (database, automation platform, etc.)

Compare 3-4 options on:
- Cost
- Ease of use
- Features
- Scalability
- Lock-in risk

Get decision matrix and recommendation for 3 scenarios.

**Deliverable:**

Document with all 4 exercises completed, including prompts used and AI responses.

**Success Criteria:**
- Used Chain-of-Thought for debugging
- Created working few-shot classifier
- Improved a design through self-critique
- Analyzed trade-offs systematically',

  50,
  true,
  (SELECT id FROM quizzes WHERE title = 'Chain-of-Thought Quiz')
FROM modules m
WHERE m.slug = 'llm-mastery';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Advanced Prompt Engineering Techniques',
  'https://www.youtube.com/watch?v=hhHdMQ48HVo',
  'video',
  1
FROM sections WHERE slug = 'chain-of-thought'
UNION ALL
SELECT
  id,
  'Chain of Thought Prompting Explained',
  'https://www.youtube.com/watch?v=yVP88nZrHZ0',
  'video',
  2
FROM sections WHERE slug = 'chain-of-thought';

-- ============================================================================
-- SECTION 2.4: System Prompts & Role Engineering
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'System Prompts Quiz'), 1,
'What is a system prompt?',
'["A prompt about computer systems", "Instructions that set AI behavior for an entire conversation", "A prompt that crashes the AI", "A very short prompt"]',
1,
'System prompts define the AI''s role and behavior for the entire conversation or session.'),

((SELECT id FROM quizzes WHERE title = 'System Prompts Quiz'), 2,
'Where are system prompts most commonly used?',
'["In one-off ChatGPT questions", "In API integrations and custom tools", "Only in GPT-4", "Nowhere"]',
1,
'System prompts are essential in API integrations where you need consistent behavior.'),

((SELECT id FROM quizzes WHERE title = 'System Prompts Quiz'), 3,
'What should a good system prompt include?',
'["Only the AI''s role", "Role, knowledge, behavior rules, output format, constraints", "Just examples", "As little as possible"]',
1,
'Comprehensive system prompts define role, knowledge, behavior, format, and constraints.'),

((SELECT id FROM quizzes WHERE title = 'System Prompts Quiz'), 4,
'Why is role engineering important?',
'["Makes prompts longer", "Shapes AI perspective and expertise for better outputs", "It''s not important", "Only works with GPT"]',
1,
'Role engineering helps the AI adopt the right expertise and perspective for better results.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'system-prompts',
  'System Prompts & Role Engineering',
  4,
  'Intermediate',
  '# System Prompts & Role Engineering

When you build tools with AI, you need **system prompts**—persistent instructions that define behavior across many interactions.

## What is a System Prompt?

A system prompt is instructions that persist across an entire conversation or session.

**In ChatGPT/Claude:** Set once at start, affects every message

**In API Integrations:** Included in every call to ensure consistent behavior

## Example: Customer Support Bot

**Without System Prompt:**
Random, inconsistent responses with no policy adherence.

**With System Prompt:**
```
You are customer support for TechShop, an electronics retailer.

ROLE: Helpful, professional, empathetic

KNOWLEDGE:
- Refund policy: 30 days, original packaging
- Store credit: Available past 30 days
- Damaged items: Always refund/replace

BEHAVIOR:
- Verify order details first
- Escalate if: >$500, angry customer, policy exception
- Never make up policies

CONSTRAINTS:
- Don''t process refunds yourself
- Don''t share internal info

FORMAT:
- Under 100 words
- Clear next steps
```

Now every interaction follows policies consistently.

## Anatomy of a Good System Prompt

**1. Identity & Role**
```
You are a senior Python developer specializing in automation.
```

**2. Knowledge Domain**
```
KNOWLEDGE:
- Our company sells B2B SaaS for construction
- Product tracks timelines, budgets, teams
- Customers: 50-500 person firms
```

**3. Behavior & Tone**
```
BEHAVIOR:
- Professional but conversational
- Explain technical concepts simply
- Ask clarifying questions
- Admit when you don''t know
```

**4. Constraints**
```
CONSTRAINTS:
- Never make up data
- Don''t recommend tools over $100/mo without asking
- Never share API keys
```

**5. Output Format**
```
FORMAT:
- Brief summary (1-2 sentences)
- Step-by-step instructions
- Next steps section
```

**6. Escalation Rules**
```
ESCALATE IF:
- Refund >$500
- User mentions legal action
- Outside knowledge domain
```

## Example: Lead Qualifier Bot
```
You are a lead qualification assistant for AutomateFlow.

ROLE: Qualify inbound leads by asking the right questions

KNOWLEDGE:
Services: Process automation, CRM setup, AI integration
Ideal Client: 5-50 employees, $500k-$5M revenue, budget $3k-$15k

GOAL: Classify as Hot/Warm/Cold/Unqualified

QUESTIONS (in order):
1. What task takes too much time?
2. How many people affected?
3. What have you tried?
4. Timeline for solving?
5. Budget allocated?

CONSTRAINTS:
- Don''t pitch services
- Don''t provide solutions yet
- One question at a time
- If unqualified, redirect to free resources

FORMAT:
- 2-3 sentences per response
- One question per response
- Natural conversation

After qualifying, provide:
CLASSIFICATION: [Hot/Warm/Cold/Unqualified]
REASON: [Brief explanation]
NEXT STEP: [What should happen]
```

## System Prompt in Code

When using APIs:
```javascript
const systemPrompt = `You are a lead classifier.

Classify as: HOT, WARM, COLD, or UNQUALIFIED

HOT: Decision maker, clear need, budget, urgent
WARM: Interested, slower timeline
COLD: Early research, no budget
UNQUALIFIED: Wrong market

Format: "CLASSIFICATION: [X] - [Reason]"`;

// API call with system prompt
const response = await fetch(''https://api.anthropic.com/v1/messages'', {
  body: JSON.stringify({
    model: ''claude-3-5-sonnet-20241022'',
    system: systemPrompt,
    messages: [{ role: ''user'', content: userMessage }]
  })
});
```

## Testing System Prompts

1. Write v1
2. Test with 10 varied inputs
3. Note failures
4. Refine
5. Test again
6. Repeat until consistent

Test with:
- Normal cases
- Edge cases
- Hostile inputs
- Ambiguous requests

## Common Mistakes

**Mistake 1: Too Vague**
Bad: "You are helpful"
Good: "You are customer support for TechCo. Help users troubleshoot app issues. Escalate refunds to support@techco.com"

**Mistake 2: Conflicting Instructions**
Bad: "Be concise. Provide detailed explanations. Keep short."
Good: "Provide brief answers (2-3 sentences) by default. If user asks for detail, provide thorough explanation."

**Mistake 3: No Format**
Always specify output structure for consistency.

**Mistake 4: Not Testing**
Write once, test many times.',

  '## Exercise: Build Production System Prompts

**Objective:** Create and test system prompts for real use cases.

**Instructions:**

### Part 1: Lead Qualification Bot

Build a lead qualifier for a business (real or fictional).

**Define:**
- What they sell
- Ideal customer
- Typical deal size

**Create system prompt with:**
1. Role and identity
2. Knowledge domain
3. Behavior rules
4. Questions to ask
5. Classification criteria
6. Output format

**Test with 5 leads:**
1. "Can you send prices?"
2. "100-person company, 20hrs/week manual work, $10k budget"
3. "Student researching for paper"
4. "Interested, can we talk next quarter?"
5. "Competitor quoted $50k, too much. Your price?"

Document how it classified each.

### Part 2: Customer Support Bot

Build support bot for a SaaS product.

**Define:**
- Product functionality
- Common issues
- Policies (refunds, hours, etc.)

**Create system prompt with:**
1. Role
2. Knowledge base
3. Behavior/tone
4. Escalation rules
5. Constraints
6. Format

**Test with:**
1. "Doesn''t work. Want money back."
2. "How do I export data?"
3. "Been trying to reach someone for 3 days!"
4. "Can you add [feature]?"
5. "Bug - clicking X does nothing."

### Part 3: Code Reviewer

Create system prompt for code reviewer that:
- Reviews for bugs and style
- Provides improvement suggestions
- Rates code quality
- Suggests refactoring

Test with 2-3 code samples.

### Part 4: API Integration Prompt

Pick one use case and write complete system prompt:

**Option A: Email Responder**
- Reads customer emails
- Drafts responses
- Tags with category

**Option B: Data Enricher**
- Takes company name
- Returns industry, size, location, website
- Formats as JSON

**Option C: Meeting Processor**
- Takes raw notes
- Extracts decisions, actions, questions
- Assigns priorities

Include example input/output and pseudocode.

**Deliverable:**

Document with 3-4 complete system prompts, test results, and refinements.

**Success Criteria:**
- Production-ready system prompts
- Tested with real inputs
- Iterated based on results
- Reusable templates created',

  55,
  true,
  (SELECT id FROM quizzes WHERE title = 'System Prompts Quiz')
FROM modules m
WHERE m.slug = 'llm-mastery';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'System Prompts and Custom Instructions',
  'https://www.youtube.com/watch?v=jC4v5AS4RIM',
  'video',
  1
FROM sections WHERE slug = 'system-prompts';

-- ============================================================================
-- SECTION 2.5: Model Selection & Cost Optimization
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Model Selection Quiz'), 1,
'When should you use a smaller, cheaper model instead of GPT-4 or Claude Opus?',
'["Never, always use the best", "For simple, repetitive tasks with clear patterns", "Only if you can''t afford better", "For all production systems"]',
1,
'Smaller models are perfect for simple, repetitive tasks. Save expensive models for complex reasoning.'),

((SELECT id FROM quizzes WHERE title = 'Model Selection Quiz'), 2,
'What is the main cost driver for LLM API usage?',
'["Number of API calls", "Tokens processed (input + output)", "Time of day", "Your location"]',
1,
'LLM APIs charge based on tokens processed - both what you send and what the model generates.'),

((SELECT id FROM quizzes WHERE title = 'Model Selection Quiz'), 3,
'How can you reduce LLM costs in production?',
'["Use the most expensive model for everything", "Cache common responses, use smaller models for simple tasks, optimize prompts", "Make more API calls", "Only use free models"]',
1,
'Caching, right-sizing models to tasks, and efficient prompts all reduce costs significantly.'),

((SELECT id FROM quizzes WHERE title = 'Model Selection Quiz'), 4,
'What is "prompt caching"?',
'["Storing prompts in a database", "Reusing large, unchanged prompt parts to reduce input token costs", "Making prompts shorter", "A paid feature that doesn''t help"]',
1,
'Prompt caching lets you reuse large system prompts across calls, paying only once for those tokens.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'model-selection',
  'Model Selection & Cost Optimization',
  5,
  'Intermediate',
  '# Model Selection & Cost Optimization

Not every task needs GPT-4 or Claude Opus. Smart operators match the model to the task and keep costs under control.

## The Model Landscape

**Top-Tier Models (Most Expensive, Most Capable):**
- GPT-4 Turbo
- Claude 3.5 Opus
- Use for: Complex reasoning, architecture design, difficult problems

**Mid-Tier Models (Balanced):**
- GPT-4o
- Claude 3.5 Sonnet
- Use for: Most operator tasks, code generation, workflow design

**Small Models (Cheap, Fast):**
- GPT-4o-mini
- Claude 3.5 Haiku
- Use for: Classification, simple extraction, repetitive tasks

## Cost Breakdown

LLM APIs charge per token (roughly 4 characters = 1 token).

**Example costs (approximate):**
- GPT-4 Turbo: ~$10 per 1M input tokens
- GPT-4o: ~$2.50 per 1M input tokens
- GPT-4o-mini: ~$0.15 per 1M input tokens

**Real example:**
Classifying 10,000 leads per month, avg 100 tokens each:

With GPT-4o: 10k × 100 tokens × $2.50/1M = **$2.50/month**
With GPT-4o-mini: 10k × 100 tokens × $0.15/1M = **$0.15/month**

For simple classification, mini is perfect.

## Decision Framework

**Use Top-Tier When:**
- Designing complex systems
- Writing critical code
- Strategic analysis
- Novel problems
- High stakes (cost of error > model cost)

**Use Mid-Tier When:**
- Standard operator work
- Code generation
- Documentation
- Workflow design
- Most automation tasks

**Use Small Models When:**
- Classification (hot/warm/cold)
- Simple extraction (pull email from text)
- Format conversion (CSV to JSON)
- Repetitive, pattern-based tasks
- High volume operations

## Cost Optimization Strategies

### 1. Right-Size Your Models

Don''t use GPT-4 to classify leads. Use GPT-4o-mini.

Audit your API calls:
- What task is this?
- Does it need complex reasoning?
- Could a smaller model do this?

### 2. Optimize Prompt Length

Shorter prompts = lower costs.

**Bad (wasteful):**
```
I need you to please help me classify this lead into one of the following categories which I will now list for you: Hot, Warm, Cold, or Unqualified. A hot lead is someone who has decision making authority and has expressed clear intent to purchase soon. A warm lead is... [500 words]
```

**Good (efficient):**
```
Classify lead as Hot/Warm/Cold/Unqualified.

Hot: Decision maker, clear intent, budget
Warm: Interested, slower timeline
Cold: Early research
Unqualified: Wrong fit

Lead: [paste lead info]
```

Same result, 80% fewer tokens.

### 3. Cache System Prompts

If your system prompt is long and unchanging, use prompt caching (supported by Anthropic Claude).

**Without caching:**
Every API call pays for the full system prompt.

**With caching:**
Pay once for system prompt, reuse it across calls.

For 1000 calls with 2000-token system prompt:
- Without cache: 2M tokens = ~$5
- With cache: 2k tokens + 1k cache hits = ~$0.50

**10x cheaper.**

### 4. Batch When Possible

If you need to process 1000 items, don''t make 1000 individual API calls.

**Instead:** Batch 10-50 items per call (if the model can handle it).

Reduces overhead and can be cheaper.

### 5. Set Max Tokens

Prevent runaway costs by limiting output length:
```javascript
{
  model: ''gpt-4o-mini'',
  max_tokens: 150,  // Won''t generate more than this
  messages: [...]
}
```

For classification, you only need 10-20 tokens. Don''t let it generate 1000.

## Monitoring Costs

Track API usage:

**Weekly check:**
- How many calls?
- Average tokens per call?
- Total cost?
- Most expensive operations?

**Monthly review:**
- Which automations cost the most?
- Can any be optimized?
- Are you using the right models?

**Red flags:**
- Costs growing faster than usage
- Single automation using >$50/month
- Small tasks using expensive models

## Example: Lead Classifier Optimization

**v1 (Expensive):**
- Model: GPT-4 Turbo
- System prompt: 1500 tokens (no caching)
- Processing: 10,000 leads/month
- Cost: ~$150/month

**v2 (Optimized):**
- Model: GPT-4o-mini (classification is simple)
- System prompt: 800 tokens (optimized)
- Prompt caching: Enabled
- Processing: 10,000 leads/month
- Cost: ~$2/month

**98.7% cost reduction** with no quality loss.

## When to Splurge

Sometimes expensive models are worth it:

**High-value tasks:**
- Designing $10k+ automations
- Strategic business analysis
- Complex integration planning

**High-risk tasks:**
- Financial calculations
- Legal document review (with human verification)
- Security-critical code

**Cost-benefit check:**
If the model costs $1 but saves you 2 hours of work, it''s worth it.

## Model Selection Checklist

Before each API integration:

□ What''s the task complexity?
□ How many operations per month?
□ What''s my budget?
□ Can a smaller model do this?
□ Is my prompt optimized?
□ Should I cache anything?
□ What''s my max acceptable cost?

Answer these before writing code.',

  '## Exercise: Cost Optimization Audit

**Objective:** Learn to optimize LLM costs.

**Instructions:**

### Part 1: Model Selection Practice

For each task, choose the right model (GPT-4 Turbo, GPT-4o, GPT-4o-mini, Claude Opus, Sonnet, Haiku):

**Task 1:** Classify 5000 customer emails per month as Support/Sales/Billing
Your choice: [?]
Why: [?]

**Task 2:** Design a complex multi-system automation architecture
Your choice: [?]
Why: [?]

**Task 3:** Extract order number from confirmation emails (50k/month)
Your choice: [?]
Why: [?]

**Task 4:** Write a custom authentication system for a SaaS app
Your choice: [?]
Why: [?]

**Task 5:** Convert CSV rows to JSON (100k/month)
Your choice: [?]
Why: [?]

### Part 2: Prompt Optimization

Take this bloated prompt and optimize it:
```
Hello AI assistant, I would like to ask for your help with something. I need you to please take a look at this customer inquiry that I am going to provide to you below and I need you to classify it into one of several categories. The categories are as follows: the first category is "Hot Lead" which means the customer is very interested and ready to buy soon, the second category is "Warm Lead" which means they are interested but need more time, the third category is "Cold Lead" which means they are just browsing, and the fourth category is "Not Qualified" which means they are not a good fit for our product. Please analyze carefully and provide your classification along with a brief explanation of why you chose that category. Here is the inquiry: "We''re a 50-person company looking to implement this next month. Budget is approved. Can we schedule a demo this week?"
```

**Your optimized version:**
[Write here]

**Token reduction:**
Original: ~[count] tokens
Optimized: ~[count] tokens
Savings: [%]

### Part 3: Cost Calculation

**Scenario:** Lead classification system
- Volume: 10,000 leads/month
- Avg input: 150 tokens (lead info)
- Avg output: 30 tokens (classification + reason)
- System prompt: 500 tokens

**Calculate monthly cost for:**

**Option A: GPT-4 Turbo (no caching)**
Input: 10k × (150 + 500) = 6.5M tokens
Output: 10k × 30 = 300k tokens
Cost: [calculate]

**Option B: GPT-4o-mini (no caching)**
Cost: [calculate]

**Option C: GPT-4o-mini (with prompt caching)**
Cost: [calculate]

**Best option and why:** [?]

### Part 4: Real Optimization Challenge

Pick one of your own potential use cases:
- What task?
- Expected volume?
- Current model choice?
- Estimated cost?

Now optimize it:
- Could you use a smaller model?
- Can you shorten the prompt?
- Should you cache anything?
- Can you batch operations?

**Before optimization:** $[?]/month
**After optimization:** $[?]/month
**Savings:** [?]%

**Deliverable:**

Document with all 4 parts completed.

**Success Criteria:**
- Correct model choices with reasoning
- Optimized prompt is clearer and shorter
- Accurate cost calculations
- Real optimization with measurable savings',

  45,
  true,
  (SELECT id FROM quizzes WHERE title = 'Model Selection Quiz')
FROM modules m
WHERE m.slug = 'llm-mastery';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Understanding LLM Pricing and Tokens',
  'https://www.youtube.com/watch?v=BnX7OdYqHXw',
  'video',
  1
FROM sections WHERE slug = 'model-selection';

-- ============================================================================
-- SECTION 2.6: Context Windows & Memory Management
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Context Windows Quiz'), 1,
'What is a context window?',
'["The window where you type prompts", "The maximum amount of text an LLM can process at once", "A browser window", "A chatbot interface"]',
1,
'Context window is the maximum amount of text (input + output) an LLM can handle in one interaction.'),

((SELECT id FROM quizzes WHERE title = 'Context Windows Quiz'), 2,
'What happens when you exceed the context window?',
'["The AI gets smarter", "The AI forgets early parts or the request fails", "Nothing", "It costs more money"]',
1,
'When you exceed context limits, the AI either truncates early content or the request fails entirely.'),

((SELECT id FROM quizzes WHERE title = 'Context Windows Quiz'), 3,
'How can you handle very long documents that exceed context limits?',
'["Give up", "Chunk them and process piece by piece, or use RAG", "Make the font smaller", "Use multiple models at once"]',
1,
'Chunking (breaking into pieces) and RAG (Retrieval-Augmented Generation) let you work with large documents.'),

((SELECT id FROM quizzes WHERE title = 'Context Windows Quiz'), 4,
'Why is conversation history management important?',
'["It''s not important", "Long histories eventually exceed limits and cost more tokens", "To make conversations look prettier", "Only matters for chatbots"]',
1,
'Long conversation histories consume tokens and eventually hit limits. Smart management keeps costs down.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'context-windows',
  'Context Windows & Memory Management',
  6,
  'Intermediate',
  '# Context Windows & Memory Management

LLMs can''t remember everything. Understanding context limits is crucial for building reliable systems.

## What is a Context Window?

The context window is the maximum amount of text an LLM can process at once (input + output combined).

**Current context windows (approximate):**
- GPT-4 Turbo: 128k tokens (~96k words)
- GPT-4o: 128k tokens
- Claude 3.5 Sonnet: 200k tokens (~150k words)
- Claude 3.5 Opus: 200k tokens

## Why It Matters

### 1. Long Documents

If you paste a 200-page PDF into GPT-4o, it might exceed the limit and fail.

### 2. Long Conversations

Each message in a conversation is part of the context. After 100 messages, you might hit limits.

### 3. Cost

Longer context = more tokens = higher cost, even if you''re not using all that information.

## When You Hit the Limit

**What happens:**
- API request fails with error
- Or the AI "forgets" early parts of the conversation
- Or it truncates your input

**Solution:**
- Break content into chunks
- Summarize earlier conversation
- Use RAG (Retrieval-Augmented Generation)

## Handling Long Documents

### Strategy 1: Chunking

Break document into pieces, process separately:
```
Document: 500 pages

Chunk 1 (pages 1-50): Summarize
Chunk 2 (pages 51-100): Summarize
...
Chunk 10 (pages 451-500): Summarize

Then: Synthesize all summaries into final summary
```

### Strategy 2: RAG (Retrieval-Augmented Generation)

Don''t send entire document. Send only relevant parts:

1. Store document in chunks in a database
2. When user asks question, search for relevant chunks
3. Send only those chunks to LLM
4. Get answer based on relevant context

**Example:**
User: "What does the contract say about termination?"

Instead of sending 100-page contract:
- Search contract for "termination" sections
- Send only those 3 pages to LLM
- Get answer

Much cheaper, faster, and doesn''t hit limits.

### Strategy 3: Summarize Then Drill Down

1. Get high-level summary of entire document
2. User asks specific question
3. Find relevant section
4. Send only that section for detailed analysis

## Managing Conversation History

In chatbots or ongoing conversations, history grows:

**Message 1:** 100 tokens
**Message 2:** 100 tokens
...
**Message 100:** Total = 10,000 tokens

Eventually hits limits or gets expensive.

### Strategy 1: Sliding Window

Keep only last N messages:
```javascript
// Keep only last 10 messages
const recentMessages = conversationHistory.slice(-10);

// Send to API
{
  messages: recentMessages
}
```

Older context is lost, but you stay within limits.

### Strategy 2: Summarize Old Context
```
Every 20 messages:
1. Summarize messages 1-20
2. Replace them with summary
3. Keep only summary + recent messages
```

**Before:**
[Msg 1][Msg 2][Msg 3]...[Msg 30] = 3000 tokens

**After:**
[Summary of 1-20][Msg 21][Msg 22]...[Msg 30] = 1200 tokens

### Strategy 3: Store Important Info Separately

Instead of keeping all history, extract key facts:

**Conversation:**
User: "My company is TechCorp, we have 50 employees"
User: "We use Salesforce for CRM"
User: "Budget is $10k"

**Store separately:**
```javascript
userData = {
  company: "TechCorp",
  employees: 50,
  crm: "Salesforce",
  budget: 10000
}
```

**In new conversations:**
Include this context without the full history.

## Token Counting

Before sending to API, estimate tokens:

**Rough estimate:**
- 1 token ≈ 4 characters
- 1 token ≈ 0.75 words

**Better:** Use tokenizer libraries
- `tiktoken` for OpenAI models
- Anthropic provides token counts in API responses
```javascript
import { encode } from ''gpt-tokenizer'';

const tokens = encode(myPrompt);
console.log(`This prompt uses ${tokens.length} tokens`);
```

## Optimizing Context Usage

### 1. Only Include What''s Needed

Don''t send:
```
Here''s all our company history [50k tokens]
Here''s every product we''ve ever made [20k tokens]
Here''s every customer [30k tokens]

Question: What''s our return policy?
```

Send:
```
Return Policy:
- 30 days with receipt
- Original packaging
- Store credit if >30 days

Question: What''s our return policy?
```

### 2. Structure Information Clearly
```
RELEVANT CONTEXT:
[Only what''s needed for this specific task]

TASK:
[What you want the AI to do]
```

Not:
```
[Giant wall of mixed information]
Do something with this.
```

### 3. Remove Formatting Bloat

HTML, markdown, extra whitespace all consume tokens.

**Bloated:**
```html
<div class="container">
  <div class="row">
    <div class="col-md-6">
      <p>The return policy is 30 days.</p>
    </div>
  </div>
</div>
```

**Clean:**
```
Return policy: 30 days
```

Same information, 90% fewer tokens.

## When Context Limits Don''t Matter

Short, focused tasks:
- Classification (50-100 tokens)
- Simple extraction (100-200 tokens)
- Format conversion (200-500 tokens)

These never hit limits. Focus on optimization for complex, long-running systems.

## Best Practices

1. **Measure before optimizing** - Count tokens, know your usage
2. **Start simple** - Don''t over-engineer until you hit actual limits
3. **Chunk large docs** - Never send 200-page PDFs raw
4. **Summarize old context** - Don''t keep full conversation history forever
5. **Store structured data** - Extract facts instead of keeping raw messages
6. **Test edge cases** - What happens at 90% of limit? 100%? 110%?

## Red Flags

Watch for:
- Conversations failing after 20-30 messages
- API errors about token limits
- Costs spiking with conversation length
- Slow responses (long context = slower)

These mean you need better context management.',

  '## Exercise: Context Management Practice

**Objective:** Learn to handle context limits effectively.

**Instructions:**

### Part 1: Token Counting

**Task:** Estimate tokens for these prompts:

**Prompt 1:**
```
Classify this lead: "We''re interested in your product."
```
Your estimate: [?] tokens

**Prompt 2:**
```
Here''s our complete company history: [3000 words]
Here''s our full product catalog: [5000 words]
Here''s every customer testimonial: [2000 words]

Question: What''s your refund policy?
```
Your estimate: [?] tokens

**Prompt 3:**
```
You are a helpful assistant.

User: Hi
Assistant: Hello! How can I help?
User: What''s 2+2?
Assistant: 2+2 equals 4.
[... 50 more message pairs ...]

User: What did I first ask you?
```
Your estimate: [?] tokens

Then use an online token counter to check your estimates.

### Part 2: Long Document Strategy

**Scenario:** You need to analyze a 150-page legal contract (context limit: 128k tokens).

**Your task:**

Design a system to answer questions about this contract without exceeding limits.

**Outline your approach:**
1. How will you break up the document?
2. How will you find relevant sections?
3. How will you handle questions that span multiple sections?
4. What will you store vs. process on-demand?

### Part 3: Conversation History Management

**Scenario:** Customer support chatbot. Average conversation: 30 messages. Context limit concerns after message 50.

**Design a strategy that:**
- Keeps recent context
- Preserves important facts (customer name, order number, issue)
- Stays under token limits
- Maintains conversation quality

**Write pseudocode or description:**
```
When conversation exceeds X messages:
1. [Your step]
2. [Your step]
3. [Your step]
```

### Part 4: Context Optimization

**Take this bloated context:**
```
COMPANY BACKGROUND:
[2000 words of company history, mission statement, team bios, office locations, awards won, press mentions, future plans]

PRODUCT INFORMATION:
[5000 words covering every product feature in detail, technical specifications, pricing tiers, comparison charts, case studies, testimonials]

USER QUESTION: "Do you offer a free trial?"
```

**Optimize it:**

Rewrite to include only necessary context for this question.

**Before tokens:** [estimate]
**After tokens:** [estimate]
**Reduction:** [%]

### Part 5: Real-World Planning

Pick a potential use case:
- Long document analysis
- Multi-turn chatbot
- Large dataset processing
- Ongoing automation

**Plan your context strategy:**
1. What''s the maximum context you might need?
2. What are your limits?
3. How will you handle:
   - Initial information overload
   - Conversation growth over time
   - Very long inputs
4. What will you cache/store separately?
5. When will you summarize or truncate?

**Deliverable:**

Document with all 5 parts completed.

**Success Criteria:**
- Accurate token estimates
- Practical long document strategy
- Working conversation management plan
- Effective context optimization (>50% reduction)
- Real-world plan for your use case',

  50,
  true,
  (SELECT id FROM quizzes WHERE title = 'Context Windows Quiz')
FROM modules m
WHERE m.slug = 'llm-mastery';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Understanding LLM Context Windows',
  'https://www.youtube.com/watch?v=p4qCWxvy6Pc',
  'video',
  1
FROM sections WHERE slug = 'context-windows';
