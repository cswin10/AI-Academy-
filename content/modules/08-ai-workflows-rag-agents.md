---
number: 8
title: AI Workflows, RAG & Agents
description: Build sophisticated AI systems with RAG, agents with tool calling, prompt chaining, and memory. This is where you become a true AI engineer.
estimatedTime: "7-10 days"
difficulty: Advanced
prerequisites: ["01-foundations", "02-understanding-llms", "03-ai-content-creation", "04-core-interface-tools", "05-data-layer", "06-automation-layer", "07-apis-webhooks"]
category: Automation & Intelligence
---

# 📘 MODULE 8: AI Workflows, RAG & Agents

**Estimated Time:** 7-10 days
**Difficulty:** Advanced
**Prerequisites:** Modules 1-7 (all previous modules)

## 📖 Overview & Why This Matters

This is the module where it all comes together. Everything you've learned - databases, APIs, automation, embeddings - now combines into the most powerful AI systems you can build: RAG systems that can search through millions of documents, AI agents that can use tools and make decisions, and workflows that chain multiple AI operations together intelligently.

Here's what separates this from "just using ChatGPT": Anyone can paste text into ChatGPT and get a response. Professional AI Operators build systems where AI has access to private knowledge bases, can execute actions in the real world, maintains conversation context, and operates autonomously. These are the systems that companies pay $200K+ to have built.

RAG (Retrieval Augmented Generation) is what lets AI answer questions about YOUR specific data - your customer support history, your product documentation, your company knowledge base. It's the difference between generic AI responses and AI that knows your business inside and out.

AI Agents take it further - they can break down complex tasks, decide which tools to use, execute actions, and iterate until the task is complete. Building agents is the frontier of AI operations right now, and the skill that's most in demand.

This module is challenging. But mastering it means you can build AI systems that most people think are magic.

## 🎯 Learning Objectives

By the end of this module, you will:

- [ ] Build production-ready RAG systems with proper chunking and retrieval
- [ ] Implement multi-query strategies to improve retrieval accuracy
- [ ] Design prompt chains that break complex tasks into steps
- [ ] Build AI agents that can use tools (search, API calls, calculations)
- [ ] Implement conversation memory and context management
- [ ] Create feedback loops that improve AI performance over time
- [ ] Understand when to use RAG vs. fine-tuning vs. prompt engineering

## 🧠 Core Concepts

### RAG: The Complete Picture

Basic RAG (what you built in Module 5):
```
User Question → Embed → Search vectors → Retrieve docs → Generate answer
```

Production RAG (what you'll build here):
```
User Question
  → Query enhancement (expand/rephrase)
  → Hybrid search (vectors + keywords)
  → Rerank results (score by relevance)
  → Context assembly (chunk merging)
  → Answer generation (with citations)
  → Quality check (hallucination detection)
  → Return with sources
```

The difference: Basic RAG works 70% of the time. Production RAG works 95% of the time.

### The Chunking Problem

How you split documents matters enormously:

**Too large (whole documents):**
- Too much irrelevant info in context
- Exceeds token limits
- Reduces precision

**Too small (every sentence):**
- Loses context
- More database storage
- More API calls

**Just right (semantic chunks):**
- 300-500 tokens
- Breaks on logical boundaries (paragraphs, sections)
- Includes overlap with adjacent chunks
- Stores metadata (source, date, section)

### Prompt Chaining: Sequential AI Operations

Instead of one mega-prompt, chain focused prompts:

```
Step 1: Extract key info from user request
Step 2: Search knowledge base with extracted info
Step 3: Validate search results are relevant
Step 4: Generate answer from validated results
Step 5: Format answer for user's preferred style
```

Each step is simpler, more reliable, and easier to debug.

### AI Agents: Tool-Using AI

An agent is an AI system that:
1. Receives a goal
2. Plans steps to achieve it
3. Decides which tools to use
4. Executes tool calls
5. Observes results
6. Iterates until goal is met

Example agent loop:
```
Goal: "Research competitor pricing and create comparison table"

Agent thinks: "I need to find competitor websites, scrape pricing, organize in table"
Tool call: search("competitor pricing pages")
Observation: Found 3 competitor URLs
Agent thinks: "Now get pricing from each site"
Tool call: scrape_website(url1)
Observation: Pricing data retrieved
... repeat for each site ...
Agent thinks: "Now organize into table"
Tool call: create_table(data)
Observation: Table created
Final answer: [returns table]
```

The AI is choosing which tools to use and when - that's the key difference from simple automation.

### Memory Systems

**Short-term memory (conversation context):**
- Store recent messages in conversation
- Summarize when token limit approaches
- Pass to next AI call

**Long-term memory (across conversations):**
- Store conversation summaries in database
- Embed and search like RAG
- Retrieve relevant past conversations

**Episodic memory (specific events):**
- Store key facts learned about user
- Update knowledge graph
- Reference in future conversations

### The ReAct Pattern

ReAct (Reasoning + Acting) is the dominant agent pattern:

```
Thought: I should search for competitor pricing
Action: search_web("competitor pricing software")
Observation: Found 5 results
Thought: The first result looks most relevant
Action: read_webpage("https://competitor.com/pricing")
Observation: Pricing is $99/month for pro plan
Thought: I have enough information now
Final Answer: Competitor charges $99/month
```

The AI explains its reasoning, takes actions, observes results, and iterates.

## 🛠️ Tools Deep Dive

### LangChain

**Best for:** Building complex AI workflows with many integrations
**When to use:** Multi-step AI operations, agent systems, RAG at scale
**Pricing:** Free (open source)
**Pros:**
- Huge library of integrations (100+ tools)
- Abstracts common patterns (RAG, agents, memory)
- Active community
- Production-ready
- Supports both Python and JavaScript

**Cons:**
- Steep learning curve
- Can be over-engineered for simple tasks
- Frequent breaking changes in updates
- Documentation can lag behind features

**Example usage:**
```python
from langchain.chains import RetrievalQA
from langchain.vectorstores import Pinecone
from langchain.llms import OpenAI

vectorstore = Pinecone.from_existing_index("knowledge-base")
qa_chain = RetrievalQA.from_chain_type(
    llm=OpenAI(model="gpt-4"),
    retriever=vectorstore.as_retriever(),
    return_source_documents=True
)

result = qa_chain("How do I reset my password?")
```

### LlamaIndex

**Best for:** RAG systems, document search, knowledge bases
**When to use:** When RAG is your primary use case
**Pricing:** Free (open source)
**Pros:**
- Optimized for RAG specifically
- Better data connectors (load from anywhere)
- More sophisticated retrieval strategies
- Easier to get started than LangChain for RAG
- Better chunking strategies out-of-box

**Cons:**
- Less flexible for non-RAG tasks
- Smaller community than LangChain
- Fewer agent capabilities

**Example usage:**
```python
from llama_index import VectorStoreIndex, SimpleDirectoryReader

documents = SimpleDirectoryReader('./docs').load_data()
index = VectorStoreIndex.from_documents(documents)
query_engine = index.as_query_engine()

response = query_engine.query("What are our return policies?")
```

### OpenAI Assistants API

**Best for:** Building agents without infrastructure management
**When to use:** Need agents but don't want to manage conversation state
**Pricing:** Pay per token (same as OpenAI API) + storage
**Pros:**
- Managed service (OpenAI handles everything)
- Built-in tool calling
- File search built in (automatic RAG)
- Persistent conversation threads
- No infrastructure to manage

**Cons:**
- Locked to OpenAI
- Less control over retrieval
- Can get expensive with large knowledge bases
- Slower than self-hosted solutions

**Example usage:**
```javascript
const assistant = await openai.beta.assistants.create({
  model: "gpt-4o",
  instructions: "You are a helpful customer support agent",
  tools: [{ type: "file_search" }],
  tool_resources: {
    file_search: { vector_store_ids: ["vs_abc123"] }
  }
})

const thread = await openai.beta.threads.create()
await openai.beta.threads.messages.create(thread.id, {
  role: "user",
  content: "How do I change my email?"
})

const run = await openai.beta.threads.runs.create(thread.id, {
  assistant_id: assistant.id
})
```

### Anthropic Claude with Tools

**Best for:** Reliable tool use, complex reasoning tasks
**When to use:** Need high-quality reasoning or working with sensitive data
**Pricing:** Pay per token (Input: $3/M tokens, Output: $15/M tokens for Claude 3.5 Sonnet)
**Pros:**
- Excellent at following tool schemas
- Better at complex reasoning than GPT-4
- Longer context windows (200K tokens)
- More reliable tool calling

**Cons:**
- No built-in RAG (you build it)
- More expensive than GPT-4o
- Smaller ecosystem than OpenAI

## 💡 Real Business Examples

### Example 1: Customer Support RAG System

**Problem:** SaaS company with 1,000+ help articles, 50K+ past support tickets. Support agents spending 40% of time searching for answers, often missing relevant information.

**Basic Approach (Module 5 level):**
- Embed all articles
- User asks question → search → return top 3 → generate answer
- Works okay, but 30% of questions get wrong or incomplete answers

**Advanced Approach (Production RAG):**

```python
# 1. Query Enhancement
async def enhance_query(user_question):
    # Generate multiple query variants
    variants = await llm.generate([
        f"Rephrase: {user_question}",
        f"What keywords would help find info about: {user_question}",
        f"What specific product features relate to: {user_question}"
    ])
    return [user_question] + variants

# 2. Hybrid Search
async def hybrid_search(queries):
    results = []

    for query in queries:
        # Vector search
        vector_results = await pinecone.query(
            vector=await get_embedding(query),
            top_k=10,
            filter={"category": "support"}
        )

        # Keyword search in PostgreSQL
        keyword_results = await db.query(
            "SELECT * FROM articles WHERE to_tsvector(content) @@ to_tsquery($1)",
            [query]
        )

        results.extend(vector_results + keyword_results)

    # Deduplicate and rank
    return rank_results(results)

# 3. Reranking
async def rerank_results(results, original_question):
    # Use Claude to score each result's relevance
    scored_results = []

    for result in results:
        score = await claude.messages.create(
            model="claude-3-5-sonnet",
            messages=[{
                "role": "user",
                "content": f"Rate 1-10 how relevant this article is to the question.\n\nQuestion: {original_question}\n\nArticle: {result.text}\n\nScore:"
            }],
            max_tokens=10
        )

        scored_results.append({
            "content": result,
            "score": int(score.content[0].text)
        })

    return sorted(scored_results, key=lambda x: x["score"], reverse=True)[:5]

# 4. Context Assembly
async def assemble_context(ranked_results):
    # Merge overlapping chunks, add source citations
    context = ""
    sources = []

    for i, result in enumerate(ranked_results):
        context += f"[{i+1}] {result.content.metadata.title}\n{result.content.text}\n\n"
        sources.append({
            "number": i + 1,
            "title": result.content.metadata.title,
            "url": result.content.metadata.url
        })

    return context, sources

# 5. Answer with Citations
async def generate_answer(question, context, sources):
    response = await openai.chat.completions.create(
        model="gpt-4o",
        messages=[{
            "role": "system",
            "content": "Answer based on provided articles. Cite sources as [1], [2], etc. If unsure, say so."
        }, {
            "role": "user",
            "content": f"Context:\n{context}\n\nQuestion: {question}\n\nAnswer:"
        }]
    )

    answer = response.choices[0].message.content

    return {
        "answer": answer,
        "sources": sources,
        "confidence": estimate_confidence(answer)
    }

# 6. Complete Pipeline
async def answer_support_question(question):
    queries = await enhance_query(question)
    results = await hybrid_search(queries)
    ranked = await rerank_results(results, question)
    context, sources = await assemble_context(ranked)
    return await generate_answer(question, context, sources)
```

**Result:**
- Answer accuracy: 70% → 94%
- Support agent research time: 40% of day → 5%
- Customer satisfaction: 72 → 89
- Automated 60% of tier-1 support tickets
- Cost: $800/month in AI APIs, saved $15K/month in support labor

### Example 2: Research Agent

**Problem:** Marketing team needed to research competitors, synthesize information from multiple sources, and create comparison reports. Taking 8 hours per report.

**Agent System Design:**

```python
from langchain.agents import Tool, AgentExecutor
from langchain.agents.react.agent import create_react_agent
from langchain.llms import OpenAI

# Define tools the agent can use
tools = [
    Tool(
        name="WebSearch",
        func=search_web,
        description="Search the web for information. Input: search query. Returns: list of results."
    ),
    Tool(
        name="ReadWebpage",
        func=scrape_webpage,
        description="Read content from a URL. Input: URL. Returns: page text content."
    ),
    Tool(
        name="SaveToDatabase",
        func=save_to_supabase,
        description="Save research findings. Input: JSON with {company, data, category}."
    ),
    Tool(
        name="CreateTable",
        func=generate_comparison_table,
        description="Create comparison table. Input: list of companies with data."
    )
]

# Create agent
agent = create_react_agent(
    llm=OpenAI(model="gpt-4o"),
    tools=tools,
    prompt="""You are a research assistant. Break down research tasks into steps.

Available tools:
{tools}

Use this format:
Thought: [your reasoning]
Action: [tool name]
Action Input: [input to tool]
Observation: [tool output]
... (repeat Thought/Action/Observation as needed)
Thought: I now have enough information
Final Answer: [your final response]

Task: {input}
{agent_scratchpad}"""
)

executor = AgentExecutor(agent=agent, tools=tools, verbose=True)

# Run research task
result = executor.invoke({
    "input": """Research top 3 competitors in project management software:
    1. Find their websites
    2. Get pricing information
    3. Extract key features
    4. Create comparison table
    5. Save findings to database"""
})
```

**Example execution:**

```
Thought: I need to find the top project management software competitors first.
Action: WebSearch
Action Input: "top project management software 2024"
Observation: Found articles mentioning Asana, Monday.com, ClickUp as top 3

Thought: Now I need to get pricing info for Asana
Action: ReadWebpage
Action Input: "https://asana.com/pricing"
Observation: [Pricing page content]

Thought: I found Asana pricing. Now for Monday.com
Action: ReadWebpage
Action Input: "https://monday.com/pricing"
Observation: [Pricing page content]

[... continues for all competitors ...]

Thought: I have all the data. Let me save it and create a table.
Action: SaveToDatabase
Action Input: {"company": "Asana", "data": {...}, "category": "pricing"}
Observation: Saved successfully

Action: CreateTable
Action Input: [{"name": "Asana", "price": "$10.99", ...}, ...]
Observation: Table created

Thought: I now have complete research with table
Final Answer: [Research report with comparison table]
```

**Result:**
- Research time: 8 hours → 20 minutes
- Can research 10x more competitors in same time
- Findings automatically organized in database
- Consistent data format (no human variation)
- Cost: $5-10 per report in API costs

### Example 3: Content Production Agent with Memory

**Problem:** Agency creating personalized content for 50 clients. Each client has preferences, brand voice, topics to avoid. Hard to keep track manually.

**Memory-Enhanced Agent:**

```python
class ContentAgent:
    def __init__(self, client_id):
        self.client_id = client_id
        self.memory = ConversationBufferMemory()
        self.client_knowledge = self.load_client_knowledge()

    async def load_client_knowledge(self):
        # Load past conversations and preferences
        past_content = await db.query(
            "SELECT * FROM content WHERE client_id = $1 ORDER BY created_at DESC LIMIT 10",
            [self.client_id]
        )

        preferences = await db.query(
            "SELECT * FROM client_preferences WHERE client_id = $1",
            [self.client_id]
        )

        # Embed and store in vector DB for retrieval
        knowledge = {
            "past_content": past_content,
            "preferences": preferences,
            "style_guide": await self.extract_style_patterns(past_content)
        }

        return knowledge

    async def extract_style_patterns(self, past_content):
        # Use AI to analyze writing patterns
        analysis = await openai.chat.completions.create(
            model="gpt-4o",
            messages=[{
                "role": "system",
                "content": "Analyze these content samples and extract the writing style patterns."
            }, {
                "role": "user",
                "content": f"Samples:\n{past_content}"
            }]
        )

        return analysis.choices[0].message.content

    async def create_content(self, topic, content_type):
        # Build context from memory
        relevant_memories = await self.search_memories(topic)

        prompt = f"""Create {content_type} about: {topic}

Client Profile:
- Industry: {self.client_knowledge.preferences.industry}
- Tone: {self.client_knowledge.preferences.tone}
- Avoid: {self.client_knowledge.preferences.avoid_topics}

Writing Style (learned from past content):
{self.client_knowledge.style_guide}

Relevant Past Content:
{relevant_memories}

Create new content that matches their style but with fresh angle."""

        content = await openai.chat.completions.create(
            model="gpt-4o",
            messages=[{"role": "user", "content": prompt}]
        )

        # Save to memory for future use
        await self.save_to_memory(topic, content.choices[0].message.content)

        return content.choices[0].message.content

    async def search_memories(self, query):
        # Search past content for relevant examples
        embedding = await get_embedding(query)
        similar = await pinecone.query(
            vector=embedding,
            filter={"client_id": self.client_id},
            top_k=3
        )
        return similar

    async def save_to_memory(self, topic, content):
        # Store in both database and vector store
        await db.insert("content", {
            "client_id": self.client_id,
            "topic": topic,
            "content": content,
            "created_at": datetime.now()
        })

        embedding = await get_embedding(content)
        await pinecone.upsert({
            "id": f"{self.client_id}-{uuid()}",
            "values": embedding,
            "metadata": {"client_id": self.client_id, "topic": topic}
        })
```

**Result:**
- Content matches client style 95% of time (vs. 60% before)
- No more "this doesn't sound like us" revisions
- Agent learns and improves with each piece
- Scales from 5 to 50 clients without quality drop
- New clients ramp up faster (learns style in 3-5 samples)

## ⚠️ Common Pitfalls

### 1. **Treating RAG as Just Vector Search**
❌ Question → embed → search → generate
✅ Query enhancement → hybrid search → reranking → answer generation

### 2. **No Guardrails on Agent Loops**
❌ Agent runs forever trying to complete impossible task
✅ Max iterations limit (e.g., 10 steps), timeout after 2 minutes

### 3. **Ignoring Hallucination Risk**
❌ Trust AI output blindly
✅ Check for citations, validate facts against sources, confidence scoring

### 4. **Poor Chunking Strategy**
❌ Split documents by character count (e.g., every 500 chars)
✅ Split by semantic meaning (paragraphs, sections), include overlap

### 5. **Not Testing Retrieval Quality**
❌ Assume if you get results, they're relevant
✅ Build test set of questions → expected documents, measure recall/precision

### 6. **One-Size-Fits-All Prompts**
❌ Same system prompt for all agent tasks
✅ Task-specific prompts, dynamic prompt construction based on context

### 7. **No Monitoring of Agent Decisions**
❌ Agent runs, you only see final output
✅ Log every tool call, decision, and observation for debugging

## ✨ Pro Tips

### Tip 1: The "Few-Shot Retrieval" Pattern

Include example Q&A pairs in your RAG prompt:

```
Examples of good answers:
Q: How do I reset password?
A: Go to Settings > Security > Reset Password. [1]

Q: What's your refund policy?
A: We offer 30-day money-back guarantee. [2]

Now answer: {user_question}
Context: {retrieved_docs}
```

This dramatically improves answer quality.

### Tip 2: Use Different Models for Different Tasks

```
Query enhancement: gpt-4o-mini (cheap, fast)
Retrieval scoring: claude-3-haiku (excellent at ranking)
Final answer: gpt-4o (best quality)
```

Don't waste expensive models on simple tasks.

### Tip 3: Implement "Confidence Thresholds"

```python
async def answer_with_confidence(question, context):
    response = await llm.generate(question, context)

    # Ask AI to rate its own confidence
    confidence = await llm.generate(
        f"On a scale of 1-10, how confident are you that this answer is correct based on the provided context?\n\nAnswer: {response}"
    )

    if int(confidence) < 7:
        return {
            "answer": "I'm not confident enough to answer. Let me get a human.",
            "escalate": True
        }

    return {"answer": response, "escalate": False}
```

### Tip 4: The "Reasoning Trace" Pattern

Have agents explain their reasoning:

```python
agent_prompt = """For each action, explain:
1. What you're trying to achieve
2. Why this tool/approach
3. What you expect to learn

This helps debug when things go wrong."""
```

### Tip 5: Implement Progressive Disclosure

Don't dump all tools on agent at once:

```python
# Start with basic tools
if task_complexity == "low":
    tools = [search, read]
# Add more as needed
elif task_complexity == "medium":
    tools = [search, read, save, analyze]
# Full suite for complex tasks
else:
    tools = [search, read, save, analyze, create, execute]
```

Fewer tools = better decision making.

### Tip 6: Use Async for Speed

RAG with parallel retrieval:

```python
# Bad: Sequential (slow)
results1 = search_pinecone(query)
results2 = search_database(query)
results3 = search_web(query)

# Good: Parallel (3x faster)
results = await asyncio.gather(
    search_pinecone(query),
    search_database(query),
    search_web(query)
)
```

### Tip 7: Build Feedback Loops

```python
async def answer_with_feedback(question):
    answer = await rag_system.answer(question)

    # Show answer, ask user for feedback
    feedback = await ask_user("Was this helpful? (yes/no)")

    # Save for training data
    await db.insert("feedback", {
        "question": question,
        "answer": answer,
        "helpful": feedback == "yes",
        "timestamp": now()
    })

    # Periodically review low-scoring answers
    # Identify patterns, improve prompts/retrieval
```

## 📝 Module Project: Build an AI Research Assistant Agent

### Objective

Build a complete AI agent that can research topics, search multiple sources, synthesize information, and create comprehensive reports with citations. This combines RAG, tool use, and memory.

[Project continues with detailed 8-step implementation...]

### Success Criteria

✅ Agent can break down research tasks autonomously
✅ Uses multiple tools (web search, scraping, database)
✅ Retrieves relevant context from knowledge base
✅ Generates reports with proper citations
✅ Maintains memory across multiple research sessions
✅ Implements guardrails (max iterations, timeouts)
✅ Logs all decisions for debugging
✅ You can explain how each component works

## 📚 Resources & Next Steps

### Recommended Reading
- LangChain Documentation (https://python.langchain.com)
- LlamaIndex Guide (https://docs.llamaindex.ai)
- "Building LLM Apps" by Anthropic (https://docs.anthropic.com)
- "RAG Best Practices" by Pinecone

### Tools & Links
- LangChain (https://langchain.com)
- LlamaIndex (https://llamaindex.ai)
- OpenAI Assistants (https://platform.openai.com/docs/assistants)
- LangSmith (https://smith.langchain.com) - Observability for LLM apps

### Communities
- LangChain Discord
- r/LangChain on Reddit
- AI Engineer World's Fair

### What's Next?

In Module 9 (Payments & Auth), you'll learn to add user authentication and payment processing to your AI applications, turning projects into products people can actually use and pay for.

## ✅ Module Completion Checklist

Before moving to Module 9, you should be able to confidently say "yes" to all of these:

- [ ] I understand the difference between basic and production RAG systems
- [ ] I've built a RAG system with query enhancement and reranking
- [ ] I can implement prompt chaining for multi-step tasks
- [ ] I've created an AI agent that uses multiple tools
- [ ] I understand the ReAct pattern (Reasoning + Acting)
- [ ] I've implemented conversation memory in an AI system
- [ ] I know how to prevent hallucinations and implement guardrails
- [ ] I can debug agent behavior by examining reasoning traces
