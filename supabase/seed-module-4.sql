-- ============================================================================
-- MODULE 4: AI Tools Ecosystem
-- ============================================================================
-- This file contains the complete Module 4 with all quizzes, sections, and resources
-- Run this AFTER schema.sql and the base seed.sql (which creates tracks)

-- First, remove any existing Module 4 data to avoid duplicates
DELETE FROM external_resources WHERE section_id IN (
  SELECT id FROM sections WHERE module_id IN (
    SELECT id FROM modules WHERE slug = 'ai-tools-ecosystem'
  )
);
DELETE FROM sections WHERE module_id IN (
  SELECT id FROM modules WHERE slug = 'ai-tools-ecosystem'
);
DELETE FROM quiz_questions WHERE quiz_id IN (
  SELECT id FROM quizzes WHERE title IN (
    'LLM Platforms Quiz',
    'AI Code Assistants Quiz',
    'No-Code AI Tools Quiz',
    'Specialized AI Tools Quiz',
    'Tool Selection Quiz'
  )
);
DELETE FROM quizzes WHERE title IN (
  'LLM Platforms Quiz',
  'AI Code Assistants Quiz',
  'No-Code AI Tools Quiz',
  'Specialized AI Tools Quiz',
  'Tool Selection Quiz'
);
DELETE FROM modules WHERE slug = 'ai-tools-ecosystem';

-- Insert Module 4
INSERT INTO modules (track_id, slug, title, short_description, order_index, estimated_hours, level, xp_reward, is_active)
SELECT
  id,
  'ai-tools-ecosystem',
  'AI Tools Ecosystem',
  'Navigate the landscape of AI tools: LLM platforms, code assistants, no-code AI tools, and specialized services.',
  4,
  4,
  'Beginner',
  50,
  true
FROM tracks WHERE slug = 'core-foundation';

-- Create quizzes for Module 4
INSERT INTO quizzes (title, description, difficulty, passing_score, xp_reward) VALUES
('LLM Platforms Quiz', 'Test your knowledge of different LLM platforms', 'beginner', 70, 10),
('AI Code Assistants Quiz', 'Test your understanding of AI coding tools', 'beginner', 70, 10),
('No-Code AI Tools Quiz', 'Test your knowledge of no-code AI platforms', 'intermediate', 75, 15),
('Specialized AI Tools Quiz', 'Test your understanding of specialized AI services', 'intermediate', 75, 15),
('Tool Selection Quiz', 'Test your ability to choose the right tools', 'intermediate', 75, 15);

-- ============================================================================
-- SECTION 4.1: LLM Platforms (ChatGPT, Claude, Gemini, Perplexity)
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'LLM Platforms Quiz'), 1,
'What is the main advantage of ChatGPT Plus over the free version?',
'["It''s faster only", "Access to GPT-4, web browsing, image generation, and custom GPTs", "It has a better UI", "It costs less"]',
1,
'ChatGPT Plus gives you access to the more capable GPT-4 model plus additional features like browsing and DALL-E.'),

((SELECT id FROM quizzes WHERE title = 'LLM Platforms Quiz'), 2,
'When should you use Perplexity instead of ChatGPT?',
'["For creative writing", "For research tasks requiring current information with citations", "For code generation", "Never"]',
1,
'Perplexity is specifically designed for research, providing sources and citations for its answers.'),

((SELECT id FROM quizzes WHERE title = 'LLM Platforms Quiz'), 3,
'What makes Claude particularly strong for operators?',
'["It''s the cheapest", "Long context windows and excellent code generation", "It has the best UI", "It''s the fastest"]',
1,
'Claude excels at handling long documents and generating high-quality code, making it ideal for operator work.'),

((SELECT id FROM quizzes WHERE title = 'LLM Platforms Quiz'), 4,
'Which platform should you use for quick fact-checking with sources?',
'["ChatGPT", "Claude", "Gemini", "Perplexity"]',
3,
'Perplexity is built specifically for research and always provides sources for its answers.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'llm-platforms',
  'LLM Platforms (ChatGPT, Claude, Gemini, Perplexity)',
  1,
  'Beginner',
  '# LLM Platforms

As an AI operator, you need to know which LLM platform to use for which task. Each has strengths and weaknesses.

## ChatGPT (OpenAI)

**Best for:** General tasks, structured outputs, function calling

**Plans:**
- **Free:** GPT-3.5, limited usage
- **Plus ($20/mo):** GPT-4, web browsing, DALL-E, custom GPTs
- **Team ($25/user/mo):** Plus features + team workspace
- **Enterprise:** Custom pricing, enhanced security

**Strengths:**
- Most well-known and widely used
- Excellent for structured outputs (JSON, schemas)
- Strong function calling for tool integration
- Custom GPTs (create specialized bots)
- DALL-E integration for image generation
- Web browsing for current information

**Weaknesses:**
- Can be verbose
- Sometimes over-cautious with refusals
- Shorter context window than Claude

**When to use:**
- Need structured data (JSON, XML)
- Building tool integrations
- Want to create custom GPTs for specific tasks
- Need image generation (DALL-E)
- General everyday use

**API Access:**
- Pay-as-you-go: GPT-4 Turbo, GPT-4o, GPT-4o-mini
- Pricing: ~$2.50/1M tokens (GPT-4o)

## Claude (Anthropic)

**Best for:** Code, long documents, detailed analysis

**Plans:**
- **Free:** Claude 3.5 Sonnet, limited usage
- **Pro ($20/mo):** Higher limits, priority access
- **Team ($25/user/mo):** Team features
- **Enterprise:** Custom pricing

**Strengths:**
- Exceptional code generation and debugging
- 200k token context window (very long documents)
- Thoughtful, detailed responses
- Better at following complex instructions
- Excellent reasoning and analysis
- More natural conversation style

**Weaknesses:**
- No image generation
- No web browsing (yet)
- Less widely known than ChatGPT
- Can be slower

**When to use:**
- Writing or debugging code
- Analyzing long documents (100+ pages)
- Need detailed, thoughtful responses
- Complex reasoning tasks
- System architecture design

**API Access:**
- Claude 3.5 Opus, Sonnet, Haiku
- Pricing: ~$3/1M tokens (Sonnet)

## Gemini (Google)

**Best for:** Google ecosystem integration, multimodal tasks

**Plans:**
- **Free:** Gemini Pro
- **Advanced ($20/mo):** Gemini Ultra, higher limits
- **Business/Enterprise:** Custom pricing

**Strengths:**
- Deep Google integration (Workspace, Search, Maps)
- Strong multimodal (text, images, video)
- Access to Google''s knowledge graph
- Real-time information via Search

**Weaknesses:**
- Less consistent quality than GPT-4 or Claude
- Smaller developer community
- Limited third-party integrations

**When to use:**
- Already use Google Workspace heavily
- Need Google Search integration
- Multimodal tasks (analyzing images/video)
- Want free access to capable model

**API Access:**
- Gemini Pro and Ultra
- Pricing: Competitive with OpenAI

## Perplexity

**Best for:** Research with sources

**Plans:**
- **Free:** Limited searches
- **Pro ($20/mo):** Unlimited searches, Pro model, file uploads

**Strengths:**
- Always provides sources and citations
- Excellent for research and fact-checking
- Web search built-in by default
- Clean, focused interface
- Multiple search modes (Quick, Pro, Focus)

**Weaknesses:**
- Not great for creative tasks
- Limited for code generation
- Smaller context window
- Less customizable

**When to use:**
- Research tasks
- Need citations and sources
- Fact-checking information
- Quick answers to current events
- Comparing multiple sources

**No API access (as of now)**

## Decision Framework

**"I need to..."**

**...generate code or debug** → Claude
**...create structured data (JSON)** → ChatGPT
**...research a topic with sources** → Perplexity
**...analyze a 100-page document** → Claude
**...integrate with Google Workspace** → Gemini
**...create images** → ChatGPT (DALL-E)
**...general everyday questions** → ChatGPT or Claude
**...verify facts quickly** → Perplexity

## Should You Pay for Multiple?

**Recommended setup:**

**Minimum (pick one):**
- ChatGPT Plus ($20/mo) OR
- Claude Pro ($20/mo)

**Optimal (both):**
- ChatGPT Plus ($20/mo) AND
- Claude Pro ($20/mo)
- **Total: $40/mo**

**Why both?**
- Use ChatGPT for 70% of tasks
- Use Claude when you need better code or long context
- Having both prevents being blocked by usage limits

**Add later:**
- Perplexity Pro ($20/mo) if you do a lot of research
- API credits ($50-100/mo) when building automations

## Platform-Specific Features

### ChatGPT Custom GPTs

Create specialized bots for repeated tasks:

**Example GPTs:**
- "Email Response Writer" (trained on your style)
- "Process Analyzer" (uses your frameworks)
- "Code Reviewer" (follows your standards)

**How to create:**
1. ChatGPT Plus → Explore GPTs → Create
2. Describe what you want
3. Add instructions and knowledge files
4. Test and refine
5. Share or keep private

### Claude Projects

Organize work by project with persistent context:

**Example Projects:**
- "Client Work - ACME Corp" (all context about that client)
- "Personal Automation" (your workflows)
- "Learning Notes" (study material)

**How to use:**
1. Claude → New Project
2. Add project knowledge (docs, style guides)
3. All conversations in that project share context
4. Switch between projects as needed

### Perplexity Collections

Save and organize research:

**Example Collections:**
- "Automation Tools Research"
- "Competitor Analysis"
- "Industry Trends"

## Quick Reference Table

| Feature | ChatGPT | Claude | Gemini | Perplexity |
|---------|---------|--------|--------|------------|
| Code | Good | Excellent | Good | Fair |
| Research | Good | Good | Good | Excellent |
| Long docs | Fair | Excellent | Fair | Fair |
| Sources | Via browsing | No | Via Search | Always |
| API | Yes | Yes | Yes | No |
| Images | DALL-E | No | Yes | No |
| Context | 128k | 200k | 128k | ~10k |

## Common Mistakes

**Mistake 1: Using only free versions**
You''re wasting hours to save $20. Just pay for Plus/Pro.

**Mistake 2: Not switching tools**
Using ChatGPT for everything when Claude would be better for code.

**Mistake 3: Not organizing work**
Using chat without Projects or custom GPTs for repeated tasks.

**Mistake 4: Ignoring API access**
Once you''re building automations, API access is essential.',

  '## Exercise: Platform Comparison

**Objective:** Experience the differences between platforms firsthand.

**Instructions:**

### Part 1: Same Task, Different Platforms

**Task:** Analyze this business process and suggest improvements

**Process:**
"We receive customer support emails to support@company.com. Someone manually reads each one, figures out if it''s technical or billing, then forwards to the right team. We get about 50 emails a day. Sometimes emails sit for hours before being read."

**Test on all platforms you have access to (minimum 2):**
1. ChatGPT (Free or Plus)
2. Claude (Free or Pro)
3. Gemini (if available)
4. Perplexity (if available)

**Use this exact prompt:**
```
Analyze this business process and suggest 3 automation improvements, from simplest to most advanced. Use the 4-layer model.

Process: [paste process above]
```

**Compare:**
- Which response was most practical?
- Which had best structure?
- Which would you actually implement?
- Speed of response?
- Quality of suggestions?

### Part 2: Specialized Tasks

**Task A: Code Generation**

Ask ChatGPT and Claude:
```
Write a Python function that reads a CSV file and sends each row to a webhook URL. Include error handling for network failures.
```

Compare:
- Code quality
- Error handling
- Comments
- Which would you use in production?

**Task B: Research with Sources**

If you have Perplexity, ask:
```
What are the current best practices for AI prompt engineering? Provide sources.
```

Compare with ChatGPT (with browsing):
- Quality of sources
- Depth of research
- Ease of verifying information

**Task C: Long Document Analysis**

Find a 20+ page PDF (or use a long article).

Test ChatGPT and Claude:
```
Summarize this document in 5 key points. Then identify any action items or recommendations.
```

Compare:
- Which handled the length better?
- Quality of summary
- Did either miss key information?

### Part 3: Custom Setup

**Choose your primary platform (ChatGPT or Claude)**

**If ChatGPT:**
Create a custom GPT for "Process Analyzer"
- Instructions: Use 4-layer model, I→T→O framework
- Test it on 2-3 processes

**If Claude:**
Create a Project for "Business Automation"
- Add knowledge: Your style guide, frameworks
- Test it on 2-3 conversations

**Document:**
- Setup time
- Did it remember context correctly?
- Is this useful for your work?

### Part 4: Cost-Benefit Analysis

**Calculate your monthly usage:**
- How many hours per week do you use AI?
- What tasks?
- Could you do these tasks without AI? How long would it take?

**If free tier:**
- How often do you hit limits?
- How much time do you waste waiting?
- What''s 5-10 hours of your time worth?

**Make the decision:**
- Should you upgrade to Plus/Pro?
- Should you pay for multiple platforms?
- What''s your budget: __ per month
- What''s the ROI if you save 10 hours/month?

### Part 5: Build Your Workflow

**Design your personal LLM workflow:**

**For everyday use:**
- Primary: [ChatGPT/Claude]
- Secondary: [ChatGPT/Claude]
- Research: [Perplexity/ChatGPT Browsing]

**For specific tasks:**
- Code: [platform]
- Writing: [platform]
- Research: [platform]
- Analysis: [platform]
- Automation design: [platform]

**Access method:**
- Web interface for: [tasks]
- API for: [tasks]
- Custom GPT/Project for: [tasks]

**Budget:**
- Monthly spend: $__
- API credits: $__
- Total: $__

**Deliverable:**

Document with:
- Platform comparison results
- Code quality comparison
- Research quality comparison
- Custom setup (GPT or Project)
- Cost-benefit analysis
- Your personal LLM workflow

**Success Criteria:**
- You''ve tested at least 2 platforms
- You understand when to use which
- You have a clear workflow
- You can justify your spending (or not spending)
- You know which platform to recommend to others',

  50,
  true,
  (SELECT id FROM quizzes WHERE title = 'LLM Platforms Quiz')
FROM modules m
WHERE m.slug = 'ai-tools-ecosystem';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'ChatGPT vs Claude vs Gemini - Which is Best?',
  'https://www.youtube.com/watch?v=e5dOpTEhLjI',
  'video',
  1
FROM sections WHERE slug = 'llm-platforms'
UNION ALL
SELECT
  id,
  'How to Use ChatGPT Custom GPTs',
  'https://www.youtube.com/watch?v=pGOyw_M1mNE',
  'video',
  2
FROM sections WHERE slug = 'llm-platforms';

-- ============================================================================
-- SECTION 4.2: AI Code Assistants (Cursor, Windsurf, GitHub Copilot, Cline)
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'AI Code Assistants Quiz'), 1,
'What is the main advantage of AI code assistants over using ChatGPT/Claude directly?',
'["They''re cheaper", "They''re integrated into your editor with full codebase context", "They write better code", "They don''t require internet"]',
1,
'AI code assistants live in your editor and can see your entire project, making suggestions context-aware.'),

((SELECT id FROM quizzes WHERE title = 'AI Code Assistants Quiz'), 2,
'When should you use Cursor over VS Code with Copilot?',
'["Never", "When you want the entire IDE built around AI-first workflows", "Only for Python", "Only for beginners"]',
1,
'Cursor is designed from the ground up for AI-assisted development, with AI integrated into every part of the experience.'),

((SELECT id FROM quizzes WHERE title = 'AI Code Assistants Quiz'), 3,
'What is GitHub Copilot best for?',
'["Replacing developers entirely", "Inline code suggestions and autocompletion as you type", "Project management", "Debugging production issues"]',
1,
'Copilot excels at suggesting code completions as you type, speeding up routine coding tasks.'),

((SELECT id FROM quizzes WHERE title = 'AI Code Assistants Quiz'), 4,
'Why would an AI operator use code assistants even if they''re not a "real developer"?',
'["To look cool", "To learn by doing and build real tools quickly with AI guidance", "They shouldn''t", "Only for testing"]',
1,
'Code assistants let operators learn programming while building, making technical implementation accessible.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'ai-code-assistants',
  'AI Code Assistants (Cursor, Windsurf, GitHub Copilot, Cline)',
  2,
  'Beginner',
  '# AI Code Assistants

AI code assistants are tools that live inside your code editor and help you write code faster. Even if you''re not a "real developer," these tools make coding accessible.

## Why Code Assistants Matter for Operators

**"I''m not a developer" is no longer an excuse.**

With AI code assistants, you can:
- Build scripts for automation
- Create custom tools
- Modify existing code
- Learn programming by doing
- Ship working software in hours, not weeks

You don''t need 10 years of experience. You need curiosity and an AI assistant.

## The Main Players

### Cursor

**What it is:** A fork of VS Code, rebuilt around AI

**Pricing:**
- Free: Limited AI requests
- Pro ($20/mo): Unlimited requests, best models

**Strengths:**
- Entire IDE designed for AI-first coding
- Cmd+K: Ask AI to edit any code inline
- Composer: Multi-file editing with AI
- Tab to autocomplete with AI context
- Can read your entire codebase
- @-mentions to reference files, docs, web

**Weaknesses:**
- Separate app from VS Code (need to switch)
- Smaller ecosystem than VS Code
- Still evolving (some bugs)

**When to use:**
- Building new projects from scratch
- Want AI as your primary coding method
- Need to edit multiple files at once
- Learning to code with AI help

**Perfect for operators who are "coding" for the first time.**

### Windsurf (by Codeium)

**What it is:** Another AI-first IDE (similar to Cursor)

**Pricing:**
- Free: Limited
- Pro ($10/mo): More accessible than Cursor

**Strengths:**
- Cheaper than Cursor
- Similar AI-first interface
- Fast performance
- Good inline suggestions

**Weaknesses:**
- Smaller user base
- Less mature than Cursor
- Fewer integrations

**When to use:**
- Want Cursor-like experience but cheaper
- Don''t need bleeding-edge features

### GitHub Copilot

**What it is:** AI code completion plugin for VS Code, JetBrains, etc.

**Pricing:**
- $10/mo (Individual)
- $19/mo (Business)
- Free for students/open source maintainers

**Strengths:**
- Works in VS Code, your existing editor
- Excellent inline suggestions
- Large training data (all of GitHub)
- Well-established, stable
- Chat interface in VS Code

**Weaknesses:**
- Not as powerful as Cursor for "AI-first" coding
- Requires VS Code knowledge
- Less context about your whole project

**When to use:**
- Already use VS Code and don''t want to switch
- Want code suggestions while typing
- Need stable, proven tool

### Cline (formerly Claude Dev)

**What it is:** VS Code extension that turns Claude into a coding agent

**Pricing:**
- Free extension
- Bring your own Claude API key ($)

**Strengths:**
- Uses Claude (excellent for code)
- Works in VS Code
- Can execute terminal commands
- Can read/write files
- Approval-based (you control what it does)

**Weaknesses:**
- Requires Claude API key (pay per use)
- More manual than Cursor
- Requires understanding API costs

**When to use:**
- Want Claude specifically for coding
- Use VS Code and don''t want to switch
- Okay managing API usage/costs
- Want more control over AI actions

## Decision Framework

**"I want to..."**

**...learn to code with AI help** → Cursor

**...add AI to my existing VS Code setup** → GitHub Copilot or Cline

**...save money but get AI coding** → Windsurf or Cline

**...build a quick script** → Cursor (fastest)

**...work on existing large codebase** → Cursor or Copilot

## How Operators Use Code Assistants

### Use Case 1: Build Automation Scripts

**Task:** Create a Python script to process CSV and send to API

**Without AI:**
- Google how to read CSV in Python (30 mins)
- Figure out requests library (20 mins)
- Debug errors (1 hour)
- Add error handling (30 mins)
**Total: 2+ hours**

**With Cursor:**
1. Open Cursor
2. Cmd+K → "Create a Python script that reads customers.csv and posts each row to https://api.example.com/customers"
3. AI generates complete script
4. Test it
5. Cmd+K → "Add error handling for network failures"
6. Done
**Total: 15 minutes**

### Use Case 2: Modify Existing Code

**Task:** Your Zapier code step needs a tweak

**Without AI:**
- Remember JavaScript syntax (if you know it)
- Figure out the bug
- Test fix
**Time: 30-60 mins**

**With Cursor:**
1. Paste code into Cursor
2. Cmd+K → "Fix this to handle empty email fields"
3. AI fixes it
4. Copy back to Zapier
**Time: 5 minutes**

### Use Case 3: Learn By Doing

**Task:** You want to learn Python

**Old way:**
- Take a course (weeks)
- Do exercises (more weeks)
- Forget it all when you need it

**With AI assistants:**
- Start building something you actually need
- AI explains as you go
- Learn by actually shipping
- Ask questions in context

**You learn faster because you''re solving real problems.**

## Getting Started with Cursor (Recommended)

**Step 1: Install**
- Go to cursor.com
- Download for Mac/Windows/Linux
- Install

**Step 2: Open a Project**
- File → Open Folder
- Choose where you want to code
- Or start fresh: New Folder

**Step 3: Try Basic Commands**

**Cmd+K (inline edit):**
- Highlight code
- Cmd+K
- Tell AI what to change
- Accept or reject

**Cmd+L (chat):**
- Open AI chat sidebar
- Ask questions
- Reference files with @filename

**Tab (autocomplete):**
- Start typing
- AI suggests completion
- Tab to accept

**Composer (multi-file):**
- Cmd+I
- Ask AI to make changes across multiple files

**Step 4: Build Something Real**

Try building:
- A Python script to organize your files
- A simple web scraper
- A CSV processor
- A Zapier webhook receiver

Don''t worry about "doing it right." Let AI guide you.

## Tips for Using AI Code Assistants

### 1. Be Specific

**Bad:** "Make this better"
**Good:** "Add error handling for network timeouts and log failures to errors.txt"

### 2. Work Iteratively

**Don''t ask for everything at once:**
1. "Create basic script"
2. "Add error handling"
3. "Add logging"
4. "Add retry logic"

Each step is testable.

### 3. Read the Code

**Don''t blindly accept AI code.**
- Read it
- Understand what it does
- Test it
- Ask AI to explain if confused

### 4. Use Comments

AI can write code from comments:
```python
# Read customers.csv
# For each row, post to API
# If API fails, retry 3 times
# Log all activity to activity.log
```

Cursor will generate the code from this.

### 5. Reference Docs

In Cursor: `@docs` to include documentation
```
@docs python requests
How do I add authentication headers to a POST request?
```

AI uses actual docs to answer.

## Common Workflows

### Workflow 1: Quick Script

1. Cursor → New file
2. Cmd+K → Describe what you need
3. AI writes it
4. Test
5. Iterate

### Workflow 2: Debug Existing Code

1. Paste code into Cursor
2. Cmd+L → "This code fails when X happens. Why and how do I fix it?"
3. AI explains and fixes
4. Test

### Workflow 3: Learn a New Language

1. Pick a project
2. Ask AI to write it in [language]
3. Read the code
4. Cmd+L → Ask questions about parts you don''t understand
5. Modify it yourself
6. Repeat

## Should You Pay for AI Code Assistants?

**If you code even occasionally: YES.**

**ROI Calculation:**

Your time: £50-100/hour (conservative)
Tool cost: £20/month

If it saves you **1 hour per month**, it''s worth 5x the cost.

Realistically, it saves **10+ hours per month** once you use it regularly.

**No-brainer investment.**

## What About "Real Developers"?

**"Won''t this make me a bad developer who can''t code without AI?"**

**Answer:** Who cares?

The goal isn''t to pass a coding interview. The goal is to **ship stuff that works**.

If AI helps you build useful tools in 1/10th the time, use AI.

Plus, you learn faster by building real things than by memorizing syntax.',

  '## Exercise: Build Your First AI-Assisted Tool

**Objective:** Use an AI code assistant to build something real.

**Instructions:**

### Part 1: Setup

**Choose one:**
- Cursor (recommended, $20/mo or free trial)
- GitHub Copilot (if you have VS Code, $10/mo)
- Cline (free, needs Claude API key)

**Install and set up your chosen tool.**

### Part 2: Build a CSV Processor

**Task:** Create a Python script that:
1. Reads a CSV file
2. Filters rows based on a condition
3. Saves filtered rows to a new CSV
4. Prints a summary

**Example use case:**
- Input: customers.csv (name, email, country, status)
- Filter: country = "UK" AND status = "active"
- Output: uk_active_customers.csv
- Summary: "Found 47 active UK customers"

**Using AI:**

**Step 1:** Create new file: `filter_csv.py`

**Step 2:** Use AI to generate:
```
Create a Python script that:
- Reads customers.csv
- Filters for rows where country = "UK" and status = "active"
- Saves results to uk_active_customers.csv
- Prints summary of how many rows matched
```

**Step 3:** Test with sample data

**Step 4:** Iterate:
- Add error handling for missing file
- Add command line arguments for filename
- Add logging

**Document:**
- What AI generated
- What you had to fix
- How long it took
- Would you have been able to do this without AI?

### Part 3: Build a Web Scraper

**Task:** Scrape data from a website

**Simple example:** Scrape product prices from a page

**Using AI:**
```
Create a Python script using BeautifulSoup that:
- Loads this URL: [some public website]
- Extracts all product names and prices
- Saves to products.csv
- Include error handling
```

**Test it on a simple site (e.g., a static demo site)**

**Note:** What did the AI help with? What did you need to debug?

### Part 4: Build a Zapier Webhook Handler

**Task:** Create a simple web server that receives webhooks

**Using AI:**
```
Create a simple Flask web server that:
- Has one endpoint: /webhook
- Accepts POST requests with JSON
- Logs the received data to webhook_log.txt
- Returns success response
- Include instructions for running it
```

**Test:**
1. Run the server
2. Use Postman or curl to send test webhook
3. Verify it logs correctly

### Part 5: Modify Existing Code

**Find a piece of code** (from a previous exercise, online tutorial, anywhere)

**Ask AI to:**
1. Explain what it does
2. Improve its error handling
3. Add comments
4. Refactor for clarity
5. Add a new feature

**Compare:**
- Original vs AI-modified
- Do you understand it better now?
- Is it actually improved?

### Part 6: Learn Something New

**Pick a language or framework you don''t know:**
- JavaScript
- TypeScript
- React
- Flask
- FastAPI

**Build a tiny project in it with AI help:**

**Example:** "Create a simple React component that displays a list of tasks with add/remove functionality"

**Let AI teach you:**
- Ask it to explain each part
- Ask why it did things a certain way
- Ask for alternatives

**Document:**
- What you learned
- What was confusing
- Could you now modify this code yourself?

### Deliverable

Document with:
- Screenshots of AI assistance
- Code generated for each project
- What worked / what didn''t
- Time spent vs. time it would''ve taken without AI
- Your assessment: Is this tool worth paying for?

**Success Criteria:**
- You''ve built at least 3 working scripts/tools
- You understand what the code does (even if you didn''t write it)
- You can see the time savings
- You have working examples for future reference
- You can decide if AI coding assistants are worth it for you',

  55,
  true,
  (SELECT id FROM quizzes WHERE title = 'AI Code Assistants Quiz')
FROM modules m
WHERE m.slug = 'ai-tools-ecosystem';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Cursor AI - Complete Beginner''s Guide',
  'https://www.youtube.com/watch?v=gqUQbjsYZLQ',
  'video',
  1
FROM sections WHERE slug = 'ai-code-assistants'
UNION ALL
SELECT
  id,
  'GitHub Copilot Tutorial',
  'https://www.youtube.com/watch?v=Fi3AJZZregI',
  'video',
  2
FROM sections WHERE slug = 'ai-code-assistants';

-- ============================================================================
-- SECTION 4.3: No-Code AI Tools (Zapier AI, Make AI, Relevance AI)
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'No-Code AI Tools Quiz'), 1,
'What is the main advantage of no-code AI tools?',
'["They''re free", "They let you integrate AI into workflows without coding", "They''re more powerful than APIs", "They don''t use LLMs"]',
1,
'No-code AI tools provide visual interfaces to add AI capabilities to automations without writing code.'),

((SELECT id FROM quizzes WHERE title = 'No-Code AI Tools Quiz'), 2,
'When should you use Zapier''s built-in AI actions vs. custom API calls?',
'["Always use built-in", "Use built-in for simple tasks, API for advanced control", "Always use API", "They''re the same"]',
1,
'Built-in AI actions are simpler but less flexible. APIs give you full control for complex needs.'),

((SELECT id FROM quizzes WHERE title = 'No-Code AI Tools Quiz'), 3,
'What makes Relevance AI different from Zapier/Make?',
'["It''s cheaper", "It''s built specifically for AI agents and chains, not general automation", "It''s easier", "Nothing"]',
1,
'Relevance AI is purpose-built for AI workflows with agents, chains, and tools, not general automation.'),

((SELECT id FROM quizzes WHERE title = 'No-Code AI Tools Quiz'), 4,
'Why would you pay for a no-code AI tool if APIs are available?',
'["APIs don''t work", "To save development time and get pre-built integrations", "No-code is always better", "You shouldn''t"]',
1,
'No-code tools save significant time with pre-built integrations and visual interfaces, making development much faster.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'no-code-ai-tools',
  'No-Code AI Tools (Zapier AI, Make AI, Relevance AI)',
  3,
  'Intermediate',
  '# No-Code AI Tools

No-code platforms now integrate AI directly, letting you build intelligent automations without writing code.

## Why No-Code AI Tools Matter

**The promise:** Add AI to your automations with visual workflows, no coding required.

**The reality:** It works, but with tradeoffs.

**Best for:**
- Simple AI tasks (classification, extraction, summarization)
- Quick prototypes
- Non-technical users
- Teams without developers

**Limitations:**
- Less control than direct API use
- Can be more expensive
- Limited customization
- Vendor lock-in

## Zapier AI Actions

**What it is:** Built-in AI steps in Zapier workflows

**Available AI Actions:**
- **Chatbots:** Ask AI questions in workflows
- **Text Generation:** Create content with prompts
- **Data Extraction:** Pull structured data from text
- **Classification:** Categorize inputs
- **Summarization:** Condense long text

**Pricing:**
- Included in Zapier plans
- Uses Zapier AI credits (based on usage)
- Can get expensive at scale

**Example Use Case:**

**Lead Classification Workflow:**
1. **Trigger:** New form submission (Tally, Typeform)
2. **AI Action:** Classify as Hot/Warm/Cold based on message content
3. **Filter:** If Hot, send to Step 4
4. **Action:** Create urgent Slack notification
5. **Action:** Add to CRM with "Hot" tag

**Built entirely in Zapier, no code needed.**

**Pros:**
- Dead simple
- Works immediately
- No API key management
- Integrated with thousands of apps

**Cons:**
- Limited prompt control
- Can''t customize models
- Expensive for high volume
- Black box (can''t see what''s happening inside)

## Make (Integromat) AI Modules

**What it is:** AI modules you add to Make scenarios

**Available Modules:**
- OpenAI integration (full GPT API access)
- Text analysis
- Sentiment detection
- Translation

**Pricing:**
- Included in Make plans
- Make''s pricing is operation-based
- More flexible than Zapier for complex logic

**Example Use Case:**

**Customer Support Router:**
1. **Trigger:** New email to support@
2. **OpenAI Module:** Analyze email and return:
   - Category (Technical/Billing/General)
   - Urgency (High/Medium/Low)
   - Sentiment (Positive/Negative/Neutral)
3. **Router:** Based on category + urgency
4. **Actions:** Route to correct team with priority flag

**Pros:**
- More control than Zapier
- Direct OpenAI API access
- Better for complex logic
- Cheaper at scale

**Cons:**
- Steeper learning curve
- Requires understanding of API concepts
- Still limited compared to full code

## Relevance AI

**What it is:** Platform built specifically for AI agents and chains

**Key Features:**
- **Agents:** Build AI workers that perform tasks
- **Tools:** Give agents abilities (search web, query database, etc.)
- **Chains:** Multi-step AI workflows
- **Knowledge:** Upload documents for AI to reference
- **Deployment:** API endpoints for your AI agents

**Pricing:**
- Free tier available
- Pro: ~$99/mo
- Usage-based for API calls

**When to use:**
- Building AI-powered products
- Need agent-like behavior (AI that uses tools)
- Want to deploy AI as API
- More sophisticated than simple automation

**Example Use Case:**

**Research Assistant Agent:**
1. User asks: "Research competitors in the automation space"
2. Agent uses tools:
   - Web search tool → Find competitor websites
   - Scraping tool → Extract key info
   - Analysis tool → Compare features
3. Agent compiles report
4. Returns structured markdown document

**More powerful than Zapier/Make for AI-specific tasks.**

**Pros:**
- Built for AI, not retrofitted
- Agent framework (AI that uses tools)
- Can build sophisticated AI products
- Deployable as API

**Cons:**
- Learning curve
- Less mature than Zapier/Make
- Smaller integration ecosystem
- More expensive

## n8n with AI Nodes

**What it is:** Self-hosted open-source automation with AI integrations

**AI Capabilities:**
- OpenAI node
- Pinecone (vector database) node
- LangChain integration
- Custom code nodes for any AI API

**Pricing:**
- Self-hosted: Free (you pay for hosting)
- Cloud: ~$20/mo starter

**When to use:**
- Want full control
- Need to self-host (data privacy)
- Comfortable with technical setup
- Want to customize everything

**Pros:**
- Open source
- Full control
- Self-hosted option
- No vendor lock-in
- Can use any AI API

**Cons:**
- Requires technical knowledge
- Self-hosting = maintenance
- Smaller community than Zapier

## Decision Framework

**"I need to..."**

**...add simple AI to existing automations** → Zapier AI Actions

**...build complex AI logic** → Make + OpenAI

**...create AI agents with tools** → Relevance AI

**...have full control + self-host** → n8n

**...prototype quickly** → Zapier

**...go to production at scale** → Make or n8n or direct API

## Cost Comparison

**Scenario:** Classify 10,000 leads per month

**Zapier AI:**
- AI credits: ~$50-100/mo
- Zapier plan: $29-69/mo
- **Total: ~$80-170/mo**

**Make + OpenAI API:**
- Make plan: $9-29/mo
- OpenAI API: ~$5/mo (GPT-4o-mini)
- **Total: ~$15-35/mo**

**Direct API (custom code):**
- Hosting: $5/mo
- OpenAI API: ~$5/mo
- **Total: ~$10/mo**

**At scale, no-code gets expensive. But for low volume, the time savings justify the cost.**

## When to Graduate to Code

**Stick with no-code when:**
- Volume is low (<1000 operations/month)
- Logic is simple
- You don''t have dev resources
- Speed of deployment > cost

**Graduate to code when:**
- Volume is high (>10,000 operations/month)
- Logic is complex
- You have dev resources
- You need full control
- Cost matters

**The beauty:** You can prototype in Zapier, then rewrite in code if needed.

## Combining No-Code + Code

**Hybrid approach:**

Use no-code for:
- Triggers (form submissions, emails, webhooks)
- Integrations (CRM, email, Slack)
- Simple routing

Use code for:
- Complex AI logic
- Data processing
- Custom transformations

**Example:**

**Zapier workflow:**
1. Trigger: New form submission
2. Action: Send data to your custom API endpoint (code)
3. [Your API does complex AI processing]
4. Zapier receives response
5. Action: Create CRM record with results

**Best of both worlds.**

## Common Patterns

### Pattern 1: AI Classification Router

**No-code setup:**
- Form submission → AI classify → Route based on category → Actions

**Works in:** Zapier, Make

### Pattern 2: Content Generation Pipeline

**No-code setup:**
- Trigger → AI generate content → Format → Post to CMS

**Works in:** Zapier, Make

### Pattern 3: Data Enrichment

**No-code setup:**
- New CRM contact → AI research company → Update CRM with findings

**Works in:** Make, Relevance AI

### Pattern 4: Customer Support Agent

**No-code setup:**
- Email received → AI analyze → AI draft response → Human approval → Send

**Works in:** Make, Relevance AI',

  '## Exercise: Build No-Code AI Workflows

**Objective:** Use no-code platforms to add AI to automations.

**Instructions:**

### Part 1: Simple AI Classification (Zapier)

**Task:** Build a lead scoring workflow

**Requirements:**
- Trigger: Form submission (use Tally, Typeform, or Google Forms - free options)
- AI: Classify as Hot/Warm/Cold based on:
  - Budget mentioned
  - Timeline urgency
  - Company size
  - Role/authority
- Action: Send different email based on classification

**Steps:**
1. Create a simple form with: Name, Email, Company, Message
2. Set up Zapier trigger for new submissions
3. Add "Chatbots" action (Zapier AI)
4. Prompt: "Classify this lead as Hot, Warm, or Cold based on [criteria]. Return only the classification."
5. Add Filter: If Hot, continue
6. Add email action
7. Test with sample submissions

**Document:**
- Screenshots of workflow
- Test results (did it classify correctly?)
- Cost estimate for 100 submissions/month

### Part 2: AI Data Extraction (Make or Zapier)

**Task:** Extract structured data from text

**Scenario:** Customer emails contain appointment requests buried in conversation

**Input Example:**
"Hi, I''d love to schedule a consultation. I''m available next Tuesday at 2pm or Thursday at 10am. My phone is 555-0123. Thanks, John Smith from ACME Corp"

**Extract:**
- Name
- Company
- Phone
- Preferred dates/times

**Build workflow:**
1. Trigger: Sample text input (use webhook or manual trigger)
2. AI action: Extract structured data
3. Format as JSON
4. Output (log, send to database, or display)

**Test with 3 different examples.**

### Part 3: Content Generation (Zapier or Make)

**Task:** Auto-generate social media posts

**Workflow:**
1. Trigger: New blog post (or manual input)
2. AI: Generate 3 social media variations:
   - Twitter/X (280 chars)
   - LinkedIn (longer, professional)
   - Instagram (with emoji, casual)
3. Output to Google Sheet or save as draft

**Test:**
- Give it a blog post URL or summary
- Review AI-generated posts
- Are they usable? What needed editing?

### Part 4: Compare Platforms

**Same task, different tools:**

**Task:** Sentiment analysis on customer feedback

**Build in:**
- Zapier (if you have access)
- Make (free tier available)

**Compare:**
- Ease of setup
- Cost
- AI quality
- Flexibility

**Test with same 5 customer messages:**
1. "Love your product, it''s amazing!"
2. "It''s okay, nothing special"
3. "Terrible experience, waste of money"
4. "Some good features but buggy"
5. "Works as described"

**Document:**
- Which platform was easier?
- Which gave better results?
- Which would you use for production?

### Part 5: Advanced Agent (Relevance AI - Optional)

**If you want to try Relevance AI:**

**Task:** Build a simple research agent

**Agent abilities:**
- Web search
- Summarization
- Report generation

**Test query:** "Research no-code automation tools and compare features"

**See what it produces.**

**Note:** This is more advanced. Only do this if you want to explore agent frameworks.

### Part 6: Cost Analysis

**For your lead scoring workflow from Part 1:**

**Calculate costs at different scales:**

**10 leads/month:**
- Zapier: $__
- Make: $__
- Custom API: $__

**100 leads/month:**
- Zapier: $__
- Make: $__
- Custom API: $__

**1,000 leads/month:**
- Zapier: $__
- Make: $__
- Custom API: $__

**At what volume should you switch from no-code to code?**

### Deliverable

Document with:
- Screenshots of each workflow built
- Test results and AI outputs
- Platform comparison
- Cost analysis
- Your recommendation: When to use no-code vs. code?

**Success Criteria:**
- Built at least 2 working AI workflows
- Understand the tradeoffs of no-code AI
- Can calculate costs at different scales
- Know when to use which platform
- Can explain to a client when no-code makes sense',

  60,
  true,
  (SELECT id FROM quizzes WHERE title = 'No-Code AI Tools Quiz')
FROM modules m
WHERE m.slug = 'ai-tools-ecosystem';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Zapier AI Features Tutorial',
  'https://www.youtube.com/watch?v=JtdUgJGI_Oo',
  'video',
  1
FROM sections WHERE slug = 'no-code-ai-tools'
UNION ALL
SELECT
  id,
  'Make + OpenAI Integration Guide',
  'https://www.youtube.com/watch?v=JSA2oezQWOU',
  'video',
  2
FROM sections WHERE slug = 'no-code-ai-tools';

-- ============================================================================
-- SECTION 4.4: Specialized AI Tools (Midjourney, ElevenLabs, Runway)
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Specialized AI Tools Quiz'), 1,
'What is Midjourney best used for?',
'["Writing code", "Generating high-quality images from text descriptions", "Video editing", "Data analysis"]',
1,
'Midjourney excels at creating artistic, high-quality images from text prompts.'),

((SELECT id FROM quizzes WHERE title = 'Specialized AI Tools Quiz'), 2,
'Why would an AI operator need image generation tools?',
'["They don''t", "For client presentations, marketing materials, and rapid prototyping", "Only for fun", "To replace designers completely"]',
1,
'Image generation speeds up visual content creation for presentations, mockups, and marketing.'),

((SELECT id FROM quizzes WHERE title = 'Specialized AI Tools Quiz'), 3,
'What makes ElevenLabs valuable for operators?',
'["It generates images", "It creates realistic AI voice for content, training, and automation", "It writes code", "It''s free"]',
1,
'ElevenLabs produces natural-sounding voice content for various applications without needing voice actors.'),

((SELECT id FROM quizzes WHERE title = 'Specialized AI Tools Quiz'), 4,
'When should you use specialized AI tools vs. ChatGPT/Claude?',
'["Never", "When you need specific outputs like images, voice, or video", "Always", "Only for large companies"]',
1,
'Specialized tools are purpose-built for specific content types and produce much better results than general LLMs.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'specialized-ai-tools',
  'Specialized AI Tools (Midjourney, ElevenLabs, Runway)',
  4,
  'Intermediate',
  '# Specialized AI Tools

Beyond text generation, specialized AI tools handle images, voice, video, and more. Operators use these to create professional content quickly.

## Why Specialized Tools Matter

**ChatGPT and Claude are generalists. Sometimes you need a specialist.**

**Use cases for operators:**
- Client presentations (images, mockups)
- Marketing materials (graphics, videos)
- Training content (voiceovers, videos)
- Product mockups (UI designs)
- Social media content (images, short videos)

You''re not replacing designers or video editors. You''re **enabling rapid iteration** and **reducing dependency on others** for simple tasks.

## Image Generation

### Midjourney

**What it is:** AI image generation via Discord bot

**Pricing:**
- Basic: $10/mo (200 images)
- Standard: $30/mo (unlimited in relaxed mode)
- Pro: $60/mo (more speed, stealth mode)

**Strengths:**
- Highest quality artistic images
- Great for creative, stylized work
- Active community with shared prompts
- v6 is photorealistic

**Weaknesses:**
- Discord-only (clunky interface)
- Learning curve for prompts
- No web interface (yet)
- Can''t iterate on specific details easily

**When to use:**
- High-quality marketing images
- Concept art for products
- Presentation visuals
- Social media content

**Example prompts:**
```
"Professional office team collaborating, modern bright office, photorealistic, shot on Canon --ar 16:9 --v 6"

"Abstract data visualization, blue and purple gradient, clean minimal design, 4k"

"Startup founder presenting to investors, confident, modern, cinematic lighting --ar 3:2"
```

### DALL-E (via ChatGPT)

**What it is:** OpenAI''s image generator, integrated into ChatGPT Plus

**Pricing:**
- Included in ChatGPT Plus ($20/mo)

**Strengths:**
- Integrated into ChatGPT (easy to use)
- Good at understanding complex prompts
- Can iterate in conversation
- No extra cost if you have Plus

**Weaknesses:**
- Lower quality than Midjourney for artistic work
- Fewer style options
- Can be overly "safe" (restrictive content policy)

**When to use:**
- Quick mockups while working in ChatGPT
- Simple graphics
- Iterative design (chat-based)

### Stable Diffusion

**What it is:** Open-source image generation

**Pricing:**
- Free (self-host) or cloud services vary

**Strengths:**
- Open source (full control)
- Can fine-tune models
- No restrictions
- Free if self-hosted

**Weaknesses:**
- Requires technical setup
- Steeper learning curve
- Quality varies based on model

**When to use:**
- Need full control
- Want to fine-tune
- High volume (cheaper at scale)
- Comfortable with technical setup

## Voice & Audio

### ElevenLabs

**What it is:** AI voice generation and cloning

**Pricing:**
- Free: 10k characters/month
- Starter: $5/mo (30k characters)
- Creator: $22/mo (100k characters)
- Pro: $99/mo (500k characters)

**Features:**
- Text-to-speech (natural voices)
- Voice cloning (clone any voice)
- Multiple languages
- API access

**Use Cases:**
- Training videos (narration without hiring voice actor)
- Podcast intros
- Automated phone messages
- Video content
- Audiobook-style content

**Quality:** Shockingly good. Often indistinguishable from real human voice.

**Example workflow:**
1. Write script in ChatGPT
2. Paste into ElevenLabs
3. Select voice
4. Generate
5. Download MP3
6. Use in video

**When to use:**
- Need professional voiceover quickly
- Consistent voice for series of videos
- Multiple language versions of same content
- Can''t afford voice actor

### Suno / Udio (AI Music)

**What it is:** AI-generated music from text prompts

**Pricing:**
- Free tier available
- Pro: ~$10/mo

**Use Cases:**
- Background music for videos
- Podcast intros/outros
- Hold music for phone systems
- Demo/prototype content

**Quality:** Good for background music. Not ready for professional music production.

## Video Generation & Editing

### Runway

**What it is:** AI video generation and editing suite

**Features:**
- Text-to-video
- Image-to-video
- Video-to-video (style transfer)
- Green screen removal
- Object removal
- Super slow motion

**Pricing:**
- Free: Limited credits
- Standard: $12/mo
- Pro: $28/mo
- Unlimited: $76/mo

**Use Cases:**
- Create video from text/images
- Quick video editing without complex software
- Social media content
- Presentation videos

**Limitations:**
- Generated video still has quirks
- Best for short clips (5-10 seconds)
- Not ready for long-form content

### Descript

**What it is:** AI-powered video/audio editing

**Features:**
- Edit video by editing text transcript
- Remove filler words (um, uh)
- AI voices (Overdub)
- Screen recording
- Multi-track editing

**Pricing:**
- Free: 1 hour transcription/month
- Creator: $12/mo
- Pro: $24/mo

**Use Cases:**
- Edit podcast or video by editing transcript
- Remove mistakes without video editing skills
- Create training videos
- Screen recordings with narration

**When to use:**
- Making video tutorials
- Podcast editing
- Need to edit video but don''t know Premiere/Final Cut

### OpusClip / Klap

**What it is:** AI-powered short-form video creation

**Features:**
- Takes long video, creates short clips
- Auto-captions
- Auto-reframe for vertical video
- Viral score prediction

**Pricing:**
- ~$10-30/mo

**Use Cases:**
- Turn podcast into social clips
- Repurpose webinar into shorts
- Create TikTok/Instagram/YouTube Shorts

## Design & UI

### Figma AI Plugins

**What it is:** AI plugins for Figma

**Popular plugins:**
- Automator (automate repetitive tasks)
- Magician (AI design suggestions)
- Content Reel (fill designs with realistic content)

**Use Cases:**
- Mockup UI quickly
- Generate placeholder content
- Automate design tasks

### Uizard / Galileo

**What it is:** AI-powered UI design from text

**Use Cases:**
- Quick mockups for client presentations
- Prototype ideas fast
- Generate starting points for designers

**Limitations:**
- Not production-ready
- Still need designer for polish
- Best for prototyping

## How Operators Use Specialized Tools

### Workflow 1: Client Presentation

**Task:** Pitch automation services to potential client

**Tools used:**
- **Midjourney:** Generate hero images for slides
- **ChatGPT:** Write presentation content
- **ElevenLabs:** Record narration
- **Descript:** Assemble video presentation

**Result:** Professional presentation in hours, not days.

### Workflow 2: Training Content

**Task:** Create onboarding videos for new automation system

**Tools used:**
- **Descript:** Record screen + narration
- **ElevenLabs:** Clean up audio or use AI voice
- **OpusClip:** Create short "how-to" clips for different features

**Result:** Complete training library without video editor.

### Workflow 3: Social Media Content

**Task:** Generate month of content

**Tools used:**
- **ChatGPT:** Generate post ideas and copy
- **Midjourney:** Create eye-catching images
- **Runway:** Generate short video clips
- **Scheduling tool:** Queue posts

**Result:** 30 days of content in 4 hours.

## Tool Selection Framework

**"I need to create..."**

**...high-quality images** → Midjourney
**...quick mockup images** → DALL-E (ChatGPT)
**...voiceover** → ElevenLabs
**...video from scratch** → Runway
**...edit existing video easily** → Descript
**...short social clips from long video** → OpusClip
**...UI mockup** → Figma + AI plugins or Uizard
**...background music** → Suno/Udio

## Budgeting for Specialized Tools

**Starter Operator ($40-50/mo):**
- ChatGPT Plus ($20) - includes DALL-E
- ElevenLabs Starter ($5)
- Descript Creator ($12)
- **Total: ~$37/mo**

**Professional Operator ($100-120/mo):**
- ChatGPT Plus ($20)
- Claude Pro ($20)
- Midjourney Standard ($30)
- ElevenLabs Creator ($22)
- Descript Pro ($24)
- **Total: ~$116/mo**

**Only pay for what you use regularly.** Start small, add as needed.

## Common Mistakes

**Mistake 1: Expecting Perfection**
AI-generated content is a starting point, not the finish line. You''ll still need to review, edit, and refine.

**Mistake 2: Using AI for Everything**
Sometimes a human designer/writer/editor is worth it. Use AI for speed and iteration, humans for final polish.

**Mistake 3: Not Learning the Tools**
Each tool has a learning curve. Invest time to learn proper prompting and workflows.

**Mistake 4: Ignoring Licensing**
Check terms of service. Some tools restrict commercial use. Know what you can/can''t do with outputs.

## When to Use Humans vs. AI

**Use AI for:**
- First drafts
- Rapid iteration
- Internal content
- Prototyping
- Low-stakes content

**Use Humans for:**
- Final client deliverables
- Brand-critical content
- Complex creative direction
- High-stakes work
- Anything that needs nuanced judgment',

  '## Exercise: Create Multi-Modal Content

**Objective:** Use specialized AI tools to create professional content.

**Instructions:**

### Part 1: Image Generation Challenge

**Task:** Create 5 images for a fictional client presentation

**Scenario:** Client is a small law firm wanting to automate client intake

**Create images for:**
1. Hero slide (professional law office)
2. "Current process" (chaos/manual work)
3. "Future state" (streamlined/automated)
4. Team collaboration image
5. Happy client receiving service

**Tool:** Midjourney or DALL-E (use what you have access to)

**Requirements:**
- Professional quality
- Consistent style
- Appropriate for business context

**Document:**
- Prompts used
- Which images worked/failed
- How many iterations needed
- Time spent
- Would you use these in real presentation?

### Part 2: Voice Content Creation

**Task:** Create a 1-minute narration for a training video

**Script topic:** "How to use our new automated lead intake system"

**Steps:**
1. Write script with ChatGPT (make it ~150-200 words)
2. Generate voice with ElevenLabs (free tier available)
3. Download audio
4. Listen and evaluate

**Evaluate:**
- Does it sound natural?
- Would you use this in real training?
- What would you change?
- Compare to your own voice recording (optional)

### Part 3: Video Editing Challenge (Optional)

**If you have Descript or similar:**

**Task:** Create a simple tutorial video

**Content:** Screen recording showing how to do something simple (e.g., create a Zapier workflow)

**Steps:**
1. Record screen + narration (or just screen)
2. Import to Descript
3. Edit by editing transcript
4. Remove filler words
5. Add captions
6. Export

**Time it:** How long did this take vs. traditional video editing?

### Part 4: Social Media Content Package

**Task:** Create a complete social media post

**Components:**
1. **Image:** (Midjourney/DALL-E)
2. **Caption:** (ChatGPT)
3. **Short video:** (Runway or screen recording + Descript)

**Topic:** "5 Tasks You Should Automate Today"

**Create for:**
- LinkedIn (professional image + longer caption)
- Instagram (eye-catching image + shorter caption + story video)
- Twitter/X (simple image + tweet)

**Document:**
- Time to create all 3
- Quality assessment
- Would you actually post these?

### Part 5: Compare Quality vs. Cost

**Scenario:** You need 10 professional images for a website

**Option A: AI (Midjourney)**
- Cost: $30/mo for unlimited
- Time: 2-3 hours (including iterations)
- Quality: Good but needs careful prompting

**Option B: Stock Photos**
- Cost: ~$10-30 per image = $100-300
- Time: 2-3 hours searching
- Quality: Professional but generic

**Option C: Designer**
- Cost: ~$50-100 per custom image = $500-1000
- Time: 1-2 weeks
- Quality: Exactly what you want, highest quality

**Which would you choose and why?**

### Part 6: Build a Content Creation Workflow

**Design your personal workflow for:**

**"I need to create a client presentation video"**

**Map out:**
1. Content creation (script) - Tool: __
2. Visual assets - Tool: __
3. Voiceover - Tool: __
4. Video assembly - Tool: __
5. Editing - Tool: __

**Estimate time and cost for each step.**

### Deliverable

Document with:
- All created assets (images, audio, video)
- Prompts and process used
- Quality assessments
- Cost/time breakdowns
- Your recommended toolset
- When you''d use AI vs. humans

**Success Criteria:**
- Created content with at least 2 specialized tools
- Can assess quality honestly
- Understand cost/time tradeoffs
- Know when to use AI vs. humans
- Have working examples for your portfolio',

  50,
  true,
  (SELECT id FROM quizzes WHERE title = 'Specialized AI Tools Quiz')
FROM modules m
WHERE m.slug = 'ai-tools-ecosystem';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Midjourney for Beginners - Complete Guide',
  'https://www.youtube.com/watch?v=9WVZbitXbck',
  'video',
  1
FROM sections WHERE slug = 'specialized-ai-tools'
UNION ALL
SELECT
  id,
  'ElevenLabs Tutorial - AI Voice Generation',
  'https://www.youtube.com/watch?v=ZDUDAArXwWI',
  'video',
  2
FROM sections WHERE slug = 'specialized-ai-tools';

-- ============================================================================
-- SECTION 4.5: Tool Selection Framework & Decision Matrix
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Tool Selection Quiz'), 1,
'What is the most important factor when choosing AI tools?',
'["Price", "Matching the tool''s strengths to your specific use case", "Popularity", "How new it is"]',
1,
'The right tool for the job is more important than cost or popularity - focus on fit for purpose.'),

((SELECT id FROM quizzes WHERE title = 'Tool Selection Quiz'), 2,
'Why shouldn''t you just use the "best" tool for everything?',
'["There is no best tool", "Different tools excel at different tasks - specialization matters", "You should use the best tool", "Cost is the only reason"]',
1,
'Each tool has different strengths - using the right tool for each task produces better results.'),

((SELECT id FROM quizzes WHERE title = 'Tool Selection Quiz'), 3,
'When should you pay for a tool vs. using a free alternative?',
'["Always pay", "When time saved exceeds cost and quality matters", "Never pay", "Randomly"]',
1,
'Calculate ROI: if a tool saves you hours and improves quality, it''s worth paying for.'),

((SELECT id FROM quizzes WHERE title = 'Tool Selection Quiz'), 4,
'What should you do before committing to an expensive tool?',
'["Buy immediately", "Test with free tier or trial, measure results, then decide", "Ask friends", "Flip a coin"]',
1,
'Always validate that a tool actually solves your problem before committing to paid plans.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'tool-selection',
  'Tool Selection Framework & Decision Matrix',
  5,
  'Intermediate',
  '# Tool Selection Framework

With hundreds of AI tools available, how do you choose? This framework helps you make smart decisions.

## The Problem: Tool Overload

**New AI tools launch every week.**

It''s easy to:
- Get overwhelmed by options
- Waste money on tools you don''t use
- Use the wrong tool for the task
- Miss obviously better alternatives

**You need a system for evaluating tools.**

## The Decision Framework

### Step 1: Define Your Need

**Before looking at tools, clearly state:**

**What problem am I solving?**
- "I need to generate images for client presentations"
- "I need to classify customer support emails"
- "I need to write and debug code faster"

**Be specific. "I want AI" is not a need.**

### Step 2: Identify Must-Haves

**What are non-negotiables?**

Examples:
- Must integrate with Zapier
- Must be under $50/month
- Must work offline
- Must have API access
- Must support our language
- Must be SOC 2 compliant

**This immediately eliminates many options.**

### Step 3: Evaluate Options

**For each remaining tool, score on:**

**1. Fit for Purpose (1-10)**
- Does it solve my specific problem well?
- Is this what it''s designed for?

**2. Ease of Use (1-10)**
- Can I figure it out quickly?
- Is the learning curve acceptable?

**3. Cost (1-10)**
- Is it within budget?
- Is pricing predictable?
- What''s the ROI?

**4. Integration (1-10)**
- Works with my existing stack?
- API available if needed?

**5. Reliability (1-10)**
- Is it stable?
- Good uptime?
- Mature product or early beta?

**Total score: 50 points possible**

**40+:** Excellent fit
**30-39:** Good fit
**20-29:** Acceptable but not ideal
**<20:** Look elsewhere

### Step 4: Test Before Committing

**Always test before paying:**

1. Use free tier if available
2. Run through real use case
3. Measure results
4. Compare to alternatives

**Don''t trust marketing. Test yourself.**

## Real Example: Choosing an LLM Platform

**Need:** Primary LLM for operator work (analysis, code, writing)

**Must-haves:**
- Under $30/month
- API access available
- Good for code
- Long context (50k+ tokens)

**Options:** ChatGPT Plus, Claude Pro, Gemini Advanced

**Scoring:**

| Criteria | ChatGPT Plus | Claude Pro | Gemini Advanced |
|----------|-------------|-----------|----------------|
| Fit for Purpose | 8 | 9 | 7 |
| Ease of Use | 9 | 8 | 7 |
| Cost | 8 ($20) | 8 ($20) | 8 ($20) |
| Integration | 9 | 7 | 6 |
| Reliability | 9 | 8 | 7 |
| **Total** | **43** | **40** | **35** |

**Decision:** ChatGPT Plus for general use, Claude Pro for code-heavy work

**Reasoning:** Both score high. Having both ($40/mo total) covers all bases.

## Decision Matrix Template

Use this for any tool decision:
```
TOOL COMPARISON: [Category]

Need: [Clearly stated problem]

Must-haves:
- [ ] Requirement 1
- [ ] Requirement 2
- [ ] Requirement 3

Options:
1. [Tool A]
2. [Tool B]
3. [Tool C]

Scoring (1-10 each):

| Criteria | Tool A | Tool B | Tool C |
|----------|--------|--------|--------|
| Fit | _ | _ | _ |
| Ease | _ | _ | _ |
| Cost | _ | _ | _ |
| Integration | _ | _ | _ |
| Reliability | _ | _ | _ |
| **Total** | __ | __ | __ |

Decision: [Tool X] because [reasoning]

Test plan:
1. [What I''ll test]
2. [Success criteria]
3. [Timeline for decision]
```

## Common Traps to Avoid

### Trap 1: Shiny Object Syndrome

**Symptom:** Trying every new tool that launches

**Fix:** Only evaluate tools when you have a specific need.

### Trap 2: Feature Comparison Paralysis

**Symptom:** Endless spreadsheet comparisons, never choosing

**Fix:** Set a decision deadline. Pick, test, move on.

### Trap 3: Paying for Too Many Tools

**Symptom:** $300/month in AI tools, using 3 of them

**Fix:** Monthly audit. Cut tools you haven''t used in 30 days.

### Trap 4: Using Wrong Tool for Task

**Symptom:** Using ChatGPT for code when Claude is better

**Fix:** Match tool strengths to task requirements.

### Trap 5: Not Switching When Better Option Emerges

**Symptom:** Sticking with first tool you tried

**Fix:** Re-evaluate quarterly. Tools improve fast.

## Build vs. Buy Decision

**Sometimes you should build custom vs. using existing tool.**

**Build custom when:**
- Existing tools don''t fit
- Volume makes it cheaper
- Need full control
- Have dev resources

**Use existing tool when:**
- Good fit exists
- Low volume
- Time > money
- Don''t have dev resources

**Example:**

**Need:** Classify 50 leads/month

**Option A:** Zapier + AI ($30/mo, 2 hours setup)
**Option B:** Custom API ($10/mo + $200 dev time upfront)

**Month 1:**
- Option A: $30
- Option B: $210

**Month 12:**
- Option A: $360 total
- Option B: $330 total

**If volume stays low, Option A is fine.**

**If volume grows to 5,000/month:**
- Option A: ~$200/mo
- Option B: ~$15/mo

**Now custom makes sense.**

## Your Personal Tool Stack

**Design your operator toolkit:**

### Tier 1: Core (Can''t work without)
- LLM platform: __
- Code assistant: __
- Automation: __

**Spend here: No compromise.**

### Tier 2: Regular Use (Use weekly)
- Image generation: __
- Voice: __
- Specialized tools: __

**Spend here: Worth it for time savings.**

### Tier 3: Occasional (Use monthly)
- Various specialized tools
- Try free tiers first
- Pay as needed

**Spend here: Only if specific project requires.**

## Budgeting Framework

**Calculate your AI tool budget:**

**Your hourly rate:** £__ /hour

**Hours saved per month by tools:** __ hours

**Value of time saved:** £__ /month

**Your tool budget should be:** ~20-30% of time saved value

**Example:**
- Your rate: £50/hour
- Tools save: 20 hours/month
- Value: £1,000/month
- Budget: £200-300/month

**This keeps ROI positive.**

## When to Upgrade vs. Downgrade

**Upgrade to paid tier when:**
- You hit free tier limits
- Quality difference matters
- Time savings justify cost
- Using tool daily

**Downgrade or cancel when:**
- Haven''t used in 30 days
- Found better alternative
- Need changed
- Not getting value

**Monthly review:** Which tools are earning their cost?

## Future-Proofing Your Stack

**The AI landscape changes fast.**

**Stay flexible:**
- Don''t over-commit to annual plans
- Keep skills transferable (prompting, not tool-specific tricks)
- Re-evaluate quarterly
- Test new tools that might be better

**But also:**
- Don''t chase every new thing
- Master your core tools
- Switching has a cost too

**Balance: Be aware of new tools, but don''t constantly switch.**',

  '## Exercise: Build Your Personal Tool Stack

**Objective:** Design a rational, cost-effective AI tool stack.

**Instructions:**

### Part 1: Audit Current Usage

**List every AI tool you currently use or have access to:**

For each tool, track for 1 week:
- How many times did you use it?
- For what tasks?
- Could you have used a different tool?
- Are you paying for it?

**Create a table:**

| Tool | Times Used | Tasks | Cost/mo | Keep/Cut |
|------|-----------|-------|---------|----------|
| ChatGPT Plus | __ | __ | $20 | __ |
| ... | ... | ... | ... | ... |

**Calculate:**
- Total monthly spend: $__
- Tools used 0 times: __
- Tools used <3 times: __
- Tools used daily: __

### Part 2: Define Your Needs

**List your top 5 most frequent tasks:**

1. __
2. __
3. __
4. __
5. __

**For each task:**
- Current tool: __
- Is it the best tool? __
- Better alternative? __
- Why/why not switch? __

### Part 3: Score Your Current Tools

**Pick your 3-5 most-used tools.**

**For each, score (1-10):**

| Tool | Fit | Ease | Cost | Integration | Reliability | Total |
|------|-----|------|------|------------|-------------|-------|
| __ | __ | __ | __ | __ | __ | __ |

**What''s your lowest-scoring tool? Should you replace it?**

### Part 4: Identify Gaps

**What do you currently struggle with?**

Examples:
- "Takes me 3 hours to create presentation images"
- "Can''t easily analyze long documents"
- "Video editing is painful"
- "Code debugging takes forever"

**For each gap:**
- Problem: __
- Current solution (if any): __
- Time wasted per month: __ hours
- Value of that time: £__
- Potential tools to solve: __
- Cost: __
- ROI: Yes/No

### Part 5: Design Your Ideal Stack

**Based on your needs and budget, design your toolkit:**

**Tier 1: Core (Must-have)**
- LLM: __ ($__)
- Code assist: __ ($__)
- Automation: __ ($__)

**Tier 2: Regular Use**
- Image: __ ($__)
- Voice: __ ($__)
- Other: __ ($__)

**Tier 3: Occasional**
- __ (free tier)
- __ (pay as needed)

**Total monthly cost:** $__

**Expected hours saved:** __ hours/month

**ROI calculation:**
- Your hourly rate: £__
- Hours saved value: £__
- Cost: £__
- Net benefit: £__

**Is this worth it?**

### Part 6: Test New Tools

**Pick ONE gap you want to fill.**

**Research 3 tools that might solve it:**

Tool 1: __
- Free tier? __
- What I''ll test: __

Tool 2: __
- Free tier? __
- What I''ll test: __

Tool 3: __
- Free tier? __
- What I''ll test: __

**Actually test all 3 with a real use case.**

**Document:**
- Which worked best?
- Time to learn each
- Quality of output
- Which would you pay for?

### Part 7: Make Cuts

**Based on your audit, which tools should you cut?**

**For each potential cut:**
- Tool: __
- Cost: $__
- Used __ times last month
- Replacement: __ (or none)
- Savings: $__

**Total potential savings:** $__

### Deliverable

**Your Personal Tool Stack Document:**

**Section 1: Current State**
- All tools
- Usage frequency
- Total cost

**Section 2: Analysis**
- What I use most
- What I waste money on
- What I''m missing

**Section 3: Recommended Stack**
- Tier 1 tools (with justification)
- Tier 2 tools (with justification)
- Total cost

**Section 4: ROI Calculation**
- Hours saved
- Value of time
- Net benefit

**Section 5: Action Plan**
- Tools to cut
- Tools to add
- Tests to run
- Timeline

**Success Criteria:**
- You have a clear, justified tool stack
- You''ve identified waste
- You know your ROI
- You have a plan to test new tools
- You can explain your choices',

  55,
  true,
  (SELECT id FROM quizzes WHERE title = 'Tool Selection Quiz')
FROM modules m
WHERE m.slug = 'ai-tools-ecosystem';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'How to Choose the Right AI Tools',
  'https://www.youtube.com/watch?v=l2dpxspED1s',
  'video',
  1
FROM sections WHERE slug = 'tool-selection';
