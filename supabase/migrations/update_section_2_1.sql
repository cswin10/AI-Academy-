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
'How should operators choose which model to use for a task?',
'["Always use the most expensive model for best quality", "Route by capability tier: fast/cheap for simple tasks, deep reasoning for complex ones", "Use the same model for everything for consistency", "Pick randomly"]',
1,
'Operators route tasks by capability tier - fast/cheap models for classification and extraction, balanced models for daily work, high-reasoning models for complex problems.'),

((SELECT id FROM quizzes WHERE title = 'What LLMs Are Quiz'), 3,
'What is the operator principle: "If switching models does not change the system design..."?',
'["...then the model is broken", "...then it is not an architectural decision", "...then you should switch anyway", "...then you need a better model"]',
1,
'If switching models doesn''t change the system design, it''s not an architectural decision. Operators focus on systems, not vendor loyalty.'),

((SELECT id FROM quizzes WHERE title = 'What LLMs Are Quiz'), 4,
'Which of these is a REQUIRED practice for production LLM systems?',
'["Using only the newest models", "Having fallbacks, human override, confidence thresholds, and observability", "Avoiding structured outputs", "Never logging LLM responses"]',
1,
'Production LLM systems must have fallbacks, human override, confidence thresholds, and observability. These are non-negotiable for safe, reliable automation.'),

((SELECT id FROM quizzes WHERE title = 'What LLMs Are Quiz'), 5,
'What should happen when an LLM output has medium or low confidence?',
'["Auto-execute anyway", "Queue for human review or fail safely", "Ignore the output", "Retry until confidence is high"]',
1,
'Medium confidence outputs should be queued for human review. Low confidence outputs should trigger fallbacks or fail safely. Only high confidence outputs should auto-execute.');

-- Update the section content
UPDATE sections
SET
  content_markdown = '# What LLMs Are and How They Help Operators

Large Language Models (LLMs) like GPT, Claude, and Gemini are your most important tools as an AI operator. Understanding what they are, what they''re good at, and how to use them effectively will 10x your productivity.

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

---

## The LLM Ecosystem: Why Operators Don''t Bet on One Model

Smart operators maintain flexibility across providers. Each has strengths:

| Provider | Where It Shines | Typical Operator Use |
|----------|-----------------|---------------------|
| **Anthropic (Claude)** | Long context, code quality, nuanced writing | Default daily driver |
| **OpenAI (GPT family)** | Tool calling, structured output, broad ecosystem | Production automation |
| **Google (Gemini)** | Multimodal, document/image understanding | PDF analysis, screenshots |
| **Open-source (LLaMA, Mistral)** | Cost control, data sovereignty | Self-hosted or regulated environments |

**Key principle:**

> If switching models doesn''t change the system design, it''s not an architectural decision.

Operators focus on systems, not vendor loyalty. Tools are interchangeable; your thinking is what matters.

---

## Understanding Model Tiers (Not Specific Names)

> **Important:** Model names, pricing, and capabilities change frequently. Focus on capability tiers, not specific labels.

### The Three Tiers

| Tier | Capability | When to Use | Cost |
|------|------------|-------------|------|
| **Fast/Cheap** | Classification, extraction, format conversion | High-volume, simple, pattern-based tasks | Very Low |
| **Balanced** | Code, analysis, writing, daily operator work | Most everyday tasks | Medium |
| **Deep Reasoning** | Complex multi-step problems, architecture, hard debugging | Tasks requiring careful analysis | Higher |

### Examples by Provider

**Fast/Cheap tier:**
- Anthropic: Haiku
- OpenAI: GPT-4o-mini
- Google: Gemini Flash

**Balanced tier:**
- Anthropic: Sonnet
- OpenAI: GPT-4o
- Google: Gemini Pro

**Deep Reasoning tier:**
- Anthropic: Opus (with extended reasoning)
- OpenAI: o1, o3
- Google: Gemini Ultra

*These names will change. The tier concept won''t.*

---

## Capability-First Routing

Operators route tasks by **capability**, not by provider.

### Core Capabilities to Route By

| Capability | Best Tier | Example Tasks |
|------------|-----------|---------------|
| **Classification** | Fast/Cheap | Lead scoring, email categorization, sentiment |
| **Extraction** | Fast/Cheap | Pull order numbers, parse addresses, extract dates |
| **Code Generation** | Balanced | Write scripts, debug, refactor |
| **Long Document Analysis** | Balanced+ | Contract review, spec analysis |
| **Structured Output (JSON)** | Balanced | API responses, data transformation |
| **Multimodal (Images, PDFs)** | Varies | Screenshot analysis, document processing |
| **Complex Reasoning** | Deep | Architecture decisions, tricky debugging |
| **Data Sovereignty** | Open-source | Regulated industries, sensitive data |

### Routing Logic Example

```
IF task is classification or extraction:
    use Fast/Cheap tier
ELSE IF task involves images or PDFs:
    use model with multimodal capability
ELSE IF task requires deep multi-step reasoning:
    use Deep Reasoning tier
ELSE:
    use Balanced tier (default)
```

### Cost Impact

Proper routing can reduce LLM costs by 70-90% while maintaining quality where it matters.

```
10,000 classifications/month:
  Deep tier: ~$150/month
  Fast tier: ~$2/month
  Savings: 98%
```

---

## Model Fallbacks: Build Resilient Systems

Production systems need fallbacks. Models have outages, rate limits, and failures.

**Pattern: Primary → Fallback → Manual**
```
1. Try primary model (e.g., Claude Balanced)
2. If fails → Try fallback (e.g., GPT Balanced)
3. If fails → Queue for human review
```

Never build systems that depend on a single model with no backup plan.

---

## Extended Reasoning Modes

Some models offer extended reasoning modes (Claude''s extended thinking, OpenAI''s o1/o3).

**What this actually means:**

These modes increase internal computation, not intelligence. The model allocates more processing to work through complex problems before responding.

**When to use extended reasoning:**
- Complex debugging with multiple possible causes
- System design with many tradeoffs
- Multi-step logic problems
- Anything where you''d want a human to "think carefully"

**When NOT to use it:**
- Simple classification
- Straightforward code generation
- Anything routine

**Tradeoffs:** Extended reasoning is slower and more expensive. Use it selectively, not by default.

---

## API vs Chat Interface

As an operator, you''ll use LLMs two ways:

### Chat Interface (ChatGPT, Claude.ai, Gemini)
- **Best for:** Learning, exploration, one-off tasks
- **How it works:** You type, AI responds, back and forth
- **Limitation:** Manual, doesn''t scale

### API (Programmatic Access)
- **Best for:** Production systems, automation, integration
- **How it works:** Your code sends requests, gets responses
- **Advantage:** Scales infinitely, integrates with workflows

**You need both.** Start with chat to learn and prototype. Move to API when you need automation.

---

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
  "follow_up_days": 7
}
```

The second version can be parsed and used by your automation.

> **Always request structured output when building systems.** This is non-negotiable.

---

## The Human Override Principle

**Every LLM integration needs a human override path.**

LLMs will make mistakes. Your systems must allow humans to:
1. **Review** - See what the AI decided
2. **Correct** - Fix wrong outputs
3. **Learn** - Feed corrections back to improve prompts

| Pattern | Risk Level |
|---------|------------|
| LLM → Auto-send email (no review) | ❌ Dangerous |
| LLM → Draft email → Human approves → Send | ✅ Safe |

---

## Confidence Thresholds: When to Execute

Not every AI output should trigger an action. Operators define confidence thresholds and execution rules:

| Confidence | Action |
|------------|--------|
| **High confidence** | Auto-execute |
| **Medium confidence** | Queue for human review |
| **Low confidence** | Fallback or manual handling |

### How to Implement

1. **Request confidence in structured output:**
```json
{
  "classification": "hot",
  "confidence": 0.92,
  "reasoning": "Budget approved, timeline urgent, decision maker engaged"
}
```

2. **Define thresholds:**
```
IF confidence >= 0.85: auto-execute
ELSE IF confidence >= 0.60: human review
ELSE: fallback to manual
```

3. **Log everything for tuning** - Thresholds should be adjusted based on real performance data.

This dramatically improves system safety and reliability.

---

## Observability: Know When Things Go Wrong

Production LLM systems need logging and monitoring:

**Log these for every LLM call:**
- Input (what you sent)
- Output (what you got back)
- Model and tier used
- Latency (how long it took)
- Token count (cost tracking)
- Confidence score
- Success/failure

**Alert on:**
- Error rate spikes
- Latency increases
- Confidence score drops
- Unexpected output patterns
- Cost anomalies

If you can''t see what''s happening, you can''t fix it when it breaks.

---

## What LLMs Are NOT

**They are NOT:**
- ❌ Perfect databases of facts (they hallucinate)
- ❌ Replacement for testing (always verify their code)
- ❌ Deterministic (same input can give different outputs)
- ❌ Aware of real-time information (knowledge cutoff exists)
- ❌ Able to take actions (they can only suggest, you execute)
- ❌ Thinking like humans (they''re probabilistic reasoning engines)

**They ARE:**
- ✅ Incredibly fast at research and synthesis
- ✅ Great at pattern recognition and transformation
- ✅ Excellent at explaining complexity simply
- ✅ Tireless - available 24/7
- ✅ Probabilistic, not deterministic

---

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

---

## LLM Task Design (Not "Prompt Engineering")

Effective LLM use is about task design, not magic spells:

| Component | Purpose |
|-----------|---------|
| **Instructions** | What you want done |
| **Constraints** | What to avoid, limits |
| **Examples** | Show the pattern you want |
| **Evaluation** | How you''ll verify quality |

Prompts are instructions, constraints, and examples - not magic. The skill is in clear thinking, not clever wording.

---

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

> **Note:** Actual savings depend on your experience, problem clarity, and verification discipline. These estimates assume you verify outputs properly.

---

## Key Takeaways

1. **Route by capability tier** - Not by brand or hype
2. **Build with fallbacks** - Never depend on one model or provider
3. **Use structured outputs** - JSON is non-negotiable for automation
4. **Set confidence thresholds** - Not every output should auto-execute
5. **Keep humans in the loop** - Every system needs override capability
6. **Log everything** - Observability is not optional
7. **Focus on systems** - If switching models doesn''t change your design, it''s not architectural
8. **Verify outputs** - LLMs are probabilistic, not oracles',

  exercise_markdown = '## Exercise: Model Ecosystem and Routing Design

This exercise is completed through the interactive form below. You''ll design capability-based routing for a real use case.',

  exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Understanding Model Tiers",
      "description": "Demonstrate your understanding of capability-based model selection.",
      "fields": [
        {
          "id": "tier_understanding",
          "type": "textarea",
          "label": "In your own words, explain the three model tiers (Fast/Cheap, Balanced, Deep Reasoning) and when to use each:",
          "placeholder": "Fast/Cheap tier is for...\nBalanced tier is for...\nDeep Reasoning tier is for...",
          "required": true,
          "rows": 5
        },
        {
          "id": "classification_tier",
          "type": "radio",
          "label": "You need to classify 50,000 customer support tickets per month as Billing/Technical/General. Which TIER should you use?",
          "required": true,
          "options": [
            "Deep Reasoning - need the best quality",
            "Balanced - safe middle ground",
            "Fast/Cheap - high volume, simple pattern matching",
            "Any tier works equally well"
          ]
        },
        {
          "id": "architecture_tier",
          "type": "radio",
          "label": "You need to design a complex multi-system integration with many tradeoffs. Which TIER should you use?",
          "required": true,
          "options": [
            "Fast/Cheap - keep costs low",
            "Balanced - good enough for most things",
            "Deep Reasoning - complex analysis required",
            "Any tier works equally well"
          ]
        },
        {
          "id": "multimodal_scenario",
          "type": "textarea",
          "label": "A client sends you scanned PDF invoices that need data extraction. Which capability do you need and which providers offer it?",
          "placeholder": "Capability needed: ...\nProviders that offer this: ...\nMy approach: ...",
          "required": true,
          "rows": 4
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Capability-First Routing Design",
      "description": "Design a model routing strategy based on capabilities, not brands.",
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
          "label": "List 5+ tasks where LLMs could help. For each, identify the CAPABILITY needed (classification, extraction, code gen, reasoning, multimodal, etc.):",
          "placeholder": "1. Classify incoming emails → Capability: Classification\n2. Extract order numbers → Capability: Extraction\n3. Generate response drafts → Capability: Writing/Generation\n4. Analyze support trends → Capability: Analysis/Reasoning\n5. Process receipt images → Capability: Multimodal",
          "required": true,
          "rows": 7
        },
        {
          "id": "routing_table",
          "type": "textarea",
          "label": "Create a routing table by TIER (not specific model names). Which tier handles each task?",
          "placeholder": "Task 1: Email classification → Fast/Cheap tier (simple pattern matching)\nTask 2: Order extraction → Fast/Cheap tier (structured extraction)\nTask 3: Response drafts → Balanced tier (needs writing quality)\nTask 4: Trend analysis → Balanced tier (synthesis required)\nTask 5: Receipt images → Balanced tier with multimodal capability",
          "required": true,
          "rows": 7
        },
        {
          "id": "provider_flexibility",
          "type": "textarea",
          "label": "For your most critical task, list 2-3 providers that could handle it. Why does this flexibility matter?",
          "placeholder": "Critical task: ...\nOption 1: [Provider] - because...\nOption 2: [Provider] - because...\nFlexibility matters because: ...",
          "required": true,
          "rows": 5
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Confidence Thresholds and Safety",
      "description": "Design execution rules based on confidence levels.",
      "fields": [
        {
          "id": "confidence_design",
          "type": "textarea",
          "label": "For your lead classification or email routing system, design confidence thresholds. What happens at each level?",
          "placeholder": "High confidence (>85%): Auto-execute - route to appropriate queue\nMedium confidence (60-85%): Queue for human review with AI suggestion\nLow confidence (<60%): Flag for manual classification, no AI action",
          "required": true,
          "rows": 5
        },
        {
          "id": "structured_output_example",
          "type": "textarea",
          "label": "Write a sample structured output (JSON) that includes classification, confidence, and reasoning:",
          "placeholder": "{\n  \"classification\": \"hot_lead\",\n  \"confidence\": 0.89,\n  \"reasoning\": \"Budget mentioned, timeline is Q1, decision maker engaged\",\n  \"recommended_action\": \"immediate_followup\"\n}",
          "required": true,
          "rows": 7
        },
        {
          "id": "fallback_design",
          "type": "textarea",
          "label": "Design your fallback chain. What happens when your primary model fails?",
          "placeholder": "1. Primary: [Provider/Tier] - because...\n2. Fallback 1: [Provider/Tier] - triggered when...\n3. Fallback 2: Human review queue - triggered when...\n4. Final fallback: Fail safely with notification",
          "required": true,
          "rows": 5
        },
        {
          "id": "human_override",
          "type": "textarea",
          "label": "How will humans review and correct AI decisions? Describe the override process:",
          "placeholder": "1. All AI decisions logged with unique ID\n2. Dashboard shows decisions with confidence scores\n3. Users can click to review low-confidence items\n4. Override button allows correction\n5. Corrections logged for future prompt improvement",
          "required": true,
          "rows": 5
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Observability Planning",
      "description": "Design logging and monitoring for your LLM system.",
      "fields": [
        {
          "id": "logging_plan",
          "type": "textarea",
          "label": "What will you log for every LLM call? Be specific:",
          "placeholder": "- Timestamp\n- Request ID\n- Input (sanitized)\n- Output\n- Model/tier used\n- Latency (ms)\n- Token count (input/output)\n- Confidence score\n- Cost estimate\n- Success/failure status",
          "required": true,
          "rows": 8
        },
        {
          "id": "alert_conditions",
          "type": "checkbox_group",
          "label": "Which conditions should trigger alerts? (Select all that apply)",
          "required": true,
          "options": [
            "Error rate exceeds 5%",
            "Average latency exceeds 10 seconds",
            "Confidence scores dropping below threshold",
            "Daily cost exceeds budget",
            "Unusual output patterns detected",
            "Fallback model being used frequently",
            "Human override rate increasing"
          ]
        },
        {
          "id": "key_principle",
          "type": "textarea",
          "label": "In your own words, explain this principle: \"If switching models doesn''t change the system design, it''s not an architectural decision.\"",
          "placeholder": "This means that...\nFor example...\nThis matters because...",
          "required": true,
          "rows": 4
        }
      ]
    }
  ],
  "deliverables": [
    "Explained model tiers based on capability, not brand names",
    "Designed capability-first routing for a real use case",
    "Created confidence thresholds with execution rules",
    "Designed fallback chains and human override processes",
    "Planned observability with logging and alerting"
  ],
  "success_criteria": [
    "You route by capability tier, not by specific model names",
    "You maintain provider flexibility (not locked to one vendor)",
    "You have confidence thresholds that prevent unsafe auto-execution",
    "You have fallback chains and human override processes",
    "You plan for observability in all LLM systems"
  ]
}'::jsonb
WHERE slug = 'what-llms-are';

-- Update external resources to remove "prompt engineering" language
UPDATE external_resources
SET title = 'LLM Task Design - Beginner''s Guide'
WHERE section_id = (SELECT id FROM sections WHERE slug = 'what-llms-are')
AND title LIKE '%Prompt Engineering%';

-- Verify the update
SELECT slug, title,
  CASE WHEN exercise_schema IS NOT NULL THEN 'Has Schema' ELSE 'No Schema' END as schema_status,
  LENGTH(content_markdown) as content_length
FROM sections
WHERE slug = 'what-llms-are';
