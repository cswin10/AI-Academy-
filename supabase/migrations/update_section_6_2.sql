-- ============================================================================
-- UPDATE SECTION 6.2: Conditional Logic & Branching
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, remove any existing questions 5-8 to allow clean re-runs, then add 4 more to reach 8 total
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Conditions and Logic Quiz')
AND order_index IN (5, 6, 7, 8);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Conditions and Logic Quiz'), 5,
'How does conditional logic relate to the logic layer in Module 2''s 4-layer model?',
'["Conditional logic is separate from the 4-layer model", "Conditional logic IS the logic layer implementation, determining routing, filtering, and decision-making", "The logic layer does not use conditions", "Only the trigger layer uses conditions"]',
1,
'The logic layer from Module 2 is where decisions happen. Conditional logic (if-then-else, routing, filtering) is how you implement that layer in practice.'),

((SELECT id FROM quizzes WHERE title = 'Conditions and Logic Quiz'), 6,
'What is a truth table and when should you use one?',
'["A database table", "A systematic way to map all possible input combinations to their outputs, useful for complex multi-condition logic", "A testing document", "A way to store boolean values"]',
1,
'Truth tables help you think through complex logic by listing every combination of conditions and what should happen for each. They prevent missing edge cases.'),

((SELECT id FROM quizzes WHERE title = 'Conditions and Logic Quiz'), 7,
'What is De Morgan''s Law and why is it useful for automation logic?',
'["A physics principle", "A rule for simplifying NOT expressions: NOT(A AND B) equals (NOT A) OR (NOT B), helping simplify complex conditions", "A data validation rule", "A trigger timing rule"]',
1,
'De Morgan''s Laws help you rewrite complex negations into simpler forms. This makes conditions more readable and less error-prone.'),

((SELECT id FROM quizzes WHERE title = 'Conditions and Logic Quiz'), 8,
'How does the I-T-O framework apply to designing conditional routing?',
'["I-T-O does not apply to conditions", "Input is the data being evaluated, Task is applying the condition rules, Output is the routing decision or transformed data", "Only Output matters for conditions", "Conditions replace I-T-O thinking"]',
1,
'Conditional routing follows I-T-O: define what data you are evaluating (Input), specify the decision rules (Task), and determine where data goes or how it changes (Output).');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Conditional Logic & Branching

Automations need to make decisions. The quality of your decision logic determines how smart your automations are. Good logic equals smart automations. Bad logic equals bugs, confusion, and failed workflows. This section implements the logic layer from Module 2''s 4-layer model.

## Definitions

**Boolean**: A value that is either true or false. All conditions ultimately evaluate to boolean values.

**AND Operator**: A logical operator requiring all conditions to be true for the overall expression to be true.

**OR Operator**: A logical operator requiring at least one condition to be true for the overall expression to be true.

**NOT Operator**: A logical operator that inverts a condition, making true become false and false become true.

**Branching**: Splitting automation flow into different paths based on condition evaluation.

**Default Path**: The path taken when no other conditions match. Also called "else" or "catch-all."

**Edge Case**: An unusual but valid scenario that your logic must handle correctly.

**Truth Table**: A systematic listing of all possible input combinations and their corresponding outputs.

**Early Exit**: A pattern where disqualifying conditions are checked first and cause the flow to stop, simplifying subsequent logic.

**Lookup Table**: A data structure that replaces many conditions with a single data lookup, simplifying complex branching.

## Boolean Logic Fundamentals

All conditions ultimately evaluate to true or false. Understanding boolean logic is the foundation for all conditional automation.

### AND Operator

Both conditions must be true for the overall expression to be true.

Example: If amount is greater than 100 AND country equals "US", then apply the domestic bulk discount.

The truth table for AND shows that both inputs must be true:

When amount greater than 100 is true AND country equals US is true, the result is true.
When amount greater than 100 is true AND country equals US is false, the result is false.
When amount greater than 100 is false AND country equals US is true, the result is false.
When amount greater than 100 is false AND country equals US is false, the result is false.

Use AND when all criteria must be met for an action to occur.

### OR Operator

At least one condition must be true for the overall expression to be true.

Example: If source equals "Website" OR source equals "Mobile App", then track as a digital lead.

The truth table for OR shows that any true input produces true:

When source equals Website is true OR source equals Mobile App is true, the result is true.
When source equals Website is true OR source equals Mobile App is false, the result is true.
When source equals Website is false OR source equals Mobile App is true, the result is true.
When source equals Website is false OR source equals Mobile App is false, the result is false.

Use OR when any of the criteria being met is sufficient.

### NOT Operator

Inverts the condition. True becomes false, false becomes true.

Example: If NOT status equals "Complete", then continue processing. This is equivalent to: If status does not equal "Complete".

Use NOT when you want the opposite of a condition.

### Combining Operators

Complex conditions combine AND, OR, and NOT. Parentheses control the order of evaluation.

Example with different groupings:

If (A AND B) OR C evaluates as: true if both A and B are true, OR if C is true alone.

If A AND (B OR C) evaluates as: true if A is true AND at least one of B or C is true.

Practical example: If customer equals "VIP" AND (amount greater than 500 OR items greater than 10). This means VIP customers get the discount on either large orders or bulk quantities.

## Branching Patterns

### Pattern 1: Simple If-Then

Single condition with a single outcome.

If status equals "Urgent", send to priority queue. Otherwise, continue normal flow.

The workflow checks the condition, and if urgent, routes to priority queue. If not urgent, continues the standard path.

### Pattern 2: If-Then-Else

Two mutually exclusive paths based on one condition.

If amount is greater than 100, apply discount. Otherwise, apply no discount.

The workflow evaluates the amount, routes to discount calculation if threshold met, otherwise continues with standard pricing.

### Pattern 3: If-Else If-Else (Chained Conditions)

Multiple paths where the first matching condition wins. Order of evaluation matters.

If amount is greater than 1000, apply 20% discount.
Otherwise if amount is greater than 500, apply 15% discount.
Otherwise if amount is greater than 100, apply 10% discount.
Otherwise, apply no discount.

Important: Check the largest values first. If you check amount greater than 100 first, a $1500 order would only get 10% because the first matching condition wins.

### Pattern 4: Nested Conditions

Conditions within conditions. Use when the second decision depends on the first.

If customer type equals "Business":
  If annual spend is greater than 50000, route to Enterprise tier.
  Otherwise, route to Business tier.
Otherwise:
  If customer has subscription, route to Premium consumer.
  Otherwise, route to Standard consumer.

When to nest: The second condition only makes sense if the first is true. You need different criteria for different categories.

When not to nest: Logic becomes too deep (more than 2-3 levels). Conditions are independent of each other.

### Pattern 5: Switch/Case (Multiple Options)

Multiple conditions on the same field. Cleaner than chained if-else for many options.

Based on department value: If "Sales", route to sales queue. If "Support", route to support queue. If "Billing", route to finance queue. Default: route to general inbox.

### Pattern 6: Multi-Condition Matrix

When multiple factors combine to determine outcome. A matrix helps visualize all combinations.

Example shipping matrix:

VIP customers with any order size get Free Express shipping.
Regular customers with orders over $100 get Free Standard shipping.
Regular customers with orders $100 or below get Standard Rate.
Guest customers with orders over $50 get Standard Rate.
Guest customers with orders $50 or below get Premium Rate.

Implementation order: Check VIP first (free express). Then check Regular AND amount greater than 100 (free standard). Then check Regular (standard rate). Then check amount greater than 50 (standard rate). Finally default to premium rate.

## Edge Case Handling

Edge cases are unusual but valid scenarios that your logic must handle.

### Null and Empty Values

Always check if data exists before using it.

Problematic approach: Check if email contains "@company.com" to identify internal users. This fails if email is empty or null.

Better approach: First check if email is not empty, then check if email contains "@company.com". Only then route as internal user.

### Unknown or Unexpected Values

What happens when you receive data you did not anticipate?

Problematic approach: If status equals "Active" process the record. If status equals "Inactive" skip the record. But what if status equals "Pending"? Nothing happens, and the record falls through without handling.

Better approach: If status equals "Active" process. Otherwise if status equals "Inactive" skip. Otherwise log the unknown status value and alert for investigation. Always have a default path.

### Type Mismatches

Ensure data types match your expectations.

Problem: Checking if amount is greater than 100 fails if amount is stored as the text string "150" instead of the number 150.

Solution: Convert to number first with toNumber(amount), then check if greater than 100.

### Boundary Conditions

Pay special attention to exact boundary values.

Question: Does exactly $100 get the discount?

If amount greater than 100: No, only 101 and above qualify.
If amount greater than or equal to 100: Yes, 100 and above qualify.

Be explicit about boundaries in your documentation and testing.

## Common Mistakes and How to Avoid Them

### Mistake 1: Wrong Operator (OR vs AND)

Intention: Give special treatment to high-value VIP orders.
Bug: Using OR instead of AND. If amount greater than 1000 OR customer equals "VIP" means both $50 VIP orders AND $2000 random orders qualify.
Correct: If amount greater than 1000 AND customer equals "VIP" means only VIP orders over $1000 qualify.

### Mistake 2: Unreachable Code

Bug: Check if amount greater than 100 first (Path A). Then check if amount greater than 500 (Path B). Path B is never reached because any amount over 500 already matched the first condition.

Correct: Check larger values first. If amount greater than 500 (Path B). Otherwise if amount greater than 100 (Path A).

### Mistake 3: Missing Default Path

Bug: Check for US region (US process). Check for EU region (EU process). But what about Asia, Australia, South America? Records from those regions have no path.

Correct: Check for US, then EU, then add a default "International process" for everything else.

### Mistake 4: Over-Complex Nesting

Hard to read: If A then if B then if C then if D then do something. Four levels of nesting is confusing.

Better with combined conditions: If A AND B AND C AND D then do something. Flatten when all conditions are required.

Better with early exits: If NOT A then exit. If NOT B then exit. If NOT C then exit. If NOT D then exit. Then do something. Check disqualifiers first and exit early.

## Simplification Techniques

### De Morgan''s Laws

Transform complex NOT expressions into simpler forms.

NOT (A AND B) equals (NOT A) OR (NOT B).
NOT (A OR B) equals (NOT A) AND (NOT B).

Example: NOT (isVIP AND hasPurchased) can be rewritten as (NOT isVIP) OR (NOT hasPurchased), which reads as "is regular customer OR has not purchased."

### Early Exits

Check disqualifying conditions first and exit early. This flattens nested logic.

Instead of nested conditions checking if email is valid, then if user opted in, then if user is active, then sending email...

Use early exits: If email is NOT valid, exit. If user has NOT opted in, exit. If user is NOT active, exit. Then send email. Each check either exits or passes through.

### Lookup Tables

Replace many conditions with a data lookup.

Instead of: If country equals "US" then tax is 0. If country equals "CA" then tax is 5. If country equals "UK" then tax is 20. And fifty more countries...

Use a lookup: Tax equals TaxRates table lookup by country. Store the rates in a table or spreadsheet and look them up.

### Truth Tables

For complex logic with multiple variables, map out all possibilities.

Example with three boolean inputs (isVIP, amount greater than 100, hasDiscount):

When VIP is true and amount is high and has discount: Apply VIP 25%.
When VIP is true and amount is high and no discount: Apply VIP 20%.
When VIP is true and amount is low (either discount): Apply VIP 10%.
When VIP is false and amount is high and has discount: Apply 15%.
When VIP is false and amount is high and no discount: Apply 10%.
When VIP is false and amount is low (either discount): No discount.

This systematic approach ensures you handle every combination.

## Connection to Module 2

Conditional logic implements the logic layer from Module 2''s 4-layer model.

The logic layer is where your automation makes decisions. Conditions are the mechanism for those decisions.

Filter patterns implement "should this continue?" decisions.
Router patterns implement "where should this go?" decisions.
Priority patterns implement "how important is this?" decisions.
Transformation patterns implement "how should this change?" decisions.

Every condition follows I-T-O: Input is the data being evaluated. Task is applying the condition rules. Output is the routing decision or transformed result.

Design your logic layer by first identifying all the decisions that need to be made, then implementing each as a clear condition pattern.',

exercise_markdown = '## Exercise: Master Conditional Logic

**Objective:** Build complex conditional logic and test all branches thoroughly, applying logic layer thinking from Module 2.

### Part 1: Design Logic for These Scenarios

**Scenario 1: Expense Approval Routing**

Design the conditional logic for expense report routing:

If amount is less than $100: Auto-approve.
If amount is $100 to $500: Require manager approval.
If amount is greater than $500: Require finance team approval.
Any amount with missing receipt: Always require manual review.
Any amount with flagged vendor: Require security review.

Questions to answer:

What order should conditions be checked? Consider that missing receipt and flagged vendor override amount-based routing.

How do you handle multiple conditions matching? If a $600 expense has a missing receipt, which path takes priority?

What is the default path? What happens if an expense does not match any condition?

Document your logic as a decision tree or structured list.

**Scenario 2: Support Ticket Routing**

Design routing for incoming support tickets:

If customer is VIP: Route to senior support with priority.
If ticket contains "bug" or "error": Route to engineering team.
If category equals "Billing": Route to finance team.
If sentiment analysis shows angry: Escalate to manager.
Default: Route to general support queue.

Questions to answer:

Can a ticket match multiple conditions? Yes, a VIP with a billing question triggers both VIP and Billing conditions.

Which takes priority: VIP status or angry sentiment? Define your priority order.

How would you detect angry sentiment? Consider using AI classification from Module 3.

Document your logic with explicit priority ordering.

**Scenario 3: E-commerce Order Processing**

Design order fulfillment logic based on inventory, payment status, and location:

In stock AND paid AND US location: Ship next-day.
In stock AND paid AND international: Ship 3-5 days.
In stock AND payment pending: Hold for payment.
Out of stock AND paid: Backorder or offer refund.
Out of stock AND payment pending: Cancel order.

Questions to answer:

How many distinct paths exist? Count all combinations.

What is the check order? Should you check inventory first or payment first?

What notifications accompany each path? Customer email, internal alert, etc.

Document as a matrix or decision tree.

### Part 2: Build One Scenario

Choose one scenario from Part 1 and implement it:

Create the automation in your platform (n8n, Make, or Zapier). Build all conditional paths with appropriate routing. Add actions for each path (notifications, record updates). Include a default or catch-all path.

Document with screenshots or detailed descriptions of your conditional setup.

### Part 3: Create Test Cases for All Branches

For your implemented scenario, create test cases covering every branch:

Create a test matrix with columns: Test number, Input data, Expected path, Expected outcome.

Requirements:

At least one test for each possible branch.
Include edge cases such as boundary values and empty fields.
Include a test for the default path.
Include tests for overlapping conditions if applicable.

### Part 4: Execute Tests and Document Results

Run each test case and record:

Did it take the expected path?
Was the outcome correct?
Any unexpected behavior?

Document any bugs found and how you fixed them.

### Part 5: Debug a Broken Logic Scenario

Here is automation logic with bugs. Find and fix them:

Buggy discount calculator:
If amount greater than 50: Apply 5% discount.
If amount greater than 100: Apply 10% discount.
If amount greater than 200: Apply 15% discount.
If customer equals VIP: Apply 25% discount.

Bugs to find:

What discount does a $250 order get? (Hint: Order of conditions matters.)

What about a VIP with a $300 order? (Hint: Should they get 25% or is the 15% applied first?)

What about a $49.99 order? (Hint: Is there a path for small orders?)

Provide the corrected logic with proper ordering and a default path.

### Part 6: Simplify Complex Logic

Rewrite this nested logic to be more readable:

Original nested structure:
If customer type equals "Enterprise":
  If contract status equals "Active":
    If last purchase was less than 30 days ago:
      Route to Priority support.
    Else:
      If support tier equals "Premium":
        Route to Standard support.
      Else:
        Route to Basic support.
  Else:
    Route to Sales outreach.
Else:
  If customer type equals "Small Business":
    If has subscription:
      Route to Standard support.
    Else:
      Route to Self-service.
  Else:
    Route to Self-service.

Provide a simplified version using:

Early exits to flatten nesting.
Clear path naming.
Documented decision order.

### Deliverables

Logic designs for all 3 scenarios with explicit decision ordering.

One fully implemented and tested automation.

Test case matrix with results.

Bug fixes for the broken logic with explanation.

Simplified version of the complex logic.

### Success Criteria

All scenarios have complete logic designs.

At least one automation built and tested.

All branches tested with documented results.

Can explain the difference between AND, OR, and NOT with examples.

Can identify and fix common logic bugs.',

exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Design Logic for Scenarios",
      "description": "Design conditional logic for three business scenarios.",
      "fields": [
        {
          "id": "expense_logic",
          "type": "textarea",
          "label": "Scenario 1: Expense Approval Routing",
          "placeholder": "Condition order (why this order):\n1. ...\n2. ...\n\nMultiple condition handling:\n- $600 with missing receipt: [which path]\n\nDefault path: ...\n\nDecision tree:\n...",
          "required": true,
          "rows": 10
        },
        {
          "id": "ticket_logic",
          "type": "textarea",
          "label": "Scenario 2: Support Ticket Routing",
          "placeholder": "Priority order:\n1. VIP vs angry: [which wins]\n2. ...\n\nMultiple matches (VIP + billing):\n- Resolution: ...\n\nAngry sentiment detection:\n- Method: [AI classification tier]\n\nLogic with priorities:\n...",
          "required": true,
          "rows": 10
        },
        {
          "id": "order_logic",
          "type": "textarea",
          "label": "Scenario 3: E-commerce Order Processing",
          "placeholder": "Distinct paths count: X\n\nCheck order:\n- First: [inventory or payment]\n- Why: ...\n\nPath matrix:\n| Stock | Payment | Location | Action |\n| In | Paid | US | Ship next-day |\n| In | Paid | Intl | Ship 3-5 days |\n| ... | ... | ... | ... |\n\nNotifications per path:\n...",
          "required": true,
          "rows": 14
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Build One Scenario",
      "description": "Implement one scenario in your platform.",
      "fields": [
        {
          "id": "scenario_choice",
          "type": "radio",
          "label": "Which scenario did you implement?",
          "options": ["Expense Approval", "Support Tickets", "Order Processing"],
          "required": true
        },
        {
          "id": "implementation",
          "type": "textarea",
          "label": "Document your implementation:",
          "placeholder": "Platform used: ...\n\nConditional setup:\n- First condition: ...\n- Second condition: ...\n- (continue)\n\nActions per path:\n- Path A: ...\n- Path B: ...\n\nDefault path:\n- What happens: ...",
          "required": true,
          "rows": 12
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Test Cases",
      "description": "Create test cases for all branches.",
      "fields": [
        {
          "id": "test_matrix",
          "type": "textarea",
          "label": "Create your test matrix:",
          "placeholder": "| Test # | Input | Expected Path | Expected Outcome |\n| 1 | [data] | Path A | [outcome] |\n| 2 | [data] | Path B | [outcome] |\n| ... | ... | ... | ... |\n\nEdge cases:\n| EC-1 | [boundary value] | ... | ... |\n| EC-2 | [empty field] | ... | ... |\n\nDefault path test:\n| D-1 | [no match data] | Default | ... |\n\nOverlapping conditions:\n| O-1 | [matches multiple] | [priority path] | ... |",
          "required": true,
          "rows": 16
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Execute and Document",
      "description": "Run tests and document results.",
      "fields": [
        {
          "id": "test_results",
          "type": "textarea",
          "label": "Document test execution results:",
          "placeholder": "| Test # | Expected | Actual | Status |\n| 1 | Path A | Path A | PASS |\n| 2 | Path B | Path C | FAIL |\n| ... | ... | ... | ... |\n\nBugs found:\n- Test 2 failed because: ...\n- Fix applied: ...\n- Retest result: ...",
          "required": true,
          "rows": 14
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Debug Broken Logic",
      "description": "Find and fix bugs in the discount calculator.",
      "fields": [
        {
          "id": "bug_fixes",
          "type": "textarea",
          "label": "Find and fix the bugs:",
          "placeholder": "Bug 1: $250 order\n- Current behavior: [what discount]\n- Problem: [order of conditions]\n- Fix: ...\n\nBug 2: VIP with $300\n- Current behavior: ...\n- Problem: ...\n- Fix: ...\n\nBug 3: $49.99 order\n- Current behavior: [no path]\n- Problem: [missing default]\n- Fix: ...\n\nCorrected logic:\n1. If VIP: 25% (check first)\n2. If > 200: 15%\n3. If > 100: 10%\n4. If > 50: 5%\n5. Default: 0%",
          "required": true,
          "rows": 16
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: Simplify Complex Logic",
      "description": "Rewrite nested logic to be more readable.",
      "fields": [
        {
          "id": "simplified_logic",
          "type": "textarea",
          "label": "Simplify the nested customer routing logic:",
          "placeholder": "Simplified version using early exits:\n\n1. If not Enterprise AND not Small Business: -> Self-service (exit)\n\n2. If Enterprise AND not Active contract: -> Sales outreach (exit)\n\n3. If Enterprise AND Active AND recent purchase (< 30 days): -> Priority support (exit)\n\n4. If Enterprise AND Active AND Premium tier: -> Standard support (exit)\n\n5. If Enterprise AND Active: -> Basic support (exit)\n\n6. If Small Business AND has subscription: -> Standard support (exit)\n\n7. Default: -> Self-service\n\nWhy this is better:\n...",
          "required": true,
          "rows": 18
        }
      ]
    }
  ],
  "deliverables": [
    "Logic designs for all 3 scenarios",
    "One implemented and tested automation",
    "Test case matrix with results",
    "Bug fixes with explanations",
    "Simplified logic version"
  ],
  "success_criteria": [
    "All scenarios have complete logic designs",
    "At least one automation built and tested",
    "All branches tested with documented results",
    "Can explain AND, OR, NOT differences",
    "Can identify and fix common logic bugs"
  ]
}'

WHERE slug = 'conditional-logic-branching';
