-- ============================================================================
-- MODULE 5: Data & Information Architecture
-- ============================================================================

-- Insert Module 5
INSERT INTO modules (track_id, slug, title, short_description, order_index, estimated_hours, level, xp_reward, is_active)
SELECT
  id,
  'data-information-architecture',
  'Data & Information Architecture',
  'Understand how data flows through systems, design schemas, ensure quality, and handle security and compliance.',
  5,
  4,
  'Intermediate',
  50,
  true
FROM tracks WHERE slug = 'core-foundation';

-- Create quizzes for Module 5
INSERT INTO quizzes (title, description, difficulty, passing_score, xp_reward) VALUES
('Data Flow Quiz', 'Test your understanding of how data moves through systems', 'intermediate', 75, 15),
('Data Structures Quiz', 'Test your knowledge of databases, spreadsheets, and documents', 'intermediate', 75, 15),
('Schema Design Quiz', 'Test your understanding of designing data structures', 'intermediate', 75, 15),
('Data Quality Quiz', 'Test your knowledge of validation and quality control', 'intermediate', 75, 15),
('Privacy and Security Quiz', 'Test your understanding of data security and compliance', 'advanced', 80, 25);

-- ============================================================================
-- SECTION 5.1: How Data Flows in Modern Systems
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Data Flow Quiz'), 1,
'What is the primary purpose of understanding data flow?',
'["To make diagrams", "To identify where data enters, transforms, and ends up in systems", "To use more tools", "To impress clients"]',
1,
'Understanding data flow helps you design reliable systems by tracking how information moves and changes.'),

((SELECT id FROM quizzes WHERE title = 'Data Flow Quiz'), 2,
'What is a "data source" in a system?',
'["Where data is deleted", "Where data originates or enters the system", "The most important database", "A type of software"]',
1,
'Data sources are the entry points where information first enters your system - forms, APIs, imports, etc.'),

((SELECT id FROM quizzes WHERE title = 'Data Flow Quiz'), 3,
'Why is it important to map data flows before building automations?',
'["It''s not important", "To identify bottlenecks, dependencies, and potential failure points", "To waste time", "Only for large companies"]',
1,
'Mapping data flows reveals how information moves, where problems might occur, and what depends on what.'),

((SELECT id FROM quizzes WHERE title = 'Data Flow Quiz'), 4,
'What happens if you don''t track where data comes from?',
'["Nothing", "You can''t debug issues, verify accuracy, or maintain the system properly", "Systems work better", "It saves time"]',
1,
'Without tracking data sources, you can''t troubleshoot problems, verify data quality, or understand system dependencies.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'data-flow',
  'How Data Flows in Modern Systems',
  1,
  'Intermediate',
  '# How Data Flows in Modern Systems

Before you can build automations, you need to understand how data moves through systems. Bad data flow design = broken systems.

## What is Data Flow?

**Data flow** is the path information takes from entry to storage to use to output.

**Think of it like plumbing:**
- Water enters (data sources)
- Flows through pipes (connections)
- Gets processed (filters, heaters)
- Reaches destinations (sinks, taps)
- Sometimes recirculates (feedback loops)

**Understanding the plumbing prevents leaks, clogs, and floods.**

## The Five Stages of Data Flow

### 1. Entry (Data Sources)

**Where does data enter your system?**

Common entry points:
- **Forms:** Website forms, surveys, intake forms
- **Email:** Inquiries, orders, support requests
- **APIs:** External services sending data
- **Manual Entry:** Someone types into a system
- **File Uploads:** CSVs, PDFs, images
- **Integrations:** Zapier, Make, native connections
- **Sensors/IoT:** Automated data collection

**Key question:** Where is all your data coming from?

**Example: E-commerce business**
- Orders: Shopify
- Support: Email to support@
- Reviews: Google, Trustpilot
- Inventory updates: Supplier API
- Analytics: Google Analytics

### 2. Validation (Quality Gates)

**Before data enters your system, check it.**

Validation checks:
- **Required fields present?** (name, email, etc.)
- **Correct format?** (valid email, phone number)
- **Within acceptable range?** (quantity 1-1000)
- **Makes sense?** (no orders for -5 items)
- **Not duplicate?** (same email already exists)

**Bad data in = bad data out.**

**Example validation:**
```
Email submission:
- Has @ symbol? ✓
- Domain exists? ✓
- Not a disposable email? ✓
- Not already in database? ✓
→ Accept
```

### 3. Transformation (Processing)

**Data rarely enters in the perfect format.**

Common transformations:
- **Normalization:** "john@COMPANY.com" → "john@company.com"
- **Enrichment:** Add missing data (city from zip code)
- **Calculation:** Sum, average, totals
- **Classification:** High/Medium/Low priority
- **Extraction:** Pull specific fields from text
- **Formatting:** Change date format, currency

**Example:**
```
Input: "John Smith" "555-0100" "New York"
Transform:
  - Split name → firstName: "John", lastName: "Smith"
  - Format phone → "+1-555-0100"
  - Add state → "New York, NY"
  - Add timezone → "America/New_York"
Output: Structured record with all fields normalized
```

### 4. Storage (Persistence)

**Where does data live long-term?**

Storage options:
- **Databases:** Airtable, Notion, Supabase, PostgreSQL
- **Spreadsheets:** Google Sheets, Excel
- **Document stores:** MongoDB, files
- **Data warehouses:** BigQuery, Snowflake
- **Files:** PDFs, images, documents

**Key considerations:**
- How much data?
- How often accessed?
- Who needs access?
- How long to keep?
- Backup strategy?

### 5. Output (Usage)

**What happens to the data?**

Common outputs:
- **Dashboards:** Visualizations for humans
- **Reports:** Scheduled exports
- **Notifications:** Emails, Slack messages
- **Integrations:** Sent to other systems
- **APIs:** Made available to other services
- **Actions:** Triggers workflows

**Example: CRM lead**
- Enters via form
- Validated and enriched
- Stored in Airtable
- Outputs:
  - Sales gets Slack notification
  - Lead gets confirmation email
  - Dashboard shows new lead count
  - Zapier sends to email marketing tool

## Mapping Data Flow

**Before building, map the flow on paper/whiteboard.**

### Simple Mapping Template
```
[DATA SOURCE]
    ↓
[VALIDATION]
    ↓
[TRANSFORMATION]
    ↓
[STORAGE]
    ↓
[OUTPUT 1] [OUTPUT 2] [OUTPUT 3]
```

### Real Example: Customer Support System
```
[DATA SOURCES]
- Email: support@company.com
- Form: Website contact form
- Chat: Intercom widget

    ↓

[VALIDATION]
- Email: Check valid format
- Form: Required fields present
- Chat: User authenticated

    ↓

[TRANSFORMATION]
- Extract: Name, email, issue type, message
- Classify: Technical/Billing/General
- Prioritize: High/Medium/Low
- Enrich: Lookup customer in CRM

    ↓

[STORAGE]
- Primary: Airtable "Support Tickets" table
- Backup: Google Sheet (nightly export)

    ↓

[OUTPUTS]
- If High priority → Slack #urgent-support
- If Technical → Email engineering@
- If Billing → Email billing@
- All → Confirmation email to customer
- All → Update dashboard count
```

## Data Flow Patterns

### Pattern 1: Pipeline (Sequential)
```
A → B → C → D
```

Each stage depends on the previous. Most common pattern.

**Example:** Form → Validate → Transform → Store → Notify

### Pattern 2: Branching (Conditional)
```
      → B (if condition 1)
A →   → C (if condition 2)
      → D (otherwise)
```

Data takes different paths based on conditions.

**Example:** Lead → (Hot → Sales) or (Warm → Nurture) or (Cold → Archive)

### Pattern 3: Aggregation (Combining)
```
A →
B →  → D
C →
```

Multiple sources feed into one destination.

**Example:** Web form + Email + Chat → All go to same support database

### Pattern 4: Fan-out (Distribution)
```
      → B
A →   → C
      → D
```

One source feeds multiple destinations.

**Example:** New order → (CRM + Accounting + Inventory + Customer email)

### Pattern 5: Feedback Loop (Circular)
```
A → B → C → D
    ↑_______|
```

Output influences input.

**Example:** AI classifies → Human corrects → Training data for better AI

## Common Data Flow Problems

### Problem 1: Orphaned Data

**Symptom:** Data enters but goes nowhere

**Example:** Form submissions not connected to anything

**Fix:** Ensure every input has a destination

### Problem 2: Bottlenecks

**Symptom:** Data backs up at one stage

**Example:** 1000 leads/day but manual review is the bottleneck

**Fix:** Automate or parallelize bottleneck stage

### Problem 3: Data Loss

**Symptom:** Information disappears between stages

**Example:** Validation rejects data, no record kept

**Fix:** Log rejections, keep audit trail

### Problem 4: Duplicate Processing

**Symptom:** Same data processed multiple times

**Example:** Email triggers 3 separate workflows

**Fix:** Deduplicate at entry, use unique IDs

### Problem 5: Unclear Dependencies

**Symptom:** Breaking one thing breaks everything

**Example:** Change email format, 5 workflows break

**Fix:** Document dependencies, design for loose coupling

## Data Flow Best Practices

### 1. Single Source of Truth

**One canonical place for each piece of data.**

**Bad:** Customer email in 5 different places, all might be different
**Good:** Email in CRM, everything else references it

### 2. Clear Entry Points

**Know exactly where data comes from.**

**Track:** Source, timestamp, who/what created it

### 3. Validate Early

**Don''t let bad data enter your system.**

Reject or flag problems at the gate, not later.

### 4. Transform Consistently

**Same input should always produce same output.**

Use standard functions, not ad-hoc transformations.

### 5. Log Everything

**Keep records of data movement.**

Who created it? When? What changed? Why?

### 6. Handle Failures Gracefully

**When something breaks, don''t lose data.**

- Retry failed operations
- Queue for manual review
- Alert humans
- Keep failed data for debugging

## Designing Your First Data Flow

**Step 1:** List all data sources

**Step 2:** Define what data you need from each

**Step 3:** Design validation rules

**Step 4:** Plan transformations

**Step 5:** Choose storage location

**Step 6:** Define outputs/actions

**Step 7:** Map dependencies

**Step 8:** Identify failure points

**Step 9:** Design error handling

**Step 10:** Document everything',

  '## Exercise: Map a Complete Data Flow

**Objective:** Design a complete data flow for a real system.

**Instructions:**

### Part 1: Identify Data Sources

**Scenario:** Small marketing agency wants to track leads

**List all possible data sources:**
1. Website contact form
2. Email inquiries
3. LinkedIn messages
4. Phone calls
5. Referrals from existing clients
6. [Your additions]

**For each source, document:**
- How data arrives
- What fields/information comes with it
- How often (daily volume)
- Current handling (manual? automated?)

### Part 2: Design Validation Rules

**For the contact form source:**

**Define validation rules for each field:**

**Name:**
- Required? Yes/No
- Min length: __
- Max length: __
- Format rules: __

**Email:**
- Required? Yes/No
- Format validation: __
- Domain validation: __
- Duplicate check: __

**Company:**
- Required? Yes/No
- Validation: __

**Message:**
- Required? Yes/No
- Min length: __
- Max length: __
- Spam detection: __

**What happens if validation fails?**
- Reject submission?
- Flag for review?
- Accept but mark as incomplete?

### Part 3: Design Transformations

**What transformations need to happen?**

**Normalization:**
- Email to lowercase
- Phone number formatting
- Name capitalization

**Enrichment:**
- Research company (industry, size, website)
- Geocode address if provided
- Lookup in existing CRM

**Classification:**
- Lead quality score (Hot/Warm/Cold)
- Based on what criteria?

**Extraction:**
- Pull budget mentions from message
- Extract timeline urgency
- Identify decision-maker language

**Document each transformation:**
```
Transform: [Name]
Input: [What comes in]
Process: [What happens]
Output: [What comes out]
```

### Part 4: Design Storage Schema

**What database structure do you need?**

**Tables needed:**
1. Leads
2. Companies
3. Interactions
4. [Others?]

**For "Leads" table, define fields:**

| Field Name | Type | Required | Default | Notes |
|------------|------|----------|---------|-------|
| id | unique ID | yes | auto | Primary key |
| name | text | yes | - | Full name |
| email | email | yes | - | Unique |
| company | text | no | - | Link to Companies table |
| status | select | yes | New | Hot/Warm/Cold |
| source | select | yes | - | Where they came from |
| created_at | datetime | yes | now | When added |
| ... | ... | ... | ... | ... |

**Design all necessary tables.**

### Part 5: Map Complete Flow

**Create a visual map:**
```
[Form Submission]
    ↓
[Validate Fields]
    ↓
[If valid] → [Transform Data]
    ↓
[Store in Leads Table]
    ↓ ← branch based on score
[If Hot] → [Slack #urgent + Email sales@]
[If Warm] → [Add to nurture sequence]
[If Cold] → [Newsletter only]
    ↓
[Confirmation email to lead]
    ↓
[Update dashboard]
```

**Create similar maps for:**
- Email inquiry flow
- Phone call flow

### Part 6: Identify Failure Points

**For your mapped flow, ask:**

**What could go wrong at each stage?**

**Example failure points:**
- Form submit while server down
- Validation rules too strict, rejects good leads
- Transformation fails (API timeout)
- Database write fails
- Email send fails
- Notification to team fails

**For each failure:**
- How will you detect it?
- What happens to the data?
- Who gets notified?
- How do you retry?

### Part 7: Design Error Handling

**Create an error handling strategy:**

**Error Type: Form submission fails**
- Detection: User sees error
- Data handling: Save in browser, retry
- Notification: Log error
- Recovery: Retry 3 times, then save to fallback

**Error Type: Email send fails**
- Detection: Send API returns error
- Data handling: Queue for retry
- Notification: Alert admin if 10+ failures
- Recovery: Retry every 5 mins for 1 hour

**Document for all critical failure points.**

### Deliverable

**Complete data flow documentation:**

**Section 1: Sources**
- All data sources listed
- Volume estimates
- Current state

**Section 2: Validation**
- Complete validation rules
- Failure handling

**Section 3: Transformations**
- All transformations documented
- Input → Process → Output

**Section 4: Storage**
- Complete schema design
- All tables and fields defined

**Section 5: Visual Flow Map**
- End-to-end data flow diagram
- All branches and conditions shown

**Section 6: Error Handling**
- All failure points identified
- Recovery strategies defined

**Section 7: Dependencies**
- What depends on what
- Critical paths identified

**Success Criteria:**
- Complete mapping from entry to output
- All sources accounted for
- Validation rules defined
- Storage schema designed
- Error handling planned
- Could hand this to a developer to build',

  55,
  true,
  (SELECT id FROM quizzes WHERE title = 'Data Flow Quiz')
FROM modules m
WHERE m.slug = 'data-information-architecture';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Understanding Data Flow in Systems',
  'https://www.youtube.com/watch?v=OkqLnAfqD30',
  'video',
  1
FROM sections WHERE slug = 'data-flow';

-- ============================================================================
-- SECTION 5.2: Databases vs Spreadsheets vs Documents
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Data Structures Quiz'), 1,
'When should you use a database instead of a spreadsheet?',
'["Never", "When you need relationships between data, many users, or complex queries", "Always", "Only for large companies"]',
1,
'Databases excel at handling relationships, multiple users, and complex data structures that spreadsheets can''t manage well.'),

((SELECT id FROM quizzes WHERE title = 'Data Structures Quiz'), 2,
'What is a key advantage of spreadsheets over databases?',
'["They''re more powerful", "They''re immediately accessible and familiar to non-technical users", "They handle more data", "They''re more secure"]',
1,
'Spreadsheets are easier for non-technical users to understand and use without training.'),

((SELECT id FROM quizzes WHERE title = 'Data Structures Quiz'), 3,
'When is a document-based system (like Notion) better than a database?',
'["Always", "When you need rich content, notes, and human-readable organization", "Never", "Only for personal use"]',
1,
'Document systems are ideal when you need rich text, notes, and organization that humans will read and edit.'),

((SELECT id FROM quizzes WHERE title = 'Data Structures Quiz'), 4,
'What is the main limitation of using Google Sheets at scale?',
'["It costs money", "Performance degrades with large datasets and many users editing simultaneously", "It doesn''t work", "No limitations"]',
1,
'Spreadsheets become slow and unstable with thousands of rows or many concurrent editors.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'databases-spreadsheets-documents',
  'Databases vs Spreadsheets vs Documents',
  2,
  'Intermediate',
  '# Databases vs Spreadsheets vs Documents

One of the most common mistakes: using the wrong tool to store data. Each has strengths and weaknesses.

## The Three Categories

### Spreadsheets
**Examples:** Google Sheets, Excel, Airtable (hybrid)

**Structure:** Rows and columns, like a table

### Databases
**Examples:** PostgreSQL, MySQL, Supabase, Airtable (hybrid)

**Structure:** Tables with relationships, schemas

### Documents
**Examples:** Notion, Google Docs, Obsidian, Markdown files

**Structure:** Flexible, human-readable content

## When to Use Spreadsheets

### Strengths

**1. Immediately Accessible**
Anyone can open, understand, and edit a spreadsheet. No training required.

**2. Flexible Structure**
Add columns anytime. No schema changes needed.

**3. Built-in Calculations**
Formulas, SUM, AVERAGE, etc. right there.

**4. Visual**
See all your data at once. Easy to spot patterns.

**5. Familiar**
Everyone knows Excel/Sheets basics.

### Weaknesses

**1. Poor at Relationships**
Linking data across sheets is painful.

**2. No Data Integrity**
Nothing stops someone from entering "fifty" in a number field.

**3. Doesn''t Scale**
Slow with 10,000+ rows. Breaks with concurrent editors.

**4. Version Chaos**
Which version is current? Who changed what?

**5. Limited Automation**
Can''t trigger complex workflows easily.

### Best Use Cases

✅ Quick prototypes
✅ Small datasets (<5,000 rows)
✅ Financial calculations
✅ Single-user or small team
✅ Data that non-technical people edit
✅ Temporary or exploratory analysis

❌ Don''t use for:
- Data with complex relationships
- High-volume data entry
- Mission-critical production systems
- Real-time collaboration (10+ users)

## When to Use Databases

### Strengths

**1. Relationships**
Link data across tables naturally. Orders → Customers → Companies.

**2. Data Integrity**
Enforce rules: emails must be valid, quantities must be positive.

**3. Scales**
Handles millions of rows smoothly.

**4. Multi-User**
100+ people can use simultaneously without issues.

**5. Powerful Queries**
Complex searches, filters, aggregations.

**6. Automation-Friendly**
Easy to trigger workflows, connect to APIs.

### Weaknesses

**1. Learning Curve**
Requires understanding tables, fields, relationships.

**2. Less Flexible**
Changing structure requires schema migrations.

**3. Less Visual**
Can''t see all data at once easily.

**4. Setup Required**
Need to design schema before starting.

### Best Use Cases

✅ Production systems
✅ Complex data relationships
✅ Large datasets (10,000+ records)
✅ Multiple users
✅ API integrations
✅ Data integrity critical

❌ Don''t use for:
- Quick experiments
- Data non-technical people need to edit directly
- One-off calculations

## No-Code Databases (Hybrid Approach)

### Airtable

**What it is:** Database with spreadsheet interface

**Strengths:**
- Looks like a spreadsheet (familiar)
- Works like a database (relationships, data types)
- Beautiful interfaces
- Good integrations

**When to use:**
- Need database power with spreadsheet ease
- Non-technical team
- Visual interfaces matter

### Notion Databases

**What it is:** Document system with database features

**Strengths:**
- Flexible views (table, board, calendar)
- Rich content (notes, files, embeds)
- Great for knowledge management
- Team workspaces

**When to use:**
- Need databases + documents
- Team knowledge base
- Project management
- Content lives alongside data

### Supabase

**What it is:** Open-source Firebase alternative (PostgreSQL)

**Strengths:**
- Real PostgreSQL database
- Built-in auth
- Real-time subscriptions
- Developer-friendly

**When to use:**
- Building custom applications
- Need full database power
- Developer on team

## When to Use Documents

### Strengths

**1. Human-Readable**
Written for humans to read and understand.

**2. Rich Content**
Text, images, embeds, files, formatting.

**3. Flexible Structure**
No schema. Add whatever you need.

**4. Contextual**
Information lives with context and explanation.

### Weaknesses

**1. Hard to Query**
Can''t easily find "all projects with budget > $10k"

**2. No Data Integrity**
No validation, no required fields.

**3. Doesn''t Scale**
Searching 10,000 docs is painful.

**4. Limited Automation**
Hard to trigger workflows from document changes.

### Best Use Cases

✅ Knowledge bases
✅ SOPs and documentation
✅ Meeting notes
✅ Project context
✅ Research and writing
✅ Team wikis

❌ Don''t use for:
- Structured data needing queries
- Data that drives automations
- High-volume data entry

## Decision Framework

### Ask These Questions

**1. How many records?**
- <100: Spreadsheet or document
- 100-10,000: Spreadsheet or no-code database
- 10,000+: Database

**2. How complex are relationships?**
- None: Any tool works
- Simple (1-2 links): Spreadsheet or no-code DB
- Complex (many tables): Database

**3. Who edits the data?**
- Non-technical team: Spreadsheet or Airtable
- Technical team: Database
- Mixed team: Airtable or Notion

**4. How structured is the data?**
- Very structured: Database
- Semi-structured: No-code database
- Unstructured: Documents

**5. What''s the use case?**
- Automation: Database
- Human reading: Documents
- Calculations: Spreadsheet
- Hybrid: No-code database

## Quick Reference

| Need | Tool |
|------|------|
| Quick prototype | Spreadsheet |
| Small team (<10) | Spreadsheet or Airtable |
| Complex relationships | Database |
| >10,000 records | Database |
| Non-technical editors | Airtable or Sheets |
| Rich content + data | Notion |
| Custom application | Supabase |
| Knowledge base | Notion or Docs |
| Financial models | Spreadsheet |
| Production CRM | Database |',

  '## Exercise: Choose the Right Tool

**Objective:** Practice selecting the appropriate data storage tool.

**Instructions:**

### Part 1: Tool Selection Scenarios

**For each scenario, choose: Spreadsheet, No-code DB (Airtable/Notion), or Database (Supabase/PostgreSQL)**

**Scenario 1: Personal Task Management**
- 50-100 tasks
- Just you using it
- Categories, due dates, priorities

**Your choice:** __
**Why:** __

---

**Scenario 2: Agency Client CRM**
- 500+ clients
- 5 team members
- Need: clients, projects, invoices linked
- Non-technical team

**Your choice:** __
**Why:** __

---

**Scenario 3: Content Calendar**
- 30-50 posts per month
- Rich content (images, drafts, notes)
- Multiple views (calendar, list, status)
- Team of 3

**Your choice:** __
**Why:** __

---

**Scenario 4: E-commerce Inventory**
- 5,000+ products
- Multiple warehouses
- Real-time stock updates
- Needs API for website

**Your choice:** __
**Why:** __

---

**Scenario 5: Team Wiki / Knowledge Base**
- 200+ documents
- SOPs, guides, meeting notes
- Searchable
- Collaborative editing

**Your choice:** __
**Why:** __

### Part 2: Design for Each Tool

**Take Scenario 2 (Agency Client CRM) and design it in two different tools:**

**Design A: In Google Sheets**
- Sheet 1: Clients (Columns: __)
- Sheet 2: Projects (Columns: __)
- How do you link them? __
- What breaks at 1,000 clients? __

**Design B: In Airtable**
- Table 1: Clients (Fields: __)
- Table 2: Projects (Fields: __, Link to Clients: __)
- Table 3: Invoices (Fields: __, Links: __)
- Why is this better? __

### Part 3: Migration Planning

**Scenario: You have a Google Sheet with 2,000 customer records that''s becoming unmanageable.**

**Design migration plan:**
- Step 1: Choose destination tool
- Step 2: Design new structure
- Step 3: Migration process
- Step 4: What stays in Sheets?
- Step 5: Timeline

**Success Criteria:**
- Tool choices are justified
- You understand tradeoffs
- Migration planning is realistic
- You can explain when to use what',

  50,
  true,
  (SELECT id FROM quizzes WHERE title = 'Data Structures Quiz')
FROM modules m
WHERE m.slug = 'data-information-architecture';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Database vs Spreadsheet - When to Use Each',
  'https://www.youtube.com/watch?v=F8sSc6uer0w',
  'video',
  1
FROM sections WHERE slug = 'databases-spreadsheets-documents'
UNION ALL
SELECT
  id,
  'Airtable Tutorial for Beginners',
  'https://www.youtube.com/watch?v=8Mm4N0kXnZ8',
  'video',
  2
FROM sections WHERE slug = 'databases-spreadsheets-documents';

-- ============================================================================
-- SECTION 5.3: Schema Design Fundamentals
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Schema Design Quiz'), 1,
'What is a database schema?',
'["The color scheme", "The structure defining tables, fields, and relationships", "The database software", "The user interface"]',
1,
'A schema is the blueprint for how your data is organized - tables, fields, types, and how they relate.'),

((SELECT id FROM quizzes WHERE title = 'Schema Design Quiz'), 2,
'Why is good schema design important?',
'["It looks nice", "It prevents data issues, makes querying easier, and supports growth", "It''s not important", "Only for large companies"]',
1,
'Good schema design prevents data problems, makes the system easier to use, and allows for future growth.'),

((SELECT id FROM quizzes WHERE title = 'Schema Design Quiz'), 3,
'What is a "primary key" in a database?',
'["The most important field", "A unique identifier for each record", "The first field in a table", "The password"]',
1,
'A primary key uniquely identifies each record, ensuring no duplicates and enabling relationships.'),

((SELECT id FROM quizzes WHERE title = 'Schema Design Quiz'), 4,
'When should you create a separate table vs. adding more columns?',
'["Always add columns", "Create separate table for one-to-many relationships or repeating groups", "Never create separate tables", "Randomly"]',
1,
'Separate tables are needed when one record can have multiple related items (one-to-many) or when data repeats.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'schema-design',
  'Schema Design Fundamentals',
  3,
  'Intermediate',
  '# Schema Design Fundamentals

A schema is your data''s blueprint. Bad schema = constant problems. Good schema = everything works smoothly.

## What is a Schema?

**Schema** = The structure of your data

Defines:
- What tables exist
- What fields each table has
- What type of data each field holds
- How tables relate to each other
- What rules/constraints apply

## Core Concepts

### Tables

**Tables** hold related data.

**Example tables:**
- Customers
- Orders
- Products
- Invoices

**One table = one type of thing**

### Fields (Columns)

**Fields** are the attributes of that thing.

**Customers table fields:**
- id
- name
- email
- phone
- company
- created_at

### Records (Rows)

**Records** are individual instances.

### Relationships

**Relationships** link tables together.

**Types:**
1. **One-to-Many:** One customer has many orders
2. **Many-to-Many:** One order has many products, one product appears in many orders
3. **One-to-One:** One user has one profile (rare)

## Field Types

### Text Types
- **Short Text:** Names, emails (~255 chars)
- **Long Text:** Descriptions, notes
- **Email:** With validation
- **URL:** Web addresses
- **Phone:** Phone numbers

### Number Types
- **Integer:** Whole numbers
- **Decimal:** Numbers with decimals
- **Currency:** Money values

### Date/Time Types
- **Date:** Just the date
- **DateTime:** Date and time together
- **Created At / Updated At:** Automatic timestamps

### Boolean
- **True/False:** Yes/No questions

### Special Types
- **Select (Dropdown):** Predefined options
- **Multi-Select:** Multiple options
- **Link to Another Table:** Create relationships
- **Attachment:** File uploads

## Schema Design Process

### Step 1: List Your "Things"
What nouns exist in your system?

### Step 2: Define Attributes
What do you need to know about each thing?

### Step 3: Identify Relationships
How do things connect?

### Step 4: Choose Field Types
For each attribute, pick the right type.

### Step 5: Add Constraints
What rules must data follow?

### Step 6: Design Keys
Primary keys and foreign keys.

## Schema Design Mistakes

### Mistake 1: Everything in One Table
**Fix:** Separate tables for separate things

### Mistake 2: No Unique IDs
**Fix:** Always use auto-generated unique ID

### Mistake 3: Repeating Fields
**Fix:** Separate table for repeating data

### Mistake 4: Storing Calculated Values
**Fix:** Calculate on demand

### Mistake 5: Wrong Field Types
**Fix:** Use proper field types',

  '## Exercise: Design a Complete Schema

**Objective:** Design a production-ready database schema.

**Scenario: Freelance Service Marketplace**

A platform where:
- Freelancers offer services
- Clients post jobs
- Freelancers bid on jobs
- Clients select freelancer and pay
- Freelancer delivers work
- Client reviews and rates

### Part 1: List All "Things"
List all nouns in this system.

### Part 2: Define Tables and Fields
For each thing, create a table with fields:
- Users, Services, Jobs, Bids, Contracts, Payments, Reviews, Messages

### Part 3: Define Relationships
Map how tables connect.

### Part 4: Schema Diagram
Create a visual representation.

### Part 5: Write Sample Queries
Example queries your system would need.

### Part 6: Test Edge Cases
Challenge your schema with unusual scenarios.

**Success Criteria:**
- Schema is complete and logical
- Relationships make sense
- Edge cases are handled
- Could hand this to a developer to build',

  60,
  true,
  (SELECT id FROM quizzes WHERE title = 'Schema Design Quiz')
FROM modules m
WHERE m.slug = 'data-information-architecture';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Database Schema Design Tutorial',
  'https://www.youtube.com/watch?v=ztHopE5Wnpc',
  'video',
  1
FROM sections WHERE slug = 'schema-design';

-- ============================================================================
-- SECTION 5.4: Data Validation & Quality Control
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Data Quality Quiz'), 1,
'What is data validation?',
'["Deleting bad data", "Checking data meets requirements before accepting it", "Backing up data", "Encrypting data"]',
1,
'Validation ensures data meets your requirements (format, range, type) before entering your system.'),

((SELECT id FROM quizzes WHERE title = 'Data Quality Quiz'), 2,
'When should you validate data?',
'["Never", "As early as possible - at the point of entry", "After storing it", "Only when errors occur"]',
1,
'Validate at entry to prevent bad data from entering your system in the first place.'),

((SELECT id FROM quizzes WHERE title = 'Data Quality Quiz'), 3,
'What is data normalization?',
'["Making data normal", "Standardizing data format for consistency", "Deleting duplicates", "Validating data"]',
1,
'Normalization converts data to a consistent format (e.g., all emails lowercase, all phones same format).'),

((SELECT id FROM quizzes WHERE title = 'Data Quality Quiz'), 4,
'Why is deduplication important?',
'["It''s not important", "Duplicate records cause confusion, wasted resources, and inaccurate reporting", "It saves disk space only", "Only for large databases"]',
1,
'Duplicates lead to confusion (which is correct?), waste (multiple contacts), and errors (wrong counts).');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'data-validation-quality',
  'Data Validation & Quality Control',
  4,
  'Intermediate',
  '# Data Validation & Quality Control

Bad data in = bad data out. Always. Good systems prevent bad data from entering in the first place.

## Why Data Quality Matters

**Real costs of bad data:**
- Sales calls the wrong number (wasted time)
- Emails bounce (lost opportunities)
- Reports show wrong numbers (bad decisions)
- Duplicate records (confusion about which is correct)
- Missing data (can''t complete processes)

## Types of Data Problems

### 1. Invalid Format
- Email: "john.company.com" (missing @)
- Phone: "call me" (not a number)

### 2. Out of Range
- Age: -5 or 200 (impossible)
- Quantity: 0 or -10

### 3. Missing Required Data
- Customer with no email
- Order with no shipping address

### 4. Inconsistent Format
- Phone: "555-0100" vs "(555) 0100" vs "5550100"

### 5. Duplicates
- Same customer with slight name variations

### 6. Stale/Outdated
- Old phone numbers, old addresses

## Data Validation Strategies

### Level 1: Input Validation
Prevent bad data at entry with required fields, format validation, range validation.

### Level 2: Transformation/Normalization
Standardize data as it enters (lowercase emails, format phones).

### Level 3: Enrichment
Add missing data automatically (city from zip code).

### Level 4: Deduplication
Detect and merge duplicates using fuzzy matching.

### Level 5: Ongoing Quality Checks
Continuously monitor data quality with automated checks.

## Data Cleaning Strategies

### Step 1: Assess the Damage
Run queries to find problems.

### Step 2: Prioritize
What matters most?

### Step 3: Clean in Phases
Critical issues first, then standardize, then deduplicate, then enrich.

### Step 4: Prevent Future Issues
Add validation going forward.

## Best Practices

1. Validate Early
2. Be Specific
3. Help Users
4. Normalize Automatically
5. Log Rejections
6. Regular Audits
7. Gradual Improvement
8. Document Standards
9. Train Team
10. Continuous Monitoring',

  '## Exercise: Data Quality Audit & Cleanup

**Objective:** Assess and improve data quality in a real dataset.

### Part 1: Create Sample Dataset
Build a messy customer database with intentional problems (70% bad records).

### Part 2: Quality Assessment
Analyze your dataset for missing fields, format issues, duplicates.
Calculate quality score.

### Part 3: Design Validation Rules
Write validation rules for new data (name, email, phone, company).

### Part 4: Clean the Dataset
Phase 1: Fix critical issues
Phase 2: Normalize
Phase 3: Deduplicate
Phase 4: Enrich

### Part 5: Calculate Improvement
Before/after quality scores.

### Part 6: Design Ongoing Monitoring
Create a quality dashboard with metrics and thresholds.

### Part 7: Document Standards
Create a data quality standards document.

**Success Criteria:**
- Quality score improved by 20%+
- All validation rules documented
- Prevention strategy in place
- Standards document created',

  55,
  true,
  (SELECT id FROM quizzes WHERE title = 'Data Quality Quiz')
FROM modules m
WHERE m.slug = 'data-information-architecture';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Data Validation Best Practices',
  'https://www.youtube.com/watch?v=WNOGqJxrS6c',
  'video',
  1
FROM sections WHERE slug = 'data-validation-quality';

-- ============================================================================
-- SECTION 5.5: Privacy, Security & Compliance Basics
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Privacy and Security Quiz'), 1,
'What is PII (Personally Identifiable Information)?',
'["Public information", "Information that can identify a specific individual", "Company data", "Anonymous data"]',
1,
'PII is any data that can identify an individual person - name, email, SSN, address, phone, etc.'),

((SELECT id FROM quizzes WHERE title = 'Privacy and Security Quiz'), 2,
'Why is GDPR important for operators to understand?',
'["It''s not important", "It governs how you can collect, store, and use personal data of EU residents", "Only lawyers need to know it", "It only applies to large companies"]',
1,
'GDPR applies to anyone handling EU residents'' data, with serious penalties for violations.'),

((SELECT id FROM quizzes WHERE title = 'Privacy and Security Quiz'), 3,
'What is the principle of "least privilege" in data security?',
'["Give everyone access to everything", "Give people only the minimum access they need", "Only executives get access", "Security doesn''t matter"]',
1,
'Least privilege means people get only the access they absolutely need, reducing risk of breaches.'),

((SELECT id FROM quizzes WHERE title = 'Privacy and Security Quiz'), 4,
'What should you do before storing customer data?',
'["Store everything", "Determine what you actually need and get proper consent", "Hide it from everyone", "Share it publicly"]',
1,
'Only collect data you need, get proper consent, and ensure you have legal basis to store it.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'privacy-security-compliance',
  'Privacy, Security & Compliance Basics',
  5,
  'Advanced',
  '# Privacy, Security & Compliance Basics

As an operator handling data, you''re responsible for protecting it. Violations = fines, lawsuits, and destroyed trust.

## Why This Matters

**Real consequences:**
- GDPR fines: up to €20M or 4% of global revenue
- Data breaches: lawsuits, compensation, lost business
- Reputation damage: customers leave
- Personal liability: you can be held responsible

## Core Concepts

### PII (Personally Identifiable Information)
Data that identifies a specific person: name, email, phone, address, SSN, photos.

### Sensitive Data
Even more protected: health, financial, racial/ethnic, political, religious, sexual orientation.

## Key Regulations

### GDPR (EU)
- Right to access, deletion, portability, correction
- Requires consent, purpose limitation, data minimization
- Penalties: Up to €20M or 4% of global revenue

### CCPA (California)
- Right to know, delete, opt-out of sales
- Similar to GDPR with some differences

### HIPAA (US Healthcare)
If you handle health data, you need to comply.

## Data Handling Best Practices

### 1. Collect Only What You Need
Ask: Do we actually need this data?

### 2. Get Proper Consent
Clear, explicit consent with easy withdrawal.

### 3. Transparent Privacy Policy
Explain what, why, how, who, how long, how to delete.

### 4. Secure Storage
Encryption at rest, in transit. Access control. Backups. Audit logs.

### 5. Limit Access
Principle of Least Privilege.

### 6. Data Retention Policy
Don''t keep data forever. Define retention periods.

### 7. Vendor Management
Ensure third-party services also comply. Sign DPAs.

### 8. Breach Response Plan
Have a plan: contain, assess, notify, inform, remediate, document.

## Practical Security Measures

### For Operators
- Strong passwords + password manager
- Two-factor authentication
- Secure devices
- Be careful with email
- Use VPN on public WiFi
- Log out when done

### For Systems You Build
- HTTPS everywhere
- Encrypt sensitive data
- Validate all inputs
- Rate limiting
- Regular updates
- Regular backups

## When to Get Legal Help

- Handling health data
- Handling payment data
- Large-scale data collection
- International data transfers
- Anything with kids'' data

## Key Takeaways

1. Collect minimally
2. Be transparent
3. Secure properly
4. Enable control
5. Plan for breaches
6. Stay updated
7. When in doubt, ask',

  '## Exercise: Privacy & Security Audit

**Objective:** Assess and improve privacy and security practices.

### Part 1: Current State Assessment
For a system you use or are building, audit current practices.

### Part 2: Consent Audit
How do you get consent? Rate current consent.

### Part 3: Privacy Policy Audit
Do you have one? Does it explain everything?

### Part 4: Security Audit
Access control, data protection, account security.

### Part 5: Vendor Audit
List all third-party services with access to data.

### Part 6: Data Rights Audit
Can users request, delete, correct, export their data?

### Part 7: Retention Policy
Do you have one? Create if not.

### Part 8: Breach Response Plan
Create a plan for detecting, containing, notifying, remediating.

### Part 9: Create Action Plan
List issues by priority with timeline.

### Part 10: Document Standards
Create your privacy & security standards document.

**Success Criteria:**
- All data collection justified
- Proper consent mechanisms
- Privacy policy in place
- Security measures documented
- User rights enabled
- Breach response plan created
- Action plan with timeline',

  60,
  true,
  (SELECT id FROM quizzes WHERE title = 'Privacy and Security Quiz')
FROM modules m
WHERE m.slug = 'data-information-architecture';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'GDPR Explained Simply',
  'https://www.youtube.com/watch?v=j6wwBqfSk-o',
  'video',
  1
FROM sections WHERE slug = 'privacy-security-compliance'
UNION ALL
SELECT
  id,
  'Data Security Best Practices',
  'https://www.youtube.com/watch?v=hXSFdwIOfnE',
  'video',
  2
FROM sections WHERE slug = 'privacy-security-compliance';
