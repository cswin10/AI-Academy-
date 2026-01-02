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

**This is how automations begin and move.**

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

### Trigger Selection Guide

Choose event-based for immediate response (new signups, payments). Choose scheduled for recurring tasks (daily reports, weekly summaries). Choose webhooks for real-time external integrations (payment notifications). Choose manual for on-demand tasks (report generation). Choose polling when webhooks are unavailable.

### Trigger Failure Modes

Triggers misfire. Understanding how helps you design resilient automations.

**Duplicate triggers**: Forms submit twice when users click impatiently. Webhooks retry on timeout. Polling detects the same record twice. Design your actions to handle receiving the same trigger multiple times.

**Late triggers**: Webhooks arrive delayed due to service backlogs. Scheduled triggers fire late due to platform load. Build in tolerance for timing variations.

**Out-of-order triggers**: Events arrive in unexpected sequence. Update triggers arrive before create triggers due to network timing. Do not assume order unless you verify it.

**Missing triggers**: Webhooks fail silently. Polling misses items between intervals. Have fallback detection or manual trigger options for critical flows.

**Manual trigger inconsistency**: Different people trigger with different expectations. Document when and why to use manual triggers clearly.

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

Idempotent actions are safe under retries. When your automation fails partway through and restarts, idempotent actions do not create chaos.

Non-idempotent actions create duplicates and spam. "Create new record" runs twice, you have two records. "Send email" runs twice, the customer gets two emails.

You want every automation to have a way to recognize it already processed something. Check for existing records before creating. Use unique identifiers to prevent duplicates. Update with "set to value" rather than "increment by value."

Idempotent examples: "Update record where ID equals 123" and "Set status to processed." Running these multiple times produces the same result.

Non-idempotent examples: "Create new record" and "Increment counter." Running these multiple times creates duplicates or inflates values.

**Order matters.** Actions execute in sequence. Ensure dependencies are handled correctly.

Correct order: validate data, then create record, then get the new record ID, then send email referencing that ID.

Incorrect order: sending an email referencing a record ID before creating the record will fail because the ID does not exist yet.

## Understanding Conditions

A condition is a decision point. It implements the logic layer from Module 2''s 4-layer model.

### Conditions Are Not Validation

Some readers confuse conditions with validation. They solve different problems.

Validation asks "is this data acceptable?" Validation checks if an email format is correct, if a required field is present, if a number is within range. Validation decides whether data should enter the system at all.

Conditions ask "what path does acceptable data take?" Conditions route valid data to different workflows. If the lead is enterprise tier, go to sales. If the order is over 500 dollars, require approval.

Both matter. Validation happens early to reject bad data. Conditions happen after to route good data. Do not use conditions to catch data that should have been validated.

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

## Operator Principles

Design for duplicate triggers. Assume users will click twice, webhooks will retry, and polls will overlap.

Make actions idempotent. If it runs twice, nothing breaks.

Validate early, route later. Keep conditions for routing, not data quality.

Every trigger type has failure modes. Know them before you ship.

Document what triggers each automation. Your future self will thank you.',

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
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Design a Lead Intake Automation",
      "description": "Map the lead intake automation to the 4-layer model.",
      "fields": [
        {
          "id": "layer_mapping",
          "type": "textarea",
          "label": "Map your automation to the 4-layer model:",
          "placeholder": "Trigger Layer:\n- Type: [form submission/webhook/etc]\n- Platform: ...\n- Data provided: ...\n\nLogic Layer:\n- Conditions to evaluate: ...\n- Routing decisions: ...\n- Default path: ...\n\nExecution Layer:\n- Actions in order: ...\n- Data each needs: ...\n- What each produces: ...\n\nOutput Layer:\n- Notifications sent: ...\n- Records created: ...\n- Lead receives: ...",
          "required": true,
          "rows": 18
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Build the Automation",
      "description": "Implement the automation in n8n, Make, or Zapier.",
      "fields": [
        {
          "id": "platform_choice",
          "type": "radio",
          "label": "Which platform did you use?",
          "options": ["n8n", "Make", "Zapier", "Other"],
          "required": true
        },
        {
          "id": "implementation",
          "type": "textarea",
          "label": "Document your implementation for each step:",
          "placeholder": "Step 1 (Trigger): [description]\n\nStep 2 (Validation): [how you validate required fields]\n\nStep 3 (CRM/Spreadsheet): [how you store the lead]\n\nStep 4 (Routing): [how you route by service type]\n\nStep 5 (Email): [confirmation email setup]\n\nStep 6 (Slack): [notification setup]",
          "required": true,
          "rows": 14
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Test Scenarios",
      "description": "Test your automation with multiple scenarios.",
      "fields": [
        {
          "id": "test_results",
          "type": "textarea",
          "label": "Document results for each test scenario:",
          "placeholder": "Scenario A (Normal lead):\n- Input: John Smith, john@company.com, Consulting\n- Expected: CRM + email + Slack + Consulting path\n- Actual: [what happened]\n- Status: [PASS/FAIL]\n\nScenario B (Empty optional fields):\n- Input: Jane Doe, jane@test.com, Training, no phone\n- Expected: Still works with empty phone\n- Actual: ...\n- Status: ...\n\nScenario C (Invalid data):\n- Input: empty name, not-an-email\n- Expected: Validation catches, no CRM record\n- Actual: ...\n- Status: ...\n\nScenario D (Volume - 5 rapid submissions):\n- All captured: [Yes/No]\n- Duplicates: [Yes/No]\n- Failures: [count]",
          "required": true,
          "rows": 20
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Add Error Handling",
      "description": "Identify and handle failure points.",
      "fields": [
        {
          "id": "error_handling",
          "type": "textarea",
          "label": "For each action, document failure handling:",
          "placeholder": "Action 1: [name]\n- What could fail: ...\n- Detection: ...\n- Response: [retry/log/alert/skip]\n\nAction 2: [name]\n- What could fail: ...\n- Detection: ...\n- Response: ...\n\n(continue for all actions)\n\nError path added:\n- What it handles: ...\n- Why you chose this: ...",
          "required": true,
          "rows": 14
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Additional Automations",
      "description": "Design two more automations with 4-layer mapping.",
      "fields": [
        {
          "id": "automation2",
          "type": "textarea",
          "label": "Automation 2: Customer Onboarding",
          "placeholder": "Trigger Layer:\n- Trigger: New customer in CRM\n\nLogic Layer:\n- Conditions: Different paths for Basic/Pro/Enterprise\n\nExecution Layer:\n- Actions: Welcome email, Create folder, Schedule meeting\n\nOutput Layer:\n- Notifications sent: ...",
          "required": true,
          "rows": 10
        },
        {
          "id": "automation3",
          "type": "textarea",
          "label": "Automation 3: Daily Scheduled Report",
          "placeholder": "Trigger Layer:\n- Trigger: Every day at 9am\n\nLogic Layer:\n- Conditions: Only send if data exists, weekday vs weekend\n\nExecution Layer:\n- Actions: Query data, Format report, Send\n\nOutput Layer:\n- Report delivered via: ...",
          "required": true,
          "rows": 10
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: Documentation",
      "description": "Create documentation for each automation.",
      "fields": [
        {
          "id": "documentation",
          "type": "textarea",
          "label": "Document your main automation:",
          "placeholder": "Purpose: [problem it solves]\n\nTrigger: [what starts it, when]\n\nLogic: [decisions made]\n\nActions: [what happens in order]\n\nError Handling: [what happens on failure]\n\nTesting: [how you verified it works]",
          "required": true,
          "rows": 12
        }
      ]
    }
  ],
  "deliverables": [
    "4-layer model mapping for 3 automations",
    "At least 1 fully built automation",
    "Test results for all scenarios",
    "Error handling documentation"
  ],
  "success_criteria": [
    "Built at least 1 working automation",
    "Tested with normal, edge, and error scenarios",
    "Handled at least 1 error gracefully",
    "Documented trigger, actions, and conditions",
    "Mapped to 4-layer model explicitly"
  ]
}'

WHERE slug = 'triggers-actions-conditions';
