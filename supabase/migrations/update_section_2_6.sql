-- ============================================================================
-- UPDATE SECTION 2.6: Context Windows & Memory Management
-- ============================================================================
-- Run this in Supabase SQL Editor to update Section 2.6 content
-- Uses capability tiers instead of specific model names
-- Connects to I→T→O framework and earlier sections
-- ============================================================================

-- First, rename the quiz
UPDATE quizzes
SET title = 'Context Windows & State Management Quiz'
WHERE title = 'Context Windows Quiz';

-- Update the section title and content
UPDATE sections
SET
  title = 'Context Windows & State Management',
  content_markdown = '# Context Windows & State Management

LLMs are stateless. Every request starts fresh. Understanding context limits, and building state management around them, is essential for reliable systems.

## The Stateless Reality

Every API call is independent. The model does not remember previous calls.

**What creates the illusion of memory:**
- You (the operator) send conversation history with each request
- The model processes all messages as if seeing them for the first time
- Your system manages what context to include

This means:
- You control what the model "remembers"
- You pay for every token of context on every call
- You decide when to summarize, truncate, or retrieve

## Context Windows Explained

The context window is the maximum tokens (input + output) a model can process in one request.

Context window sizes vary heavily by model and change frequently. As a rough guide:
- Fast/Cheap tiers often range from 16k to 128k tokens
- Balanced and Deep Reasoning tiers often support 128k to 200k+ tokens

> Always check current specs for your provider. These ranges shift as models evolve.

**Why 80% practical limit?**
- Leave room for output generation
- Avoid edge-case failures
- Performance often degrades near limits

## Why Context Management Matters

### 1. Cost

Longer context = more tokens = higher cost.

A 10k-token system prompt sent 1,000 times = 10M input tokens billed.

From Section 2.5: Cache static content. Structure beats compression.

### 2. Quality Degradation

Models can struggle with very long contexts:
- Important details get "lost in the middle"
- Attention spreads thin across many tokens
- Latency increases significantly

**The middle problem:** Information at the start and end of context gets more attention than information in the middle. Structure your context accordingly.

**Placement rule:** Put constraints and task goal at the top, put retrieved evidence at the bottom.

### 3. Hard Failures

Exceeding context limits causes:
- API errors (request rejected)
- Silent truncation (provider drops content)
- Unpredictable behavior

## The I→T→O Context Framework

Apply the I→T→O framework (from Section 1.3) to context management:

**Input Context:**
- System instructions (static, cache these)
- Task-specific knowledge (dynamic, retrieve as needed)
- User input (variable)

**Transformation Context:**
- Conversation history (managed, summarized)
- Working memory (extracted facts)
- Intermediate results (from previous steps)

**Output Constraints:**
- max_tokens limit
- Format requirements (affects output length)
- Structured response schemas

## Context Management Strategies

### Strategy 1: Chunking

For documents exceeding context limits, process in pieces.

```
Document: 200 pages (~150k tokens)
Context limit: 32k tokens

Approach:
1. Split into 10 chunks (~20 pages each)
2. Process each chunk with the same prompt
3. Collect results
4. Synthesize final output from chunk results
```

**When chunking works:**
- Summarization (each chunk independently summarizable)
- Extraction (facts can be found in individual chunks)
- Classification (each chunk can be classified)

**When chunking fails:**
- Questions requiring cross-document reasoning
- Analysis needing full context
- Tasks where chunk boundaries break meaning

For cross-document reasoning, use RAG instead. But note: RAG retrieves relevant context, it does not guarantee global reasoning. For true global synthesis, combine retrieval with a structured multi-step synthesis pipeline.

### Strategy 2: RAG (Retrieval-Augmented Generation)

Do not send everything. Retrieve only what is relevant.

```
Step 1: Index documents in vector database
Step 2: When query arrives, search for relevant chunks
Step 3: Send only relevant chunks to LLM
Step 4: Generate response from focused context
```

**RAG reduces:**
- Token costs (send 3 pages, not 300)
- Latency (smaller context = faster)
- The "lost in the middle" problem (less noise)

**RAG requires:**
- Embedding and indexing infrastructure
- Retrieval quality tuning
- Chunk size optimization

This is an architecture decision. If you need RAG, plan for it early.

### Strategy 3: Sliding Window

For conversations, keep only recent history.

**Implementation:** Keep only the last N messages (e.g., 10-20). On each request, send system prompt + recent messages only.

**Trade-off:** Older context is lost. The model cannot reference early conversation.

**When sliding window works:**
- Support conversations (recent context sufficient)
- Simple Q&A (no long-term continuity needed)
- High-volume, low-depth interactions

### Strategy 4: Summarize and Compress

Periodically summarize older messages.

```
Every 20 messages:
1. Take messages 1-20
2. Generate summary: key facts, decisions, user preferences
3. Replace messages 1-20 with summary
4. Continue with summary + recent messages
```

**Before compression:**
[Msg 1][Msg 2]...[Msg 30] = 6000 tokens

**After compression:**
[Summary of 1-20: 300 tokens][Msg 21]...[Msg 30] = 1800 tokens

Compression ratio: 70% reduction

### Strategy 5: Working Memory (Structured State)

Extract key facts into structured storage instead of keeping raw messages.

**Example working memory structure:**
```
user:
  name: Sarah
  company: TechCorp
  role: CTO

preferences:
  communication_style: concise
  timezone: UTC-8

session:
  goal: Evaluate authentication options
  decisions_made: [Use OAuth2, No SSO for MVP]
  open_questions: [Session timeout duration?]
```

**Injected as context:**
```
User: Sarah (CTO, TechCorp)
Goal: Evaluate authentication options
Decisions: Use OAuth2, No SSO for MVP
Open: Session timeout duration?
```

**Benefits:**
- Predictable token count
- No information loss (facts persist)
- Queryable state (you know what is stored)
- Faster context injection

This is the most sophisticated approach. Use it for production systems.

**If you are building an agent with multi-turn goals, treat working memory as the default, not an upgrade.**

## Conversation Lifecycle Management

### Phase 1: Initialization

```
First message:
- Load user profile (if returning user)
- Set session context
- Initialize working memory
- Inject relevant background
```

### Phase 2: Active Conversation

```
Each message:
- Check context budget
- Decide: include full history or summarize?
- Extract any new facts to working memory
- Generate response
- Update working memory with new information
```

### Phase 3: Session End

```
End of session:
- Generate session summary
- Persist working memory updates
- Clear temporary context
- Log for observability (Section 2.4)
```

## Token Counting

Estimate tokens before sending:

Token counts vary by language, content, and tokenizer. For accuracy, use provider token counts or a tokenizer library.

**Rough heuristic (English only):** ~3-4 characters per token, ~0.75 words per token. Do not rely on this for budgeting.

**For production:** Use provider-returned token counts or tokenizer libraries. Build counting into your pipeline.

**Implementation note:** Before each request, sum estimated tokens for system prompt + messages. Alert or compress if approaching 80% of limit.

## Context Optimization Techniques

### 1. Strip Formatting Bloat

HTML, markdown, whitespace consume tokens.

**Before (~90 tokens):** Nested HTML divs with classes wrapping "Return policy: 30 days with receipt."

**After (~8 tokens):** `Return policy: 30 days with receipt.`

Same information, 90% fewer tokens.

### 2. Use Structured Data

From Section 2.5: Structure beats compression.

**Prose (verbose):**
```
The customer contacted us about their order number 12345.
They placed this order on January 15th and it was supposed
to arrive by January 20th but it still has not arrived.
They are frustrated and want a refund or replacement.
```

**Structured (concise):**
```
Order: 12345
Ordered: Jan 15
Expected: Jan 20
Status: Not arrived
Request: Refund or replacement
Sentiment: Frustrated
```

Same information, 60% fewer tokens.

### 3. Reference, Do Not Repeat

If information is in system instructions, reference it.

**Wasteful:**
```
User: What is the return policy?

Context injected: [Full 500-word return policy]

AI: The return policy says...
```

**Efficient:**
```
System prompt (cached): [Full return policy]

User: What is the return policy?

AI: [Answers from system prompt knowledge]
```

## When Context Limits Do Not Matter

For short, focused tasks, optimization is premature:

- Classification: 50-100 tokens
- Simple extraction: 100-200 tokens
- Format conversion: 200-500 tokens

Focus optimization efforts on:
- Long-running conversations
- Document processing systems
- Multi-turn agent workflows

## Connecting to Earlier Sections

**From 2.1 (Capability Tiers):**
- Higher tiers have larger windows (usually)
- But cost more per token
- Choose tier, then optimize context for it

**From 2.2 (Task Templates):**
- Static template text should be cached
- Variable slots sized to fit context budget
- Execution boundary affects how much context is safe

**From 2.4 (System Instructions):**
- System prompts are sent on every call
- Cache them (most providers support this)
- Keep them as concise as possible

**From 2.5 (Cost Management):**
- Context length is a major cost driver
- Structure beats compression
- Prompt caching reduces cost dramatically

## Observability for Context

Track these metrics:

```
PER REQUEST:
- Input token count
- Output token count
- Context window utilization %
- Summarization triggered (y/n)
- RAG chunks retrieved

PER CONVERSATION:
- Total messages
- Total tokens processed
- Compression events
- Working memory size

ALERTS:
- Context utilization > 90%
- Summarization failing
- Token costs spiking
- Latency increasing with context size
```

## Common Mistakes

### 1. No Context Strategy

Building without a plan, then hitting limits in production.

**Fix:** Design context management before you build.

### 2. Sending Everything

Including all possible context "just in case."

**Fix:** Send only what is needed for this specific task.

### 3. Ignoring the Middle

Putting critical information in the middle of long contexts.

**Fix:** Put important content at the start or end.

### 4. No Token Budgeting

Not knowing how many tokens you are using.

**Fix:** Count tokens, set budgets, monitor usage.

### 5. Static Conversations

Never summarizing or managing growing history.

**Fix:** Implement compression at defined thresholds.

---

## Key Takeaways

1. **LLMs are stateless**, you manage all memory
2. **Context = cost**, every token is billed on every call
3. **80% practical limit**, leave room for output
4. **The middle problem**, critical info at start or end
5. **Five strategies**: Chunking, RAG, Sliding Window, Summarization, Working Memory
6. **Working Memory is production-grade**, structured state over raw history
7. **Cache system prompts**, they repeat on every call
8. **Structure beats prose**, same info, fewer tokens
9. **Budget and monitor**, know your token usage
10. **Plan context strategy early**, not after hitting limits',

  exercise_markdown = '## Exercise: Context Management Architecture

Complete the interactive exercise below to design context management for a real system.'

WHERE slug = 'context-windows';

-- Update quiz questions
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Context Windows & State Management Quiz');

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Context Windows & State Management Quiz'), 1,
'Why do LLMs appear to "remember" previous messages in a conversation?',
'["They store memories in a database", "The operator sends conversation history with each request", "They have built-in memory chips", "They remember everything automatically"]',
1,
'LLMs are stateless. The illusion of memory is created because you (the operator) send conversation history with each request. The model processes all messages fresh each time.'),

((SELECT id FROM quizzes WHERE title = 'Context Windows & State Management Quiz'), 2,
'Why should you use 80% of the context window as a practical limit?',
'["To save money", "To leave room for output and avoid edge-case failures", "That is the official recommendation", "80% is easier to calculate"]',
1,
'Using 80% as a practical limit leaves room for output generation, avoids edge-case failures near the limit, and accounts for performance degradation that often occurs near context limits.'),

((SELECT id FROM quizzes WHERE title = 'Context Windows & State Management Quiz'), 3,
'What is the "middle problem" in long contexts?',
'["The model charges more for middle tokens", "Information in the middle of context gets less attention than start or end", "Middle sections process slower", "You cannot edit the middle"]',
1,
'Models tend to give more attention to content at the start and end of context, while information in the middle can get "lost." Structure important content accordingly.'),

((SELECT id FROM quizzes WHERE title = 'Context Windows & State Management Quiz'), 4,
'When should you use RAG instead of chunking?',
'["When documents are too long", "When you need cross-document reasoning or to answer queries about specific parts", "RAG is always better", "Chunking is always better"]',
1,
'Chunking works for tasks where each piece can be processed independently. RAG is needed when you need cross-document reasoning or when questions may require finding specific relevant sections.'),

((SELECT id FROM quizzes WHERE title = 'Context Windows & State Management Quiz'), 5,
'What is Working Memory (structured state) in context management?',
'["The model internal memory", "Extracting key facts into structured storage instead of keeping raw messages", "A special API feature", "The context window size"]',
1,
'Working Memory means extracting key facts (user name, preferences, decisions) into structured storage rather than keeping raw conversation history. It provides predictable token count and no information loss.'),

((SELECT id FROM quizzes WHERE title = 'Context Windows & State Management Quiz'), 6,
'What gives bigger token savings: shorter words or better structure?',
'["Shorter words", "Better structure (bullets, schemas, no fluff)", "They are equally effective", "Neither affects token count significantly"]',
1,
'Better structure (bullet points, structured data, removing conversational fluff) typically provides much larger token savings than trying to use shorter words. Structure beats compression.'),

((SELECT id FROM quizzes WHERE title = 'Context Windows & State Management Quiz'), 7,
'When should you design your context management strategy?',
'["After hitting production limits", "When costs become a problem", "Before you build, as part of architecture", "Context management is not needed for most systems"]',
2,
'Design context management before you build. Retrofitting context strategies after hitting limits in production is much harder than planning for it from the start.'),

((SELECT id FROM quizzes WHERE title = 'Context Windows & State Management Quiz'), 8,
'What should you track for context observability?',
'["Only total cost", "Only token counts", "Token counts, context utilization, compression events, and latency trends", "Nothing, context management is automatic"]',
2,
'Track input/output token counts, context window utilization percentage, when summarization or compression triggers, RAG retrieval metrics, and how latency changes with context size.');

-- Update exercise schema
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Context Budget Planning",
      "description": "Plan your context budget for a specific use case.",
      "fields": [
        {
          "id": "use_case",
          "type": "textarea",
          "label": "Define your use case and estimate context needs:",
          "placeholder": "Use case: Customer support chatbot for SaaS product\n\nContext components:\n- System prompt: ~[X] tokens (identity, rules, knowledge)\n- Product documentation: ~[X] tokens (retrieved via RAG)\n- User profile: ~[X] tokens\n- Conversation history: ~[X] tokens (growing)\n- Current message: ~[X] tokens\n\nTotal at start of conversation: ~[X] tokens\nTotal after 20 messages: ~[X] tokens\nContext limit: [X] tokens\n80% budget: [X] tokens",
          "required": true,
          "rows": 14
        },
        {
          "id": "tier_selection",
          "type": "textarea",
          "label": "Which capability tier will you use and why?",
          "placeholder": "Selected tier: [Fast/Cheap | Balanced | Deep Reasoning]\nContext window: [X] tokens\n\nRationale:\n- Why this tier fits the task complexity\n- Why this context window is sufficient\n- Cost considerations from Section 2.5",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Strategy Selection",
      "description": "Choose and justify your context management strategy.",
      "fields": [
        {
          "id": "strategy_choice",
          "type": "textarea",
          "label": "Which strategy (or combination) will you use? (Chunking, RAG, Sliding Window, Summarization, Working Memory)",
          "placeholder": "Primary strategy: [Strategy]\nSecondary strategy: [Strategy if applicable]\n\nWhy this combination:\n- [Reason 1]\n- [Reason 2]\n\nWhy NOT other strategies:\n- Not using [Strategy] because [reason]\n- Not using [Strategy] because [reason]",
          "required": true,
          "rows": 10
        },
        {
          "id": "implementation_plan",
          "type": "textarea",
          "label": "Describe how you will implement your chosen strategy:",
          "placeholder": "Implementation:\n\n1. [Step 1: e.g., Set up vector database for RAG]\n2. [Step 2: e.g., Define chunking strategy for documents]\n3. [Step 3: e.g., Implement working memory schema]\n4. [Step 4: e.g., Set compression thresholds]\n\nWhen summarization/compression triggers:\n- After [X] messages, or\n- When context reaches [X]% of budget\n\nWhat gets preserved vs discarded:\n- Always preserve: [list]\n- Can discard: [list]",
          "required": true,
          "rows": 14
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Working Memory Design",
      "description": "Design a structured working memory schema.",
      "fields": [
        {
          "id": "memory_schema",
          "type": "textarea",
          "label": "Define your working memory schema:",
          "placeholder": "const workingMemory = {\n  user: {\n    // Persistent user info\n    id: string,\n    name: string,\n    [other fields]\n  },\n  session: {\n    // Current session state\n    goal: string,\n    context: string,\n    [other fields]\n  },\n  facts: {\n    // Extracted facts from conversation\n    [structure]\n  },\n  decisions: {\n    // Decisions made this session\n    [structure]\n  },\n  open_questions: [\n    // Unresolved questions\n  ]\n};",
          "required": true,
          "rows": 18
        },
        {
          "id": "memory_injection",
          "type": "textarea",
          "label": "How will you inject working memory into context?",
          "placeholder": "Template for injecting working memory:\n\n```\nUser Context:\n- Name: ${user.name}\n- Account type: ${user.accountType}\n\nSession:\n- Goal: ${session.goal}\n- Decisions made: ${decisions.join(\", \")}\n\nOpen questions:\n${openQuestions.map(q => \"- \" + q).join(\"\\n\")}\n```\n\nEstimated tokens: ~[X] tokens\nThis is [X]% of my context budget",
          "required": true,
          "rows": 12
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Optimization Techniques",
      "description": "Apply context optimization techniques.",
      "fields": [
        {
          "id": "before_optimization",
          "type": "textarea",
          "label": "Take a real or example context payload. Show the unoptimized version:",
          "placeholder": "System prompt (unoptimized):\n\n\"Hello! You are a helpful customer support assistant for TechCorp. TechCorp is a SaaS company that was founded in 2015 and has grown to serve over 10,000 customers worldwide. Our main product is a project management tool that helps teams collaborate more effectively. You should always be polite and helpful, and you should try to solve customer problems quickly and efficiently. If you cannot solve a problem, you should escalate to a human agent. Here is some information about our products and policies that you should know...\"\n\n[Continue with example context]\n\nEstimated tokens: ~[X]",
          "required": true,
          "rows": 12
        },
        {
          "id": "after_optimization",
          "type": "textarea",
          "label": "Apply optimization techniques (structure, remove bloat, use references):",
          "placeholder": "System prompt (optimized):\n\n\"You are TechCorp Support. Project management SaaS, 10k+ customers.\n\nRules:\n- Solve issues directly when possible\n- Escalate to human if: [criteria]\n\nProduct knowledge: [reference to cached documentation]\n\nResponse format: [structured format]\"\n\nEstimated tokens: ~[X]\nReduction: [X]%\n\nTechniques applied:\n- [Technique 1]\n- [Technique 2]",
          "required": true,
          "rows": 14
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Observability Setup",
      "description": "Plan your context observability.",
      "fields": [
        {
          "id": "metrics",
          "type": "textarea",
          "label": "What metrics will you track?",
          "placeholder": "Per-request metrics:\n- Input tokens: [how measured]\n- Output tokens: [how measured]\n- Context utilization %: [formula]\n\nPer-conversation metrics:\n- Total messages\n- Compression events triggered\n- Working memory updates\n\nAlerts:\n- Context utilization > [X]%: [action]\n- Token costs > [X]: [action]\n- Latency > [X]ms: [action]",
          "required": true,
          "rows": 14
        },
        {
          "id": "failure_handling",
          "type": "textarea",
          "label": "How will you handle context-related failures?",
          "placeholder": "Failure scenarios and handling:\n\n1. Context limit exceeded mid-conversation:\n   - Detection: [how detected]\n   - Response: [what happens]\n   - Recovery: [how to continue]\n\n2. Summarization fails:\n   - Detection: [how detected]\n   - Fallback: [what to do]\n\n3. RAG retrieval returns nothing relevant:\n   - Detection: [how detected]\n   - Fallback: [what to do]\n\nEscalation path (from Section 2.4):\n- [When to escalate to human]",
          "required": true,
          "rows": 14
        }
      ]
    }
  ],
  "deliverables": [
    "Context budget plan with token estimates",
    "Strategy selection with clear rationale",
    "Working memory schema for your use case",
    "Optimized context with measurable reduction",
    "Observability plan with metrics and alerts"
  ],
  "success_criteria": [
    "Token estimates are realistic and add up correctly",
    "Strategy choice matches use case requirements",
    "Working memory schema captures essential state without bloat",
    "Optimization achieves at least 40% token reduction",
    "Observability plan includes actionable alerts and failure handling"
  ]
}'::jsonb
WHERE slug = 'context-windows';

-- Verify the update
SELECT slug, title,
       LENGTH(content_markdown) as content_length,
       exercise_schema IS NOT NULL as has_schema
FROM sections
WHERE slug = 'context-windows';
