-- ============================================================================
-- UPDATE SECTION 2.1: What LLMs Are and How They Help Operators
-- ============================================================================
-- Run this to update Section 2.1 with modernized content
-- This uses UPDATE statements so it won't conflict with existing data
-- ============================================================================

-- First, delete old quiz questions for this quiz and re-insert
DELETE FROM quiz_questions WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'What LLMs Are Quiz');

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

-- Update the section content
UPDATE sections
SET
  content_markdown = '# What LLMs Are and How They Help Operators

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
  exercise_markdown = '## Exercise: Model Selection and Comparison

This exercise is completed through the interactive form below. Complete all parts to understand when to use each model.',
  exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Model Knowledge Assessment",
      "description": "Test your understanding of the current LLM landscape.",
      "fields": [
        {
          "id": "claude_models",
          "type": "checkbox_group",
          "label": "Which of these are current Claude model tiers? (Select all that apply)",
          "required": true,
          "options": [
            "Claude Opus 4",
            "Claude Sonnet 4",
            "Claude Haiku",
            "Claude GPT",
            "Claude Mini"
          ]
        },
        {
          "id": "model_for_classification",
          "type": "radio",
          "label": "You need to classify 50,000 customer support tickets per month as Billing/Technical/General. Which model should you use?",
          "required": true,
          "options": [
            "Claude Opus 4 - need the best quality",
            "Claude Sonnet 4 - balanced choice",
            "Claude Haiku - fast and cheap for simple classification",
            "o1 - need deep reasoning"
          ]
        },
        {
          "id": "classification_reasoning",
          "type": "textarea",
          "label": "Explain why you chose that model for the classification task:",
          "placeholder": "Consider: task complexity, volume, cost, speed requirements...",
          "required": true,
          "rows": 3
        },
        {
          "id": "model_for_architecture",
          "type": "radio",
          "label": "You need to design a complex multi-system integration with many tradeoffs. Which model should you use?",
          "required": true,
          "options": [
            "Claude Haiku - fast response",
            "GPT-4o-mini - cheapest option",
            "Claude Opus 4 or o1 - complex reasoning required",
            "Any model works equally well"
          ]
        },
        {
          "id": "architecture_reasoning",
          "type": "textarea",
          "label": "Explain why complex architecture design needs a more powerful model:",
          "placeholder": "Consider: tradeoff analysis, multi-step reasoning, experience needed...",
          "required": true,
          "rows": 3
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Model Routing Design",
      "description": "Design a model routing strategy for a real use case.",
      "fields": [
        {
          "id": "business_context",
          "type": "text",
          "label": "Describe a business or project you want to add LLM capabilities to:",
          "placeholder": "e.g., E-commerce customer support, Lead qualification system, Content generation pipeline",
          "required": true
        },
        {
          "id": "task_list",
          "type": "textarea",
          "label": "List 5+ tasks where LLMs could help in this business:",
          "placeholder": "1. Classify incoming emails by intent\n2. Generate response drafts\n3. Extract order numbers from messages\n4. Summarize long customer histories\n5. Design new automation workflows...",
          "required": true,
          "rows": 6
        },
        {
          "id": "routing_table",
          "type": "textarea",
          "label": "Create a routing table: For each task, specify which model tier to use and why:",
          "placeholder": "Task 1: Email classification → Haiku (simple pattern matching, high volume)\nTask 2: Response drafts → Sonnet 4 (needs good writing quality)\nTask 3: Order extraction → Haiku (simple extraction)\n...",
          "required": true,
          "rows": 8
        },
        {
          "id": "cost_estimate",
          "type": "textarea",
          "label": "Estimate monthly costs for your routing strategy (assume volumes):",
          "placeholder": "Email classification: 10k/month × $0.25/1M tokens = ~$X\nResponse drafts: 5k/month × $3/1M tokens = ~$X\nTotal estimated: $X/month",
          "required": true,
          "rows": 5
        },
        {
          "id": "alternative_cost",
          "type": "textarea",
          "label": "What would it cost if you used Opus 4 for everything? Calculate the difference:",
          "placeholder": "All tasks with Opus: X tokens × $15/1M = $X\nDifference: $X saved per month with routing",
          "required": true,
          "rows": 3
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Fallback and Override Design",
      "description": "Design resilient systems with fallbacks and human oversight.",
      "fields": [
        {
          "id": "primary_model",
          "type": "select",
          "label": "For your main use case, what is your PRIMARY model choice?",
          "required": true,
          "options": [
            "Claude Sonnet 4",
            "Claude Opus 4",
            "Claude Haiku",
            "GPT-4.1",
            "GPT-4o-mini",
            "o1 / o3"
          ]
        },
        {
          "id": "fallback_model",
          "type": "select",
          "label": "What is your FALLBACK model if the primary fails?",
          "required": true,
          "options": [
            "Claude Sonnet 4",
            "GPT-4.1",
            "Claude Haiku",
            "GPT-4o-mini",
            "Queue for human review",
            "Fail silently (not recommended)"
          ]
        },
        {
          "id": "fallback_triggers",
          "type": "checkbox_group",
          "label": "When should the system switch to the fallback? (Select all that apply)",
          "required": true,
          "options": [
            "API timeout (>30 seconds)",
            "Rate limit exceeded",
            "5xx server error",
            "Invalid/malformed response",
            "Content policy violation",
            "Cost threshold exceeded"
          ]
        },
        {
          "id": "human_override_design",
          "type": "textarea",
          "label": "Describe your human override process. How can humans intervene when the AI makes mistakes?",
          "placeholder": "1. All AI outputs are logged with unique IDs\n2. Users can flag incorrect outputs via [method]\n3. Flagged items go to [queue/dashboard]\n4. Humans can correct and the correction is [stored/fed back]...",
          "required": true,
          "rows": 5
        },
        {
          "id": "observability_plan",
          "type": "textarea",
          "label": "What will you log and monitor for your LLM system?",
          "placeholder": "Logs:\n- Input prompts\n- Model responses\n- Latency\n- Token counts\n- Errors\n\nAlerts:\n- Error rate > X%\n- Latency > X seconds\n- Daily cost > $X",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Hands-On Model Comparison",
      "description": "Actually test different models and document your findings.",
      "fields": [
        {
          "id": "test_completed",
          "type": "radio",
          "label": "Have you tested both ChatGPT and Claude with the prompts below?",
          "required": true,
          "options": [
            "Yes, I tested both",
            "I tested one of them",
            "Not yet, I will do this after"
          ]
        },
        {
          "id": "explanation_test",
          "type": "textarea",
          "label": "Test 1: Ask both models to explain webhooks to a non-technical person in 100 words. Which was clearer and why?",
          "placeholder": "Claude said: [summary]\nGPT said: [summary]\nWinner: [model] because [reason]",
          "required": true,
          "rows": 5
        },
        {
          "id": "code_test",
          "type": "textarea",
          "label": "Test 2: Ask both to write a Python function that validates email addresses. Compare the code quality:",
          "placeholder": "Claude code: [observations - error handling, readability, edge cases]\nGPT code: [observations]\nWinner for code: [model] because [reason]",
          "required": true,
          "rows": 5
        },
        {
          "id": "structured_output_test",
          "type": "textarea",
          "label": "Test 3: Ask both to classify this lead as JSON: \"We are a 50-person company looking to implement next month. Budget approved.\" Compare the outputs:",
          "placeholder": "Claude output: {\"classification\": \"...\", ...}\nGPT output: {\"classification\": \"...\", ...}\nWhich followed JSON format better? Which classification was more accurate?",
          "required": true,
          "rows": 5
        },
        {
          "id": "personal_preferences",
          "type": "textarea",
          "label": "Based on your tests, when will you personally use Claude vs GPT vs other models?",
          "placeholder": "I will use Claude for: [tasks]\nI will use GPT for: [tasks]\nI will use Haiku/mini for: [tasks]\nReasoning: [why]",
          "required": true,
          "rows": 5
        }
      ]
    }
  ],
  "deliverables": [
    "Correctly identified current model tiers and their use cases",
    "Designed a model routing strategy with cost estimates",
    "Created fallback and human override processes",
    "Tested multiple models and documented preferences",
    "Planned observability for LLM operations"
  ],
  "success_criteria": [
    "You can match tasks to appropriate model tiers",
    "You understand cost implications of model choices",
    "You have fallback and human override plans for every LLM integration",
    "You know when to use Claude vs GPT vs cheaper models",
    "You plan for observability in all LLM systems"
  ]
}'::jsonb
WHERE slug = 'what-llms-are';

-- Verify the update
SELECT slug, title,
  CASE WHEN exercise_schema IS NOT NULL THEN 'Has Schema' ELSE 'No Schema' END as schema_status,
  LENGTH(content_markdown) as content_length
FROM sections
WHERE slug = 'what-llms-are';
