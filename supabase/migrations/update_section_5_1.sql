-- ============================================================================
-- UPDATE SECTION 5.1: How Data Flows in Modern Systems
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, remove any existing questions 5-8 to allow clean re-runs, then add 4 more to reach 8 total
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Data Flow Quiz')
AND order_index IN (5, 6, 7, 8);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Data Flow Quiz'), 5,
'How does the I-T-O framework from Module 2 relate to data flow design?',
'["They are unrelated concepts", "Each data flow stage represents a transformation with inputs and outputs, making I-T-O the foundation for understanding data movement", "I-T-O only applies to LLM tasks", "Data flow replaces I-T-O thinking"]',
1,
'Data flow is I-T-O at scale. Each stage (entry, validation, transformation, storage, output) is itself an I-T-O operation. Understanding this connection helps you design reliable systems.'),

((SELECT id FROM quizzes WHERE title = 'Data Flow Quiz'), 6,
'When designing the transformation stage of a data flow, what should guide your design decisions?',
'["Transform everything just in case", "Define the exact output format needed for downstream systems, then work backwards to required transformations", "Use the most complex transformation available", "Skip transformation to save time"]',
1,
'Output-driven design ensures you only transform what is necessary. This connects to Module 3''s principle of specifying desired output format before crafting the transformation.'),

((SELECT id FROM quizzes WHERE title = 'Data Flow Quiz'), 7,
'How do the four layers of automation (Triggers, Logic, Execution, Outputs) from Module 2 map to data flow stages?',
'["They do not map at all", "Entry points are triggers, validation and transformation are logic, storage is execution, and outputs remain outputs", "Only the output layer matters", "Data flow is a completely separate concept"]',
1,
'The 4-layer model and data flow are complementary views. Triggers initiate data entry, logic handles validation and transformation, execution persists to storage, and outputs deliver results.'),

((SELECT id FROM quizzes WHERE title = 'Data Flow Quiz'), 8,
'What is the relationship between data flow patterns and capability tier selection for AI-assisted processing?',
'["Use Deep Reasoning tier for everything", "Simple sequential flows often need only Fast/Cheap tier, while complex branching with conditional logic may require Balanced or Deep Reasoning tier", "Capability tiers only apply to chat interfaces", "Always use the cheapest tier available"]',
1,
'Match capability tier to flow complexity. Simple validation uses Fast/Cheap. Complex classification or routing decisions use Balanced. Multi-step reasoning about data relationships uses Deep Reasoning.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# How Data Flows in Modern Systems

This section provides the foundation for designing reliable data systems. Understanding data flow connects directly to the I-T-O framework from Module 2. Every data flow is a series of Input-Task-Output operations chained together. Master this concept and you can design systems that scale.

## Definitions

**Data Flow**: The complete path information takes from initial entry through all transformations to final storage and output. A well-designed data flow is predictable, traceable, and resilient to failures.

**Data Source**: Any point where new data enters your system. Sources include forms, APIs, file uploads, manual entry, email, and integrations. Identifying all sources is the first step in flow design.

**Data Sink**: Where data ultimately lands and is consumed. Sinks include databases, reports, dashboards, notifications, and external systems. Every flow should have clearly defined sinks.

**Validation Gate**: A checkpoint where data is verified before proceeding. Gates prevent bad data from corrupting downstream processes. Early validation is cheaper than late cleanup.

**Transformation**: Any operation that changes data format, structure, or content. Transformations include normalization, enrichment, calculation, extraction, and formatting.

**Data Lineage**: The complete history of where data came from and how it changed. Good lineage enables debugging, auditing, and compliance.

**Idempotency**: The property where processing the same data multiple times produces the same result. Idempotent operations are safer and easier to retry after failures.

## The Plumbing Metaphor

Data flow works like plumbing. Water enters through pipes (data sources), flows through filters and heaters (transformations), reaches destinations like sinks and taps (outputs), and sometimes recirculates (feedback loops). Understanding the plumbing prevents leaks (data loss), clogs (bottlenecks), and floods (system overwhelm).

This metaphor helps non-technical stakeholders understand why data architecture matters. When explaining a system design, describing it as plumbing makes abstract concepts concrete.

## The Five Stages of Data Flow

### Stage 1: Entry (Data Sources)

Every piece of data in your system entered somewhere. The first design task is cataloging all entry points.

**Common entry points include:**

Web forms where users submit information directly. These are controllable sources where you define the fields and validation.

Email where inquiries, orders, and support requests arrive as unstructured text. Email requires parsing and extraction before use.

APIs where external services push data to your system. APIs typically send structured data but require authentication and validation.

Manual entry where humans type directly into systems. Manual entry is error-prone and should be minimized where possible.

File uploads including CSVs, PDFs, images, and documents. Files require parsing and format handling.

Integrations where automation platforms like n8n, Make, or Zapier connect systems. Integrations move data automatically based on triggers.

Sensors and IoT devices that collect data automatically. Sensor data tends to be high-volume and requires aggregation.

**Design questions for entry points:**

Where is all your data coming from? List every source, even the ones that seem minor.

What format does data arrive in? Structured JSON, unstructured email, semi-structured CSV?

How often does data arrive? Real-time, batched hourly, daily dumps?

Who or what creates this data? Users, systems, sensors, partners?

**Example: E-commerce business data sources**

Orders arrive from Shopify as structured JSON via webhook. Support requests arrive via email to support@company.com as unstructured text. Reviews appear on Google and Trustpilot and must be fetched via API. Inventory updates come from supplier APIs as CSV attachments. Analytics data flows from Google Analytics via integration.

This catalog becomes your reference for designing validation and transformation.

### Stage 2: Validation (Quality Gates)

Before data enters your core system, verify it meets requirements. Validation is the immune system of your data architecture.

**Types of validation checks:**

Required fields validation ensures essential data is present. A customer record without an email cannot receive communications.

Format validation confirms data matches expected patterns. Email addresses must contain @ symbol. Phone numbers must be digits.

Range validation ensures values fall within acceptable bounds. Quantities should be positive. Dates should not be in the past for future events.

Semantic validation checks that data makes logical sense. An order for negative items is syntactically valid but semantically wrong.

Duplicate detection identifies data that already exists in the system. Duplicate customer records cause confusion and wasted effort.

**What happens when validation fails?**

Reject the submission and show a clear error message to the user.

Accept but flag for human review. Useful when rejection would lose potentially valuable data.

Accept with warning, logging the issue for later investigation.

Silently drop (rarely appropriate, but sometimes used for spam).

The choice depends on the cost of accepting bad data versus the cost of rejecting potentially good data.

**Validation connects to I-T-O thinking:**

Input: Raw data from source.
Task: Apply validation rules.
Output: Accepted data, rejected data with reason, or flagged data for review.

Each validation check is itself a mini I-T-O operation.

### Stage 3: Transformation (Processing)

Data rarely arrives in the perfect format for your needs. Transformation bridges the gap between what you receive and what you need.

**Common transformations include:**

Normalization standardizes format. Convert email to lowercase. Format phone numbers consistently. Standardize date formats.

Enrichment adds missing data. Look up city and state from zip code. Add company information from domain name. Append timezone from location.

Calculation derives new values. Sum order line items for total. Calculate age from birthdate. Compute days since last purchase.

Classification assigns categories. Score lead as hot, warm, or cold. Categorize support tickets by type. Tag content by topic.

Extraction pulls specific data from larger content. Extract name and company from email signature. Pull amounts from invoice PDFs. Identify dates from unstructured text.

Formatting prepares data for output. Convert internal IDs to human-readable names. Format currency for display. Generate summary text from structured data.

**Example transformation pipeline:**

Input: Name field contains "john smith", phone field contains "5550100", email field contains "John@COMPANY.com"

Transformations applied:
- Split name into firstName "John" and lastName "Smith" with proper capitalization
- Format phone as "+1-555-0100" with country code
- Convert email to lowercase "john@company.com"
- Look up company "Company" and add industry "Technology"
- Set timezone to "America/New_York" based on area code

Output: Structured record with all fields normalized and enriched.

**Transformation connects to capability tiers:**

Simple transformations like format normalization work well with Fast/Cheap tier models or even rule-based code.

Classification tasks requiring context understanding benefit from Balanced tier.

Complex extraction from unstructured text requiring reasoning uses Deep Reasoning tier.

Match the transformation complexity to the appropriate capability tier.

### Stage 4: Storage (Persistence)

Where does data live long-term? Storage decisions affect performance, cost, accessibility, and compliance.

**Storage options span a spectrum:**

Databases like Airtable, Notion databases, Supabase, and PostgreSQL offer structured storage with relationships, queries, and constraints. Best for data that will be queried, filtered, and related to other data.

Spreadsheets like Google Sheets and Excel provide familiar interfaces for small datasets. Best for data that non-technical users need to view and edit directly.

Document stores like MongoDB and Notion pages handle semi-structured or variable data. Best when data structure varies between records.

Data warehouses like BigQuery and Snowflake handle large-scale analytics. Best for aggregating data from multiple sources for reporting.

File storage for PDFs, images, and documents that need to be retrieved but not queried.

**Key storage decisions:**

How much data will you store? Thousands of records work in spreadsheets. Millions require proper databases.

How often is data accessed? Frequently accessed data should be in fast storage. Archival data can be in cheaper, slower storage.

Who needs access? Technical teams can use databases. Non-technical teams may need spreadsheet interfaces.

How long must you keep it? Retention policies affect storage costs and compliance.

What is your backup strategy? Data should exist in multiple locations. Test your recovery process.

Section 5.2 covers storage tool selection in depth. Section 5.3 covers schema design.

### Stage 5: Output (Usage)

Data ultimately serves a purpose. Outputs are how data creates value.

**Common output types:**

Dashboards visualize data for human understanding. Real-time metrics, trends, and status indicators.

Reports package data for communication. Scheduled exports, summaries, and analyses.

Notifications alert humans to important events. Email, Slack messages, SMS, push notifications.

Integrations send data to other systems. CRM updates, accounting entries, inventory adjustments.

APIs make data available to other services. External partners, mobile apps, custom applications.

Actions trigger automated workflows. A new high-priority lead triggers sales outreach. A support ticket creates a task.

**Example: CRM lead outputs**

Lead enters via website form. After validation and enrichment, the lead is stored in Airtable. Then outputs flow:

Sales team receives Slack notification in sales-leads channel.
Lead receives confirmation email with next steps.
Dashboard updates with new lead count and source attribution.
Zapier sends lead to email marketing tool for nurture sequence.
If score is hot, calendar booking link is sent immediately.

Each output is an I-T-O operation: lead data as input, formatting as task, destination-specific output.

## Data Flow Patterns

### Pattern 1: Pipeline (Sequential)

Data moves through stages in order. Stage B depends on Stage A completing. Stage C depends on Stage B.

Example: Form submission flows to validation, then transformation, then storage, then notification.

Use when: Order matters. Each stage needs output from previous stage.

Risks: Single point of failure. One broken stage stops everything downstream.

### Pattern 2: Branching (Conditional)

Data takes different paths based on conditions. After evaluation, data goes to Path A, Path B, or Path C.

Example: After lead scoring, hot leads go to immediate sales contact, warm leads go to nurture sequence, cold leads go to newsletter only.

Use when: Different data needs different handling.

Risks: Logic complexity. Test all branches. Ensure no data falls through without a path.

### Pattern 3: Aggregation (Combining)

Multiple sources feed into single destination. Source A, Source B, and Source C all flow to combined storage.

Example: Website form, email inquiries, and chat all flow to unified support ticket database.

Use when: Data from multiple sources needs unified handling.

Risks: Format inconsistency. Normalize all sources to common format.

### Pattern 4: Fan-out (Distribution)

Single source feeds multiple destinations. One input creates outputs to Destination A, B, and C.

Example: New order triggers updates to CRM, accounting system, inventory, and customer email.

Use when: One event affects multiple systems.

Risks: Partial failure. What if one destination fails? Design for independent delivery.

### Pattern 5: Feedback Loop (Circular)

Output influences future input. Data flows A to B to C to D, and D feeds back to inform B.

Example: AI classifies support tickets. Humans correct misclassifications. Corrections train better AI classification.

Use when: System should improve over time based on outcomes.

Risks: Amplification of errors. Monitor for feedback loops that make things worse.

## Common Data Flow Problems

### Problem 1: Orphaned Data

Symptom: Data enters but goes nowhere. Form submissions pile up without processing.

Cause: Entry point created without connecting to downstream flow.

Fix: Every entry point must have a defined path to storage and output. Audit regularly for disconnected sources.

### Problem 2: Bottlenecks

Symptom: Data backs up at one stage. Thousands of records waiting for processing.

Cause: One stage cannot handle the volume. Often manual review or slow API calls.

Fix: Parallelize the bottleneck stage. Automate what can be automated. Add capacity.

### Problem 3: Data Loss

Symptom: Information disappears between stages. Records vanish without trace.

Cause: Failed operations without retry. Rejections without logging. Errors without handling.

Fix: Log everything. Queue failed operations for retry. Keep audit trail of rejections.

### Problem 4: Duplicate Processing

Symptom: Same data processed multiple times. Duplicate emails sent. Duplicate records created.

Cause: Retry without idempotency. Multiple triggers for same event. No deduplication.

Fix: Use unique identifiers. Check for existing before creating. Make operations idempotent.

### Problem 5: Unclear Dependencies

Symptom: Changing one thing breaks everything. Unexpected downstream failures.

Cause: Undocumented connections. Tight coupling between stages.

Fix: Document all dependencies. Design for loose coupling. Test changes in isolation before deploying.

## Data Flow Best Practices

### Practice 1: Single Source of Truth

Each piece of data should have one canonical location. Other systems reference it, not copy it.

Bad: Customer email stored in CRM, email tool, billing system, and spreadsheet. Each might be different.

Good: Customer email stored in CRM. All other systems query CRM for current email.

### Practice 2: Clear Entry Points

Know exactly where data comes from. Tag data with source, timestamp, and creator at entry.

This enables debugging (where did this bad data come from?), auditing (who created this?), and analytics (which sources provide most valuable data?).

### Practice 3: Validate Early

Catch problems at the gate, not downstream. Fixing bad data after storage is expensive.

Every minute spent on entry validation saves hours of cleanup later.

### Practice 4: Transform Consistently

Same input should always produce same output. Use standardized functions, not ad-hoc processing.

Document transformation logic. Version control it. Test it.

### Practice 5: Log Everything

Record data movement. Who created it? When? What changed? Why?

Logs are essential for debugging, compliance, and understanding system behavior.

### Practice 6: Handle Failures Gracefully

When something breaks, do not lose data. Design for the assumption that things will fail. Because they will.

**Use queues for reliability.** Instead of processing data directly, place it in a queue first. The queue guarantees delivery even if the processor is temporarily down. Failed items can be retried automatically. This pattern is essential for production systems.

**Retry with backoff.** When an operation fails, wait before retrying. Increase the wait time with each retry (exponential backoff). This prevents overwhelming a struggling service.

**Dead letter queues.** After maximum retries, move failed items to a separate queue for human review rather than losing them.

**Alert on patterns.** Individual failures happen. Alert when failure rate exceeds threshold, indicating a systemic problem.

## Designing Your First Data Flow

Follow this process for any new data flow:

Step 1: List all data sources. Where does information originate?

Step 2: Define required fields from each source. What data do you need?

Step 3: Design validation rules. What makes data acceptable?

Step 4: Plan transformations. How must data change?

Step 5: Choose storage location. Where will data live?

Step 6: Define outputs and actions. What happens with the data?

Step 7: Map dependencies. What depends on what?

Step 8: Identify failure points. What could break?

Step 9: Design error handling. What happens when it breaks?

Step 10: Document everything. Future you will thank present you.

## Connection to Earlier Modules

This section builds on Module 2''s 4-layer model. The trigger layer corresponds to data entry. The logic layer handles validation and transformation. The execution layer manages storage operations. The output layer delivers results to destinations.

Data flow design also connects to Module 3''s I-T-O framework. Each stage is an I-T-O operation. Specifying clear inputs, explicit tasks, and defined outputs at each stage creates reliable, debuggable flows.

When using AI for transformation stages, capability tier selection matters. Simple format conversions use Fast/Cheap tier. Classification and extraction use Balanced tier. Complex reasoning about data relationships uses Deep Reasoning tier.',

exercise_markdown = '## Exercise: Design a Complete Data Flow System

**Objective:** Create a comprehensive data flow design for a real business scenario, applying I-T-O framework and connecting to the 4-layer automation model from Module 2.

This exercise has you design before building. Good data flow design prevents problems that are expensive to fix later.

### Part 1: Source Catalog

**Scenario:** A marketing agency wants to centralize lead tracking across all acquisition channels.

**Task: Identify all data sources**

Document each source with the following information:

Source 1: Website contact form
- Data format: Form fields (structured)
- Fields received: name, email, company, phone, message, source page
- Volume: Approximately 20-50 per day
- Current handling: Emails to info@, manually entered into spreadsheet

Source 2: Email inquiries to hello@agency.com
- Data format: Unstructured email text
- Fields to extract: sender name, sender email, company (from signature), message content
- Volume: 10-20 per day
- Current handling: Forwarded to account managers

Source 3: LinkedIn messages
- Data format: Platform messages
- Fields available: sender name, sender profile URL, message
- Volume: 5-10 per day
- Current handling: Responded to individually, no tracking

Source 4: Referrals from existing clients
- Data format: Email or verbal
- Fields: referrer name, prospect name, prospect email, context
- Volume: 2-5 per week
- Current handling: Ad hoc spreadsheet entries

Source 5: Phone calls
- Data format: Verbal (requires manual capture)
- Fields: caller name, phone, company, inquiry type, notes
- Volume: 5-10 per day
- Current handling: Notes on paper, sometimes entered to CRM

**Your task:** Add two more sources you think the agency might have. Document each with the same detail level.

### Part 2: Validation Rules Design

**For the website contact form source, design validation rules:**

Name field:
- Required: Yes or No and why
- Minimum length: What value and why
- Maximum length: What value and why
- Format rules: What patterns to enforce
- Validation failure action: Reject, flag, or accept with warning

Email field:
- Required: Yes or No and why
- Format validation: What to check
- Domain validation: Block disposable emails? Check MX records?
- Duplicate handling: What if email already exists in system?
- Validation failure action: What happens on failure

Company field:
- Required: Yes or No and why
- Validation rules: Any to apply?
- Enrichment opportunity: What could you add automatically?

Phone field:
- Required: Yes or No and why
- Format validation: What patterns to accept
- Normalization: How to standardize format

Message field:
- Required: Yes or No and why
- Minimum length: What value prevents empty submissions
- Maximum length: What value prevents abuse
- Content validation: Spam detection? Link detection?

**Define the overall validation strategy:**
- What percentage of submissions do you expect to pass validation?
- What happens to submissions that fail validation?
- How do you prevent losing valid leads due to overly strict validation?

### Part 3: Transformation Pipeline Design

**Design transformations for each field:**

Name transformation:
- Input: Raw name string
- Transformations to apply: (list each step)
- Output: Structured name data

Email transformation:
- Input: Raw email string
- Transformations to apply: (list each step)
- Output: Standardized email

Company transformation:
- Input: Raw company name
- Enrichment sources: What to look up
- Data to add: What fields to append
- Output: Enriched company record

Lead scoring transformation:
- Input: All lead fields
- Scoring criteria: What factors increase score
- Classification output: Hot, Warm, Cold thresholds
- What capability tier would you use for AI-assisted scoring?

**Design the transformation order:**
Why does order matter? What must happen before what?

### Part 4: Storage Schema Design

**Design the database structure:**

Leads table:
- List all fields with data types
- Define primary key
- Define required vs optional fields
- Define default values where appropriate

Companies table:
- What fields from lead should be in separate company table?
- How does Leads table link to Companies table?
- What company-level data is shared across multiple leads?

Interactions table:
- How do you track all touchpoints with a lead?
- What fields does each interaction record need?
- How does this connect to Leads table?

Sources table:
- Should source be its own table or a field on Leads?
- What metadata about each source should you track?

**Justify your schema decisions:**
- Why separate tables vs single table?
- Why these specific relationships?
- What queries will this schema make easy or hard?

### Part 5: Output Design

**Define all outputs from the data flow:**

Output 1: Sales notification
- Trigger condition: What causes this output
- Destination: Where does it go (Slack channel, email)
- Content: What information is included
- Format: How is it structured
- Timing: Immediate, batched, or scheduled

Output 2: Lead confirmation email
- Trigger condition: When is this sent
- Recipient: Who receives it
- Content: What does it say
- Personalization: What fields are inserted

Output 3: Dashboard update
- Metrics to display: What numbers matter
- Update frequency: Real-time, hourly, daily
- Visualizations: What charts or displays

Output 4: Nurture sequence enrollment
- Trigger condition: What leads enter nurture
- Destination system: What email tool
- Data passed: What fields are needed
- Timing: When does enrollment happen

**Add two more outputs relevant to this scenario.**

### Part 6: Flow Diagram

**Create a visual representation of the complete flow:**

Draw or describe the flow showing:
- All entry points
- Validation stage
- Transformation stage
- Storage (with tables)
- All outputs

Include:
- Decision points (branches)
- Error paths
- Retry loops

The diagram should be clear enough that another person could understand the system by reading it.

### Part 7: Failure Analysis

**Identify failure points and design handling:**

Failure Point 1: Form submission during server outage
- Detection method: How do you know it failed
- User experience: What does the user see
- Data handling: Where does the data go
- Recovery: How do you retry

Failure Point 2: Email parsing fails
- Detection method: How do you identify parsing failures
- Fallback: What happens to the email
- Escalation: Who reviews failures
- Prevention: How do you reduce parsing failures

Failure Point 3: Enrichment API timeout
- Detection method: How do you detect timeout
- Fallback: Process without enrichment or wait
- Retry logic: How many times, with what delay
- Degraded operation: Can lead proceed without enrichment

Failure Point 4: Slack notification fails
- Impact assessment: How critical is this failure
- Fallback: Alternative notification method
- Retry logic: Automatic or manual

**Add two more failure points specific to this scenario.**

### Part 8: 4-Layer Model Mapping

**Map your data flow to Module 2''s 4-layer automation model:**

Trigger Layer:
- What triggers exist in your flow?
- Which are event-based vs scheduled?

Logic Layer:
- Where is conditional logic applied?
- What decisions are made in the flow?

Execution Layer:
- What actions are performed?
- What systems are written to?

Output Layer:
- What notifications are sent?
- What reports are generated?

### Part 9: Documentation Package

**Create a complete documentation package containing:**

System Overview: One paragraph describing the entire flow

Source Catalog: All sources with details

Validation Rules Document: Complete rules for all sources

Transformation Specifications: All transformations documented

Schema Diagram: Visual representation of database structure

Flow Diagram: Complete flow visualization

Failure Handling Procedures: What to do when things break

Monitoring Plan: What metrics to track, what alerts to set

**This documentation should be sufficient for another person to understand, build, or maintain the system.**

### Deliverable

Submit a complete data flow design package including all nine parts above.

**Format:** Document or collection of documents totaling 2000+ words with diagrams.

### Success Criteria

You have completed this exercise successfully when:
- All sources are identified and documented with volume estimates
- Validation rules are specific and actionable
- Transformations are clearly specified with order
- Storage schema is complete with relationships defined
- Outputs cover all stakeholder needs
- Flow diagram is clear and complete
- Failure handling addresses realistic scenarios
- Documentation could be handed to a developer to build
- Design connects explicitly to I-T-O framework and 4-layer model',

exercise_schema = '{
  "exercise_id": "5.1-data-flow-design",
  "title": "Design a Complete Data Flow System",
  "objectives": [
    "Catalog all data sources in a business scenario",
    "Design validation rules for data quality",
    "Specify transformation pipelines with ordering",
    "Create storage schema with appropriate relationships",
    "Define outputs that serve stakeholder needs",
    "Identify and handle failure scenarios",
    "Connect data flow to 4-layer automation model"
  ],
  "parts": [
    {
      "part_number": 1,
      "title": "Source Catalog",
      "type": "analysis",
      "task": "Document all data entry points",
      "required_elements": ["source_name", "data_format", "fields", "volume", "current_handling"],
      "minimum_sources": 7
    },
    {
      "part_number": 2,
      "title": "Validation Rules Design",
      "type": "specification",
      "task": "Define validation rules for each field",
      "fields_to_cover": ["name", "email", "company", "phone", "message"],
      "rule_elements": ["required", "format", "range", "duplicate_handling", "failure_action"]
    },
    {
      "part_number": 3,
      "title": "Transformation Pipeline Design",
      "type": "specification",
      "task": "Define all data transformations",
      "transformation_types": ["normalization", "enrichment", "calculation", "classification"],
      "must_specify_order": true,
      "connection_to_capability_tiers": true
    },
    {
      "part_number": 4,
      "title": "Storage Schema Design",
      "type": "design",
      "task": "Design database structure",
      "required_tables": ["leads", "companies", "interactions", "sources"],
      "must_define": ["fields", "types", "relationships", "keys"]
    },
    {
      "part_number": 5,
      "title": "Output Design",
      "type": "specification",
      "task": "Define all system outputs",
      "minimum_outputs": 6,
      "output_elements": ["trigger", "destination", "content", "format", "timing"]
    },
    {
      "part_number": 6,
      "title": "Flow Diagram",
      "type": "visualization",
      "task": "Create complete flow visualization",
      "required_elements": ["entry_points", "validation", "transformation", "storage", "outputs", "decision_points", "error_paths"]
    },
    {
      "part_number": 7,
      "title": "Failure Analysis",
      "type": "analysis",
      "task": "Identify and handle failures",
      "minimum_failure_points": 6,
      "handling_elements": ["detection", "fallback", "retry_logic", "escalation"]
    },
    {
      "part_number": 8,
      "title": "4-Layer Model Mapping",
      "type": "connection",
      "task": "Map flow to Module 2 concepts",
      "layers_to_map": ["trigger", "logic", "execution", "output"],
      "connection_to_module_2": true
    },
    {
      "part_number": 9,
      "title": "Documentation Package",
      "type": "synthesis",
      "task": "Create complete documentation",
      "required_documents": ["overview", "source_catalog", "validation_rules", "transformations", "schema", "flow_diagram", "failure_handling", "monitoring"]
    }
  ],
  "deliverable": {
    "format": "document_or_collection",
    "minimum_length": "2000 words with diagrams",
    "contents": ["all_nine_parts", "visualizations", "specifications"]
  },
  "success_criteria": [
    "All sources documented with volume estimates",
    "Validation rules specific and actionable",
    "Transformations clearly ordered",
    "Schema complete with relationships",
    "Outputs cover stakeholder needs",
    "Flow diagram clear and complete",
    "Failure handling realistic",
    "Documentation developer-ready",
    "Explicit I-T-O and 4-layer connections"
  ],
  "estimated_time_minutes": 90,
  "connections": {
    "module_2": "4-layer automation model, I-T-O framework",
    "module_3": "Capability tier selection for AI transformations",
    "section_5_2": "Storage tool selection",
    "section_5_3": "Schema design details"
  }
}'

WHERE slug = 'data-flow';
