-- ============================================================================
-- MODULE 6: Automation Fundamentals
-- ============================================================================

-- Insert Module 6
INSERT INTO modules (track_id, slug, title, short_description, order_index, estimated_hours, level, xp_reward, is_active)
SELECT
  id,
  'automation-fundamentals',
  'Automation Fundamentals',
  'Master the core concepts of automation: triggers, actions, conditions, error handling, and building reliable workflows.',
  6,
  5,
  'Intermediate',
  50,
  true
FROM tracks WHERE slug = 'core-foundation';

-- Create quizzes for Module 6
INSERT INTO quizzes (title, description, difficulty, passing_score, xp_reward) VALUES
('Triggers and Actions Quiz', 'Test your understanding of automation triggers and actions', 'intermediate', 75, 15),
('Conditions and Logic Quiz', 'Test your knowledge of conditional logic in automations', 'intermediate', 75, 15),
('Error Handling Quiz', 'Test your understanding of handling failures gracefully', 'advanced', 80, 25),
('Testing and Debugging Quiz', 'Test your knowledge of testing automation workflows', 'intermediate', 75, 15),
('Optimization Quiz', 'Test your understanding of making automations efficient', 'advanced', 80, 25);

-- ============================================================================
-- SECTION 6.1: Triggers, Actions, and Conditions
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Triggers and Actions Quiz'), 1,
'What is a trigger in automation?',
'["The action that happens", "The event that starts the automation", "The condition to check", "The error that occurs"]',
1,
'A trigger is the event that initiates an automation - like a form submission, new email, or scheduled time.'),

((SELECT id FROM quizzes WHERE title = 'Triggers and Actions Quiz'), 2,
'What is the difference between a trigger and an action?',
'["No difference", "Trigger starts the workflow, action is what happens as a result", "Actions are faster", "Triggers cost more"]',
1,
'Triggers start workflows, actions are the steps that execute in response to the trigger.'),

((SELECT id FROM quizzes WHERE title = 'Triggers and Actions Quiz'), 3,
'When should you use a scheduled trigger vs an event-based trigger?',
'["Always use scheduled", "Use scheduled for recurring tasks, event-based for immediate response", "Always use event-based", "Doesn''t matter"]',
1,
'Scheduled triggers run at set times (daily reports), event-based triggers respond immediately to events (new form submission).'),

((SELECT id FROM quizzes WHERE title = 'Triggers and Actions Quiz'), 4,
'What is a webhook trigger?',
'["A fishing hook", "A way for external services to push data to your automation in real-time", "A type of database", "An error handler"]',
1,
'Webhooks let external services send data to your automation immediately when something happens.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'triggers-actions-conditions',
  'Triggers, Actions, and Conditions',
  1,
  'Intermediate',
  '# Triggers, Actions, and Conditions

Every automation has three core components: what starts it (trigger), what it does (actions), and what decisions it makes (conditions). Understanding these building blocks is essential for creating effective workflows.

## Understanding Triggers

A **trigger** is the event that starts your automation. Without a trigger, nothing happens. It''s the "when" of your automation.

### Types of Triggers

**1. Event-Based Triggers (Instant)**

Something happens → automation runs immediately.

```
Examples:
- Form submission received
- New email arrives
- Database record created
- Payment completed
- File uploaded to folder
- Customer signs up
```

**When to use:** When immediate response matters. A new lead should get a response now, not in 15 minutes.

**2. Scheduled Triggers (Time-Based)**

Automation runs at specific, predictable times.

```
Examples:
- Every day at 9am: Send daily report
- Every Monday at 8am: Weekly summary
- First of month: Generate invoices
- Every 15 minutes: Check for updates
- End of quarter: Create analytics report
```

**When to use:** For recurring tasks, batch processing, or when timing is more important than immediacy.

**3. Webhook Triggers (Push-Based)**

External services push data directly to your automation endpoint.

```
Examples:
- Stripe sends payment notification
- Shopify sends order details
- GitHub sends commit information
- Slack sends message events
```

**Advantages:**
- Real-time data
- No polling needed
- Lower API usage
- More reliable than checking repeatedly

**4. Manual Triggers (On-Demand)**

A person explicitly starts the automation by clicking a button.

```
Examples:
- "Generate Report" button
- "Send Reminder" action
- "Process Selected Items" trigger
- Admin approval click
```

**When to use:** For on-demand tasks, one-off operations, or when human judgment should initiate the process.

**5. Polling Triggers (Check Periodically)**

Automation checks for changes at regular intervals.

```
Examples:
- Check email inbox every 5 minutes
- Look for new files every hour
- Scan database for updates every 10 minutes
```

**Trade-offs:**
- Simpler to set up than webhooks
- May miss time-sensitive events
- Uses more API calls
- Delay between event and detection

### Choosing the Right Trigger

| Scenario | Best Trigger Type |
|----------|-------------------|
| New customer signup | Event-based |
| Daily sales report | Scheduled |
| Payment notification | Webhook |
| Generate invoice on demand | Manual |
| Check competitor prices | Polling |

## Understanding Actions

An **action** is what your automation does. It''s the "what" that happens after the trigger fires.

### Types of Actions

**Data Operations:**
- **Create:** Add new records (CRM contact, database row, file)
- **Read:** Retrieve existing data (lookup customer, fetch order details)
- **Update:** Modify existing records (change status, update fields)
- **Delete:** Remove records (clean up old data, remove duplicates)

**Communication:**
- Send email
- Post to Slack/Teams
- Send SMS
- Push notifications
- Create calendar events

**Processing:**
- Transform data formats
- Calculate values
- Parse text
- Generate documents
- Run AI analysis

**Integration:**
- Call external APIs
- Upload/download files
- Sync between systems
- Trigger other automations

**Control Flow:**
- Wait/delay
- Branch/conditional
- Loop through items
- Stop/terminate

### Action Best Practices

**Make actions atomic:** Each action should do one thing well.

```
# Good: Single responsibility
Action 1: Create CRM record
Action 2: Send welcome email
Action 3: Notify sales team

# Bad: Multiple things
Action 1: Create record + send email + notify team
```

**Make actions idempotent:** Safe to run twice without creating problems.

```
# Idempotent: Safe to repeat
"Update record where ID = 123"
"Set status to ''processed''"

# Not idempotent: Creates duplicates
"Create new record"
"Increment counter"
```

**Order matters:** Actions execute in sequence. Ensure dependencies are handled.

```
# Correct order
1. Validate data
2. Create record
3. Get record ID
4. Send email with record ID

# Wrong order (will fail)
1. Send email with record ID  # ID doesn''t exist yet!
2. Create record
```

## Understanding Conditions

A **condition** is a decision point. It''s the "if" that determines which path the automation takes.

### Basic Condition Types

**Comparison Operators:**
```
If amount > 100 → Apply bulk discount
If status = "New" → Send welcome email
If priority >= 3 → Escalate to manager
If country != "US" → Calculate international shipping
```

**Existence Checks:**
```
If email is not empty → Send notification
If phone number exists → Add to SMS list
If attachment present → Process file
```

**Multiple Conditions:**
```
AND: Both must be true
If (amount > 100) AND (customer = "VIP") → Apply premium discount

OR: At least one must be true
If (source = "Website") OR (source = "App") → Track as digital lead

Combined:
If (status = "Paid") AND ((amount > 500) OR (customer = "Enterprise"))
```

### Condition Patterns

**Filter Pattern:** Continue or stop based on criteria
```
Trigger: New form submission
Condition: Is email valid?
  Yes → Continue processing
  No → Stop (log invalid submission)
```

**Router Pattern:** Send to different paths
```
Trigger: Support ticket created
Condition: What is the category?
  Billing → Route to finance team
  Technical → Route to engineering
  General → Route to support queue
```

**Priority Pattern:** Handle based on importance
```
Trigger: New order
Condition: Order value?
  > $1000 → High priority path
  > $100 → Standard path
  <= $100 → Batch processing
```

## Building Complete Automations

### Pattern 1: Linear Pipeline
```
Trigger → Action 1 → Action 2 → Action 3 → Done
```
Example: Form → Validate → Save to CRM → Send confirmation

### Pattern 2: Conditional Branch
```
Trigger → Check Condition → Path A (if true)
                         → Path B (if false)
```
Example: Order → Check inventory → In stock: ship / Out of stock: backorder

### Pattern 3: Filter Pipeline
```
Trigger → Check → Continue (if passes)
               → Stop (if fails)
```
Example: Email received → Is it spam? → No: process / Yes: discard

### Pattern 4: Loop Processing
```
Trigger → Get List → For Each Item → Action → Next Item → Done
```
Example: Daily → Get all pending orders → For each: send reminder → Complete

### Pattern 5: Delayed Action
```
Trigger → Wait (time period) → Action
```
Example: Cart abandoned → Wait 1 hour → Send reminder email

## Best Practices Summary

### Trigger Best Practices
- Choose the trigger type that matches your timing needs
- Handle cases where triggers might fire multiple times
- Test triggers with realistic data volumes
- Document what triggers each automation

### Action Best Practices
- Keep actions focused (single responsibility)
- Design for idempotency when possible
- Consider failure scenarios for each action
- Log important actions for debugging

### Condition Best Practices
- Use clear, readable condition names
- Always provide a default/else path
- Handle null and empty values explicitly
- Avoid deeply nested conditions (flatten when possible)',

  '## Exercise: Build Your First Complete Automation

**Objective:** Design and build a working automation that uses triggers, actions, and conditions together.

### Part 1: Design a Lead Intake Automation

**Scenario:** You run a consulting business and want to automate lead handling.

**Current Process (Manual):**
1. Lead fills out website form
2. You check email for new submissions
3. You copy lead info into spreadsheet
4. You send a confirmation email
5. You notify yourself on Slack
6. You categorize lead by service interest

**Requirements for Automation:**
- Capture leads from website form instantly
- Store in CRM/spreadsheet
- Route based on service interest (Consulting, Training, Support)
- Send confirmation email to lead
- Notify team on Slack with lead details

**Your Design Task:**

Document your automation design:

1. **Trigger:**
   - What type? (event, scheduled, webhook, etc.)
   - What platform/tool?
   - What data will it provide?

2. **Actions (in order):**
   - List each action
   - What data does each need?
   - What does each produce?

3. **Conditions:**
   - What decisions need to be made?
   - What are the possible paths?
   - What''s the default path?

### Part 2: Build It

Using Zapier, Make, or n8n:

1. Create the trigger (form submission or test trigger)
2. Add data validation action
3. Add CRM/spreadsheet creation
4. Add conditional routing based on service type
5. Add email sending action
6. Add Slack notification

**Document each step with screenshots.**

### Part 3: Test Scenarios

Test your automation with these scenarios:

**Scenario A: Normal Lead**
- Name: John Smith
- Email: john@company.com
- Service: Consulting
- Message: "Interested in automation consulting"

**Scenario B: Edge Case**
- Name: Jane Doe
- Email: jane@test.com
- Service: Training
- Phone: (empty)

**Scenario C: Invalid Data**
- Name: (empty)
- Email: not-an-email
- Service: Other

**Scenario D: Volume Test**
- Submit 5 forms in rapid succession
- Check: All captured? Any duplicates? Any failures?

### Part 4: Add Error Handling

For each action, identify:
- What could fail?
- How would you detect it?
- What should happen when it fails?

Add at least one error handling path to your automation.

### Part 5: Build Two Additional Automations

**Automation 2: Customer Onboarding Workflow**
- Trigger: New customer record created
- Actions: Send welcome email, create project folder, schedule kickoff meeting
- Condition: Different onboarding for different service tiers

**Automation 3: Daily Scheduled Report**
- Trigger: Every day at 9am
- Actions: Gather yesterday''s metrics, format report, send to team
- Condition: Only send if there''s data to report

**Deliverables:**
- Design documents for all 3 automations
- At least 1 fully built and tested automation
- Test results for all scenarios
- Error handling documentation

**Success Criteria:**
- Built at least 1 working automation
- Tested with normal and edge case scenarios
- Handled at least 1 error scenario
- Documented trigger, actions, and conditions clearly',

  60,
  true,
  (SELECT id FROM quizzes WHERE title = 'Triggers and Actions Quiz')
FROM modules m
WHERE m.slug = 'automation-fundamentals';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Zapier Automation Basics',
  'https://www.youtube.com/watch?v=lNQoRFfuZKo',
  'video',
  1
FROM sections WHERE slug = 'triggers-actions-conditions'
UNION ALL
SELECT
  id,
  'Understanding Triggers and Actions',
  'https://www.youtube.com/watch?v=S8j0CyJhY8Y',
  'video',
  2
FROM sections WHERE slug = 'triggers-actions-conditions';

-- ============================================================================
-- SECTION 6.2: Conditional Logic & Branching
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Conditions and Logic Quiz'), 1,
'What is the difference between AND and OR in conditional logic?',
'["No difference", "AND requires all conditions true, OR requires at least one condition true", "OR is faster", "AND is better"]',
1,
'AND requires ALL conditions to be true. OR requires AT LEAST ONE condition to be true.'),

((SELECT id FROM quizzes WHERE title = 'Conditions and Logic Quiz'), 2,
'When should you use nested conditions vs multiple separate conditions?',
'["Always nest", "Nest when decisions depend on previous decisions", "Never nest", "Doesn''t matter"]',
1,
'Nest conditions when the second decision only makes sense if the first condition is true.'),

((SELECT id FROM quizzes WHERE title = 'Conditions and Logic Quiz'), 3,
'What is a "default" or "else" path in conditional logic?',
'["An error", "The path taken when no other conditions match", "The first path", "The best path"]',
1,
'The default/else path is what happens when none of your specific conditions are true - a catch-all.'),

((SELECT id FROM quizzes WHERE title = 'Conditions and Logic Quiz'), 4,
'Why is it important to test all branches in conditional logic?',
'["It''s not important", "Each branch might have different errors or behavior you need to verify", "To waste time", "Only for large companies"]',
1,
'Each branch is a different code path that needs testing - bugs often hide in untested branches.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'conditional-logic-branching',
  'Conditional Logic & Branching',
  2,
  'Intermediate',
  '# Conditional Logic & Branching

Automations need to make decisions. The quality of your decision logic determines how smart your automations are. Good logic = smart automations. Bad logic = bugs, confusion, and failed workflows.

## Boolean Logic Fundamentals

All conditions ultimately evaluate to true or false. Understanding boolean logic is the foundation.

### AND Operator

Both conditions must be true for the overall expression to be true.

```
If (amount > 100) AND (country = "US")
  → Apply domestic bulk discount

Truth table:
amount > 100 | country = "US" | Result
-------------|----------------|--------
true         | true           | true
true         | false          | false
false        | true           | false
false        | false          | false
```

**Use AND when:** All criteria must be met.

### OR Operator

At least one condition must be true for the overall expression to be true.

```
If (source = "Website") OR (source = "Mobile App")
  → Track as digital lead

Truth table:
source = "Website" | source = "Mobile App" | Result
-------------------|----------------------|--------
true               | true                 | true
true               | false                | true
false              | true                 | true
false              | false                | false
```

**Use OR when:** Any of the criteria being met is sufficient.

### NOT Operator

Inverts the condition - true becomes false, false becomes true.

```
If NOT (status = "Complete")
  → Continue processing

Equivalent to:
If status != "Complete"
```

**Use NOT when:** You want the opposite of a condition.

### Combining Operators

Complex conditions combine AND, OR, and NOT. Order of operations matters.

```
# Parentheses control order
If (A AND B) OR C
  → True if: both A and B are true, OR C is true alone

If A AND (B OR C)
  → True if: A is true AND at least one of B or C is true

# Example
If (customer = "VIP") AND ((amount > 500) OR (items > 10))
  → VIP customers get discount on large orders OR bulk quantities
```

## Branching Patterns

### Pattern 1: Simple If-Then

Single condition, single outcome.

```
If status = "Urgent"
  → Send to priority queue

Workflow:
[Check] → [Urgent?] → Yes → [Priority Queue]
                   → No → [Continue normal flow]
```

### Pattern 2: If-Then-Else

Two mutually exclusive paths based on one condition.

```
If amount > 100
  → Apply discount
Else
  → No discount

Workflow:
[Order] → [Amount > 100?] → Yes → [Apply 10% discount]
                         → No → [Standard pricing]
```

### Pattern 3: If-Else If-Else (Chained Conditions)

Multiple paths where first matching condition wins.

```
If amount > 1000
  → Apply 20% discount
Else If amount > 500
  → Apply 15% discount
Else If amount > 100
  → Apply 10% discount
Else
  → No discount

Important: Order matters! Check largest first.
If you check amount > 100 first, a $1500 order would only get 10%.
```

### Pattern 4: Nested Conditions

Conditions within conditions. Use when second decision depends on first.

```
If customer_type = "Business"
  If annual_spend > 50000
    → Enterprise tier
  Else
    → Business tier
Else
  If has_subscription
    → Premium consumer
  Else
    → Standard consumer
```

**When to nest:**
- Second condition only makes sense if first is true
- You need different criteria for different categories

**When not to nest:**
- Logic becomes too deep (more than 2-3 levels)
- Conditions are independent of each other

### Pattern 5: Switch/Case (Multiple Options)

Multiple conditions on the same field - cleaner than chained if-else.

```
Switch (department):
  Case "Sales": Route to sales queue
  Case "Support": Route to support queue
  Case "Billing": Route to finance queue
  Default: Route to general inbox
```

### Pattern 6: Multi-Condition Matrix

When multiple factors combine to determine outcome.

```
Customer Type | Order Size | Shipping
--------------|------------|----------
VIP           | Any        | Free Express
Regular       | > $100     | Free Standard
Regular       | <= $100    | Standard Rate
Guest         | > $50      | Standard Rate
Guest         | <= $50     | Premium Rate

Implementation:
If customer = "VIP" → Free Express
Else If customer = "Regular" AND amount > 100 → Free Standard
Else If customer = "Regular" → Standard Rate
Else If amount > 50 → Standard Rate
Else → Premium Rate
```

## Edge Case Handling

Edge cases are unusual but valid scenarios that your logic must handle.

### Null/Empty Values

Always check if data exists before using it.

```
# Bad: Assumes data exists
If email.contains("@company.com") → Internal user

# Good: Check first
If email is not empty AND email.contains("@company.com") → Internal user
```

### Unknown/Unexpected Values

What happens when you get data you didn''t anticipate?

```
# Bad: Only handles known values
If status = "Active" → Process
If status = "Inactive" → Skip

What if status = "Pending"? Nothing happens!

# Good: Has default
If status = "Active" → Process
Else If status = "Inactive" → Skip
Else → Log unknown status and alert
```

### Type Mismatches

Ensure data types match your expectations.

```
# Problem: amount is sometimes a string
If amount > 100  # Fails if amount = "150"

# Solution: Convert first
If toNumber(amount) > 100
```

### Boundary Conditions

Pay special attention to exact boundary values.

```
# Question: Does exactly $100 get the discount?
If amount > 100 → No (101+ gets it)
If amount >= 100 → Yes (100+ gets it)

Be explicit about boundaries!
```

## Common Mistakes and How to Avoid Them

### Mistake 1: Wrong Operator (OR vs AND)

```
# Intention: High value VIP orders
# Bug: Using OR instead of AND
If amount > 1000 OR customer = "VIP"
  → Both $50 VIP orders AND $2000 random orders qualify!

# Correct:
If amount > 1000 AND customer = "VIP"
  → Only VIP orders over $1000 qualify
```

### Mistake 2: Unreachable Code

```
# Bug: Second condition can never be true
If amount > 100 → Path A
If amount > 500 → Path B  # Never reached! Already caught by first.

# Correct: Check larger values first
If amount > 500 → Path B
Else If amount > 100 → Path A
```

### Mistake 3: Missing Default Path

```
# Bug: Some values fall through
If region = "US" → US process
If region = "EU" → EU process
# What about Asia? Australia?

# Correct: Always have default
If region = "US" → US process
Else If region = "EU" → EU process
Else → International process (default)
```

### Mistake 4: Over-Complex Nesting

```
# Hard to read and maintain
If A
  If B
    If C
      If D
        → Do something

# Better: Flatten with combined conditions
If A AND B AND C AND D → Do something

# Or: Use early returns
If NOT A → Exit
If NOT B → Exit
If NOT C → Exit
If NOT D → Exit
→ Do something
```

## Simplification Techniques

### De Morgan''s Laws

Transform complex NOT expressions:

```
NOT (A AND B) = (NOT A) OR (NOT B)
NOT (A OR B) = (NOT A) AND (NOT B)

Example:
NOT (isVIP AND hasPurchased)
= (NOT isVIP) OR (NOT hasPurchased)
= isRegular OR hasNotPurchased
```

### Early Returns/Exits

Check disqualifying conditions first and exit early.

```
# Instead of nested conditions:
If isValidEmail
  If hasOptedIn
    If isActive
      → Send email

# Use early exits:
If NOT isValidEmail → Exit
If NOT hasOptedIn → Exit
If NOT isActive → Exit
→ Send email
```

### Lookup Tables

Replace many conditions with a data lookup.

```
# Instead of:
If country = "US" → tax = 0
If country = "CA" → tax = 5
If country = "UK" → tax = 20
... (50 more countries)

# Use lookup:
tax = TaxRates[country]  # Get from table/spreadsheet
```

### Truth Tables

For complex logic, map out all possibilities.

```
| isVIP | amount > 100 | hasDiscount | Action        |
|-------|--------------|-------------|---------------|
| true  | true         | true        | Apply VIP 25% |
| true  | true         | false       | Apply VIP 20% |
| true  | false        | any         | Apply VIP 10% |
| false | true         | true        | Apply 15%     |
| false | true         | false       | Apply 10%     |
| false | false        | any         | No discount   |
```',

  '## Exercise: Master Conditional Logic

**Objective:** Build complex conditional logic and test all branches thoroughly.

### Part 1: Design Logic for These Scenarios

**Scenario 1: Expense Approval Routing**

Design the conditional logic for expense report routing:

| Condition | Action |
|-----------|--------|
| Amount < $100 | Auto-approve |
| Amount $100-$500 | Manager approval |
| Amount > $500 | Finance team approval |
| Any amount + missing receipt | Always manual review |
| Any amount + flagged vendor | Security review |

Questions to answer:
- What order should conditions be checked?
- How do you handle multiple conditions matching?
- What''s the default path?

**Scenario 2: Support Ticket Routing**

Design routing for incoming support tickets:

| Condition | Route To |
|-----------|----------|
| VIP customer | Senior support (priority) |
| Contains "bug" or "error" | Engineering team |
| Category = "Billing" | Finance team |
| Sentiment = Angry | Manager escalation |
| Default | General support queue |

Questions to answer:
- Can a ticket match multiple conditions?
- Which takes priority: VIP status or angry customer?
- How do you detect "angry" sentiment?

**Scenario 3: E-commerce Order Processing**

Design order fulfillment logic:

| In Stock | Payment | Location | Action |
|----------|---------|----------|--------|
| Yes | Paid | US | Ship next-day |
| Yes | Paid | International | Ship 3-5 days |
| Yes | Pending | Any | Hold for payment |
| No | Paid | Any | Backorder or refund |
| No | Pending | Any | Cancel order |

### Part 2: Build One Scenario

Choose one scenario from Part 1 and implement it:

1. Create the automation in your platform (Zapier/Make/n8n)
2. Build all conditional paths
3. Add appropriate actions for each path
4. Include a default/catch-all path

**Document with screenshots of your conditional setup.**

### Part 3: Create Test Cases for All Branches

For your implemented scenario, create test cases:

| Test # | Input Data | Expected Path | Expected Outcome |
|--------|------------|---------------|------------------|
| 1 | [data] | [which branch] | [what happens] |
| 2 | ... | ... | ... |

**Requirements:**
- At least one test for each possible branch
- Include edge cases (boundary values, empty fields)
- Include a test for the default path

### Part 4: Execute Tests and Document Results

Run each test case and record:
- Did it take the expected path?
- Was the outcome correct?
- Any unexpected behavior?

### Part 5: Debug a Broken Logic Scenario

Here''s automation logic with bugs. Find and fix them:

```
# Discount Calculator (Buggy)
If amount > 50 → Apply 5% discount
If amount > 100 → Apply 10% discount
If amount > 200 → Apply 15% discount
If customer = "VIP" → Apply 25% discount
```

**Bugs to find:**
1. What discount does a $250 order get?
2. What about a VIP with a $300 order?
3. What about a $49.99 order?

**Provide the corrected logic.**

### Part 6: Simplify Complex Logic

Rewrite this nested logic to be more readable:

```
If customer_type = "Enterprise"
  If contract_status = "Active"
    If last_purchase < 30 days
      → Priority support
    Else
      If support_tier = "Premium"
        → Standard support
      Else
        → Basic support
  Else
    → Sales outreach
Else
  If customer_type = "Small Business"
    If has_subscription
      → Standard support
    Else
      → Self-service
  Else
    → Self-service
```

**Provide simplified version using:**
- Early exits
- Flattened conditions
- Clear path naming

**Deliverables:**
- Logic designs for all 3 scenarios
- One fully implemented and tested automation
- Test case matrix with results
- Bug fixes for the broken logic
- Simplified version of complex logic

**Success Criteria:**
- All scenarios have complete logic designs
- At least one automation built and tested
- All branches tested with documented results
- Can explain the difference between AND/OR/NOT
- Can identify and fix common logic bugs',

  55,
  true,
  (SELECT id FROM quizzes WHERE title = 'Conditions and Logic Quiz')
FROM modules m
WHERE m.slug = 'automation-fundamentals';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Conditional Logic in Automation',
  'https://www.youtube.com/watch?v=YqhNhO7sJ-g',
  'video',
  1
FROM sections WHERE slug = 'conditional-logic-branching';

-- ============================================================================
-- SECTION 6.3: Error Handling & Graceful Failures
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Error Handling Quiz'), 1,
'What is error handling in automation?',
'["Deleting errors", "Planning for and gracefully managing failures when they occur", "Ignoring problems", "Making systems never fail"]',
1,
'Error handling is about anticipating failures and managing them gracefully so systems don''t crash.'),

((SELECT id FROM quizzes WHERE title = 'Error Handling Quiz'), 2,
'What is the difference between a transient error and a permanent error?',
'["No difference", "Transient errors are temporary and may work if retried, permanent errors won''t fix themselves", "Transient errors are worse", "Permanent errors are temporary"]',
1,
'Transient errors (like network timeouts) may succeed on retry. Permanent errors (like invalid data) won''t.'),

((SELECT id FROM quizzes WHERE title = 'Error Handling Quiz'), 3,
'What should you do when an automation fails?',
'["Nothing", "Log the error, notify relevant people, and have a recovery plan", "Delete everything", "Panic"]',
1,
'Good error handling logs what happened, alerts the right people, and has a plan to recover.'),

((SELECT id FROM quizzes WHERE title = 'Error Handling Quiz'), 4,
'Why is it important to differentiate between critical and non-critical errors?',
'["It''s not important", "Critical errors need immediate attention, non-critical can wait or be ignored", "All errors are equal", "Only for large companies"]',
1,
'Not all failures are equal - critical errors (payment processing) need immediate response, minor errors can wait.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'error-handling',
  'Error Handling & Graceful Failures',
  3,
  'Advanced',
  '# Error Handling & Graceful Failures

Things will break. Always. The question isn''t "will my automation fail?" but "what happens when it does?" Good error handling is what separates amateur automations from production-ready systems.

## Why Errors Happen

Every automation has multiple points of failure:

**External Dependencies:**
- APIs go down
- Services have outages
- Rate limits get hit
- Credentials expire
- Third-party changes break integrations

**Data Issues:**
- Invalid input data
- Missing required fields
- Unexpected formats
- Encoding problems
- Data too large

**Logic Problems:**
- Edge cases not handled
- Race conditions
- Timeout exceeded
- Resource exhaustion

**The only guarantee: Something will eventually fail.**

## Types of Errors

### 1. Transient Errors (Temporary)

These may succeed if you try again.

```
Examples:
- Network timeout
- API rate limit exceeded
- Service temporarily unavailable (503)
- Connection reset
- Temporary resource contention
```

**Strategy:** Retry with exponential backoff.

### 2. Permanent Errors (Persistent)

These will NOT fix themselves. Retrying is pointless.

```
Examples:
- Invalid data format
- Authentication failure (401)
- Resource not found (404)
- Permission denied (403)
- Validation errors
```

**Strategy:** Log, alert, and require human intervention.

### 3. Partial Failures

Some operations succeed, others fail within the same workflow.

```
Example:
1. Create CRM record ✓
2. Send email ✓
3. Create invoice ✗ (API error)
4. Notify team (skipped)

Now you have incomplete state:
- Customer exists
- Email sent
- No invoice
- Team not notified
```

**Strategy:** Transaction management, rollback capability, or completion tracking.

## Error Handling Strategies

### Strategy 1: Retry with Exponential Backoff

For transient errors, retry with increasing delays.

```
Attempt 1: Try immediately
  ↓ Failed
Wait 1 second
Attempt 2: Try again
  ↓ Failed
Wait 2 seconds
Attempt 3: Try again
  ↓ Failed
Wait 4 seconds
Attempt 4: Try again
  ↓ Failed
Wait 8 seconds
Attempt 5: Try again
  ↓ Failed
→ Give up, escalate to human

Total wait: 15 seconds
Max attempts: 5
```

**Why exponential backoff?**
- Gives system time to recover
- Avoids hammering a struggling service
- Reduces chance of cascading failures

### Strategy 2: Dead Letter Queue

Failed items go to a review queue for later processing.

```
Normal Flow:
[Item] → [Process] → [Success] → Done

With Dead Letter Queue:
[Item] → [Process] → [Failure] → [Dead Letter Queue]
                                        ↓
                              [Human reviews]
                                        ↓
                              [Fix & Reprocess]
```

**Implementation:**
- Create a "Failed Operations" table/spreadsheet
- Log: timestamp, operation, input data, error message
- Review regularly and reprocess

### Strategy 3: Graceful Degradation

Continue with reduced functionality when parts fail.

```
Full Process:
1. Save to primary database ✓
2. Sync to backup ✗ (failed)
3. Send notification ✓
4. Update analytics ✗ (failed)

Graceful degradation:
- Core function (save) succeeded
- Non-critical functions failed
- Log failures for later retry
- Continue operation
```

**When to use:** When some functionality is more important than others.

### Strategy 4: Circuit Breaker

Stop trying if a service is consistently failing.

```
Normal: Requests go through
        ↓
Multiple failures detected (5 in 60 seconds)
        ↓
Circuit OPEN: Stop all requests to failing service
        ↓
Wait cooldown period (5 minutes)
        ↓
Circuit HALF-OPEN: Try one request
        ↓
Success? → Circuit CLOSED (normal operation)
Failure? → Circuit remains OPEN (wait more)
```

**Benefits:**
- Prevents cascading failures
- Gives failing service time to recover
- Fails fast instead of slow timeouts

### Strategy 5: Compensating Transactions

Undo previous operations if later ones fail.

```
Order Processing:
1. Charge credit card ✓
2. Reserve inventory ✓
3. Create shipping label ✗ (failed)

Compensation:
3. [Failed - nothing to undo]
2. Release inventory reservation
1. Refund credit card charge

Result: Clean state, customer notified
```

**Important:** Design operations to be reversible when possible.

## Monitoring & Alerting

### What to Monitor

**Error Rates:**
- Errors per hour/day
- Error rate percentage
- Error trends over time

**Performance:**
- Execution time per step
- End-to-end latency
- Queue depths

**Health Indicators:**
- API response times
- Authentication status
- Resource utilization

### When to Alert

Not all errors need immediate attention.

| Severity | Examples | Response Time | Alert Method |
|----------|----------|---------------|--------------|
| Critical | Payment failures, data loss | Immediate | SMS, phone |
| High | Main workflow broken | < 1 hour | Slack, email |
| Medium | Non-critical feature down | Same day | Daily digest |
| Low | Minor issues, warnings | Weekly review | Log only |

### Alert Best Practices

**Be specific:**
```
Bad: "Automation failed"
Good: "Lead intake automation failed: CRM API timeout. 3 leads queued for retry. Retry scheduled in 5 minutes."
```

**Include context:**
- What failed
- Why it failed (if known)
- What data was affected
- What action is needed

**Avoid alert fatigue:**
- Group similar errors
- Set appropriate thresholds
- Suppress during known outages

## Logging Best Practices

### What to Log

**Always log:**
- Timestamp (with timezone)
- Operation/action name
- Input data (sanitized)
- Result (success/failure)
- Error message and code
- Execution duration
- Correlation/trace ID

**Example log entry:**
```json
{
  "timestamp": "2024-01-15T14:30:00Z",
  "operation": "create_crm_record",
  "status": "failure",
  "error_code": "RATE_LIMIT",
  "error_message": "API rate limit exceeded",
  "input": {"email": "user@example.com", "name": "John Doe"},
  "duration_ms": 2340,
  "trace_id": "abc-123-def-456",
  "retry_count": 2
}
```

### What NOT to Log

**Never log sensitive data:**
- Passwords
- API keys and secrets
- Full credit card numbers
- Social security numbers
- Personal health information
- Unencrypted personal data

**Sanitize before logging:**
```
# Bad
"Processing payment for card 4111111111111111"

# Good
"Processing payment for card ****1111"
```

## Error Handling Patterns in Practice

### Pattern: Wrapper with Error Handling

```
For each operation:
  Try:
    Execute operation
    Log success
  Catch transient error:
    Retry with backoff
    If max retries exceeded:
      Add to dead letter queue
      Alert if critical
  Catch permanent error:
    Log error details
    Skip to next item
    Alert if critical
  Finally:
    Record execution time
    Update monitoring metrics
```

### Pattern: Pre-Validation

```
Before processing:
  Validate all required fields exist
  Validate data formats correct
  Validate external services available

If validation fails:
  Don''t even start processing
  Return clear error message
  Log validation failure
```

### Pattern: Checkpoints for Long Workflows

```
Long workflow with 10 steps:

After step 3: Save checkpoint
After step 6: Save checkpoint
After step 9: Save checkpoint

If failure at step 7:
  Don''t restart from beginning
  Resume from step 6 checkpoint
  Save state so can continue later
```

## Error Recovery Playbook

When an error occurs:

1. **Identify:** What type of error? Transient or permanent?
2. **Assess:** What''s the impact? How many items affected?
3. **Contain:** Stop further damage if needed
4. **Recover:** Fix the issue or retry failed items
5. **Learn:** Update automation to prevent recurrence
6. **Document:** Record what happened and how it was resolved',

  '## Exercise: Build Robust Error Handling

**Objective:** Implement comprehensive error handling that makes your automations production-ready.

### Part 1: Identify Failure Points

Take the lead intake automation from Section 6.1 and identify every point that could fail:

**Workflow Steps:**
1. Form submission trigger
2. Data validation
3. CRM record creation
4. Lead enrichment (external API)
5. Slack notification
6. Confirmation email

**For each step, document:**

| Step | What Could Fail | Error Type | Likelihood | Impact |
|------|-----------------|------------|------------|--------|
| 1. Form trigger | Platform outage | Transient | Low | High |
| 2. Validation | Invalid email format | Permanent | Medium | Low |
| ... | ... | ... | ... | ... |

### Part 2: Design Error Handling Strategy

For each failure point, define the handling approach:

| Failure | Strategy | Retry? | Alert? | Fallback |
|---------|----------|--------|--------|----------|
| CRM API timeout | Retry with backoff | 3x | If all fail | Dead letter queue |
| Invalid email | Skip, log | No | No | Continue without enrichment |
| ... | ... | ... | ... | ... |

### Part 3: Implement Retry Logic

Build a retry mechanism in your automation platform:

1. **Create a retry counter** (variable or field)
2. **Implement the retry loop:**
   - Attempt operation
   - If failed and retries < max:
     - Increment counter
     - Wait (exponentially longer each time)
     - Loop back
   - If failed and retries >= max:
     - Add to dead letter queue
     - Send alert

**Document your implementation with screenshots.**

### Part 4: Build Dead Letter Queue

Create a system for capturing failed operations:

1. **Create a "Failed Operations" table with columns:**
   - Timestamp
   - Operation name
   - Input data (JSON)
   - Error message
   - Error code
   - Retry count
   - Status (pending_review, retrying, resolved, abandoned)

2. **Build automation to:**
   - Add failed items to the queue
   - Include all relevant context

3. **Build review process:**
   - How will you check the queue?
   - How will you reprocess items?

### Part 5: Create Error Notification System

Set up alerts for critical errors:

1. **Define alert thresholds:**
   - What errors are critical?
   - What rate triggers an alert?

2. **Build notification:**
   - Choose channel (Slack, email, SMS)
   - Include: error type, count, affected items, suggested action

3. **Test the alert:**
   - Trigger a test error
   - Verify notification received
   - Verify information is useful

### Part 6: Test Error Scenarios

Force failures and verify your handling works:

**Test 1: API Timeout**
- Simulate by using invalid API endpoint
- Expected: Retry 3 times, then dead letter queue

**Test 2: Invalid Data**
- Submit form with invalid email
- Expected: Validation fails, logged, continues

**Test 3: Partial Failure**
- Make one step fail in middle of workflow
- Expected: Earlier steps succeed, failure logged, alert sent

**Test 4: Multiple Rapid Failures**
- Trigger 5 errors in 1 minute
- Expected: Grouped alert, not 5 separate alerts

### Part 7: Document Recovery Procedures

Create a runbook for handling failures:

```
# Error Recovery Runbook

## CRM API Failures
1. Check API status page
2. If outage: Wait for resolution
3. If our issue: Check credentials
4. Reprocess from dead letter queue

## Invalid Data Errors
1. Review failed records
2. Identify pattern
3. Fix source (form validation?)
4. Manually process or abandon

## Cascade Failures
1. Pause automation
2. Assess impact
3. Fix root cause
4. Resume and reprocess
```

**Deliverables:**
- Failure point analysis table
- Error handling strategy document
- Working retry mechanism
- Functional dead letter queue
- Alert system (tested)
- Recovery runbook

**Success Criteria:**
- All failure points identified and documented
- Retry mechanism handles transient errors
- Dead letter queue captures permanent failures
- Alerts fire for critical errors
- Recovery process is documented and tested',

  70,
  true,
  (SELECT id FROM quizzes WHERE title = 'Error Handling Quiz')
FROM modules m
WHERE m.slug = 'automation-fundamentals';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Error Handling Best Practices',
  'https://www.youtube.com/watch?v=X8XnAiZqe5w',
  'video',
  1
FROM sections WHERE slug = 'error-handling'
UNION ALL
SELECT
  id,
  'Building Resilient Automations',
  'https://www.youtube.com/watch?v=LDBctyb6Akg',
  'video',
  2
FROM sections WHERE slug = 'error-handling';

-- ============================================================================
-- SECTION 6.4: Testing & Debugging Automation Workflows
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Testing and Debugging Quiz'), 1,
'Why is testing automation workflows important?',
'["It''s not important", "To catch errors before they affect real data and operations", "To waste time", "Only for large companies"]',
1,
'Testing catches bugs before production, preventing data corruption, lost operations, and business impact.'),

((SELECT id FROM quizzes WHERE title = 'Testing and Debugging Quiz'), 2,
'What is the difference between testing and debugging?',
'["No difference", "Testing verifies it works correctly, debugging fixes issues found", "Debugging is faster", "Testing is easier"]',
1,
'Testing checks if things work as expected. Debugging is the process of finding and fixing problems.'),

((SELECT id FROM quizzes WHERE title = 'Testing and Debugging Quiz'), 3,
'What should you test before deploying an automation?',
'["Nothing", "Happy path, edge cases, error scenarios, and integration points", "Only happy path", "Ask users to test"]',
1,
'Comprehensive testing includes normal operations, edge cases, errors, and how systems interact.'),

((SELECT id FROM quizzes WHERE title = 'Testing and Debugging Quiz'), 4,
'What is a "test case"?',
'["A lawsuit", "A specific scenario with defined input and expected output", "A storage container", "An error"]',
1,
'A test case defines: what you''re testing, what input to use, and what result you expect.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'testing-debugging',
  'Testing & Debugging Automation Workflows',
  4,
  'Intermediate',
  '# Testing & Debugging Automation Workflows

"It works on my machine" is not good enough. Automations that aren''t properly tested will fail in production - usually at the worst possible time. Proper testing gives you confidence and helps you sleep at night.

## Why Testing Matters

**Without testing:**
- Bugs discovered by users (embarrassing)
- Data corruption (expensive to fix)
- Lost transactions (money lost)
- Wasted time on production firefighting
- Reputation damage

**With testing:**
- Bugs caught before users see them
- Confidence in deployments
- Faster development (catch issues early)
- Documentation of expected behavior
- Easier debugging when issues occur

## Types of Testing

### 1. Unit Testing

Test individual components in isolation.

```
Example: Test email validation function alone
Input: "user@example.com"
Expected: Valid = true

Input: "not-an-email"
Expected: Valid = false

Input: ""
Expected: Valid = false
```

**Good for:** Catching issues in specific logic early.

### 2. Integration Testing

Test how components work together.

```
Example: Test form → CRM integration
1. Submit test form
2. Verify CRM record created
3. Verify all fields mapped correctly
4. Verify no duplicate records
```

**Good for:** Catching issues in connections between systems.

### 3. End-to-End Testing

Test the entire workflow from start to finish.

```
Example: Complete lead workflow
1. Submit form on website
2. Verify CRM record created
3. Verify email sent to lead
4. Verify Slack notification received
5. Verify all data correct at each step
```

**Good for:** Verifying the complete user/business flow works.

### 4. Regression Testing

Verify that new changes don''t break existing functionality.

```
After adding new feature:
1. Run all existing tests
2. All should still pass
3. If something breaks, the new change caused it
```

**Good for:** Maintaining stability as you evolve the automation.

## What to Test

### Happy Path

The normal, expected scenario. Most common use case.

```
Test: Normal lead submission
Input: Valid name, valid email, selects "Consulting"
Expected:
- CRM record created
- Email sent
- Slack notification received
- No errors
```

### Edge Cases

Unusual but valid scenarios that might be handled differently.

```
Edge cases to test:
- Very long name (100+ characters)
- International characters (José, 日本語)
- Email with plus sign (user+tag@example.com)
- Multiple submissions by same person
- Form submitted at midnight (timezone issues?)
- Submission during API maintenance window
```

### Error Scenarios

Things that should fail - verify they fail gracefully.

```
Error tests:
- Missing required fields
- Invalid email format
- API unavailable (mock the failure)
- Rate limit exceeded
- Duplicate submission
- Malicious input (SQL injection, XSS)
```

### Boundary Conditions

Test at the exact edges of conditions.

```
If rule is "amount > 100 gets discount":
Test:
- amount = 99 → No discount ✓
- amount = 100 → No discount ✓
- amount = 100.01 → Discount ✓
- amount = 101 → Discount ✓
```

### Integration Points

Where your automation connects to external systems.

```
For each integration:
- Does authentication work?
- Does data map correctly?
- What happens if service is slow?
- What happens if service is down?
- Are there rate limits?
```

## Creating Test Cases

### Test Case Structure

```
Test ID: TC-001
Title: Valid lead creates CRM record
Preconditions: CRM is accessible, no existing record for test email
Steps:
  1. Submit form with valid data
  2. Wait 30 seconds
  3. Check CRM for new record
Input Data:
  - Name: "Test User"
  - Email: "test-unique-123@example.com"
  - Service: "Consulting"
Expected Result:
  - CRM record exists with matching data
  - Status = "New"
  - Created timestamp within last minute
Actual Result: [Fill after testing]
Pass/Fail: [Fill after testing]
```

### Test Data Best Practices

**Use realistic data:**
```
# Good
Name: "Sarah Johnson"
Email: "sarah.johnson@acmecorp.com"

# Bad
Name: "asdf"
Email: "test@test.com"
```

**Make test data identifiable:**
```
# Easy to identify and clean up
Email: "test-20240115-001@example.com"
Name: "TEST - John Smith"
```

**Cover variety:**
```
Test set should include:
- Short inputs and long inputs
- Special characters
- International formats
- Common and uncommon values
```

## Debugging Workflow

When something goes wrong, follow this systematic approach:

### Step 1: Reproduce the Issue

Can you make it happen again?

```
Questions:
- Does it fail every time?
- Does it fail only with certain data?
- Does it fail at certain times?
- Can you reproduce in test environment?
```

### Step 2: Isolate the Problem

Where exactly does it break?

```
Method: Binary search
1. Check if data reaches step 5 → No
2. Check if data reaches step 3 → Yes
3. Check if data reaches step 4 → Yes
4. Problem is between step 4 and 5
```

### Step 3: Check Logs

What do the logs tell you?

```
Look for:
- Error messages (exact text)
- Timestamps (when did it fail?)
- Input data (what was being processed?)
- Stack traces (where in code?)
```

### Step 4: Verify Assumptions

Question everything you think is true.

```
Common false assumptions:
- "The API is working" → Check it
- "The data is valid" → Inspect it
- "This step succeeded" → Verify it
- "Nothing changed" → Check recent updates
```

### Step 5: Check External Dependencies

Is the problem in your automation or elsewhere?

```
Check:
- API status pages
- Service health dashboards
- Recent platform updates
- Credential expiration
- Rate limit status
```

### Step 6: Create Minimal Example

Strip down to the simplest case that still fails.

```
If complex workflow fails:
1. Remove steps until you find the failing one
2. Simplify input until you find the problem data
3. Reduce to the simplest reproduction
4. Fix that, then rebuild
```

### Step 7: Fix and Verify

Apply the fix and test thoroughly.

```
1. Fix the issue
2. Test the specific case that failed
3. Test related cases
4. Run regression tests
5. Deploy carefully
6. Monitor after deployment
```

## Common Issues and Solutions

### "It worked yesterday"

Something changed. Find out what.

```
Check:
- API updates or deprecations
- Platform updates
- Credential changes
- Data format changes
- Third-party service changes
```

### "Works sometimes, fails sometimes"

Intermittent issues are often:

```
Possible causes:
- Race condition (timing issue)
- Timeout on slow responses
- Rate limiting
- Load-dependent issues
- Data-dependent issues (certain values fail)
```

### "Wrong data in output"

Mapping or transformation issue.

```
Debug by:
1. Log data at each step
2. Find where it goes wrong
3. Check field mappings
4. Check data transformations
5. Look for type conversions
```

### "Nothing happens"

Trigger not firing or filter blocking.

```
Check:
- Is trigger configured correctly?
- Does trigger have required permissions?
- Is there a filter blocking execution?
- Is the automation turned on?
- Check automation history/logs
```

### "Too slow"

Performance issue.

```
Analyze:
- Which steps take longest?
- Are operations running sequentially when they could be parallel?
- Is there unnecessary data processing?
- Are you hitting rate limits and retrying?
```

## Testing Checklist

Before deploying any automation:

```
□ Happy path tested (at least 3 scenarios)
□ Edge cases tested (empty fields, special chars, boundaries)
□ Error scenarios tested (invalid data, API failures)
□ All conditional branches tested
□ Integration points verified
□ Performance acceptable under expected load
□ Error handling verified
□ Logging captures necessary info
□ Monitoring and alerts configured
□ Rollback plan documented
□ Test data cleaned up
```

## Setting Up Test Environments

### Development/Sandbox Environment

Separate environment for building and testing.

```
Best practices:
- Use test API keys (not production)
- Use test databases (not production data)
- Mark test data clearly
- Automatic cleanup of test data
```

### Staging Environment

Production-like environment for final testing.

```
Should have:
- Same configuration as production
- Recent copy of production data (anonymized)
- Same integrations (test credentials)
- Same monitoring/logging
```

### Production Testing

Careful testing in live environment.

```
Techniques:
- Feature flags (enable for subset of users)
- Canary deployments (small percentage first)
- Synthetic tests (fake data through real system)
- Monitor closely after deployment
```',

  '## Exercise: Comprehensive Testing & Debugging

**Objective:** Learn to test and debug automation workflows systematically, ensuring reliable production deployments.

### Part 1: Create a Test Plan

For your lead intake automation, create a comprehensive test plan.

**Test Categories:**

**Happy Path Tests (5-10 tests):**
| Test ID | Description | Input | Expected Output |
|---------|-------------|-------|-----------------|
| HP-001 | Standard lead submission | Valid name, email, company | CRM record, email sent, Slack notified |
| HP-002 | Lead with phone number | All fields + phone | Same + phone in CRM |
| ... | ... | ... | ... |

**Edge Case Tests (5-10 tests):**
| Test ID | Description | Input | Expected Output |
|---------|-------------|-------|-----------------|
| EC-001 | Very long company name | 200 character name | Truncated or handled gracefully |
| EC-002 | International characters | "José García" | Correctly encoded in CRM |
| ... | ... | ... | ... |

**Error Scenario Tests (5-10 tests):**
| Test ID | Description | Input | Expected Output |
|---------|-------------|-------|-----------------|
| ER-001 | Invalid email format | "not-an-email" | Validation error, no CRM record |
| ER-002 | CRM API down | Valid data, mock API failure | Error logged, retry queued |
| ... | ... | ... | ... |

### Part 2: Execute Your Test Plan

Run every test case in your plan:

1. Set up test environment
2. Prepare test data
3. Execute each test
4. Record actual results
5. Compare to expected
6. Mark pass/fail

**Results Template:**
| Test ID | Status | Notes |
|---------|--------|-------|
| HP-001 | PASS | |
| HP-002 | FAIL | Phone number missing from CRM |
| ... | ... | ... |

### Part 3: Debug Failed Tests

For each failed test:

1. **Document the failure:**
   - What was expected?
   - What actually happened?
   - Error messages (if any)

2. **Apply debugging workflow:**
   - Reproduce the issue
   - Isolate to specific step
   - Check logs
   - Identify root cause

3. **Fix the issue:**
   - Make the change
   - Retest
   - Verify fix doesn''t break other tests

### Part 4: Forced Error Testing

Intentionally break things to test error handling:

**Test 1: API Timeout**
```
Method: Use an invalid API endpoint or add artificial delay
Expected behavior: Retry logic activates, eventually fails gracefully
Verify: Error logged, alert sent, dead letter queue populated
```

**Test 2: Invalid Data**
```
Method: Submit malformed data (wrong types, missing fields)
Expected behavior: Validation catches it before processing
Verify: Clear error message, no partial data created
```

**Test 3: Network Failure**
```
Method: Disconnect network mid-process (if possible) or mock failure
Expected behavior: Handles gracefully, can resume
Verify: State is recoverable, no data loss
```

**Test 4: Rate Limits**
```
Method: Trigger many operations rapidly
Expected behavior: Rate limiting kicks in, backoff works
Verify: Eventually completes, no permanent failures
```

### Part 5: Integration Testing

Test each external connection:

**For each integration (CRM, Email, Slack, etc.):**

| Integration | Test | Method | Result |
|-------------|------|--------|--------|
| CRM | Create record | Submit lead, check CRM | |
| CRM | Duplicate handling | Submit same lead twice | |
| Email | Delivery | Submit lead, check inbox | |
| Email | Formatting | Check email renders correctly | |
| Slack | Notification | Submit lead, check channel | |
| Slack | Formatting | Verify message format | |

### Part 6: Performance Testing

Test under realistic load:

**Test 1: Normal Load**
- Submit 10 leads over 1 hour
- All should process correctly
- Measure average processing time

**Test 2: Peak Load**
- Submit 10 leads in 5 minutes
- All should eventually process
- Note any delays or queuing

**Test 3: Stress Test**
- Submit 50 leads in 10 minutes
- Identify breaking point
- Note behavior under stress

**Record:**
| Scenario | Leads | Time | Successes | Failures | Avg Processing Time |
|----------|-------|------|-----------|----------|---------------------|
| Normal | 10 | 60min | | | |
| Peak | 10 | 5min | | | |
| Stress | 50 | 10min | | | |

### Part 7: Create Regression Test Suite

Build a reusable set of tests:

1. **Select core tests** (8-10 that must always pass)
2. **Automate if possible** (scheduled test runs)
3. **Document clearly** so anyone can run them
4. **Commit to running before each change**

**Regression Suite:**
| Priority | Test ID | Description | Last Run | Result |
|----------|---------|-------------|----------|--------|
| Critical | HP-001 | Standard lead | | |
| Critical | ER-002 | API failure handling | | |
| High | EC-003 | International characters | | |
| ... | ... | ... | ... | ... |

**Deliverables:**
- Complete test plan (20+ test cases)
- Test execution results
- Debug documentation for any failures
- Forced error test results
- Integration test results
- Performance test results
- Regression test suite

**Success Criteria:**
- Comprehensive test plan covering all scenarios
- All tests executed and documented
- All failures investigated and fixed
- Error handling verified through forced failures
- Regression suite ready for future use',

  60,
  true,
  (SELECT id FROM quizzes WHERE title = 'Testing and Debugging Quiz')
FROM modules m
WHERE m.slug = 'automation-fundamentals';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Testing Automation Workflows',
  'https://www.youtube.com/watch?v=2M8g9jkWR9Q',
  'video',
  1
FROM sections WHERE slug = 'testing-debugging'
UNION ALL
SELECT
  id,
  'Debugging Zapier Automations',
  'https://www.youtube.com/watch?v=Cj4fXzVvzwI',
  'video',
  2
FROM sections WHERE slug = 'testing-debugging';

-- ============================================================================
-- SECTION 6.5: Optimization & Performance
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Optimization Quiz'), 1,
'Why optimize automations?',
'["To show off", "To reduce cost, improve speed, and increase reliability", "It''s not necessary", "Only for large companies"]',
1,
'Optimization reduces operational costs, makes systems faster, and often makes them more reliable too.'),

((SELECT id FROM quizzes WHERE title = 'Optimization Quiz'), 2,
'What is the first step in optimization?',
'["Change everything", "Measure current performance to identify bottlenecks", "Add more servers", "Use faster tools"]',
1,
'Always measure first - you need to know where the problems are before you can fix them.'),

((SELECT id FROM quizzes WHERE title = 'Optimization Quiz'), 3,
'When should you run operations in parallel instead of sequentially?',
'["Always", "When operations don''t depend on each other", "Never", "Only for large datasets"]',
1,
'Parallel execution works when operations are independent - if B doesn''t need A''s output, run simultaneously.'),

((SELECT id FROM quizzes WHERE title = 'Optimization Quiz'), 4,
'What is caching and when should you use it?',
'["Deleting data", "Storing results to avoid re-computing, use for expensive repeated operations", "A payment method", "Encryption"]',
1,
'Caching saves computed results so you don''t repeat expensive operations for the same inputs.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'optimization-performance',
  'Optimization & Performance',
  5,
  'Advanced',
  '# Optimization & Performance

A working automation isn''t necessarily a good automation. Good automations run fast, cost little, and scale smoothly. Optimization is about making your automations better without changing what they do.

## Why Optimize?

**Cost Reduction:**
- Fewer API calls = lower platform costs
- Less compute time = lower processing costs
- Efficient prompts = lower AI costs

**Speed Improvement:**
- Faster processing = better user experience
- Quicker responses = happier customers
- Reduced latency = more throughput

**Reliability Enhancement:**
- Simpler automations = fewer failure points
- Less strain on systems = less likely to hit limits
- Efficient use of resources = more headroom

**Scalability:**
- Handle more volume with same resources
- Grow without proportional cost increase
- Avoid redesigning as you scale

## The Optimization Mindset

### Rule 1: Measure First

**Don''t guess where the problems are. Measure.**

```
Before optimizing:
1. Measure current performance
2. Identify the slowest/most expensive parts
3. Focus efforts there

You might be optimizing the wrong thing!
```

### Rule 2: Optimize the Bottleneck

The slowest step limits overall speed.

```
Workflow timing:
Step 1: 0.5 seconds
Step 2: 0.5 seconds
Step 3: 10 seconds  ← Bottleneck
Step 4: 0.5 seconds
Step 5: 0.5 seconds
Total: 12 seconds

If you optimize Step 1 to 0.1 seconds:
Total: 11.6 seconds (barely better)

If you optimize Step 3 to 2 seconds:
Total: 4 seconds (much better!)
```

### Rule 3: Good Enough is Good Enough

**Know when to stop.**

```
When to stop optimizing:
- Cost savings < optimization effort cost
- Performance is already "good enough"
- Further optimization adds significant complexity
- Reliability would suffer
```

## What to Measure

### Execution Time

**Per-step timing:**
```
Step 1: Get data       - 200ms
Step 2: Validate       - 50ms
Step 3: API call       - 1500ms  ← Slow!
Step 4: Transform      - 100ms
Step 5: Save           - 300ms
Total: 2150ms
```

**End-to-end latency:**
- From trigger to completion
- Include any queue wait time

### Cost Metrics

**Per-operation costs:**
```
Each workflow run:
- Platform cost: $0.01
- API calls: $0.005
- AI tokens: $0.02
Total per run: $0.035

Daily volume: 1000 runs
Daily cost: $35
Monthly cost: ~$1000
```

### Throughput

**Operations per time period:**
```
Current: 100 items/hour
After optimization: 400 items/hour
4x improvement!
```

### Error Rate

**Failures per operations:**
```
Before: 5 failures per 100 runs (5%)
After: 1 failure per 100 runs (1%)
```

## Optimization Strategies

### Strategy 1: Parallel Execution

Run independent operations simultaneously instead of one after another.

```
Sequential (slow):
Get CRM data → Get Email data → Get Slack data → Process
Time: 500ms + 400ms + 300ms + 100ms = 1300ms

Parallel (fast):
Get CRM data    ↘
Get Email data  → Process
Get Slack data  ↗
Time: max(500ms, 400ms, 300ms) + 100ms = 600ms

54% faster!
```

**When to parallelize:**
- Operations don''t depend on each other
- Order doesn''t matter for correctness
- Platform supports parallel execution

### Strategy 2: Batch Processing

Process multiple items together instead of one at a time.

```
Individual (slow):
For each of 100 items:
  API call to create record
100 API calls × 200ms = 20 seconds

Batched (fast):
Collect 100 items
One API call to create all
1 API call × 500ms = 0.5 seconds

40x faster!
```

**Batch opportunities:**
- Database inserts/updates
- API calls that support bulk operations
- File operations
- Notifications

### Strategy 3: Caching

Store results to avoid recomputing or refetching.

```
Without caching:
User A requests company info → API call (500ms)
User B requests company info → API call (500ms)
User C requests company info → API call (500ms)
Total: 1500ms

With caching:
User A requests company info → API call (500ms), cache result
User B requests company info → Cache hit (10ms)
User C requests company info → Cache hit (10ms)
Total: 520ms

65% faster!
```

**When to cache:**
- Data doesn''t change frequently
- Same data requested multiple times
- Fetching is expensive (slow or costly)

**Cache considerations:**
- How long before data goes stale?
- How much memory/storage for cache?
- How to invalidate when data changes?

### Strategy 4: Reduce API Calls

Every API call has overhead. Minimize them.

**Request all fields at once:**
```
Bad:
GET /contact/123?fields=name
GET /contact/123?fields=email
GET /contact/123?fields=company
3 API calls

Good:
GET /contact/123?fields=name,email,company
1 API call
```

**Use bulk endpoints:**
```
Bad:
GET /contact/1
GET /contact/2
GET /contact/3
3 API calls

Good:
GET /contacts?ids=1,2,3
1 API call
```

### Strategy 5: Optimize AI Usage

AI calls are often the most expensive part.

**Use cheaper models for simple tasks:**
```
Task: Extract name from email
Before: GPT-4 at $0.03/call
After: GPT-4o-mini at $0.001/call
30x cheaper!
```

**Shorten prompts:**
```
Before: 500 tokens prompt
After: 200 tokens prompt (same result)
60% cheaper!
```

**Batch AI requests:**
```
Before: Analyze 10 leads, 10 API calls
After: Analyze all 10 in one call
10x fewer calls
```

### Strategy 6: Filter Early

Don''t process what you don''t need.

```
Before:
1. Get all 1000 records
2. For each record:
   - Enrich with API
   - Transform
   - Check if relevant
   - If relevant: save
Result: Processed 1000, saved 50

After:
1. Get only relevant records (50)
2. For each record:
   - Enrich with API
   - Transform
   - Save
Result: Processed 50, saved 50

20x less processing!
```

### Strategy 7: Schedule Non-Urgent Work

Batch non-time-sensitive operations for off-peak processing.

```
Real-time (expensive):
Each lead → Immediately enrich → Immediately analyze

Scheduled (cheaper):
Each lead → Queue
Every hour → Batch enrich queued leads → Batch analyze
```

**Benefits:**
- Can use batch APIs
- Lower rate limiting issues
- Run during cheaper periods
- Reduce peak load

### Strategy 8: Use Webhooks Over Polling

Webhooks push data to you. Polling requires you to repeatedly ask.

```
Polling (inefficient):
Every 5 minutes: "Any new orders?"
Every 5 minutes: "Any new orders?"
Every 5 minutes: "Any new orders?"
... (288 API calls per day, mostly returning "no")

Webhook (efficient):
Service pushes: "New order: #123"
Service pushes: "New order: #124"
Only 2 API calls for 2 actual orders
```

### Strategy 9: Eliminate Redundancy

Don''t duplicate work or data.

```
Redundant:
Step 1: Fetch customer data
Step 3: Fetch customer data again
Step 7: Fetch customer data again

Optimized:
Step 1: Fetch customer data, store in variable
Step 3: Use variable
Step 7: Use variable
```

### Strategy 10: Right-Size Resources

Don''t over-provision or under-provision.

```
Under-provisioned: Hitting rate limits, slow
Over-provisioned: Paying for unused capacity

Right-sized: Enough capacity for peak + buffer
```

## Optimization Anti-Patterns

**Premature optimization:**
Don''t optimize until it works correctly. "Working and slow" is better than "broken and fast."

**Optimizing the wrong thing:**
That 50ms step doesn''t matter when another step takes 5 seconds.

**Over-engineering:**
Simple solution that''s 2x slower might be better than complex solution that''s unmaintainable.

**Sacrificing reliability:**
Don''t remove error handling or retries to save time.

**One-time optimization:**
Performance degrades. Monitor and re-optimize regularly.

## Measuring Improvement

**Before and after comparison:**
```
Metric          | Before | After  | Improvement
----------------|--------|--------|------------
Execution time  | 30s    | 8s     | 73% faster
Cost per run    | $0.05  | $0.02  | 60% cheaper
Throughput      | 100/hr | 400/hr | 4x higher
Error rate      | 3%     | 1%     | 67% lower
```

**ROI calculation:**
```
Optimization effort: 10 hours
Hourly rate: $100
Investment: $1,000

Savings per month: $500
Payback period: 2 months
12-month ROI: 500% ($6000 saved - $1000 invested)
```

## Optimization Checklist

Before optimizing:
```
□ Measured current performance
□ Identified bottlenecks
□ Quantified potential savings
□ Estimated optimization effort
□ Calculated ROI
```

Optimization techniques to consider:
```
□ Parallelize independent operations
□ Batch similar operations
□ Cache repeated lookups
□ Reduce API calls
□ Use cheaper AI models
□ Shorten prompts
□ Filter data early
□ Schedule non-urgent work
□ Use webhooks over polling
□ Eliminate redundant operations
```

After optimizing:
```
□ Measured improvement
□ Verified no functionality broken
□ Updated documentation
□ Set up ongoing monitoring
```',

  '## Exercise: Optimize an Automation

**Objective:** Apply optimization techniques to make your automations faster, cheaper, and more reliable.

### Part 1: Establish Baseline

Choose an existing automation (or use your lead intake automation) and measure current performance.

**Execution Time:**
| Step | Description | Duration |
|------|-------------|----------|
| 1 | Trigger | ms |
| 2 | Validation | ms |
| 3 | CRM Creation | ms |
| 4 | Enrichment | ms |
| 5 | Email | ms |
| 6 | Slack | ms |
| **Total** | | **ms** |

**Cost Analysis:**
| Component | Cost per Run | Runs per Month | Monthly Cost |
|-----------|--------------|----------------|--------------|
| Platform | $ | | $ |
| API calls | $ | | $ |
| AI (if any) | $ | | $ |
| **Total** | $ | | **$** |

**Throughput:**
- Current capacity: ___ runs per hour
- Current volume: ___ runs per day

### Part 2: Identify Optimization Opportunities

Analyze each step for improvement potential:

| Step | Current Time | Opportunity | Technique | Potential Saving |
|------|--------------|-------------|-----------|------------------|
| CRM Creation | 1500ms | Use batch API | Batching | 80% |
| Enrichment | 2000ms | Cache results | Caching | 70% |
| Email + Slack | 1000ms | Run parallel | Parallel | 50% |

**Prioritize by impact:**
1. Highest impact optimization: ___
2. Second highest: ___
3. Third highest: ___

### Part 3: Implement Optimizations

Apply at least 3 optimization techniques:

**Optimization 1: _______________**
- Current: [describe]
- Change: [describe]
- Implementation: [steps taken]
- Result: [measured improvement]

**Optimization 2: _______________**
- Current: [describe]
- Change: [describe]
- Implementation: [steps taken]
- Result: [measured improvement]

**Optimization 3: _______________**
- Current: [describe]
- Change: [describe]
- Implementation: [steps taken]
- Result: [measured improvement]

### Part 4: Measure Improvements

Re-measure after optimizations:

**Execution Time (After):**
| Step | Before | After | Improvement |
|------|--------|-------|-------------|
| 1 | ms | ms | % |
| 2 | ms | ms | % |
| ... | | | |
| **Total** | **ms** | **ms** | **%** |

**Cost Analysis (After):**
| Component | Before | After | Savings |
|-----------|--------|-------|---------|
| Platform | $ | $ | $ |
| API calls | $ | $ | $ |
| AI | $ | $ | $ |
| **Total** | **$** | **$** | **$** |

**Throughput (After):**
- Before: ___ runs per hour
- After: ___ runs per hour
- Improvement: ___x

### Part 5: Cost-Benefit Analysis

For each optimization:

| Optimization | Time to Implement | Monthly Savings | Payback Period |
|--------------|-------------------|-----------------|----------------|
| 1. ___ | hours | $ | months |
| 2. ___ | hours | $ | months |
| 3. ___ | hours | $ | months |

**Questions to answer:**
- Which optimization had the best ROI?
- Any optimizations not worth the effort?
- What would you do differently?

### Part 6: AI Optimization (if applicable)

If your automation uses AI, optimize it:

**Current AI Usage:**
- Model: ___
- Prompt tokens: ___
- Cost per call: $___

**Optimization attempts:**

1. **Cheaper model test:**
   - Try: GPT-4o-mini instead of GPT-4
   - Quality comparison: [acceptable / not acceptable]
   - Cost savings: ___

2. **Shorter prompt:**
   - Original tokens: ___
   - Shortened tokens: ___
   - Quality maintained? [yes / no]

3. **Batch processing:**
   - Before: ___ separate calls
   - After: ___ batched calls
   - Savings: ___

### Part 7: Create Optimization Playbook

Document reusable optimization strategies:

```
# Optimization Playbook

## Quick Wins (< 1 hour to implement)
1. _______________
2. _______________
3. _______________

## Medium Effort (1-4 hours)
1. _______________
2. _______________

## Major Optimizations (4+ hours)
1. _______________

## Monitoring Checklist
□ Weekly: Check execution times
□ Weekly: Check error rates
□ Monthly: Review costs
□ Monthly: Compare to baseline
```

**Deliverables:**
- Baseline measurements documented
- At least 3 optimizations implemented
- Before/after measurements compared
- Cost-benefit analysis completed
- Optimization playbook created

**Success Criteria:**
- Measurable improvement in at least one metric
- Either faster execution OR lower cost OR both
- All functionality still works correctly
- Documentation updated
- Playbook ready for future use',

  65,
  true,
  (SELECT id FROM quizzes WHERE title = 'Optimization Quiz')
FROM modules m
WHERE m.slug = 'automation-fundamentals';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'Optimizing Automation Workflows',
  'https://www.youtube.com/watch?v=5rLKTp0GGxA',
  'video',
  1
FROM sections WHERE slug = 'optimization-performance'
UNION ALL
SELECT
  id,
  'Performance Best Practices for Automation',
  'https://www.youtube.com/watch?v=aP-c3WBYfPE',
  'video',
  2
FROM sections WHERE slug = 'optimization-performance';
