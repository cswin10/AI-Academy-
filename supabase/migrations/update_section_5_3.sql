-- ============================================================================
-- UPDATE SECTION 5.3: Schema Design Fundamentals
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, add 4 more quiz questions to reach 8 total
INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Schema Design Quiz'), 5,
'How does the I-T-O framework from Module 2 apply to schema design?',
'["It does not apply to schema design", "Output requirements should drive schema design, determining what fields and relationships are needed to produce required outputs", "Only Input matters for schema", "Schema design is purely technical"]',
1,
'Start with outputs: What queries, reports, and automations will consume this data? Work backwards to determine what fields and relationships must exist to enable those outputs.'),

((SELECT id FROM quizzes WHERE title = 'Schema Design Quiz'), 6,
'What is normalization in database design and why does it matter?',
'["Making data normal or average", "Organizing data to reduce redundancy and dependency, ensuring each piece of information exists in exactly one place", "Deleting unusual records", "Converting all text to lowercase"]',
1,
'Normalization reduces data redundancy. Instead of storing customer name on every order, store it once in a customers table and reference it. This prevents inconsistencies and simplifies updates.'),

((SELECT id FROM quizzes WHERE title = 'Schema Design Quiz'), 7,
'When designing a schema for automation workflows, what connection to Module 2''s 4-layer model should you consider?',
'["Schema and automation are unrelated", "The execution layer needs fields that support triggers, status tracking, and action logging", "Only the output layer matters", "Automation does not need schema planning"]',
1,
'Automations need schema support: timestamp fields for triggers, status fields for workflow states, relationship fields for context. Design your schema to enable the execution layer.'),

((SELECT id FROM quizzes WHERE title = 'Schema Design Quiz'), 8,
'What is the difference between a one-to-many and many-to-many relationship, and how does each affect schema design?',
'["They are the same thing", "One-to-many uses a foreign key on the many side, while many-to-many requires a junction table to connect records", "Many-to-many is simpler", "Relationships do not affect schema"]',
1,
'One-to-many: Customer has many Orders. Orders table has customer_id field. Many-to-many: Orders have many Products, Products appear in many Orders. Requires an OrderItems junction table.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Schema Design Fundamentals

A schema is your data''s blueprint. Bad schema design creates ongoing friction: difficult queries, data inconsistencies, and painful modifications. Good schema design creates leverage: easy queries, reliable data, and straightforward extensions. This section teaches you to design schemas that work.

## Definitions

**Schema**: The complete structure of your database, defining tables, fields, data types, relationships, and constraints. A schema is a contract between your data and your applications.

**Table**: A collection of related records. Each table represents one type of thing: customers, orders, products, invoices. Tables are named with plural nouns.

**Field (Column)**: An attribute of the thing the table represents. The customers table might have fields for name, email, phone, and created_at.

**Record (Row)**: A single instance of the thing. One customer. One order. One product.

**Primary Key**: A field that uniquely identifies each record in a table. Typically an auto-generated ID. No two records can share the same primary key value.

**Foreign Key**: A field that references the primary key of another table. The orders table might have a customer_id field that references the customers table''s id field.

**Relationship**: A connection between two tables established through foreign keys. Relationships can be one-to-one, one-to-many, or many-to-many.

**Constraint**: A rule enforced by the database. Examples include requiring a field to be not null, requiring unique values, and requiring foreign keys to reference existing records.

**Normalization**: The process of organizing data to reduce redundancy. Information should exist in exactly one place.

**Denormalization**: Intentionally adding redundancy for performance or convenience. Sometimes breaking normalization rules makes sense.

**Index**: A data structure that speeds up queries on specific fields. Like a book index that helps you find topics quickly.

**Migration**: A change to the schema. Adding a table, modifying a field, creating a relationship. Migrations should be versioned and reversible.

## Why Schema Design Matters

Schema design determines how easy or hard everything else will be.

**Good schema makes queries easy.** Finding all orders for a customer is simple when the relationship is properly defined. With bad schema, it requires complex workarounds.

**Good schema prevents data problems.** Constraints prevent invalid data from entering. Required fields ensure completeness. Unique constraints prevent duplicates.

**Good schema enables automation.** The execution layer from Module 2 needs schema support. Status fields enable workflow tracking. Timestamp fields enable triggers. Relationships provide context for actions.

**Good schema scales.** A well-designed schema handles growth without restructuring. A poorly designed schema requires painful migrations as data grows.

**Good schema is self-documenting.** Clear table and field names communicate purpose. Relationships show how things connect. Constraints indicate rules.

## Core Concepts in Detail

### Tables: One Type of Thing

Each table should represent one type of thing. Not two. Not a hybrid.

**Examples of good table choices:**

Customers: People or companies who buy from you.
Orders: Purchases made by customers.
Products: Things you sell.
Invoices: Payment requests sent to customers.
Employees: People who work for you.
Projects: Work you do for clients.

**Signs you need separate tables:**

You have repeating groups of fields (product1_name, product1_price, product2_name, product2_price).

Some fields only apply to some records (fields that are always empty for certain record types).

You find yourself creating "type" fields to distinguish different uses of the same table.

### Fields: Choosing the Right Types

Every field should have the appropriate data type. The type determines what values are valid and what operations are possible.

**Text Types**

Short text (varchar, single line): Names, emails, phone numbers, short descriptions. Typically limited to 255 characters or similar.

Long text (text, multi-line): Descriptions, notes, content. Can hold thousands of characters.

Use short text for fields that will be searched, filtered, or displayed in lists. Use long text for content meant to be read.

**Number Types**

Integer: Whole numbers. Quantities, counts, ages.

Decimal (numeric, float): Numbers with decimal places. Prices, measurements, percentages.

Use integer for countable things. Use decimal for measurable things. Be careful with currency: use decimal with fixed precision, not float.

**Date and Time Types**

Date: Just the date (year, month, day). Birthdays, deadlines.

DateTime (timestamp): Date plus time. Created at, updated at, event times.

Time: Just the time. Opening hours, recurring schedules.

Always store timestamps in UTC. Convert to local time for display.

**Boolean**

True or False. Is active, is paid, is verified.

Use for binary states. If there are more than two options, use a select field instead.

**Select (Enum)**

Predefined list of options. Status (pending, active, completed), type (personal, business), priority (low, medium, high).

Use when values must be from a fixed list. Makes queries and filtering straightforward.

**Relationships (Links)**

Reference to another table. Customer_id on orders, project_id on tasks.

This is how you connect related data. Covered in detail below.

**Special Types**

Email: Text with email validation.
URL: Text with URL validation.
Phone: Text with phone formatting.
JSON: Structured data within a field. Useful for flexible attributes.
Array: List of values. Tags, categories.
UUID: Universally unique identifier. Alternative to auto-increment integers.

### Relationships: Connecting Tables

Relationships are how tables connect. Understanding relationship types is essential for schema design.

**One-to-Many Relationship**

One record in Table A relates to many records in Table B.

Example: One customer has many orders. One project has many tasks. One category has many products.

Implementation: The "many" side table has a foreign key pointing to the "one" side table.

Orders table has customer_id field. Tasks table has project_id field. Products table has category_id field.

**Many-to-Many Relationship**

Records in Table A can relate to many records in Table B, and vice versa.

Example: One order contains many products. One product appears in many orders. One student enrolls in many courses. One course has many students.

Implementation: Requires a junction table (also called join table or bridge table) that has foreign keys to both tables.

OrderItems table has order_id and product_id fields. Each record in OrderItems represents one product in one order. This table often has additional fields like quantity and price.

Enrollments table has student_id and course_id fields. Additional fields might include enrollment_date and grade.

**One-to-One Relationship**

One record in Table A relates to exactly one record in Table B.

Example: One user has one profile. One employee has one badge.

Implementation: Foreign key on either table, with a unique constraint.

One-to-one relationships are rare. Often the two tables could be combined. Use one-to-one when data has different access patterns (profile is public, user is private) or when splitting a table with many fields improves clarity.

### Constraints: Enforcing Rules

Constraints are rules the database enforces automatically.

**NOT NULL**

Field must have a value. Cannot be empty.

Use for required fields like customer email or order date.

**UNIQUE**

No two records can have the same value in this field.

Use for natural identifiers like email addresses, usernames, SKUs.

**PRIMARY KEY**

Combination of NOT NULL and UNIQUE. Identifies each record.

Every table should have a primary key. Usually an auto-generated id field.

**FOREIGN KEY**

Value must exist in the referenced table.

Prevents orphaned records. Cannot have an order with customer_id of 999 if no customer with id 999 exists.

**CHECK**

Custom validation rule.

Example: quantity must be greater than 0. end_date must be after start_date.

**DEFAULT**

Value assigned automatically if not provided.

Example: created_at defaults to current timestamp. status defaults to pending.

## Schema Design Process

### Step 1: Identify Your Things

List all the nouns in your system. What types of things will you track?

Brainstorm broadly, then consolidate. Customer and Client might be the same thing. Order and Purchase might be the same thing.

### Step 2: Define Attributes

For each thing, what do you need to know about it?

Consider: What will you display? What will you search or filter by? What will you report on? What do automations need?

### Step 3: Identify Relationships

How do things connect to each other?

For each pair of things, ask: Does one relate to the other? Is it one-to-one, one-to-many, or many-to-many?

Draw the relationships. Visualizing helps catch missing connections.

### Step 4: Choose Field Types

For each attribute, select the appropriate type.

Err on the side of specific types. Use email type for emails, not generic text. Use date for dates, not text. Specific types enable validation and proper sorting.

### Step 5: Add Constraints

What rules must data follow?

Required fields: What cannot be empty?
Unique fields: What cannot have duplicates?
Valid references: What must reference existing records?
Value rules: What range or format constraints apply?

### Step 6: Design Keys

Every table needs a primary key. Usually an auto-generated id.

Consider whether you need additional unique keys. Email might be a natural key for users. SKU might be a natural key for products.

### Step 7: Plan for Automation

Think about the execution layer from Module 2.

Add status fields for workflow tracking. Add timestamp fields for trigger conditions. Add fields for logging actions and outcomes.

### Step 8: Consider Queries

What questions will you ask of this data?

Design the schema to make common queries straightforward. If you frequently need to find all tasks for a project, ensure the relationship is direct.

### Step 9: Document

Write down what each table represents, what each field means, and why relationships exist.

Future you will thank present you.

## Common Schema Design Mistakes

### Mistake 1: Everything in One Table

Symptom: Single table with dozens of fields, many of which are empty for most records.

Problem: Hard to query, hard to extend, data integrity impossible.

Fix: Identify the different things mixed together. Create separate tables for each. Link with relationships.

### Mistake 2: No Unique Identifiers

Symptom: Using name or email as the way to identify records.

Problem: What if two customers have the same name? What if an email changes?

Fix: Always use auto-generated unique ID as primary key. Names and emails can be secondary unique constraints but not primary identification.

### Mistake 3: Repeating Fields

Symptom: Fields like product1_name, product1_qty, product2_name, product2_qty.

Problem: Limited to fixed number of items. Hard to query. Adding more requires schema change.

Fix: Create a separate table for the repeating items with a foreign key to the parent.

### Mistake 4: Storing Calculated Values

Symptom: Storing order_total when you have line items with quantities and prices.

Problem: Calculated values can become stale if underlying data changes.

Fix: Calculate on demand from source data. If performance requires stored calculations, implement careful update logic.

Exception: Historical records that should not change (invoiced totals should not recalculate).

### Mistake 5: Wrong Field Types

Symptom: Storing dates as text, numbers as text, booleans as text.

Problem: Cannot sort properly, cannot compare properly, cannot validate.

Fix: Use proper field types. Parse and convert data during import.

### Mistake 6: Missing Timestamps

Symptom: No created_at or updated_at fields.

Problem: Cannot audit when records were created or changed. Cannot build time-based triggers.

Fix: Add created_at (defaulting to now) and updated_at (updated automatically) to every table.

### Mistake 7: No Soft Delete

Symptom: Deleting records removes them completely.

Problem: Cannot recover accidentally deleted data. Cannot audit what was deleted. Breaks references.

Fix: Add is_deleted or deleted_at field. Filter deleted records in normal queries but retain the data.

### Mistake 8: Over-Normalization

Symptom: So many tables that simple queries require five joins.

Problem: Complexity slows development and queries.

Fix: Denormalize strategically. Some redundancy is acceptable for simplicity and performance.

### Mistake 9: Under-Normalization

Symptom: Same information stored in multiple places.

Problem: Data inconsistency when one place is updated but not others.

Fix: Normalize to single source of truth. Reference instead of duplicate.

## Example Schema Designs

### Example: Simple CRM

Tables:

Companies: id, name, website, industry, created_at, updated_at

Contacts: id, company_id (foreign key to Companies), first_name, last_name, email, phone, title, created_at, updated_at

Interactions: id, contact_id (foreign key to Contacts), type (call, email, meeting), notes, occurred_at, logged_by, created_at

Deals: id, company_id (foreign key to Companies), contact_id (foreign key to Contacts), name, value, status (prospecting, proposal, negotiation, won, lost), expected_close_date, created_at, updated_at

Relationships: One Company has many Contacts. One Company has many Deals. One Contact has many Interactions. One Contact has many Deals.

### Example: Project Management

Tables:

Clients: id, name, email, company, created_at

Projects: id, client_id (foreign key to Clients), name, description, status (planning, active, paused, completed), start_date, target_end_date, created_at, updated_at

Tasks: id, project_id (foreign key to Projects), assigned_to (foreign key to TeamMembers), title, description, status (todo, in_progress, review, done), priority (low, medium, high), due_date, completed_at, created_at, updated_at

TeamMembers: id, name, email, role, created_at

TimeEntries: id, task_id (foreign key to Tasks), team_member_id (foreign key to TeamMembers), hours, notes, date, created_at

Relationships: One Client has many Projects. One Project has many Tasks. One TeamMember has many Tasks assigned. One Task has many TimeEntries.

## Connection to Earlier Modules

Schema design connects to Module 2''s 4-layer model. The execution layer needs schema support for automation:

Trigger support: Timestamp fields like created_at and updated_at enable time-based triggers. Status fields enable state-change triggers.

Logic support: Fields for all decision criteria must exist. If automation routes based on priority, the schema needs a priority field.

Execution support: Status fields track workflow state. Assignment fields track ownership. Log fields record actions taken.

Output support: Fields needed for notifications, reports, and integrations must be captured and structured for easy access.

Schema design also connects to Section 5.1''s data flow stages. The storage stage receives transformed data. The schema must accommodate the fields produced by transformation. The output stage queries the schema. Query requirements should inform schema design.',

exercise_markdown = '## Exercise: Design a Production-Ready Schema

**Objective:** Design a complete, production-ready database schema for a realistic business scenario, applying all principles from this section.

This exercise takes you from requirements to complete schema documentation. You will make design decisions, justify them, and consider operational needs.

### Part 1: Requirements Analysis

**Scenario: Freelance Service Marketplace**

A platform where freelancers offer services and clients hire them. Here is how the platform works:

Freelancers create profiles with their skills, portfolio, and rates. They can offer multiple services with different pricing. Freelancers can be verified through identity and skill verification.

Clients create accounts and post job requirements. Jobs include description, budget, timeline, and required skills. Clients can save favorite freelancers.

Freelancers submit proposals on jobs they want. Proposals include proposed rate, timeline, and cover letter.

Clients review proposals and hire a freelancer. This creates a contract with agreed terms.

Work happens with milestone-based payment. Clients fund milestones, freelancers complete work, clients approve and release payment.

Both parties can leave reviews after contract completion.

Messages flow between freelancers and clients throughout the process.

**Task: Identify all entities (things) in this system**

List every noun that represents something you need to track. Group related concepts. Identify which are distinct tables versus attributes of other tables.

### Part 2: Table and Field Design

**For each entity you identified, design the complete table:**

**Users Table**

This table represents both freelancers and clients. Decide: One table with a role field, or separate tables?

Define all fields with types:
- Authentication fields: _______
- Profile fields: _______
- Verification fields: _______
- Timestamp fields: _______

Justify your decision on single vs. separate tables: _______

**FreelancerProfiles Table (if applicable)**

Define all fields: _______
- Skills handling: How do you store multiple skills?
- Portfolio handling: How do you store portfolio items?
- Rates handling: Hourly, project, or both?

**Services Table**

What is a service in this context: _______
Fields: _______
How does it relate to freelancers: _______

**Jobs Table**

Fields including: title, description, budget (range or fixed?), timeline, status
Define all fields with types: _______
Required fields: _______
Status options: _______

**Proposals Table**

Fields: _______
Status options (pending, accepted, rejected, withdrawn): _______
Relationships to Jobs and Freelancers: _______

**Contracts Table**

What happens when a proposal is accepted?
Fields: _______
Status tracking: _______
Payment terms: _______

**Milestones Table**

How is work broken into milestones?
Fields: _______
Payment status: _______
Approval workflow: _______

**Payments Table**

Track money movement.
Fields: _______
Status: _______
How does this relate to Milestones?

**Reviews Table**

Who reviews whom?
Fields: _______
Rating system: _______
Bidirectional reviews: How do you handle freelancer reviewing client and client reviewing freelancer?

**Messages Table**

Fields: _______
Thread handling: How do you group messages in a conversation?
Relationships: _______

**Additional tables you identify as needed:** _______

### Part 3: Relationship Mapping

**Document all relationships between tables:**

For each relationship, specify:
- Table A and Table B
- Relationship type (one-to-many, many-to-many)
- Foreign key location
- Whether junction table is needed

Example format:
- Users to Jobs: One-to-many (one User posts many Jobs). Jobs table has client_id foreign key.

**Create a visual diagram or structured list showing all relationships.**

### Part 4: Constraints and Validation

**For each table, define constraints:**

**Users Table**
- Required fields (NOT NULL): _______
- Unique fields: _______
- Check constraints: _______
- Default values: _______

**Jobs Table**
- Required fields: _______
- Check constraints (budget must be positive, etc.): _______
- Status transition rules: What status changes are valid?

**Contracts Table**
- Required fields: _______
- Referential integrity: What must exist before a contract can be created?

**Payments Table**
- Required fields: _______
- Amount validation: _______
- Status rules: _______

**Continue for all tables.**

### Part 5: Indexes and Query Optimization

**Identify frequently run queries and design indexes:**

Query 1: Find all open jobs in a category
- Tables involved: _______
- Fields to filter: _______
- Recommended index: _______

Query 2: Find freelancer by skills
- How is skill search implemented: _______
- Index strategy: _______

Query 3: Get all proposals for a job
- Tables involved: _______
- Index: _______

Query 4: Calculate freelancer earnings for a period
- Tables involved: _______
- Aggregation needed: _______

Query 5: Get conversation between two users
- Tables involved: _______
- Index: _______

### Part 6: Automation Support

**Design schema additions to support the execution layer:**

**Notification triggers**

What events should trigger notifications?
- New proposal on your job
- Proposal accepted/rejected
- Milestone completed
- Payment released
- New message

What fields support these triggers: _______

**Status workflow tracking**

For Jobs: What status transitions are valid? How do you prevent invalid transitions?

For Contracts: What workflow states exist? How do you track state history?

**Logging and audit**

What actions need to be logged?
How do you structure an activity log table?

**Scheduled job support**

What time-based automation might run?
- Job expiration
- Payment reminders
- Review reminders

What fields support these: _______

### Part 7: Edge Cases and Decisions

**Address these design decisions:**

**Scenario: Freelancer withdraws proposal after client accepts**
- What happens to the contract record?
- How do you track this event?
- What constraints prevent data inconsistency?

**Scenario: Client disputes completed milestone**
- What status represents disputed work?
- What fields capture dispute details?
- How does dispute affect payment?

**Scenario: User wants to delete their account**
- Soft delete or hard delete?
- What happens to their jobs, proposals, contracts, reviews?
- How do you handle GDPR deletion requests?

**Scenario: Same user wants to be both freelancer and client**
- Does your schema support this?
- If not, what changes would you make?

**Scenario: Service pricing needs to support packages (3 hours, 5 hours, 10 hours)**
- How do you model tiered pricing?
- Is it part of Services table or separate?

### Part 8: Sample Queries

**Write queries (in plain language or SQL) that your schema should support:**

Query 1: Show me all open jobs matching my skills, ordered by budget descending
- Tables involved: _______
- Query logic: _______

Query 2: Calculate total earnings for freelancer in last 30 days, broken down by client
- Tables involved: _______
- Aggregation: _______

Query 3: Find all contracts where milestone is overdue
- How do you determine overdue: _______
- Query logic: _______

Query 4: Get freelancer profile with average rating, total jobs completed, and total earnings
- Tables involved: _______
- Aggregations: _______

Query 5: Show conversation thread between two users, ordered by time
- Tables involved: _______
- Query logic: _______

### Part 9: Documentation Package

**Create complete schema documentation:**

Section 1: Schema Overview
- One paragraph describing the complete system
- Table count and key relationships
- Design philosophy and decisions

Section 2: Table Reference
- For each table: purpose, fields with types, constraints, relationships
- Use consistent format

Section 3: Relationship Diagram
- Visual or text representation of all tables and connections

Section 4: Query Patterns
- Common queries and how to execute them

Section 5: Automation Support
- How the schema enables the execution layer
- Trigger fields and status workflows

Section 6: Design Decisions
- Document key choices and reasoning
- Alternative approaches considered

### Deliverable

Submit complete schema documentation including all nine parts above.

The documentation should be detailed enough that a developer could implement the database from your specification.

### Success Criteria

You have completed this exercise successfully when:
- All entities in the scenario are modeled as tables
- Field types are appropriate and specific
- Relationships correctly model the domain
- Constraints enforce data integrity
- Indexes support common query patterns
- Automation needs are addressed
- Edge cases are handled
- Documentation is developer-ready
- Design decisions are justified',

exercise_schema = '{
  "exercise_id": "5.3-schema-design",
  "title": "Design a Production-Ready Schema",
  "objectives": [
    "Identify entities from business requirements",
    "Design tables with appropriate fields and types",
    "Model relationships correctly",
    "Define constraints for data integrity",
    "Plan indexes for query performance",
    "Support automation through schema design",
    "Handle edge cases and design decisions",
    "Create developer-ready documentation"
  ],
  "scenario": "freelance_service_marketplace",
  "parts": [
    {
      "part_number": 1,
      "title": "Requirements Analysis",
      "type": "analysis",
      "task": "Identify all entities in the system",
      "deliverable": "Entity list with groupings"
    },
    {
      "part_number": 2,
      "title": "Table and Field Design",
      "type": "design",
      "task": "Design complete tables with fields",
      "expected_tables": ["users", "freelancer_profiles", "services", "jobs", "proposals", "contracts", "milestones", "payments", "reviews", "messages"],
      "field_requirements": ["types", "constraints", "defaults"]
    },
    {
      "part_number": 3,
      "title": "Relationship Mapping",
      "type": "design",
      "task": "Document all table relationships",
      "relationship_details": ["type", "foreign_keys", "junction_tables"],
      "visualization_required": true
    },
    {
      "part_number": 4,
      "title": "Constraints and Validation",
      "type": "specification",
      "task": "Define all constraints per table",
      "constraint_types": ["not_null", "unique", "check", "foreign_key", "default"]
    },
    {
      "part_number": 5,
      "title": "Indexes and Query Optimization",
      "type": "optimization",
      "task": "Design indexes for common queries",
      "query_count": 5,
      "index_justification_required": true
    },
    {
      "part_number": 6,
      "title": "Automation Support",
      "type": "design",
      "task": "Design schema features supporting execution layer",
      "areas": ["notification_triggers", "status_workflows", "logging", "scheduled_jobs"],
      "connection_to_module_2": true
    },
    {
      "part_number": 7,
      "title": "Edge Cases and Decisions",
      "type": "analysis",
      "task": "Address specific design decisions",
      "scenarios": ["proposal_withdrawal", "milestone_dispute", "account_deletion", "dual_role_user", "tiered_pricing"]
    },
    {
      "part_number": 8,
      "title": "Sample Queries",
      "type": "validation",
      "task": "Write queries schema must support",
      "query_count": 5,
      "query_complexity": "mixed"
    },
    {
      "part_number": 9,
      "title": "Documentation Package",
      "type": "synthesis",
      "task": "Create complete schema documentation",
      "sections": ["overview", "table_reference", "relationship_diagram", "query_patterns", "automation_support", "design_decisions"]
    }
  ],
  "deliverable": {
    "format": "documentation_package",
    "completeness": "developer_ready"
  },
  "success_criteria": [
    "All scenario entities modeled",
    "Field types appropriate and specific",
    "Relationships correctly model domain",
    "Constraints enforce integrity",
    "Indexes support queries",
    "Automation needs addressed",
    "Edge cases handled",
    "Documentation developer-ready",
    "Decisions justified"
  ],
  "estimated_time_minutes": 90,
  "connections": {
    "module_2": "4-layer model execution layer support",
    "section_5_1": "Storage stage of data flow",
    "section_5_2": "Tool selection informs schema complexity"
  }
}'

WHERE slug = 'schema-design';
