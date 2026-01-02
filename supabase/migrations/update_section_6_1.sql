-- ============================================================================
-- UPDATE SECTION 6.1: Triggers, Actions, and Conditions
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, remove any existing questions 5-8 to allow clean re-runs, then add 4 more to reach 8 total
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Triggers and Actions Quiz')
AND order_index IN (5, 6, 7, 8);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Triggers and Actions Quiz'), 5,
'How do triggers relate to the 4-layer automation model from Module 2?',
'["Triggers are unrelated to the 4-layer model", "Triggers are the primary component of the trigger layer, initiating all automation workflows", "Triggers only matter for the output layer", "The 4-layer model does not include triggers"]',
1,
'The trigger layer from Module 2 is where automation begins. Understanding trigger types helps you design the first layer effectively.'),

((SELECT id FROM quizzes WHERE title = 'Triggers and Actions Quiz'), 6,
'When designing an action sequence, how does I-T-O thinking from Module 2 apply?',
'["I-T-O does not apply to actions", "Each action is an I-T-O operation where the output of one action becomes input for the next", "Only the final action uses I-T-O", "Actions replace I-T-O thinking"]',
1,
'Actions chain together as I-T-O operations. The output of creating a CRM record (the record ID) becomes input for sending an email referencing that record.'),

((SELECT id FROM quizzes WHERE title = 'Triggers and Actions Quiz'), 7,
'What is idempotency and why does it matter for automation actions?',
'["A type of error", "The property where running an action multiple times produces the same result as running it once, preventing duplicate records", "A performance optimization", "A testing methodology"]',
1,
'Idempotent actions are safe to retry. If your automation retries after a partial failure, idempotent actions prevent creating duplicate records or sending duplicate emails.'),

((SELECT id FROM quizzes WHERE title = 'Triggers and Actions Quiz'), 8,
'How should you handle the relationship between conditions and the logic layer from Module 2?',
'["Conditions are not part of the logic layer", "Conditions implement the logic layer, making decisions about routing, filtering, and transformation", "Only use conditions in the output layer", "Conditions replace the need for a logic layer"]',
1,
'The logic layer from Module 2 is where decisions happen. Conditions are the implementation mechanism, determining which path data takes through your automation.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Triggers, Actions, and Conditions

Every automation has three core components: what starts it (trigger), what it does (actions), and what decisions it makes (conditions). These map directly to Module 2''s 4-layer model: triggers are the trigger layer, conditions implement the logic layer, and actions form the execution layer.

## Definitions

**Trigger**: The event that initiates an automation workflow. Without a trigger, nothing happens. Triggers answer the question "when does this run?"

**Action**: An operation that your automation performs. Actions are the "what happens" after the trigger fires. Actions execute in the order you define.

**Condition**: A decision point that determines which path the automation takes. Conditions evaluate to true or false and enable branching logic.

**Event-Based Trigger**: A trigger that fires immediately when something happens, such as a form submission or new email arrival.

**Scheduled Trigger**: A trigger that fires at predetermined times, such as daily at 9am or every Monday morning.

**Webhook Trigger**: A trigger where external services push data directly to your automation endpoint in real-time.

**Polling Trigger**: A trigger that periodically checks for changes, such as checking for new files every 15 minutes.

**Idempotency**: The property where executing an operation multiple times produces the same result as executing it once. Critical for safe retries.

**Atomic Action**: An action that does one thing completely or not at all. Atomic actions are easier to debug and retry.

## Understanding Triggers

A trigger is the event that starts your automation. It connects directly to the trigger layer from Module 2''s 4-layer model.

### Types of Triggers

**Event-Based Triggers (Instant)**

Something happens and the automation runs immediately. These are the most responsive triggers.

Examples of event-based triggers include form submissions, new emails arriving, database records being created, payments completing, files being uploaded, and customer signups.

Use event-based triggers when immediate response matters. A new lead should get a response now, not in 15 minutes.

**Scheduled Triggers (Time-Based)**

Automation runs at specific, predictable times regardless of other events.

Examples include daily reports at 9am, weekly summaries on Monday morning, monthly invoice generation on the first of the month, status checks every 15 minutes, and quarterly analytics reports.

Use scheduled triggers for recurring tasks, batch processing, or when timing is more important than immediacy.

**Webhook Triggers (Push-Based)**

External services push data directly to your automation endpoint. This is the most efficient method for real-time integrations.

Examples include Stripe pushing payment notifications, Shopify sending order details, GitHub sending commit information, and Slack sending message events.

Advantages of webhooks: real-time data delivery, no polling overhead, lower API usage, and more reliable than periodic checking.

**Manual Triggers (On-Demand)**

A person explicitly starts the automation by clicking a button or making a request.

Examples include a "Generate Report" button, a "Send Reminder" action, a "Process Selected Items" trigger, and admin approval clicks.

Use manual triggers for on-demand tasks, one-off operations, or when human judgment should initiate the process.

**Polling Triggers (Check Periodically)**

Automation checks for changes at regular intervals and triggers when changes are detected.

Examples include checking an email inbox every 5 minutes, looking for new files in a folder every hour, and scanning a database for updates every 10 minutes.

Trade-offs of polling: simpler to set up than webhooks but may miss time-sensitive events, uses more API calls, and introduces delay between event and detection.

### Choosing the Right Trigger

For new customer signups, use event-based triggers for immediate response.

For daily sales reports, use scheduled triggers to run at a consistent time.

For payment notifications, use webhook triggers for real-time updates.

For on-demand invoice generation, use manual triggers.

For checking competitor prices, use polling triggers at appropriate intervals.

## Understanding Actions

An action is what your automation does. It implements the execution layer from Module 2''s 4-layer model.

### Types of Actions

**Data Operations**

Create actions add new records such as CRM contacts, database rows, or files.

Read actions retrieve existing data such as looking up a customer or fetching order details.

Update actions modify existing records such as changing status or updating field values.

Delete actions remove records such as cleaning up old data or removing duplicates.

**Communication Actions**

Send email, post to Slack or Teams, send SMS, push notifications, and create calendar events.

**Processing Actions**

Transform data formats, calculate values, parse text, generate documents, and run AI analysis. These connect to the capability tiers from Module 3.

**Integration Actions**

Call external APIs, upload or download files, sync between systems, and trigger other automations.

**Control Flow Actions**

Wait or delay for specified periods, branch based on conditions, loop through items, and stop or terminate workflows.

### Action Best Practices

**Make actions atomic.** Each action should do one thing well.

Good pattern: Action 1 creates the CRM record, Action 2 sends the welcome email, Action 3 notifies the sales team. Each action has single responsibility.

Problematic pattern: One action that creates the record AND sends the email AND notifies the team. When this fails, you cannot tell which part failed.

**Make actions idempotent.** Safe to run twice without creating problems.

Idempotent examples: "Update record where ID equals 123" and "Set status to processed." Running these multiple times produces the same result.

Non-idempotent examples: "Create new record" and "Increment counter." Running these multiple times creates duplicates or inflates values.

**Order matters.** Actions execute in sequence. Ensure dependencies are handled correctly.

Correct order: validate data, then create record, then get the new record ID, then send email referencing that ID.

Incorrect order: sending an email referencing a record ID before creating the record will fail because the ID does not exist yet.

## Understanding Conditions

A condition is a decision point. It implements the logic layer from Module 2''s 4-layer model.

### Basic Condition Types

**Comparison Operators**

Check if amount is greater than 100 and apply bulk discount. Check if status equals "New" and send welcome email. Check if priority is 3 or higher and escalate to manager. Check if country does not equal "US" and calculate international shipping.

**Existence Checks**

If email is not empty, send notification. If phone number exists, add to SMS list. If attachment is present, process the file.

**Multiple Conditions**

AND requires both conditions to be true: if amount greater than 100 AND customer equals "VIP", apply premium discount.

OR requires at least one condition to be true: if source equals "Website" OR source equals "App", track as digital lead.

Combined conditions: if status equals "Paid" AND (amount greater than 500 OR customer equals "Enterprise").

### Condition Patterns

**Filter Pattern: Continue or stop based on criteria.**

Trigger fires on form submission. Condition checks if email is valid. If yes, continue processing. If no, stop and log the invalid submission.

**Router Pattern: Send to different paths.**

Trigger fires on support ticket created. Condition checks the category. Billing goes to finance team. Technical goes to engineering. General goes to support queue.

**Priority Pattern: Handle based on importance.**

Trigger fires on new order. Condition checks order value. Greater than 1000 takes high priority path. Greater than 100 takes standard path. 100 or below goes to batch processing.

## Building Complete Automations

### Pattern 1: Linear Pipeline

Data flows through a sequence of actions: Trigger leads to Action 1, then Action 2, then Action 3, then completion.

Example: Form submission triggers validation, then saves to CRM, then sends confirmation email.

### Pattern 2: Conditional Branch

Data takes different paths based on a condition: Trigger leads to condition check, which routes to Path A if true or Path B if false.

Example: Order triggers inventory check. If in stock, ship the item. If out of stock, create backorder.

### Pattern 3: Filter Pipeline

Data continues only if it passes a check: Trigger leads to condition. If it passes, continue processing. If it fails, stop.

Example: Email received triggers spam check. If not spam, process the email. If spam, discard.

### Pattern 4: Loop Processing

Process each item in a collection: Trigger gets a list, then for each item executes an action, then moves to the next item until all are processed.

Example: Daily trigger gets all pending orders, sends a reminder for each, then completes when all reminders are sent.

### Pattern 5: Delayed Action

Action occurs after a waiting period: Trigger leads to wait period, then action executes.

Example: Cart abandoned triggers a wait of 1 hour, then sends reminder email.

## Connection to Module 2

This section directly implements Module 2''s 4-layer model:

Trigger layer: The trigger types covered here are how you implement the trigger layer. Choose event-based for immediate response, scheduled for recurring tasks, webhooks for efficient integrations.

Logic layer: Conditions implement the logic layer. Filter patterns, router patterns, and priority patterns are all logic layer implementations.

Execution layer: Actions implement the execution layer. Data operations, communications, and integrations are all execution layer activities.

Output layer: Communication actions and the results of your automation form the output layer.

Understanding this connection helps you design automations systematically rather than ad-hoc.

## Best Practices Summary

### Trigger Best Practices

Choose the trigger type that matches your timing needs. Handle cases where triggers might fire multiple times. Test triggers with realistic data volumes. Document what triggers each automation.

### Action Best Practices

Keep actions focused with single responsibility. Design for idempotency when possible. Consider failure scenarios for each action. Log important actions for debugging.

### Condition Best Practices

Use clear, readable condition names. Always provide a default or else path. Handle null and empty values explicitly. Avoid deeply nested conditions and flatten when possible.',

exercise_markdown = '## Exercise: Build Your First Complete Automation

**Objective:** Design and build a working automation that uses triggers, actions, and conditions together, applying Module 2''s 4-layer model explicitly.

### Part 1: Design a Lead Intake Automation

**Scenario:** You run a consulting business and want to automate lead handling.

**Current Manual Process:**

1. Lead fills out website form
2. You check email for new submissions
3. You copy lead info into spreadsheet
4. You send a confirmation email
5. You notify yourself on Slack
6. You categorize lead by service interest

**Requirements for Automation:**

Capture leads from website form instantly. Store in CRM or spreadsheet. Route based on service interest (Consulting, Training, Support). Send confirmation email to lead. Notify team on Slack with lead details.

**Map to 4-Layer Model:**

Document how your automation implements each layer:

Trigger Layer: What type of trigger will you use? What platform or tool? What data will the trigger provide?

Logic Layer: What conditions will you evaluate? What routing decisions need to be made? What is the default path if no conditions match?

Execution Layer: What actions will execute? In what order? What data does each action need? What does each action produce?

Output Layer: What notifications will be sent? What records will be created? What will the lead receive?

### Part 2: Build the Automation

Using n8n, Make, or Zapier:

Step 1: Create the trigger (form submission or test trigger)

Step 2: Add data validation action to check required fields

Step 3: Add CRM or spreadsheet creation to store the lead

Step 4: Add conditional routing based on service type selected

Step 5: Add email sending action for lead confirmation

Step 6: Add Slack notification for team awareness

Document each step with screenshots or detailed descriptions.

### Part 3: Test Scenarios

Test your automation with these scenarios:

**Scenario A: Normal Lead**
Name: John Smith. Email: john@company.com. Service: Consulting. Message: "Interested in automation consulting."
Expected: CRM record created, confirmation email sent, Slack notification received, routed to Consulting path.

**Scenario B: Edge Case - Optional Fields Empty**
Name: Jane Doe. Email: jane@test.com. Service: Training. Phone: empty.
Expected: Should still work. CRM record created with empty phone field.

**Scenario C: Invalid Data**
Name: empty. Email: not-an-email. Service: Other.
Expected: Validation should catch issues. No CRM record created for invalid data.

**Scenario D: Volume Test**
Submit 5 forms in rapid succession.
Check: Were all captured? Any duplicates created? Any failures?

### Part 4: Add Error Handling

For each action in your automation, identify:

What could fail? Examples: API timeout, invalid data, rate limiting.

How would you detect the failure? Check for error responses, missing expected output.

What should happen when it fails? Retry, log, alert, skip.

Add at least one error handling path to your automation. Document what you added and why.

### Part 5: Build Two Additional Automations

**Automation 2: Customer Onboarding Workflow**

Trigger: New customer record created in CRM.

Actions: Send welcome email with next steps. Create project folder in Google Drive or similar. Schedule kickoff meeting using calendar integration.

Conditions: Different onboarding paths for different service tiers (Basic, Pro, Enterprise).

Map this to the 4-layer model explicitly.

**Automation 3: Daily Scheduled Report**

Trigger: Every day at 9am.

Actions: Query database or spreadsheet for yesterday''s metrics. Format data into readable report. Send report to team via email or Slack.

Conditions: Only send if there is data to report. Different formatting for weekday versus weekend reports.

Map this to the 4-layer model explicitly.

### Part 6: Document Your Automations

For each automation, create documentation including:

Purpose: What problem does this solve?

Trigger: What starts it and when?

Logic: What decisions are made?

Actions: What happens in what order?

Error Handling: What happens when things fail?

Testing: How did you verify it works?

### Deliverables

Design documents for all 3 automations with explicit 4-layer model mapping.

At least 1 fully built and tested automation.

Test results for all scenarios (normal, edge cases, invalid data, volume).

Error handling documentation.

### Success Criteria

Built at least 1 working automation end-to-end.

Tested with normal, edge case, and error scenarios.

Handled at least 1 error scenario gracefully.

Documented trigger, actions, and conditions clearly.

Explicitly mapped automation to 4-layer model from Module 2.',

exercise_schema = '{
  "exercise_id": "6.1-automation-fundamentals",
  "title": "Build Your First Complete Automation",
  "objectives": [
    "Design automation using 4-layer model",
    "Implement triggers, actions, and conditions",
    "Test with multiple scenarios",
    "Add error handling",
    "Build multiple automation patterns"
  ],
  "parts": [
    {
      "part_number": 1,
      "title": "Design Lead Intake Automation",
      "type": "design",
      "task": "Map automation to 4-layer model",
      "layers": ["trigger", "logic", "execution", "output"],
      "connection_to_module_2": true
    },
    {
      "part_number": 2,
      "title": "Build the Automation",
      "type": "implementation",
      "task": "Create working automation in platform",
      "platforms": ["n8n", "Make", "Zapier"],
      "steps": ["trigger", "validation", "storage", "routing", "email", "notification"]
    },
    {
      "part_number": 3,
      "title": "Test Scenarios",
      "type": "testing",
      "task": "Test with multiple data scenarios",
      "scenarios": ["normal", "edge_case", "invalid", "volume"],
      "documentation_required": true
    },
    {
      "part_number": 4,
      "title": "Add Error Handling",
      "type": "enhancement",
      "task": "Identify and handle failure points",
      "elements": ["failure_identification", "detection_method", "response_action"]
    },
    {
      "part_number": 5,
      "title": "Build Additional Automations",
      "type": "implementation",
      "task": "Create two more automation patterns",
      "automations": ["customer_onboarding", "scheduled_report"],
      "four_layer_mapping_required": true
    },
    {
      "part_number": 6,
      "title": "Documentation",
      "type": "documentation",
      "task": "Document all automations",
      "sections": ["purpose", "trigger", "logic", "actions", "error_handling", "testing"]
    }
  ],
  "deliverable": {
    "format": "documentation_and_working_automation",
    "minimum_automations": 1,
    "design_documents": 3
  },
  "success_criteria": [
    "At least 1 working automation",
    "Multiple test scenarios executed",
    "Error handling implemented",
    "Clear documentation",
    "4-layer model mapping explicit"
  ],
  "estimated_time_minutes": 90,
  "connections": {
    "module_2": "4-layer automation model",
    "module_3": "Capability tiers for AI actions",
    "section_5_1": "Data flow patterns"
  }
}'

WHERE slug = 'triggers-actions-conditions';
