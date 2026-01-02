-- ============================================================================
-- UPDATE SECTION 6.4: Testing & Debugging Automation Workflows
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, remove any existing questions 5-8 to allow clean re-runs, then add 4 more to reach 8 total
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Testing and Debugging Quiz')
AND order_index IN (5, 6, 7, 8);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Testing and Debugging Quiz'), 5,
'How does testing relate to the validation concepts from Section 5.4?',
'["Testing and validation are unrelated", "Testing validates that your automation correctly implements validation rules and handles all data quality scenarios", "Validation replaces the need for testing", "Only test in production"]',
1,
'Testing verifies that the validation rules you designed in Section 5.4 work correctly in practice. Test with valid data, invalid data, and edge cases to ensure validation catches what it should.'),

((SELECT id FROM quizzes WHERE title = 'Testing and Debugging Quiz'), 6,
'What is regression testing and why is it important for automations?',
'["Testing for bugs", "Re-running previous tests after changes to verify existing functionality still works, preventing new changes from breaking old features", "Testing performance", "Testing in production"]',
1,
'Automations evolve over time. Regression testing ensures that updates do not break functionality that was working before. Run your test suite before and after every change.'),

((SELECT id FROM quizzes WHERE title = 'Testing and Debugging Quiz'), 7,
'How does the I-T-O framework apply to creating test cases?',
'["I-T-O does not apply to testing", "Define specific Input, specify the Task being tested, and state the expected Output for each test case", "Only Output matters in testing", "Testing replaces I-T-O"]',
1,
'Each test case is an I-T-O operation: specific input data, the operation being tested, and the expected output. This structure makes tests clear and repeatable.'),

((SELECT id FROM quizzes WHERE title = 'Testing and Debugging Quiz'), 8,
'What is the debugging technique of binary search for isolating problems?',
'["A sorting algorithm", "Checking the midpoint of a workflow to narrow down which half contains the failure, then repeating until the exact failure point is found", "A database query", "Testing performance"]',
1,
'Binary search debugging halves the problem space each time. Check if data reaches step 5 of 10. If yes, problem is in steps 6-10. If no, problem is in steps 1-5. Repeat until isolated.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Testing & Debugging Automation Workflows

"It works on my machine" is not good enough. Automations that are not properly tested will fail in production, usually at the worst possible time. Proper testing gives you confidence and helps you sleep at night. This section connects to Section 5.4 on data validation by verifying your validation rules work correctly.

## Definitions

**Testing**: The practice of verifying that a system works as expected by running it with known inputs and checking for expected outputs.

**Debugging**: The process of finding and fixing problems in a system that is not working correctly.

**Test Case**: A specific scenario with defined input, the operation being tested, and the expected output.

**Happy Path**: The normal, expected scenario where everything works correctly. The most common use case.

**Edge Case**: An unusual but valid scenario at the boundaries of expected behavior.

**Regression Testing**: Re-running previous tests after changes to verify existing functionality still works.

**Unit Testing**: Testing individual components in isolation from the rest of the system.

**Integration Testing**: Testing how multiple components work together.

**End-to-End Testing**: Testing the complete workflow from trigger to final output.

**Test Environment**: A separate environment for testing that does not affect production data.

**Smoke Test**: A quick test of basic functionality to verify the system is not completely broken.

## Why Testing Matters

**Without testing:**

Bugs are discovered by users, which is embarrassing and damages trust. Data corruption occurs and is expensive to fix. Transactions are lost, causing direct financial loss. Time is wasted on production firefighting instead of building new features. Reputation suffers when systems fail publicly.

**With testing:**

Bugs are caught before users see them. Deployments happen with confidence. Development is actually faster because issues are caught early. Expected behavior is documented through test cases. Debugging is easier when issues do occur because you have a baseline.

## Types of Testing

### Unit Testing

Test individual components in isolation from the rest of the system.

Example: Test the email validation function alone. Input: "user@example.com" expects Valid equals true. Input: "not-an-email" expects Valid equals false. Input: empty string expects Valid equals false.

Unit testing is good for catching issues in specific logic early, before that logic is integrated with other components.

### Integration Testing

Test how components work together.

Example: Test the form to CRM integration. Submit a test form entry. Verify a CRM record was created. Verify all fields mapped correctly. Verify no duplicate records exist.

Integration testing is good for catching issues in connections between systems, data mapping problems, and API communication failures.

### End-to-End Testing

Test the entire workflow from trigger to final output.

Example: Test the complete lead workflow. Submit form on website. Verify CRM record created with correct data. Verify confirmation email sent to lead. Verify Slack notification received by team. Verify all data is correct at each step.

End-to-end testing is good for verifying the complete user or business flow works as expected.

### Regression Testing

Verify that new changes do not break existing functionality.

After adding a new feature: Run all existing tests. All should still pass. If something breaks, the new change caused it and needs to be fixed or reconsidered.

Regression testing is good for maintaining stability as you evolve the automation over time.

## What to Test

### Happy Path

The normal, expected scenario. The most common use case that should always work.

Test example: Normal lead submission. Input is a valid name, valid email, and selects "Consulting" as service. Expected outcome: CRM record created correctly, email sent to lead, Slack notification received, no errors in logs.

### Edge Cases

Unusual but valid scenarios that might be handled differently.

Edge cases to test: Very long input like a name with 100 or more characters. International characters like José or Japanese characters. Email with plus sign like user+tag@example.com. Multiple submissions by the same person in quick succession. Form submitted at midnight when timezone issues might occur. Submission during known API maintenance windows.

### Error Scenarios

Things that should fail. Verify they fail gracefully rather than crashing.

Error tests to run: Missing required fields should show validation error. Invalid email format should be rejected. API unavailable should trigger retry logic. Rate limit exceeded should back off appropriately. Duplicate submission should be handled without creating duplicates. Potentially malicious input should be sanitized.

### Boundary Conditions

Test at the exact edges of conditions to verify your logic handles boundaries correctly.

If the rule is "amount greater than 100 gets discount," test: Amount equals 99 should get no discount. Amount equals 100 should get no discount (greater than, not greater or equal). Amount equals 100.01 should get the discount. Amount equals 101 should get the discount.

### Integration Points

Where your automation connects to external systems.

For each integration, test: Does authentication work? Does data map correctly between systems? What happens if the service responds slowly? What happens if the service is completely down? Are there rate limits and how does hitting them affect behavior?

## Creating Test Cases

### Test Case Structure

Each test case should have a consistent structure:

Test ID: A unique identifier like TC-001.
Title: A brief description like "Valid lead creates CRM record."
Preconditions: What must be true before the test. For example, CRM is accessible and no existing record for test email.
Steps: What actions to perform. Submit form with valid data, wait 30 seconds, check CRM for new record.
Input Data: The specific data used. Name is "Test User", email is "test-unique-123@example.com", service is "Consulting".
Expected Result: What should happen. CRM record exists with matching data, status is "New", created timestamp is within the last minute.
Actual Result: What actually happened (filled in after testing).
Pass or Fail: The verdict (filled in after testing).

### Test Data Best Practices

Use realistic data that resembles production data. Good example: Name "Sarah Johnson", email "sarah.johnson@acmecorp.com". Bad example: Name "asdf", email "test@test.com".

Make test data identifiable so you can find and clean it up. Good example: Email "test-20240115-001@example.com", name "TEST - John Smith".

Cover variety in your test data: Short inputs and long inputs. Special characters and international formats. Common values and uncommon values. Valid and invalid formats.

## Debugging Workflow

When something goes wrong, follow this systematic approach:

### Step 1: Reproduce the Issue

Can you make it happen again? Answer these questions: Does it fail every time or only sometimes? Does it fail only with certain data? Does it fail at certain times of day? Can you reproduce it in the test environment?

### Step 2: Isolate the Problem

Where exactly does it break? Use binary search debugging.

Check if data reaches step 5 of 10. If no, the problem is in steps 1-5. Check if data reaches step 3. If yes, the problem is in steps 3-5. Check if data reaches step 4. If yes, the problem is between step 4 and 5. You have now isolated the failure location.

### Step 3: Check Logs

What do the logs tell you? Look for: Exact error messages. Timestamps showing when it failed. Input data that was being processed. Stack traces or error codes showing where in the code the failure occurred.

### Step 4: Verify Assumptions

Question everything you think is true.

Common false assumptions: "The API is working" but you should check it. "The data is valid" but you should inspect it. "This step succeeded" but you should verify it. "Nothing changed recently" but you should check for recent updates.

### Step 5: Check External Dependencies

Is the problem in your automation or in an external service?

Check: API status pages for known outages. Service health dashboards. Recent platform updates or changes. Credential expiration dates. Rate limit status.

### Step 6: Create Minimal Example

Strip down to the simplest case that still fails.

If a complex workflow fails: Remove steps until you find the one that fails. Simplify input until you find the problematic data. Reduce to the simplest reproduction case. Fix that specific case, then rebuild.

### Step 7: Fix and Verify

Apply the fix and test thoroughly.

Fix the issue. Test the specific case that failed. Test related cases that might be affected. Run regression tests to ensure you did not break other things. Deploy carefully. Monitor after deployment.

## Common Issues and Solutions

### "It worked yesterday"

Something changed. Find out what.

Check: API updates or deprecations. Platform updates to your automation tool. Credential changes or expirations. Data format changes from sources. Third-party service changes.

### "Works sometimes, fails sometimes"

Intermittent issues are often caused by:

Race conditions where timing affects behavior. Timeouts on slow responses. Rate limiting when volume is high. Load-dependent issues on the server. Data-dependent issues where certain values fail.

### "Wrong data in output"

Mapping or transformation issue.

Debug by: Log data at each step. Find where it first goes wrong. Check field mappings between systems. Check data transformation logic. Look for type conversions causing issues.

### "Nothing happens"

Trigger not firing or filter blocking execution.

Check: Is the trigger configured correctly? Does the trigger have required permissions? Is there a filter or condition blocking execution? Is the automation turned on and active? Check the automation history and execution logs.

### "Too slow"

Performance issue requiring optimization.

Analyze: Which steps take the longest? Are operations running sequentially when they could be parallel? Is there unnecessary data processing? Are you hitting rate limits and retrying repeatedly?

## Testing Checklist

Before deploying any automation, verify:

Happy path tested with at least 3 different scenarios. Edge cases tested including empty fields, special characters, and boundary values. Error scenarios tested including invalid data and API failures. All conditional branches tested with cases for each path. Integration points verified to work correctly. Performance is acceptable under expected load. Error handling verified to work correctly. Logging captures necessary information for debugging. Monitoring and alerts are configured. Rollback plan is documented. Test data has been cleaned up.

## Setting Up Test Environments

### Development or Sandbox Environment

A separate environment for building and testing.

Best practices: Use test API keys, not production credentials. Use test databases, not production data. Mark test data clearly with prefixes like TEST. Set up automatic cleanup of test data.

### Staging Environment

A production-like environment for final testing before deployment.

Should have: Same configuration as production. Recent copy of production data (anonymized if needed). Same integrations with test credentials. Same monitoring and logging.

### Production Testing

Careful testing in the live environment.

Techniques: Feature flags to enable new functionality for a subset of users first. Canary deployments where a small percentage of traffic uses the new version. Synthetic tests using fake data through the real system. Close monitoring after deployment to catch issues quickly.

## Connection to Earlier Modules

Testing connects to Section 5.4 on data validation. Your tests should verify that the validation rules you designed actually work. Test with valid data (should pass), invalid data (should fail), and edge cases (should handle correctly).

Testing also validates your I-T-O designs from Module 2. Each test case is itself an I-T-O operation: specific input, the operation being tested, and expected output. Well-structured tests mirror well-structured automation design.',

exercise_markdown = '## Exercise: Comprehensive Testing and Debugging

**Objective:** Learn to test and debug automation workflows systematically, ensuring reliable production deployments.

### Part 1: Create a Test Plan

For your lead intake automation, create a comprehensive test plan.

**Happy Path Tests (create 5-10 tests):**

Create a table with columns: Test ID, Description, Input data, Expected output.

Example: HP-001, Standard lead submission, valid name and email and company, CRM record created and email sent and Slack notified.

Include variations of normal usage.

**Edge Case Tests (create 5-10 tests):**

Create a table with columns: Test ID, Description, Input data, Expected output.

Example: EC-001, Very long company name, 200-character company name, Truncated or handled gracefully.
Example: EC-002, International characters, name "José García", correctly encoded in CRM.

Include boundary conditions and unusual but valid inputs.

**Error Scenario Tests (create 5-10 tests):**

Create a table with columns: Test ID, Description, Input data, Expected output.

Example: ER-001, Invalid email format, "not-an-email", Validation error and no CRM record created.
Example: ER-002, CRM API down, valid data but mock API failure, Error logged and retry queued.

Include both data errors and system errors.

### Part 2: Execute Your Test Plan

Run every test case in your plan.

Set up your test environment with test credentials. Prepare test data for each case. Execute each test and observe behavior. Record actual results. Compare to expected results. Mark pass or fail.

Create a results table with columns: Test ID, Status (PASS or FAIL), Notes.

### Part 3: Debug Failed Tests

For each failed test:

Document the failure: What was expected? What actually happened? Were there error messages?

Apply the debugging workflow: Reproduce the issue consistently. Isolate to a specific step using binary search. Check logs for error details. Identify the root cause.

Fix the issue: Make the necessary change. Retest the failed case. Verify the fix does not break other tests.

### Part 4: Forced Error Testing

Intentionally break things to test error handling.

**Test 1 API Timeout:** Method: Use an invalid API endpoint or add artificial delay. Expected behavior: Retry logic activates, eventually fails gracefully. Verify: Error is logged, alert is sent, dead letter queue is populated.

**Test 2 Invalid Data:** Method: Submit malformed data with wrong types or missing fields. Expected behavior: Validation catches it before processing starts. Verify: Clear error message, no partial data created.

**Test 3 Network Failure:** Method: Disconnect network mid-process if possible or mock the failure. Expected behavior: Handles gracefully and can resume. Verify: State is recoverable and no data is lost.

**Test 4 Rate Limits:** Method: Trigger many operations rapidly. Expected behavior: Rate limiting kicks in and backoff works. Verify: Eventually completes without permanent failures.

### Part 5: Integration Testing

Test each external connection.

For each integration (CRM, Email, Slack), create a test matrix:

Integration name. Test description. Method. Result (pass or fail).

CRM tests: Create record, duplicate handling, field mapping.
Email tests: Delivery, formatting, personalization.
Slack tests: Notification delivery, message format.

### Part 6: Performance Testing

Test under realistic load.

**Normal Load Test:** Submit 10 leads over 1 hour. All should process correctly. Measure average processing time.

**Peak Load Test:** Submit 10 leads in 5 minutes. All should eventually process. Note any delays or queuing behavior.

**Stress Test:** Submit 50 leads in 10 minutes. Identify the breaking point. Note behavior under stress.

Record in a table: Scenario, lead count, time period, successes, failures, average processing time.

### Part 7: Create Regression Test Suite

Build a reusable set of tests for ongoing use.

Select 8-10 core tests that must always pass. Automate if your platform supports scheduled test runs. Document clearly so anyone can run them. Commit to running before each change to the automation.

Create a regression suite table with columns: Priority (Critical, High, Medium), Test ID, Description, Last run date, Result.

### Scope Note

This exercise is comprehensive. For core mastery, prioritize Parts 1-4 (test plan creation, execution, debugging, and forced errors). Parts 5-7 (integration, performance, and regression) are valuable for production readiness but can be completed in a second pass.

### Deliverables

Complete test plan with 20 or more test cases. Test execution results for all cases. Debug documentation for any failures. Forced error test results. Integration test results. Performance test results. Regression test suite.

### Success Criteria

Comprehensive test plan covering all scenario types. All tests executed and documented. All failures investigated and fixed. Error handling verified through forced failures. Regression suite ready for future use.',

exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Create Test Plan",
      "description": "Design comprehensive test cases for your automation.",
      "fields": [
        {
          "id": "happy_path",
          "type": "textarea",
          "label": "Happy Path Tests (5-10 tests):",
          "placeholder": "| Test ID | Description | Input Data | Expected Output |\n| HP-001 | Standard lead | valid name, email, company | CRM + email + Slack |\n| HP-002 | Consulting route | service=Consulting | Routed to consulting path |\n| HP-003 | Training route | service=Training | Routed to training path |\n| HP-004 | With phone | all fields + phone | Phone stored correctly |\n| HP-005 | With message | includes long message | Message truncated/stored |",
          "required": true,
          "rows": 10
        },
        {
          "id": "edge_cases",
          "type": "textarea",
          "label": "Edge Case Tests (5-10 tests):",
          "placeholder": "| Test ID | Description | Input Data | Expected Output |\n| EC-001 | Long company | 200-char name | Truncated gracefully |\n| EC-002 | Intl chars | José García | Encoded correctly |\n| EC-003 | Empty optional | no phone | Works with empty |\n| EC-004 | Min values | 1-char name | Accepted or rejected |\n| EC-005 | Special chars | name with quotes | Handled safely |",
          "required": true,
          "rows": 10
        },
        {
          "id": "error_scenarios",
          "type": "textarea",
          "label": "Error Scenario Tests (5-10 tests):",
          "placeholder": "| Test ID | Description | Input Data | Expected Output |\n| ER-001 | Invalid email | not-an-email | Validation error |\n| ER-002 | CRM API down | valid + mock fail | Error logged, retry queued |\n| ER-003 | Empty required | no name | Rejected cleanly |\n| ER-004 | Rate limited | rapid submissions | Backoff activated |\n| ER-005 | Timeout | slow API | Retry with backoff |",
          "required": true,
          "rows": 10
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Execute Test Plan",
      "description": "Run all tests and record results.",
      "fields": [
        {
          "id": "test_execution",
          "type": "textarea",
          "label": "Document test results:",
          "placeholder": "Environment setup:\n- Test credentials: [configured]\n- Test data prepared: [Yes]\n\nResults:\n| Test ID | Status | Notes |\n| HP-001 | PASS | |\n| HP-002 | PASS | |\n| EC-001 | FAIL | Crashed on long name |\n| ER-001 | PASS | |\n\nSummary:\n- Total: X tests\n- Passed: X\n- Failed: X",
          "required": true,
          "rows": 14
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Debug Failed Tests",
      "description": "Investigate and fix failures.",
      "fields": [
        {
          "id": "debugging",
          "type": "textarea",
          "label": "Document debugging for each failure:",
          "placeholder": "Failure: EC-001 (Long company name)\n\nWhat was expected: Truncated to 100 chars\nWhat happened: Workflow crashed\nError message: Field length exceeded\n\nDebugging steps:\n1. Reproduced consistently: [Yes]\n2. Isolated to step: CRM creation\n3. Root cause: No length check before insert\n\nFix applied:\n- Added substring(0,100) before CRM insert\n\nRetest result: PASS\n\n---\n\nFailure: [next failure]\n...",
          "required": true,
          "rows": 18
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Forced Error Testing",
      "description": "Intentionally break things to verify error handling.",
      "fields": [
        {
          "id": "forced_errors",
          "type": "textarea",
          "label": "Document forced error tests:",
          "placeholder": "Test 1: API Timeout\n- Method: Invalid endpoint\n- Expected: Retry, then graceful fail\n- Verified: [error logged, alert sent, DLQ populated]\n- Result: [PASS/FAIL]\n\nTest 2: Invalid Data\n- Method: Malformed email\n- Expected: Validation catches early\n- Verified: [clear error, no partial data]\n- Result: ...\n\nTest 3: Network Failure\n- Method: [disconnect/mock]\n- Expected: Handles gracefully, can resume\n- Result: ...\n\nTest 4: Rate Limits\n- Method: Rapid operations\n- Expected: Backoff activates\n- Result: ...",
          "required": true,
          "rows": 18
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Integration Testing (Advanced)",
      "description": "Test each external connection.",
      "fields": [
        {
          "id": "integration_tests",
          "type": "textarea",
          "label": "Document integration test results:",
          "placeholder": "CRM Integration:\n| Test | Method | Result |\n| Create record | Submit form | PASS |\n| Duplicate handling | Same email | PASS |\n| Field mapping | All fields | PASS |\n\nEmail Integration:\n| Test | Method | Result |\n| Delivery | Check inbox | PASS |\n| Formatting | Visual check | PASS |\n| Personalization | Name inserted | PASS |\n\nSlack Integration:\n| Test | Method | Result |\n| Notification | Check channel | PASS |\n| Message format | Readable | PASS |",
          "required": false,
          "rows": 16
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: Performance Testing (Advanced)",
      "description": "Test under realistic load.",
      "fields": [
        {
          "id": "performance_tests",
          "type": "textarea",
          "label": "Document performance test results:",
          "placeholder": "| Scenario | Count | Time | Success | Fail | Avg Time |\n| Normal | 10 | 1 hour | 10 | 0 | 2.5s |\n| Peak | 10 | 5 min | 10 | 0 | 3.1s |\n| Stress | 50 | 10 min | 48 | 2 | 4.2s |\n\nBreaking point: ~X/minute\nBehavior under stress: [queuing/failures/delays]\nBottleneck identified: [which step]",
          "required": false,
          "rows": 10
        }
      ]
    },
    {
      "id": "part7",
      "title": "Part 7: Regression Suite (Advanced)",
      "description": "Build reusable test suite.",
      "fields": [
        {
          "id": "regression_suite",
          "type": "textarea",
          "label": "Document your regression suite:",
          "placeholder": "Core tests (must pass before any change):\n\n| Priority | Test ID | Description | Last Run | Result |\n| Critical | HP-001 | Standard lead | [date] | PASS |\n| Critical | ER-001 | Invalid email | [date] | PASS |\n| Critical | EC-002 | Intl chars | [date] | PASS |\n| High | HP-003 | Routing works | [date] | PASS |\n| High | ER-002 | Error handling | [date] | PASS |\n| Medium | EC-001 | Long names | [date] | PASS |\n\nRun frequency: Before each change\nAutomation: [Yes/No, how]",
          "required": false,
          "rows": 14
        }
      ]
    }
  ],
  "deliverables": [
    "Test plan with 20+ test cases",
    "Test execution results",
    "Debug documentation for failures",
    "Forced error test results",
    "Regression suite"
  ],
  "success_criteria": [
    "Comprehensive test plan covering all types",
    "All tests executed and documented",
    "All failures investigated and fixed",
    "Error handling verified through forced failures",
    "Regression suite ready for future use"
  ]
}'

WHERE slug = 'testing-debugging';
