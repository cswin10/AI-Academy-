-- AI Operator Academy Seed Data - Sections Part 2
-- Run this after seed-sections.sql

-- ============================================
-- SECTION 1.4: Manual First, Simple First
-- ============================================
INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'manual-first-simple-first',
  'Manual First, Simple First',
  4,
  'Beginner',
  '# Manual First, Simple First

The fastest way to ship broken systems is to automate too early.

As an AI operator, you adopt two rules that will save you countless hours and help you deliver better results:

## Rule 1: Manual First

**Do it by hand once or twice before you automate it.**

## Rule 2: Simple First

**Automate the smallest useful version, then improve it.**

---

## Why Manual First?

### You Feel the Friction Directly

When you perform a task manually, you experience what''s actually annoying about it. You discover:
- Which steps take the most time
- Where you have to think vs where you''re just copy-pasting
- What information you need at each step
- Where errors are likely to happen

Reading a process description ≠ doing the process.

### You Notice Edge Cases

Every process has edge cases that people forget to mention:
- "Oh yeah, sometimes the email comes from a different address"
- "If the customer is in Europe we have to..."
- "When it''s month-end, we also need to..."

You don''t discover these by asking. You discover them by doing.

### You See Which Steps Actually Matter

Sometimes people think step 7 is the painful one, but when you do it manually you realize step 3 is where all the friction is.

Manual execution gives you the truth, not assumptions.

### You Understand Where AI Could Help vs Where Human Judgment is Critical

Some steps require creativity, empathy, or complex decision-making. Others are just pattern-matching and data entry.

When you do it manually, you can feel the difference. Then you know:
- "This step is just copying from A to B → automate it"
- "This step requires understanding context → keep a human in the loop"

---

## Why Simple First?

### Perfect is the Enemy of Done

If you try to build a system that handles every possible scenario on day one, you''ll:
- Spend weeks designing
- Over-engineer solutions
- Build features nobody needs
- Deliver nothing useful for a long time

Instead, ship something basic that works. Get feedback. Improve it.

### You Learn Faster

A simple system in production teaches you more in one day than a perfect system in your head teaches you in a month.

You''ll discover:
- What actually matters to users
- Which features are missing (that you didn''t expect)
- Which features you built but nobody uses
- Where the real edge cases are

### It''s Less Risky

If your simple system breaks, the blast radius is small. If your complex system breaks, everything breaks.

Start small. Prove it works. Then expand.

### Users Appreciate Fast Delivery

Would you rather:
- Wait 6 weeks for a "perfect" system?
- Or get 80% of the value in 3 days, then improve it weekly?

Most people choose option 2. They want results now, not perfection later.

---

## The Operator Process

Here''s how to approach any new automation project:

### Phase 1: Manual (1-2 iterations)
- Perform the process manually
- Document every step as you go
- Note friction points
- Identify repetitive vs judgment-based steps
- Time how long it takes

### Phase 2: Design Simple (planning session)
- Pick the 1-2 highest-impact steps to automate
- Sketch the system using the 4-layer model
- Plan inputs, transformations, outputs
- Decide which tools to use
- Set a deadline (usually 2-5 days)

### Phase 3: Build Simple (fast implementation)
- Build the minimum version that delivers value
- A simple form
- A basic database
- One or two automations
- Maybe one AI component
- Test it yourself first

### Phase 4: Ship (deploy to real users)
- Share with a small group first
- Watch how they use it
- Ask for feedback
- Fix obvious bugs
- Document how it works

### Phase 5: Improve (ongoing iteration)
- Based on real usage, add:
  - Error handling
  - Edge case support
  - More automation
  - Better UX
  - Additional features

Repeat Phase 5 weekly or monthly.

---

## How to Identify What to Automate First

When looking at a manual process, prioritize automation for steps that are:

### 1. High Frequency
Happens many times per day/week

### 2. High Pain
Takes a lot of time or is very annoying

### 3. Low Judgment
Doesn''t require complex human decision-making

### 4. Low Risk
If it breaks, it''s easy to fix manually

**Example:** Copying data from form submissions to a spreadsheet
- Happens 20 times a day (high frequency)
- Takes 2 minutes each time (high pain)
- Literally just copy-paste (low judgment)
- If it fails, you can manually copy (low risk)

Perfect first automation target.

**Example:** Deciding whether to give a customer a refund
- Happens 2 times a week (medium frequency)
- Takes 10 minutes to evaluate (medium pain)
- Requires understanding context and policy (high judgment)
- If wrong, could damage customer relationship (higher risk)

Not a good first automation target. Maybe add AI assistance later, but keep a human in the decision loop.

---

## The Mindset Shift

**Bad operator mindset:**
- "I need to build the perfect system"
- "Let me automate everything at once"
- "I''ll design first, build later"

**Good operator mindset:**
- "I''ll do this manually first to really understand it"
- "What''s the smallest useful thing I can ship this week?"
- "I''ll build something basic, see how it works, then improve it"

This mindset is what separates operators who deliver value from those who spend months building systems nobody uses.

---

## Your New Defaults

From now on, when someone asks you to automate something:

1. **"Let me do it manually first"**
   - Do it yourself 1-2 times
   - Document what you learn

2. **"What''s the simplest version that helps?"**
   - Pick 1-2 high-impact steps
   - Ship something in days, not weeks

3. **"Let''s improve it based on real usage"**
   - Watch how it''s used
   - Iterate weekly

This approach will make you faster, more reliable, and more valuable than 90% of people trying to "automate" things.',

  '## Exercise: Manual First in Action

**Objective:** Practice the "manual first, simple first" approach on a real process.

**Instructions:**

### Step 1: Choose a Process to Automate

Pick something you want to automate. Ideally from:
- Your own work
- A business you know
- Your personal life

Good candidates:
- Lead intake process
- Weekly reporting
- Data entry from one place to another
- Customer onboarding
- Invoice processing
- Appointment booking

### Step 2: Commit to NOT Automating (Yet)

For the next 24-48 hours, you will NOT build anything. You will only:
- Perform the process manually
- Document what you learn

### Step 3: Perform It Manually

Do the process yourself at least once (ideally 2-3 times if possible within 24 hours).

As you work, create a document with these sections:

**Every Step (in order):**
```
1. [First thing I did]
2. [Second thing I did]
3. [Continue...]
```

**Steps That Felt Repetitive:**
- [Step X] - I''m just copy-pasting the same thing every time
- [Step Y] - This is pure data entry, no thinking required

**Steps That Require Judgment:**
- [Step X] - I have to understand context here
- [Step Y] - This needs human decision-making because...

**Edge Cases I Discovered:**
- What if [X] happens?
- What about when [Y]?
- Sometimes [Z] which means I have to...

**Time Tracking:**
- Total time: [X] minutes
- Longest step: [Step Y] took [Z] minutes
- Most annoying step: [Step X] because...

### Step 4: Identify Automation Targets

Look at your documentation and answer:

**Which 1-2 steps would I automate FIRST?**
- Step [X]: [Reason - high frequency, high pain, low judgment, low risk]
- Step [Y]: [Reason]

**Which steps will stay manual (for now)?**
- Step [X]: [Reason - requires judgment, happens rarely, etc]

**What''s the simplest useful version I could build this week?**
- [Describe minimum version]
- What it does: [Core functionality]
- What it doesn''t do: [Things you''re leaving out for v1]

### Step 5: Sketch the Simple System

Using the 4-layer model, sketch your simple v1:

```
INTERFACE:
[What will users interact with?]

AUTOMATION:
[What will happen automatically?]

DATA:
[Where will information be stored?]

AI:
[Where, if anywhere, will AI help?]
```

### Step 6: Estimate Time

- If I built the simple version, it would take: [X hours/days]
- If I tried to build the "perfect" version, it would take: [Y hours/weeks]
- Difference: [Y - X] saved by starting simple

**Deliverable:**
A document that shows:
- Your manual execution notes
- What you learned
- What you''d automate first
- A sketch of the simple v1 system
- Time estimates

**Success Criteria:**
- You actually performed the process manually (not just imagined it)
- You identified specific friction points
- You have a clear idea of what to build first
- Your simple version is genuinely simple (not trying to solve everything)

**Bonus:**
If you actually build the simple version this week, you get bonus points. Ship it, even if it''s imperfect.',

  45,
  true,
  (SELECT id FROM quizzes WHERE title = 'Manual First, Simple First')
FROM modules m
WHERE m.slug = 'operator-foundations';

-- External resources for Section 1.4
INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  s.id,
  'How to Build Systems to Actually Achieve Your Goals',
  'https://www.youtube.com/watch?v=t4cIdOrc5j0',
  'video',
  1
FROM sections s WHERE s.slug = 'manual-first-simple-first';

-- ============================================
-- SECTION 1.5: Documentation & Communication Standards
-- ============================================
INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'documentation-communication',
  'Documentation & Communication Standards',
  5,
  'Beginner',
  '# Documentation & Communication Standards

The best system in the world is useless if nobody understands how it works.

As an AI operator, your success depends not just on building good systems, but on:
- **Documenting them clearly** so others can use and maintain them
- **Communicating effectively** with non-technical stakeholders
- **Creating handoff materials** so you''re not the permanent bottleneck

---

## Why Documentation Matters

### 1. Future You Will Forget

In 3 months, you won''t remember:
- Why you structured something a certain way
- What that variable name means
- Which edge cases you accounted for
- How to fix it when it breaks

Documentation is a gift to your future self.

### 2. Other People Need to Understand

Your systems will be used and maintained by:
- Clients who need to update data
- Team members who need to add features
- Other operators who inherit your work
- Non-technical people who need to troubleshoot

If they can''t understand it, they can''t use it effectively.

### 3. Good Documentation = Less Support

Instead of answering the same questions repeatedly:
- "How do I add a new user?"
- "What do I do if this workflow fails?"
- "Where does this data come from?"

You create documentation they can reference.

### 4. It Demonstrates Professionalism

Clients pay more for well-documented systems. Why? Because they know:
- They''re not locked into depending on you forever
- They can modify things without breaking everything
- They can bring in other people to help

Documentation is a sign of quality work.

---

## What to Document

For every system you build, create documentation that includes:

### 1. Overview
- **What is this system?** - One-sentence description
- **What problem does it solve?** - The business value
- **Who uses it?** - Roles and people
- **When was it built?** - Date and version

### 2. Architecture Diagram
- Use the 4-layer model (Interface, Automation, Data, AI)
- Show how components connect
- Can be a simple sketch or diagram

### 3. How It Works (Step-by-Step)
- Walk through the process from start to finish
- Include what happens at each step
- Note any conditions or branching logic

### 4. Access & Credentials
- Where things are hosted
- Who has access
- How to get access if needed

### 5. Common Issues & Troubleshooting
- What could go wrong
- How to identify the issue
- How to fix it

### 6. How to Modify
- Common modifications people might want to make
- Where to change things
- What to be careful about

---

## Documentation Template

Here''s a simple template you can use for any system:

```markdown
# [SYSTEM NAME]

## Overview
- **Purpose:** [What does this solve?]
- **Users:** [Who uses it?]
- **Built:** [Date]
- **Status:** [Active / In Development / Deprecated]

## Architecture

**Interface:**
[What users interact with]

**Automation:**
[What runs automatically]

**Data:**
[Where information is stored]

**AI:**
[Where AI is used, if applicable]

## How It Works
1. [First thing that happens]
2. [Second thing]
3. [Continue...]

## Access & Tools
- Tool 1: [URL / Location] - [Who has access]
- Tool 2: [URL / Location] - [Who has access]
- Credentials: [Where stored]

## Troubleshooting

### Issue 1: [Common problem]
- **Symptoms:** [What you''ll see]
- **Cause:** [Why it happens]
- **Fix:** [How to resolve]

## How to Modify

### [Common modification 1]
[Steps to make this change]

## Changelog
- [Date] - [What changed] - [Who made the change]
```

---

## Communication Standards

### When Talking to Technical People

You can use more jargon, but still be clear:
- "We''re using Zapier webhooks to trigger an n8n workflow that calls the Claude API"
- "The data''s in a Supabase Postgres instance with RLS enabled"

### When Talking to Non-Technical People

Focus on **what** and **why**, not **how**:

**Bad:**
"We''ll set up a Zapier integration that calls the Anthropic API using a system prompt to classify leads based on semantic similarity to historical conversion data."

**Good:**
"When someone fills out the contact form, the system automatically reads their message and figures out how urgent their request is. High-priority leads go straight to the sales team. Others go into a queue for follow-up later."

---

## The Communication Framework

For any system or project, communicate these three things clearly:

### 1. The Problem
What''s broken or inefficient right now?

**Example:**
"Right now, leads come in through 5 different channels (website, email, LinkedIn, phone, events). We''re losing track of them and response times are inconsistent - sometimes 2 hours, sometimes 2 days."

### 2. The Solution
What you''re building and how it helps

**Example:**
"We''ll create one central place where all leads land, no matter where they came from. The system will automatically prioritize them and notify the right person within 10 minutes."

### 3. The Value
What changes for them

**Example:**
"This means:
- No more lost leads
- Faster response times (under 1 hour for urgent leads)
- Clear visibility into your pipeline
- Less manual admin work for the team"

---

## Best Practices

### 1. Document As You Build
Don''t wait until the end. Document each component as you create it.

### 2. Use Screenshots
Show, don''t just tell. Screenshots of:
- Interface layouts
- Workflow steps
- Where to find settings
- What success/failure looks like

### 3. Write for "6-Months-From-Now You"
Assume you''ll forget everything. Write docs that would help someone with zero context.

### 4. Keep It Updated
When you modify a system, update the docs immediately. Stale docs are worse than no docs.

### 5. Test Your Docs
Have someone else follow your documentation without your help. If they get stuck, improve the docs.

---

## The Bottom Line

Your systems are only as good as your ability to communicate them.

Master documentation and communication, and you''ll:
- Deliver more value to clients
- Spend less time answering questions
- Build systems that outlive your involvement
- Command higher rates because your work is professional

Bad operators build systems nobody else can touch.
Good operators build systems anyone can understand and maintain.

Be a good operator.',

  '## Exercise: Document a System

**Objective:** Practice creating clear, useful documentation for a real system.

**Instructions:**

### Step 1: Choose Something to Document

Pick one of:
1. **A system you''ve built** (even if simple - a Zapier workflow, a spreadsheet with formulas, anything)
2. **A system you use regularly** (how you manage tasks, your email workflow, your note-taking system)
3. **The simple automation from Section 1.4** (if you built it)

### Step 2: Use the Template

Create a new document using the documentation template provided in this section.

Fill out EVERY section:
- Overview
- Architecture (use the 4-layer model)
- How it works (step-by-step)
- Access & Tools
- Troubleshooting (at least 2 potential issues)
- How to Modify (at least 2 common changes)

### Step 3: Add Visuals

Include at least 2 of:
- Screenshots of the interface
- Diagram of the architecture (can be hand-drawn and photographed)
- Flowchart of the process
- Screen recording walkthrough (Loom)

### Step 4: Test Your Documentation

**Do this:**

1. Set your documentation aside for 2 hours (don''t look at it)
2. Come back and read it fresh
3. Ask yourself: "If I knew nothing about this system, could I understand and use it from these docs?"
4. Identify gaps and improve them

**Even better:**

Send your documentation to a friend or colleague and ask:
- "Can you understand what this does?"
- "Could you troubleshoot an issue using this?"
- "Is anything confusing?"

### Step 5: Write a Summary for a Non-Technical Person

At the top of your document, add a "For Non-Technical Readers" section that explains:

**The Problem:**
[What was broken or manual before?]

**The Solution:**
[What does the system do now?]

**The Value:**
[What''s better as a result?]

Write this in language your grandmother could understand (no jargon).

**Deliverable:**

Complete documentation for one system that includes:
- All template sections filled out
- At least 2 visual elements
- A non-technical summary
- Evidence that you tested it (your own notes or feedback from someone else)

**Success Criteria:**

- Someone unfamiliar with your system could understand it from your docs
- You''ve included troubleshooting steps
- You''ve included modification instructions
- You have visuals that help explain
- Your non-technical summary uses zero jargon

**Bonus Challenge:**

Create a 3-minute Loom video walking through your system. Practice explaining it clearly and concisely.',

  50,
  true,
  (SELECT id FROM quizzes WHERE title = 'Documentation & Communication')
FROM modules m
WHERE m.slug = 'operator-foundations';

-- External resources for Section 1.5
INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  s.id,
  'How to Write Documentation That Actually Helps',
  'https://www.youtube.com/watch?v=t4vKPhjcMZg',
  'video',
  1
FROM sections s WHERE s.slug = 'documentation-communication';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  s.id,
  'Effective Technical Communication',
  'https://www.youtube.com/watch?v=YScv19MqWAQ',
  'video',
  2
FROM sections s WHERE s.slug = 'documentation-communication';
