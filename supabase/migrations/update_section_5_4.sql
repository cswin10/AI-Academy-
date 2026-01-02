-- ============================================================================
-- UPDATE SECTION 5.4: Data Validation & Quality Control
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, remove any existing questions 5-8 to allow clean re-runs, then add 4 more to reach 8 total
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Data Quality Quiz')
AND order_index IN (5, 6, 7, 8);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Data Quality Quiz'), 5,
'How does validation connect to the validation stage of data flow from Section 5.1?',
'["They are unrelated concepts", "The validation stage is where quality gates prevent bad data from entering storage, implementing the rules designed here", "Validation only happens after storage", "Data flow does not include validation"]',
1,
'Section 5.1 introduced validation as a data flow stage. This section provides the detailed rules and strategies for implementing that stage effectively.'),

((SELECT id FROM quizzes WHERE title = 'Data Quality Quiz'), 6,
'When using AI for data classification in the logic layer, how does data quality affect results?',
'["AI can handle any data quality", "Poor data quality leads to poor AI classifications, following the garbage in garbage out principle regardless of capability tier", "Deep Reasoning tier overcomes bad data", "Data quality only matters for manual processing"]',
1,
'Even Deep Reasoning tier models cannot reliably classify data that is incomplete, inconsistent, or malformed. Data quality is a prerequisite for effective AI processing in the execution layer.'),

((SELECT id FROM quizzes WHERE title = 'Data Quality Quiz'), 7,
'What is the I-T-O framework application for a deduplication process?',
'["I-T-O does not apply to deduplication", "Input is the dataset with potential duplicates, Task is matching and merging similar records, Output is a deduplicated dataset with merge decisions logged", "Only Output matters for deduplication", "Deduplication is purely automatic"]',
1,
'Deduplication follows I-T-O: define input (what fields to check), specify task (matching rules and merge strategy), and structure output (deduplicated data plus a log of what was merged).'),

((SELECT id FROM quizzes WHERE title = 'Data Quality Quiz'), 8,
'How should data quality monitoring connect to the output layer of the 4-layer model?',
'["Monitoring is not part of the 4-layer model", "Quality metrics should feed dashboards and alerts in the output layer, enabling proactive quality management", "Only count records in outputs", "Quality monitoring happens separately from automation"]',
1,
'The output layer should include data quality dashboards and alerts. When quality metrics cross thresholds, notifications should trigger so issues are addressed before they compound.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Data Validation & Quality Control

This section builds on the validation stage introduced in Section 5.1. There, we established validation as a quality gate in the data flow. Here, we focus on designing and operating validation systems in practice.

The core principle: bad data in equals bad data out. This applies regardless of how sophisticated your automation or AI processing is. Data quality is infrastructure, not a nice-to-have.

## Definitions

**Data Validation**: The process of checking data against defined rules before accepting it into a system. Validation prevents bad data from entering.

**Data Quality**: A measure of how well data serves its intended purpose. Quality dimensions include accuracy, completeness, consistency, timeliness, and validity.

**Data Cleansing (Cleaning)**: The process of detecting and correcting (or removing) corrupt, inaccurate, or irrelevant data from a dataset.

**Normalization (Data)**: Standardizing data format for consistency. Converting emails to lowercase. Formatting phone numbers consistently. Standardizing date formats.

**Enrichment**: Adding information to existing data from external sources. Looking up company size from domain. Adding city from zip code. Appending industry from company name.

**Deduplication**: Identifying and merging or removing duplicate records. Critical when data enters from multiple sources.

**Fuzzy Matching**: Matching records that are similar but not identical. "John Smith" and "Jon Smith" might be the same person.

**Data Profiling**: Analyzing data to understand its structure, content, quality, and relationships. Profiling reveals quality issues.

**Data Stewardship**: Ongoing responsibility for maintaining data quality. Stewards monitor, clean, and improve data over time.

**Validation Rule**: A specific check that data must pass. Email must contain @. Quantity must be positive. Date must be in the future.

## Why Data Quality Matters

Data quality has real business impact.

**Wasted effort from bad contact data.** Sales calls wrong numbers. Emails bounce. Mail returns. Every interaction with bad data wastes time and money.

**Wrong decisions from inaccurate data.** Reports show incorrect numbers. Forecasts based on flawed data miss reality. Strategic decisions based on bad data lead to bad outcomes.

**Customer frustration from duplicate records.** Customers receive multiple copies of the same email. Their history is fragmented across records. Support cannot see the full picture.

**Automation failures from inconsistent data.** Workflows break on unexpected values. Integrations fail on malformed data. The execution layer cannot execute reliably.

**Compliance risk from incomplete data.** Audit trails are incomplete. Required information is missing. Regulatory requirements cannot be met.

Data quality is not a nice-to-have. It is infrastructure.

## Types of Data Quality Problems

### Problem Type 1: Invalid Format

Data does not match expected pattern.

Examples: Email missing @ symbol. Phone number containing letters. Date in wrong format. URL without protocol.

Detection: Pattern matching, regular expressions, format parsers.

Prevention: Input validation at entry with clear format requirements and examples.

### Problem Type 2: Out of Range

Values fall outside acceptable bounds.

Examples: Negative quantity. Age of 200. Date in year 1900 for recent order. Price of zero for paid product.

Detection: Range checks, boundary validation.

Prevention: Min/max constraints, dropdown selects for bounded values.

### Problem Type 3: Missing Required Data

Essential fields are empty.

Examples: Customer without email. Order without shipping address. Lead without source attribution.

Detection: Null checks, required field validation.

Prevention: Required field constraints at entry. Cannot submit form without required fields.

### Problem Type 4: Inconsistent Format

Same data stored in different formats across records.

Examples: Phone numbers as "555-0100" and "(555) 0100" and "5550100". Dates as "1/15/2024" and "2024-01-15" and "January 15, 2024".

Detection: Format frequency analysis. Group by format, count occurrences.

Prevention: Normalize format during entry. Store in canonical format.

### Problem Type 5: Duplicates

Same entity represented by multiple records.

Examples: Same customer with slight name variations. Same company with different address formatting. Same lead entered from multiple sources.

Detection: Fuzzy matching on key fields. Exact matching on unique identifiers.

Prevention: Duplicate detection at entry. Matching against existing records before creating new.

### Problem Type 6: Stale Data

Information that was once correct is now outdated.

Examples: Old phone numbers. Former addresses. Previous job titles. Outdated pricing.

Detection: Age-based checks. Verification prompts. External validation.

Prevention: Regular verification cycles. User-prompted updates. Integration with authoritative sources.

### Problem Type 7: Inconsistent References

Related records that should match do not.

Examples: Order references customer ID that does not exist. Product references category that was deleted. Invoice references contract that was cancelled.

Detection: Foreign key validation. Orphan record detection.

Prevention: Referential integrity constraints in schema. Cascade rules for deletions.

### Problem Type 8: Semantic Errors

Data is syntactically valid but logically wrong.

Examples: End date before start date. Shipping address identical to billing for corporate accounts. Revenue of $1 for enterprise contract.

Detection: Business rule validation. Cross-field logic checks.

Prevention: Complex validation rules that check relationships between fields.

## Data Validation Strategies

### Level 1: Input Validation

Catch problems at the point of entry. This is the first line of defense.

**Required field validation** ensures essential data is present. Mark required fields clearly. Prevent submission without them.

**Format validation** checks patterns. Email contains @. Phone matches expected pattern. URL has valid structure.

**Range validation** checks bounds. Date in valid range. Number within limits. Selection from valid options.

**Cross-field validation** checks relationships between fields. End date after start date. Shipping address complete when delivery selected.

**User experience matters.** Clear error messages explain what is wrong and how to fix it. Inline validation provides immediate feedback. Examples show expected format.

### Level 2: Transformation and Normalization

Standardize data as it enters. Consistent format enables consistent processing.

**Case normalization** standardizes capitalization. Emails to lowercase. Names to proper case. Codes to uppercase.

**Format normalization** standardizes patterns. Phone numbers to consistent format. Dates to ISO format. Currency to decimal.

**Whitespace handling** removes extra spaces. Trim leading and trailing spaces. Collapse multiple spaces.

**Character handling** manages special characters. Convert curly quotes to straight. Handle unicode normalization.

This level implements the transformation stage from Section 5.1.

### Level 3: Enrichment

Add missing data automatically. Enrich records with information from external sources or derivation.

**Derived data** calculated from existing fields. Full name from first and last. Age from birth date. Status from dates.

**Lookup data** from reference sources. City and state from zip code. Country from phone prefix. Timezone from location.

**External enrichment** from APIs. Company information from domain. Social profiles from email. Industry classification from company name.

Enrichment adds value but also adds complexity and potential failure points. Decide what enrichment is worth the overhead.

### Level 4: Deduplication

Detect and handle duplicate records. Critical for data aggregated from multiple sources.

**Exact matching** on unique identifiers. Same email address. Same phone number. Same combination of identifying fields.

**Fuzzy matching** on similar but not identical values. "John Smith" matches "Jon Smith". "123 Main St" matches "123 Main Street".

**Matching strategies:**

Deterministic matching uses exact rules. If email matches, records are the same.

Probabilistic matching calculates similarity scores. If name, company, and phone all partially match, likely the same record.

**Merge strategies:**

Keep most recent. Newer data overwrites older.

Keep most complete. Record with more fields wins.

Merge fields. Combine non-conflicting data from both records.

Flag for review. When uncertain, mark for human decision.

### Level 5: Ongoing Quality Monitoring

Quality is not a one-time effort. Continuous monitoring catches drift.

**Quality metrics** track health over time. Percentage of records with complete required fields. Duplicate rate. Format compliance rate.

**Threshold alerts** notify when quality drops. If email bounce rate exceeds 5%, alert. If duplicate rate exceeds 2%, investigate.

**Scheduled audits** check quality regularly. Weekly data quality report. Monthly duplicate scan. Quarterly completeness audit.

**Quality dashboards** visualize trends. Connect to output layer for visibility.

## Automation vs Manual Review

Not everything can or should be automated. Knowing the boundary helps you allocate resources.

### What Should Always Be Automated

**Format validation.** Checking email patterns, phone formats, date structures. Machines do this perfectly every time.

**Required field checks.** Verifying mandatory fields are present. No judgment required.

**Normalization.** Lowercase emails, standardize phone formats, trim whitespace. Consistent, repeatable transformations.

**High-confidence deduplication.** Exact email matches, identical phone numbers. When certainty is high, automate the merge.

**Threshold alerts.** Monitoring quality metrics and notifying on degradation. Humans should not watch dashboards.

### What Often Requires Human Review

**Low-confidence fuzzy matches.** "Jon Smith at Acme" vs "John Smith at ACME Inc" might be the same person. Might not. Humans decide edge cases.

**Semantic validation.** Is this job title plausible for this company size? Does this order quantity make sense for this customer? Business judgment required.

**Missing critical data.** When essential fields are empty, should you reject the record, attempt enrichment, or accept with a flag? Depends on context.

**Conflicting enrichment sources.** Two APIs return different company information. Which is correct? Human verification needed.

**Merge conflicts.** Two duplicate records have different phone numbers. Which to keep? Often requires customer contact.

### Failure Cost Prioritization

When deciding what to fix first, consider failure costs:

**Bad email.** Wasted sales time, bounced campaigns, lost opportunities. Medium-high cost.

**Duplicate customer.** Broken CRM history, fragmented communications, confused support. High cost.

**Invalid status field.** Automation failures, incorrect reporting, workflow breakage. High cost.

**Missing consent record.** Legal liability, compliance risk, potential fines. Very high cost.

**Inconsistent formatting.** Ugly reports, minor inefficiencies. Low cost.

Prioritize fixes by impact, not by count.

## Data Cleaning Strategies

When you inherit dirty data, systematic cleaning is required.

### Step 1: Profile and Assess

Before cleaning, understand what you have.

**Run profiling queries:**

How many records total?
What percentage have complete required fields?
What are the format variations for key fields?
How many potential duplicates exist?
What is the distribution of values for categorical fields?

**Create a quality scorecard:**

Field: email. Complete: 85%. Valid format: 92%. Unique: 78%.
Field: phone. Complete: 65%. Valid format: 70%. Normalized: 40%.
Field: company. Complete: 75%. Enriched: 20%.

### Step 2: Prioritize

You cannot fix everything at once. Prioritize by impact.

**High priority:** Fields used for communication (email, phone). Fields used for automation triggers. Fields used for critical decisions.

**Medium priority:** Fields used for reporting. Fields used for personalization. Reference data.

**Lower priority:** Nice-to-have enrichment. Historical records rarely accessed.

### Step 3: Clean in Phases

Systematic cleaning prevents overwhelm.

**Phase 1: Critical issues.** Fix fields that block essential operations. Invalid emails that cause bounces. Missing required fields that break workflows.

**Phase 2: Standardization.** Normalize formats. Apply consistent capitalization. Standardize patterns.

**Phase 3: Deduplication.** Identify and merge duplicates. Start with high-confidence exact matches. Progress to fuzzy matching with review.

**Phase 4: Enrichment.** Add missing information. Lookup and derive data. Enhance records systematically.

### Step 4: Prevent Future Issues

Cleaning without prevention is Sisyphean. Each cleaning effort should improve entry validation.

After cleaning phone formats, add format validation to prevent new bad formats.

After deduplicating, add duplicate detection to prevent new duplicates.

Document standards so everyone understands expectations.

## Connection to I-T-O Framework

Validation processes follow I-T-O structure:

**Input validation I-T-O:**
- Input: Raw form submission
- Task: Apply validation rules, reject or accept
- Output: Validated record or error message with details

**Normalization I-T-O:**
- Input: Validated but unstandardized record
- Task: Apply normalization transforms
- Output: Standardized record ready for storage

**Deduplication I-T-O:**
- Input: New record to check
- Task: Match against existing records, decide duplicate status
- Output: New record, merged record, or flagged for review

**Quality audit I-T-O:**
- Input: Dataset to assess
- Task: Calculate quality metrics against standards
- Output: Quality scorecard with issues identified

Structuring quality processes as I-T-O operations makes them systematic and debuggable.

## Connection to Automation and Capability Tiers

Data quality affects AI processing in the execution layer.

**Fast/Cheap tier** works well for simple format validation. Check if email contains @. Check if phone matches pattern. Simple rules, fast execution.

**Balanced tier** handles more complex validation. Assess whether a message is spam. Classify the category of a support ticket. Extract structured data from semi-structured input.

**Deep Reasoning tier** addresses nuanced quality issues. Determine if two company records represent the same entity based on limited information. Assess semantic correctness of complex business rules.

Match the capability tier to the validation complexity. Do not use expensive models for simple checks.

## Data Quality Best Practices

### Practice 1: Validate Early

Check data at the point of entry. Problems caught at entry are cheap to fix. Problems found in storage are expensive.

Design forms with validation. Add constraints to APIs. Implement checks in integrations.

### Practice 2: Be Specific in Rules

Vague validation is useless validation.

Bad: "Email should be valid."
Good: "Email must contain exactly one @, have characters before @, have a domain with a TLD after @, and not be from a known disposable email provider."

Specific rules catch specific problems.

### Practice 3: Help Users Fix Issues

When validation fails, help the user succeed.

Bad: "Invalid input."
Good: "Email format invalid. Please enter an email like name@company.com."

Show examples. Highlight the specific problem. Suggest corrections when possible.

### Practice 4: Normalize Automatically

Do not rely on humans to format consistently. Humans are inconsistent. Systems should normalize.

Accept "5550100" and store as "+1-555-0100". Accept "JOHN@COMPANY.COM" and store as "john@company.com".

Users should not have to think about format.

### Practice 5: Log Rejections

Track what validation rejects. Patterns in rejections reveal:

Unclear form instructions (many users making same mistake).
Overly strict validation (rejecting valid data).
Attempted bad actors (repeated submission attempts).

### Practice 6: Conduct Regular Audits

Quality degrades over time. Data becomes stale. New entry paths bypass validation. Edge cases accumulate.

Schedule regular quality audits. Weekly for critical data. Monthly for operational data. Quarterly for archival data.

### Practice 7: Improve Gradually

Perfect is the enemy of good enough. Start with essential validation. Add more over time based on issues encountered.

Each quality problem is an opportunity to add a new rule.

### Practice 8: Document Standards

Write down your data quality standards. What formats are expected? What fields are required? What validation rules apply?

Standards enable consistency across team members and systems.

### Practice 9: Train Your Team

People who enter data should understand quality standards. Training reduces errors at the source.

Explain why quality matters. Show examples of good and bad data. Make standards accessible.

### Practice 10: Monitor Continuously

Build data quality into your dashboards. Track metrics over time. Alert on degradation.

Quality is ongoing, not a project.',

exercise_markdown = '## Exercise: Data Quality Audit and Improvement

**Objective:** Conduct a comprehensive data quality audit on a realistic dataset, design validation rules, execute cleaning operations, and establish ongoing monitoring.

This exercise develops practical skills for assessing and improving data quality in real systems.

### Part 1: Create a Sample Dataset

**Build a messy customer database for this exercise.**

Create a spreadsheet or database table with 50 customer records. Intentionally include the following quality issues (aim for 60-70% of records having at least one issue):

**Format issues (10-15 records):**
- Emails without @ symbol
- Emails with spaces
- Inconsistent email domains (both info@ and INFO@)
- Phone numbers in varied formats (555-0100, (555) 0100, 5550100, 555.0100)
- Names in inconsistent case (john smith, JOHN SMITH, John Smith)

**Missing data (10-15 records):**
- Records without email
- Records without phone
- Records without company
- Records with only first name or only last name

**Duplicate issues (5-10 records):**
- Same email, different name spelling
- Same name and company, different email
- Obvious duplicates with slight variations

**Invalid data (5-10 records):**
- Clearly fake emails (test@test.test)
- Phone numbers that are too short or too long
- Dates in the future for created_at
- Names containing numbers

**Document your dataset:** List what issues you intentionally included and how many of each.

### Part 2: Quality Assessment

**Profile your dataset and calculate quality metrics.**

**Total record count:** _______

**Field: email**
- Records with value: _____ (____%)
- Records with valid format (contains @, has domain): _____ (____%)
- Unique emails: _____ (____% unique rate)
- Format variations observed: _______

**Field: phone**
- Records with value: _____ (____%)
- Records with valid format: _____ (____%)
- Format variations observed: _______

**Field: first_name**
- Records with value: _____ (____%)
- Case variations observed: _______

**Field: last_name**
- Records with value: _____ (____%)
- Case variations observed: _______

**Field: company**
- Records with value: _____ (____%)
- Issues observed: _______

**Field: created_at**
- Records with value: _____ (____%)
- Records with valid date: _____ (____%)
- Records with impossible dates: _______

**Duplicate assessment:**
- Potential duplicates by email: _______
- Potential duplicates by name + company: _______

**Overall quality score:**
Create a scoring formula and calculate:
- Completeness score: _______
- Validity score: _______
- Uniqueness score: _______
- Combined score: _______

### Part 3: Design Validation Rules

**For each field, design complete validation rules for future data entry:**

**Email field rules:**
- Required: Yes/No
- Format validation (regex or description): _______
- Domain validation (check MX records?): _______
- Disposable email blocking: _______
- Duplicate check behavior: _______
- Normalization (lowercase?): _______
- Error message text: _______

**Phone field rules:**
- Required: Yes/No
- Accepted formats: _______
- Normalization target format: _______
- Country code handling: _______
- Error message text: _______

**Name field rules:**
- Required: Yes/No
- Minimum length: _______
- Character restrictions: _______
- Case normalization: _______
- Split into first/last behavior: _______

**Company field rules:**
- Required: Yes/No
- Minimum length: _______
- Enrichment source: _______

**Created_at field rules:**
- Required: Yes (default to now)
- Valid range: _______
- Format: _______

### Part 4: Execute Data Cleaning

**Clean your sample dataset in phases.**

**Phase 1: Critical format fixes**

Fix email formats:
- Records fixed: _______
- Method used: _______
- Records unfixable (what did you do with them): _______

Fix phone formats:
- Target format chosen: _______
- Records normalized: _______
- Records that could not be normalized: _______

**Phase 2: Standardization**

Normalize name capitalization:
- Records changed: _______
- Rule applied: _______

Normalize email case:
- Records changed: _______

**Phase 3: Deduplication**

Identify duplicates:
- Exact email matches: _______
- Fuzzy name + company matches: _______

Merge strategy for each duplicate set:
- Document which record was kept and why
- Document what data was merged
- Document what data was lost

**Phase 4: Handle missing data**

For each record with missing required field:
- List the record
- Decision: Keep, flag for follow-up, or mark for deletion
- Justification for decision

### Part 5: Calculate Improvement

**Measure before and after:**

**Email field:**
- Before: ____% complete, ____% valid, ____% unique
- After: ____% complete, ____% valid, ____% unique
- Improvement: _______

**Phone field:**
- Before: ____% complete, ____% valid, ____% normalized
- After: ____% complete, ____% valid, ____% normalized
- Improvement: _______

**Overall:**
- Before quality score: _______
- After quality score: _______
- Total improvement: _______
- Records removed: _______
- Records merged: _______
- Final record count: _______

### Part 6: Design Ongoing Monitoring

**Create a data quality monitoring plan:**

**Daily checks:**
- What metrics to check: _______
- Alert thresholds: _______
- Who receives alerts: _______

**Weekly audit:**
- What to review: _______
- Report format: _______
- Who reviews: _______

**Monthly deep dive:**
- What analysis to run: _______
- Trend comparisons: _______
- Action items generated: _______

**Dashboard design:**
- What visualizations to include: _______
- What metrics to display: _______
- How often to refresh: _______

### Part 7: Create Standards Document

**Write a data quality standards document for your organization:**

**Section 1: Purpose**
Why data quality matters for this organization.

**Section 2: Scope**
What data this standard covers.

**Section 3: Field Standards**
For each field: accepted format, required status, validation rules, examples.

**Section 4: Entry Procedures**
How data should be entered. What validation happens. What errors mean.

**Section 5: Quality Metrics**
What is measured. What targets are. How performance is tracked.

**Section 6: Cleaning Procedures**
How cleaning is done. How often. By whom.

**Section 7: Escalation**
What to do when quality issues are found. Who to contact. How to resolve.

This document should be usable by anyone entering or managing data.

### Part 8: Connect to Automation

**Design how data quality connects to the 4-layer model:**

**Trigger layer:**
What data quality events should trigger automation?
- New record created with missing required fields
- Duplicate detected
- Validation failure logged

**Logic layer:**
What quality-related decisions need automation?
- Route incomplete records to data steward
- Flag potential duplicates for review
- Classify data quality issues by type

**Execution layer:**
What quality actions should be automated?
- Normalization transformations
- Enrichment API calls
- Duplicate merge (for high-confidence matches)

**Output layer:**
What quality information should be output?
- Quality dashboard updates
- Alert notifications
- Quality reports

### Scope Note

This exercise is comprehensive. For core mastery, prioritize Parts 1-5 (dataset creation, assessment, validation rules, cleaning, and improvement calculation). Parts 6-8 (monitoring, standards, automation) are valuable for production readiness but can be completed in a second pass.

### Deliverable

Submit a complete data quality package including:

1. Your sample dataset (before and after versions)
2. Quality assessment with metrics
3. Validation rules for all fields
4. Cleaning documentation with decisions
5. Improvement calculations
6. Monitoring plan
7. Standards document
8. Automation design

### Success Criteria

You have completed this exercise successfully when:
- Sample dataset contains realistic variety of issues
- Assessment uses specific metrics, not vague descriptions
- Validation rules are specific enough to implement
- Cleaning decisions are documented and justified
- Improvement is quantified
- Monitoring plan is actionable
- Standards document is usable by others
- Automation design connects to 4-layer model',

exercise_schema = '{
  "exercise_id": "5.4-data-quality",
  "title": "Data Quality Audit and Improvement",
  "objectives": [
    "Create realistic messy data for practice",
    "Conduct comprehensive quality assessment",
    "Design specific validation rules",
    "Execute systematic data cleaning",
    "Quantify quality improvement",
    "Design ongoing monitoring",
    "Create usable standards documentation",
    "Connect quality to automation"
  ],
  "parts": [
    {
      "part_number": 1,
      "title": "Create Sample Dataset",
      "type": "creation",
      "task": "Build messy customer database",
      "record_count": 50,
      "target_issue_rate": "60-70%",
      "issue_types": ["format", "missing", "duplicate", "invalid"]
    },
    {
      "part_number": 2,
      "title": "Quality Assessment",
      "type": "analysis",
      "task": "Profile dataset and calculate metrics",
      "fields_to_assess": ["email", "phone", "first_name", "last_name", "company", "created_at"],
      "metrics": ["completeness", "validity", "uniqueness", "format_consistency"]
    },
    {
      "part_number": 3,
      "title": "Design Validation Rules",
      "type": "specification",
      "task": "Create complete validation rules",
      "rule_elements": ["required", "format", "normalization", "duplicate_handling", "error_messages"]
    },
    {
      "part_number": 4,
      "title": "Execute Data Cleaning",
      "type": "execution",
      "task": "Clean dataset in phases",
      "phases": ["critical_fixes", "standardization", "deduplication", "missing_data_handling"],
      "documentation_required": true
    },
    {
      "part_number": 5,
      "title": "Calculate Improvement",
      "type": "measurement",
      "task": "Quantify before and after",
      "metrics": ["field_level_improvement", "overall_score_change", "record_changes"]
    },
    {
      "part_number": 6,
      "title": "Design Ongoing Monitoring",
      "type": "design",
      "task": "Create monitoring plan",
      "timeframes": ["daily", "weekly", "monthly"],
      "elements": ["metrics", "thresholds", "alerts", "dashboards"]
    },
    {
      "part_number": 7,
      "title": "Create Standards Document",
      "type": "documentation",
      "task": "Write data quality standards",
      "sections": ["purpose", "scope", "field_standards", "entry_procedures", "metrics", "cleaning_procedures", "escalation"]
    },
    {
      "part_number": 8,
      "title": "Connect to Automation",
      "type": "design",
      "task": "Design quality automation",
      "layers": ["trigger", "logic", "execution", "output"],
      "connection_to_module_2": true
    }
  ],
  "deliverable": {
    "format": "package",
    "contents": ["dataset_before_after", "assessment", "validation_rules", "cleaning_documentation", "improvement_metrics", "monitoring_plan", "standards_document", "automation_design"]
  },
  "success_criteria": [
    "Dataset contains realistic issues",
    "Assessment uses specific metrics",
    "Validation rules implementable",
    "Cleaning decisions documented",
    "Improvement quantified",
    "Monitoring actionable",
    "Standards usable by others",
    "Automation connected to 4-layer model"
  ],
  "estimated_time_minutes": 90,
  "connections": {
    "module_2": "4-layer model for quality automation",
    "module_3": "Capability tier selection for AI validation",
    "section_5_1": "Validation stage of data flow",
    "section_5_3": "Schema constraints for quality"
  }
}'

WHERE slug = 'data-validation-quality';
