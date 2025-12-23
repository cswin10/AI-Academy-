-- AI Operator Academy Seed Data - Sections
-- Run this after seed.sql

-- ============================================
-- SECTION 1.1: What Is an AI Operator?
-- ============================================
INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'what-is-an-ai-operator',
  'What Is an AI Operator?',
  1,
  'Beginner',
  '# What Is an AI Operator?

An AI operator is not "the AI person" or a prompt monkey.

An AI operator is someone who can look at a messy real-world process, understand how it currently works, and then design a better version using automation and AI.

## The Intersection of Skills

AI operators sit at the intersection of:

- **Systems thinking** - Understanding how processes connect and influence each other
- **Automation tools** - Knowing which tools solve which problems and when to use them
- **Data awareness** - Understanding how information flows through systems
- **AI reasoning** - Leveraging LLMs for decision-making, classification, and generation
- **Communication and documentation** - Making systems understandable to humans

## Real-World Example

In a small business, an AI operator might:

1. **Map out the process** for handling new customer enquiries
2. **Build a simple CRM** in Notion or Airtable to track leads
3. **Connect forms, emails, and notifications** using Zapier, Make, or n8n
4. **Use GPT or Claude** to generate personalised follow-up messages
5. **Track everything in a dashboard** so the owner sees what''s happening in real-time

The result? The business owner spends less time on admin and more time talking to customers who are actually ready to buy.

## What You Don''t Need

You **don''t** need to be a full-stack engineer to be useful.

You **don''t** need years of experience or a computer science degree.

## What You Do Need

You **do** need to be able to:

- **Ask good questions** to understand the real problem
- **See how things connect** across different parts of a business
- **Design simple systems** that solve problems without over-engineering
- **Use AI tools** to fill gaps in your knowledge and accelerate learning

## Your Value Proposition

By the end of this roadmap, you should be able to walk into a small business, listen to how they currently operate, and say:

> **"Here''s where you''re losing time and attention. Here''s a simple system we can build to fix it."**

And then actually build it.

That''s what makes you valuable. Not your ability to quote AI research papers, but your ability to ship systems that work.

## The Operator Mindset

Good operators share a few key traits:

### 1. They Start Simple
They don''t try to build perfect systems on day one. They ship small, working versions and improve them based on feedback.

### 2. They Document Everything
They know that "future you" (and everyone else) will forget how things work. They write clear docs and keep them updated.

### 3. They Think in Systems
They don''t just fix individual problems. They look at the whole process and ask "what''s causing this problem?" rather than just treating symptoms.

### 4. They Communicate Clearly
They can explain technical concepts to non-technical people without being condescending. They know that adoption depends on understanding.

### 5. They Stay Curious
They''re always learning new tools, reading about new approaches, and asking "could this make my life easier?"

## What Success Looks Like

A successful AI operator:

- Saves businesses **10-20 hours per week** through better systems
- Makes processes **more reliable** by reducing human error
- Enables **better decision-making** through clearer data
- Creates systems that **anyone can use**, not just technical people
- Charges **real money** for their work because they deliver real value

You''re not trying to replace people. You''re trying to remove the boring, repetitive stuff so humans can focus on what they''re actually good at.

## Ready to Begin?

This module will give you the mental models you need to think like an operator. The rest of the academy will give you the tools and techniques to build like one.

Let''s start with how to think about any system you encounter.',

  '## Exercise: Map Your World

**Objective:** Start seeing the world through an operator''s eyes by analyzing a real process.

**Instructions:**

Write a one-page description of your own current work (or a business you know well) using these prompts:

### 1. Activities
What are the main activities that happen every week? List 5-7 recurring tasks or processes.

### 2. Information Sources
Where does information come from?
- Emails
- Forms
- Messages (Slack, WhatsApp, etc.)
- Spreadsheets
- Documents
- Calls
- Other sources

### 3. Information Handlers
Who touches that information? List the roles or people involved in each process.

### 4. Pain Points
What feels slow, annoying, or manual? Be specific:
- "I copy data from emails into a spreadsheet 20 times a day"
- "We lose track of customer requests because they come through 5 different channels"
- "Preparing weekly reports takes 3 hours of manual work"

### 5. Judgment vs Repetition
For each pain point, ask:
- Does this require human judgment, or is it just repetitive?
- Could a computer do this if given clear instructions?

**Deliverable:**

Save this document somewhere you can access later (Notion, Google Docs, local file). You''ll use this description in later modules when we start designing solutions.

**Success Criteria:**
- You''ve identified at least 3 specific pain points
- You''ve noted where information currently lives
- You can describe at least one process from start to finish

This exercise is the foundation of everything else. If you can articulate how a process currently works, you can improve it.',

  45,
  true,
  (SELECT id FROM quizzes WHERE title = 'What Is an AI Operator?')
FROM modules m
WHERE m.slug = 'operator-foundations';

-- External resources for Section 1.1
INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  s.id,
  'Systems Thinking For Small Business – Tips & Examples',
  'https://www.youtube.com/watch?v=PvkExTsoYKo',
  'video',
  1
FROM sections s WHERE s.slug = 'what-is-an-ai-operator';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  s.id,
  'How to think in systems (3 tools)',
  'https://www.youtube.com/watch?v=maBWP1YHIOI',
  'video',
  2
FROM sections s WHERE s.slug = 'what-is-an-ai-operator';

-- ============================================
-- SECTION 1.2: The 4-Layer System Model
-- ============================================
INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'four-layer-system-model',
  'The 4-Layer System Model',
  2,
  'Beginner',
  '# The 4-Layer System Model

To avoid getting overwhelmed by tools and possibilities, you''ll use a simple mental model for every system you design: **the 4-layer system model**.

Every system you build - from a simple lead capture form to a complex CRM - will have these four layers:

## Layer 1: Interface

**Where humans interact with your system.**

Examples:
- Notion dashboards
- Airtable interfaces
- Web apps and forms (Tally, Typeform, Google Forms)
- Chatbots (Intercom, custom bots)
- Mobile apps
- Email interfaces

**Key questions:**
- What do users see?
- What can users click, type, or select?
- How do they know what to do next?

## Layer 2: Automation

**Where logic runs and things happen automatically.**

Examples:
- Zapier workflows
- Make scenarios
- n8n flows
- Pipedream scripts
- Built-in automations (Notion, Airtable, Slack)

**Key questions:**
- What happens when someone submits a form?
- What triggers should fire when data changes?
- What notifications should be sent?
- What data transformations need to happen?

## Layer 3: Data

**Where information lives and persists.**

Examples:
- Notion databases
- Airtable bases
- Google Sheets
- Supabase/PostgreSQL databases
- Vector stores (Pinecone, Weaviate)
- CRMs (HubSpot, Pipedrive)

**Key questions:**
- Where is this information stored?
- How is it structured?
- Who needs access to it?
- How long do we keep it?

## Layer 4: AI

**Where reasoning, classification, and generation happen.**

Examples:
- GPT (ChatGPT, API)
- Claude (Claude.ai, API)
- Specialized AI tools (Midjourney, ElevenLabs)
- Custom models or agents

**Key questions:**
- What needs human-like reasoning?
- What content needs to be generated?
- What classification or decision-making can AI handle?
- Where can AI save the most time?

---

## How to Use This Model

When someone says **"we want to automate our intake form,"** you can quickly sketch:

### Interface
The form the user sees - what fields, what design, what happens when they click submit

### Data
Where the responses are stored - probably a database or spreadsheet with specific columns

### Automation
What happens after submission - send confirmation email, notify team, create task, enrich data

### AI
Where AI might help - draft personalized responses, classify request urgency, extract key information

---

## Why This Model Works

### 1. It Prevents Tool Paralysis
Instead of thinking "should I use Zapier or Make or n8n?" you think "I need automation between my interface and data layers. Now which tool is best for THIS specific task?"

### 2. It Makes Communication Easier
You can say to a client: "Your interface is the form. Your data lives in Airtable. We need automation to connect them and AI to personalize the responses." They understand this instantly.

### 3. It Reveals Gaps
If you can''t describe a layer, you probably haven''t thought through that part of the system. Missing the data layer? You''ll lose information. Missing automation? You''ll do everything manually.

### 4. It Scales
This model works for everything from a two-step workflow to a complex multi-agent system. The layers just get more sophisticated, but the structure remains the same.

---

## Real Example: Customer Support Intake

Let''s walk through a real system using the 4-layer model.

### The Problem
A company receives support requests via email, Slack, website form, and social media DMs. They''re missing requests and taking too long to respond.

### The Solution (4-Layer Design)

**Interface Layer:**
- Unified support widget on website (Tally form)
- Email-to-ticket system
- Slack channel
- Social media monitoring (manual for now)

**Data Layer:**
- Airtable base with:
  - Tickets table (request info, status, priority, assigned to)
  - Customers table (linked records)
  - Responses table (communication history)

**Automation Layer:**
- Zapier workflows:
  - Form submission → Create Airtable record
  - New email → Create Airtable record
  - Slack message in #support → Create Airtable record
  - Ticket created → Send auto-reply via email
  - Priority ticket → Notify team in Slack

**AI Layer:**
- Claude API:
  - Classify ticket urgency (High/Medium/Low) based on content
  - Generate draft response based on ticket type
  - Summarize long tickets for quick triage
  - Suggest help articles based on question

**Result:**
- All requests in one place
- Instant acknowledgment to customers
- Smart prioritization without manual sorting
- Faster response times with AI-drafted replies

---

## Common Mistakes

### Mistake 1: Skipping the Interface Layer
Building automation and AI without thinking about how humans will actually use the system. Users need clear, simple interfaces.

### Mistake 2: Over-Engineering the AI Layer
Using AI for things that could be handled by simple automation rules. AI is powerful but not always necessary.

### Mistake 3: Ignoring the Data Layer
Not thinking about how data is structured and stored leads to messy, hard-to-maintain systems.

### Mistake 4: No Automation Layer
Connecting interfaces directly to data without automation means manual work forever or brittle direct integrations.

---

## Practice Thinking in Layers

For every project from now on, sketch out these four layers before you start building. You can do this on paper, in a doc, or just in your head.

Ask yourself:
1. **Interface:** What will users interact with?
2. **Automation:** What needs to happen automatically?
3. **Data:** Where will information be stored?
4. **AI:** Where can intelligence add value?

This simple framework will save you hours of confusion and rework.',

  '## Exercise: Decompose Your World into Layers

**Objective:** Apply the 4-layer model to the process you mapped in Section 1.1.

**Instructions:**

Take the one-page description you wrote in the previous exercise and rewrite it using the 4-layer model.

### Step 1: Highlight Interfaces
Go through your description and **highlight** or **list** anything that looks like an interface:
- Forms people fill out
- Dashboards people view
- Chat interfaces
- Screens or apps people use
- Email interfaces

### Step 2: Highlight Data
Identify where information currently lives:
- Databases
- Spreadsheets
- Lists
- CRMs
- Documents
- Files

### Step 3: Identify Automation
Note any existing automation (even if minimal):
- Email rules
- Slack bots
- Integrations between tools
- Scheduled tasks
- Triggers or workflows

### Step 4: Note AI Usage
Identify any current use of AI:
- ChatGPT usage by team members
- Built-in AI features in tools
- Manual tasks that involve "thinking" or decision-making (these could be AI opportunities)

### Step 5: Rewrite
Create a new document with 4 sections, one for each layer. Reorganize your process description into these layers.

**Example output:**
```
INTERFACE LAYER:
- Customer inquiry form on website
- Gmail inbox for support@
- Internal Notion dashboard for viewing requests

DATA LAYER:
- Google Sheet with customer information
- Email threads in Gmail
- Loose notes in Slack

AUTOMATION LAYER:
- Gmail filter to label support emails
- (that''s it...)

AI LAYER:
- None currently
- Could use: AI to draft responses, AI to classify urgency
```

### Step 6: Identify Gaps
Look at your 4-layer breakdown and note:
- Which layers are well-developed?
- Which layers are missing or weak?
- Where is manual work happening that could be automated?
- Where could AI help?

**Deliverable:**
A new document with your process organized by the 4 layers, plus notes on gaps and opportunities.

**Success Criteria:**
- You''ve categorized existing elements into all 4 layers
- You''ve identified at least one gap or weakness
- You can see where improvements would have the biggest impact',

  50,
  true,
  (SELECT id FROM quizzes WHERE title = 'The 4-Layer System Model')
FROM modules m
WHERE m.slug = 'operator-foundations';

-- External resources for Section 1.2
INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  s.id,
  'Introduction To Business Systems Thinking',
  'https://www.youtube.com/watch?v=63ZUnLAmjmM',
  'video',
  1
FROM sections s WHERE s.slug = 'four-layer-system-model';

-- ============================================
-- SECTION 1.3: Inputs → Transformations → Outputs
-- ============================================
INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'inputs-transformations-outputs',
  'Inputs → Transformations → Outputs',
  3,
  'Beginner',
  '# Inputs → Transformations → Outputs

Every good operator thinks in terms of **inputs**, **transformations**, and **outputs**.

This is the simplest and most powerful framework for designing any workflow, automation, or system.

---

## The Framework

### Input
**The event or data that starts the process.**

Examples:
- A user submits a form
- An email arrives
- A database record is created
- A scheduled time is reached
- An API call is made

### Transformation
**What happens to that data. The processing, logic, or changes applied.**

Examples:
- Validate required fields
- Store data in a database
- Use an LLM to summarize or rewrite content
- Calculate values
- Check conditions
- Format data
- Enrich with additional information
- Route to the right person or system

### Output
**Where the result ends up or what action is taken.**

Examples:
- An email or SMS sent
- A database record updated
- A notification delivered
- A file created
- A dashboard updated
- A task assigned

---

## Why This Works

### 1. Forces Clarity
If you can''t describe your workflow in this format, you probably shouldn''t automate it yet. Clarity is a prerequisite for automation.

### 2. Reveals Dependencies
You quickly see what data you need (inputs), what needs to happen to it (transformations), and what the system must produce (outputs).

### 3. Makes Testing Obvious
You can test each transformation independently:
- "If I send this input, do I get the expected output?"
- "If the input changes, does my transformation handle it?"

### 4. Simplifies Communication
You can explain a complex system to a non-technical person:
"When a lead fills out the form (input), we validate their info, check our database, and use AI to draft a personalized response (transformations), then send them an email and notify our team (outputs)."

---

## Real Example: Gym Enquiry Form

Let''s design a system for a gym that gets consultation requests.

### Input
A visitor submits a "Book a Consult" form with:
- Name
- Email
- Phone
- Goals (dropdown: Weight Loss / Muscle Gain / General Fitness)
- Preferred time slot

### Transformations

**Step 1: Validate**
- Check that required fields are filled
- Verify email format
- Check phone number format

**Step 2: Store**
- Create new record in Airtable "Leads" table
- Link to "Goals" table for categorization

**Step 3: Enrich with AI**
- Send goals text to Claude API
- Prompt: "Summarize this person''s fitness goals in one sentence and suggest 2-3 relevant talking points for our first call."
- Store AI response in "Notes" field

**Step 4: Generate Response**
- Use template with merge fields
- Personalize based on selected goal
- Include link to calendar booking
- Include AI-generated talking points for staff

**Step 5: Route**
- Check preferred time slot
- Assign to available trainer in that slot
- If no availability, flag for manual review

### Outputs

**For the Lead:**
- Confirmation email with:
  - "Thanks for your interest!"
  - Calendar link to book consultation
  - What to prepare for the call
  - Gym address and parking info

**For the Team:**
- Slack notification in #new-leads channel:
  - Lead name and contact info
  - Their stated goals
  - AI summary and talking points
  - Assigned trainer
- Airtable record updated with status "New - Awaiting Booking"

**For Analytics:**
- Lead source tracked
- Goal type logged
- Response time measured

---

## The Template

Use this template for every workflow you design:

```
WORKFLOW NAME: _______________

INPUT:
[What starts this process? Be specific.]

TRANSFORMATIONS:
1. [First thing that happens]
2. [Second thing that happens]
3. [Third thing that happens]
...

OUTPUTS:
[What gets created, updated, or delivered?]

EDGE CASES:
- What if [X] fails?
- What if [Y] is missing?
- What if [Z] takes too long?
```

---

## Practice This Constantly

From now on, whenever you see a process (at work, in your personal life, in a store), try to describe it as:

**Input → Transformation → Output**

The more you practice this, the faster you''ll be able to design working systems.',

  '## Exercise: Design a Simple Workflow

**Objective:** Practice breaking down a process into inputs, transformations, and outputs.

**Instructions:**

### Step 1: Choose a Process
Pick any small process from your life or work, such as:
- Booking a haircut appointment
- Ordering takeaway food
- Responding to Instagram DMs
- Paying a bill
- Scheduling a meeting
- Processing a refund request

### Step 2: Write It Out
Use this template:

```
PROCESS: [Name of process]

INPUT:
[What starts this? Be specific about the trigger]

TRANSFORMATIONS:
1. [First step - what happens to the input?]
2. [Second step - what happens next?]
3. [Continue for all steps...]

OUTPUTS:
[What is the final result or action taken?]
```

**Example:**
```
PROCESS: Ordering takeaway food

INPUT:
I decide I want food and open Uber Eats app

TRANSFORMATIONS:
1. Browse restaurants and menus
2. Select items and customize
3. Review order and add delivery address
4. Enter payment information
5. Confirm and place order
6. Restaurant receives order notification
7. Restaurant prepares food
8. Driver is assigned
9. Driver picks up food
10. Driver delivers to my address

OUTPUTS:
- Food arrives at my door
- Payment processed
- Receipt emailed to me
- Order history updated in app
```

### Step 3: Ask an AI for Improvements
Copy your breakdown and ask ChatGPT or Claude:

**Prompt:**
"Here''s a process I''ve mapped out using the Input → Transformation → Output framework:

[Paste your breakdown]

How would you improve or automate this flow? What transformations could be eliminated, combined, or made faster?"

### Step 4: Capture the Suggestions
Note the AI''s suggestions. Even if you can''t implement them, this practice of seeing improvement opportunities is exactly what you''ll do for clients.

### Step 5: Do This 2 More Times
Repeat this exercise with 2 more processes. The more you practice, the faster this becomes second nature.

**Deliverable:**
Three process breakdowns using the Input → Transformation → Output framework, each with AI-generated improvement suggestions.

**Success Criteria:**
- You''ve clearly identified the input trigger
- Transformations are listed in order
- Outputs are specific and measurable
- You''ve got at least one good improvement idea from AI for each process

**Bonus Challenge:**
Pick one of your three processes and actually try to automate one transformation. Even something small counts.',

  40,
  true,
  (SELECT id FROM quizzes WHERE title = 'Inputs, Transformations, Outputs')
FROM modules m
WHERE m.slug = 'operator-foundations';

-- External resources for Section 1.3
INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  s.id,
  'Systems Thinking In Business',
  'https://www.youtube.com/watch?v=qB8spCoRgw4',
  'video',
  1
FROM sections s WHERE s.slug = 'inputs-transformations-outputs';
