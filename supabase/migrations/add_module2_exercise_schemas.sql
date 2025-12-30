-- ============================================================================
-- ADD EXERCISE SCHEMAS TO MODULE 2 SECTIONS
-- ============================================================================
-- This migration adds interactive exercise_schema JSON to Module 2 sections
-- Run this AFTER running add_exercise_responses.sql
-- ============================================================================

-- Section 2.1: What LLMs Are and How They Help Operators
UPDATE sections
SET exercise_schema = '{
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
