-- ============================================================================
-- UPDATE SECTION 6.3: Error Handling & Graceful Failures
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, remove any existing questions 5-8 to allow clean re-runs, then add 4 more to reach 8 total
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Error Handling Quiz')
AND order_index IN (5, 6, 7, 8);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Error Handling Quiz'), 5,
'How does error handling connect to the reliability principles in Section 5.1''s data flow design?',
'["Error handling is separate from data flow", "Error handling implements the failure handling patterns from data flow design, including retries, dead letter queues, and graceful degradation", "Data flow does not consider errors", "Only use error handling in the output layer"]',
1,
'Section 5.1 introduced failure handling as part of data flow design. This section provides the detailed implementation strategies for those concepts.'),

((SELECT id FROM quizzes WHERE title = 'Error Handling Quiz'), 6,
'What is exponential backoff and why is it important for retry logic?',
'["A way to speed up retries", "A strategy where wait time between retries increases exponentially, giving struggling services time to recover", "A database optimization", "A type of error message"]',
1,
'Exponential backoff (wait 1s, then 2s, then 4s, then 8s) prevents hammering a struggling service. It gives the external system time to recover before your next retry attempt.'),

((SELECT id FROM quizzes WHERE title = 'Error Handling Quiz'), 7,
'What is a circuit breaker pattern and when should you use it?',
'["A hardware component", "A pattern that stops sending requests to a failing service after multiple failures, preventing cascade failures", "A way to delete errors", "An encryption method"]',
1,
'Circuit breakers prevent cascade failures. After detecting repeated failures (e.g., 5 in 60 seconds), they stop requests entirely for a cooldown period before testing again.'),

((SELECT id FROM quizzes WHERE title = 'Error Handling Quiz'), 8,
'How does the I-T-O framework apply to designing error recovery processes?',
'["I-T-O does not apply to error handling", "Input is the failed operation and error details, Task is the recovery strategy, Output is either successful retry or escalation", "Only Output matters for errors", "Error handling replaces I-T-O"]',
1,
'Error recovery is itself an I-T-O operation: the failed state as input, recovery logic as task, and restored operation or escalation as output.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Error Handling & Graceful Failures

Things will break. Always. The question is not "will my automation fail?" but "what happens when it does?" Good error handling separates amateur automations from production-ready systems. This section implements the failure handling concepts introduced in Section 5.1.

## Definitions

**Error Handling**: The practice of anticipating, detecting, and responding to failures in a controlled manner.

**Transient Error**: A temporary error that may succeed if retried. Examples include network timeouts, rate limits, and temporary service unavailability.

**Permanent Error**: An error that will not fix itself regardless of retries. Examples include invalid data, authentication failures, and resources not found.

**Partial Failure**: A scenario where some operations in a workflow succeed while others fail, leaving the system in an incomplete state.

**Exponential Backoff**: A retry strategy where wait time between attempts increases exponentially (1 second, 2 seconds, 4 seconds, 8 seconds).

**Dead Letter Queue**: A storage location for failed operations that require human review and manual processing.

**Circuit Breaker**: A pattern that stops sending requests to a consistently failing service, preventing cascade failures.

**Graceful Degradation**: Continuing with reduced functionality when non-critical components fail.

**Compensating Transaction**: An operation that undoes the effects of a previous operation, enabling rollback after partial failures.

**Idempotency**: The property where running an operation multiple times produces the same result as running it once, making retries safe.

## Why Errors Happen

Every automation has multiple points of failure:

**External Dependencies**

APIs go down without warning. Services experience outages during peak hours. Rate limits get hit when processing volume spikes. Credentials expire or get revoked. Third-party services change their APIs without notice.

**Data Issues**

Invalid input data arrives that does not match expected formats. Required fields are missing from submissions. Unexpected data formats break parsing. Encoding problems corrupt text. Payloads exceed size limits.

**Logic Problems**

Edge cases are not handled in conditional logic. Race conditions occur when multiple processes access shared resources. Operations exceed timeout limits. Memory or other resources become exhausted.

The only guarantee: Something will eventually fail. Design for this reality.

## Types of Errors

### Transient Errors (Temporary)

These may succeed if you try again. The underlying problem is temporary.

Examples of transient errors: Network timeout where the request did not complete. API rate limit exceeded where you sent too many requests. Service temporarily unavailable returning 503 status. Connection reset where the network dropped. Temporary resource contention where the server was briefly overloaded.

Strategy for transient errors: Retry with exponential backoff. Wait longer between each attempt to give the system time to recover.

### Permanent Errors (Persistent)

These will NOT fix themselves. Retrying is pointless and wastes resources.

Examples of permanent errors: Invalid data format that cannot be parsed. Authentication failure returning 401 status. Resource not found returning 404 status. Permission denied returning 403 status. Validation errors where data violates business rules.

Strategy for permanent errors: Log the error with full context, alert appropriate people, and require human intervention. Do not retry.

### Partial Failures

Some operations succeed while others fail within the same workflow.

Example scenario: Step 1 creates CRM record (succeeds). Step 2 sends email (succeeds). Step 3 creates invoice (fails with API error). Step 4 notifies team (skipped because step 3 failed).

Now the system is in an incomplete state: Customer exists, email was sent, but no invoice was created and the team was not notified.

Strategy for partial failures: Implement transaction management with rollback capability, or track completion state so you can resume from where you left off.

## Error Handling Strategies

### Strategy 1: Retry with Exponential Backoff

For transient errors, retry with increasing delays between attempts.

Attempt 1 executes immediately and fails. Wait 1 second. Attempt 2 executes and fails. Wait 2 seconds. Attempt 3 executes and fails. Wait 4 seconds. Attempt 4 executes and fails. Wait 8 seconds. Attempt 5 executes and fails. After maximum retries reached, give up and escalate to human review. Total wait time: 15 seconds. Maximum attempts: 5.

Why exponential backoff works: It gives the struggling system time to recover. It avoids hammering a service that is already overloaded. It reduces the chance of cascading failures across dependent systems.

### Strategy 2: Dead Letter Queue

Failed items go to a review queue for later processing rather than being lost.

Normal flow: Item enters processing, succeeds, and completes normally.

Flow with dead letter queue: Item enters processing and fails. Instead of being lost, it goes to the dead letter queue. A human reviews the queue, fixes issues, and reprocesses items.

Implementation approach: Create a "Failed Operations" table or spreadsheet with columns for timestamp, operation name, input data, error message, retry count, and status (pending review, retrying, resolved, abandoned). Log every failure with full context. Review the queue regularly and reprocess items manually or automatically.

### Strategy 3: Graceful Degradation

Continue with reduced functionality when non-critical parts fail.

Example full process: Save to primary database (succeeds). Sync to backup (fails). Send notification (succeeds). Update analytics (fails).

With graceful degradation: The core function (save) succeeded. Non-critical functions (backup sync, analytics) failed but are logged for later retry. The operation continues because the essential work completed.

Use this pattern when some functionality is more important than others. Prioritize core operations over nice-to-have features.

### Strategy 4: Circuit Breaker

Stop trying if a service is consistently failing. This prevents wasting resources and allows the failing service to recover.

Normal state: Requests flow through normally to the external service.

After multiple failures detected (for example, 5 failures in 60 seconds): Circuit opens and stops all requests to the failing service.

During cooldown period (for example, 5 minutes): No requests are sent. The service has time to recover.

After cooldown, circuit enters half-open state: A single test request is sent. If it succeeds, the circuit closes and normal operation resumes. If it fails, the circuit remains open for another cooldown period.

Benefits: Prevents cascade failures from spreading. Gives failing services time to recover. Fails fast instead of waiting for slow timeouts.

### Strategy 5: Compensating Transactions

Undo previous operations if later ones fail, restoring the system to a consistent state.

Example order processing: Step 1 charges credit card (succeeds). Step 2 reserves inventory (succeeds). Step 3 creates shipping label (fails).

Compensation sequence: For step 3, nothing to undo since it failed. For step 2, release the inventory reservation. For step 1, refund the credit card charge. Result is a clean state with customer notified.

Important principle: Design operations to be reversible when possible. Some operations (like sending an email) cannot be undone, so sequence matters.

## Monitoring and Alerting

### What to Monitor

**Error Rates**: Track errors per hour or day. Track error rate as a percentage of total operations. Track error trends over time.

**Performance**: Monitor execution time per step. Track end-to-end latency from trigger to completion. Monitor queue depths for backlogs.

**Health Indicators**: Track API response times. Monitor authentication status. Check resource utilization.

### When to Alert

Not all errors need immediate attention. Match response urgency to severity.

Critical errors like payment failures or data loss need immediate response. Alert via SMS or phone.

High severity errors where main workflows are broken need response within an hour. Alert via Slack or email.

Medium severity errors where non-critical features are down can wait until the same business day. Send a daily digest.

Low severity errors like minor issues or warnings can wait for weekly review. Log only without alerting.

### Alert Best Practices

Be specific in alert messages. Vague alerts like "Automation failed" do not help. Specific alerts like "Lead intake automation failed: CRM API timeout. 3 leads queued for retry. Retry scheduled in 5 minutes." tell you what happened, why, what is affected, and what action is being taken.

Include context: What exactly failed? Why did it fail (if known)? What data was affected? What action is needed from humans?

Avoid alert fatigue: Group similar errors together. Set appropriate thresholds before alerting. Suppress alerts during known maintenance windows.

## Logging Best Practices

### What to Log

Always log: Timestamp with timezone. Operation or action name. Input data (sanitized to remove secrets). Result (success or failure). Error message and error code if applicable. Execution duration. Correlation or trace ID to link related operations.

Example log structure: Timestamp 2024-01-15T14:30:00Z, operation create_crm_record, status failure, error code RATE_LIMIT, error message "API rate limit exceeded", input shows email and name (sanitized), duration 2340 milliseconds, trace ID abc-123-def-456, retry count 2.

### What NOT to Log

Never log sensitive data: Passwords, API keys and secrets, full credit card numbers, social security numbers, personal health information, unencrypted personal data.

Sanitize before logging. Instead of logging "Processing payment for card 4111111111111111", log "Processing payment for card ending in 1111" or "Processing payment for card ****1111".

## Error Handling Patterns in Practice

### Pattern: Wrapper with Error Handling

For each operation: Try to execute the operation and log success. If a transient error occurs, retry with exponential backoff. If maximum retries are exceeded, add to dead letter queue and alert if critical. If a permanent error occurs, log error details, skip to the next item, and alert if critical. In all cases, record execution time and update monitoring metrics.

### Pattern: Pre-Validation

Before processing begins: Validate all required fields exist. Validate data formats are correct. Validate external services are available.

If validation fails: Do not start processing. Return a clear error message. Log the validation failure.

This prevents wasted effort on data that will inevitably fail later.

### Pattern: Checkpoints for Long Workflows

For workflows with many steps, save state at checkpoints.

In a 10-step workflow: After step 3, save checkpoint. After step 6, save checkpoint. After step 9, save checkpoint.

If failure occurs at step 7: Do not restart from the beginning. Resume from the step 6 checkpoint. The state is saved so processing can continue later.

## Error Recovery Playbook

When an error occurs, follow this sequence:

Step 1 Identify: What type of error is it? Transient or permanent?

Step 2 Assess: What is the impact? How many items are affected?

Step 3 Contain: Stop further damage if needed. Pause the automation if errors are cascading.

Step 4 Recover: Fix the underlying issue or retry the failed items.

Step 5 Learn: Update the automation to prevent recurrence.

Step 6 Document: Record what happened and how it was resolved for future reference.

## Connection to Earlier Modules

Error handling implements concepts from Section 5.1 on data flow. The failure handling patterns (retries, dead letter queues, graceful degradation) introduced there are fully implemented here.

Error handling also connects to the execution layer of Module 2''s 4-layer model. The execution layer must handle failures in actions. Good error handling makes the execution layer reliable.

The I-T-O framework from Module 2 applies to error recovery itself: Input is the failed operation and error details. Task is the recovery strategy (retry, escalate, rollback). Output is either successful retry or escalation to human review.',

exercise_markdown = '## Exercise: Build Robust Error Handling

**Objective:** Implement comprehensive error handling that makes your automations production-ready, applying concepts from Section 5.1 and Module 2.

### Part 1: Identify Failure Points

Take the lead intake automation from Section 6.1 and identify every point that could fail.

Workflow steps to analyze:

1. Form submission trigger
2. Data validation
3. CRM record creation
4. Lead enrichment via external API
5. Slack notification
6. Confirmation email

For each step, document in a table:

Step number and name. What could fail (API timeout, invalid data, rate limit, etc.). Error type (transient or permanent). Likelihood (low, medium, high). Impact (low, medium, high).

Example row: Step 1 Form trigger, failure could be platform outage, error type transient, likelihood low, impact high.

Complete the table for all 6 steps.

### Part 2: Design Error Handling Strategy

For each failure point, define the handling approach in a table:

Failure description. Strategy (retry, dead letter queue, graceful degradation, etc.). Whether to retry and how many times. Whether to alert and via what channel. Fallback action if all else fails.

Example row: CRM API timeout, strategy retry with exponential backoff, retry 3 times, alert if all retries fail via Slack, fallback is dead letter queue.

### Part 3: Implement Retry Logic

Build a retry mechanism in your automation platform:

Create a retry counter as a variable or field in your workflow.

Implement the retry loop: Attempt the operation. If it fails and retries are less than maximum: Increment the counter. Wait with exponential delay (1 second, then 2, then 4). Loop back to retry. If it fails and retries equal or exceed maximum: Add to dead letter queue. Send alert notification.

Document your implementation with screenshots or detailed step descriptions.

### Part 4: Build Dead Letter Queue

Create a system for capturing failed operations.

Create a "Failed Operations" table with columns: Timestamp of failure. Operation name that failed. Input data as JSON. Error message received. Error code if available. Number of retry attempts. Status (pending_review, retrying, resolved, abandoned).

Build automation to: Add failed items to the queue automatically. Include all relevant context for debugging.

Build a review process: How will you check the queue (daily review, alert thresholds)? How will you reprocess items (manual trigger, batch process)?

### Part 5: Create Error Notification System

Set up alerts for critical errors.

Define alert thresholds: Which errors are critical and need immediate attention? What rate of errors triggers an alert?

Build the notification: Choose channel (Slack, email, SMS based on severity). Include error type, count, affected items, and suggested action.

Test the alert: Trigger a test error intentionally. Verify notification is received. Verify the information is actionable.

### Part 6: Test Error Scenarios

Force failures and verify your handling works correctly.

Test 1 API Timeout: Simulate by using an invalid API endpoint or adding artificial delay. Expected behavior is retry 3 times with increasing waits, then fail gracefully. Verify error is logged, alert is sent, and item goes to dead letter queue.

Test 2 Invalid Data: Submit form with obviously invalid email format. Expected behavior is validation fails immediately without retries. Verify clear error is logged and processing stops cleanly.

Test 3 Partial Failure: Make one step fail in the middle of the workflow. Expected behavior is earlier steps succeed, failure is logged, and alert is sent. Verify system state is recoverable.

Test 4 Multiple Rapid Failures: Trigger 5 errors in 1 minute. Expected behavior is grouped alert rather than 5 separate notifications. Verify alerting does not create noise.

### Part 7: Document Recovery Procedures

Create a runbook for handling failures.

Document CRM API Failures: Check API status page for known outages. If outage, wait for resolution. If credentials issue, check and refresh. Reprocess from dead letter queue once resolved.

Document Invalid Data Errors: Review failed records for patterns. Identify if source validation needs improvement. Manually process or mark as abandoned.

Document Cascade Failures: Pause the automation immediately. Assess total impact. Fix root cause before resuming. Reprocess affected items.

### Scope Note

This exercise is comprehensive. For core mastery, prioritize Parts 1-5 (failure identification, strategy design, retry logic, dead letter queue, and notifications). Parts 6-7 (testing and runbook) are valuable for production readiness but can be completed in a second pass.

### Deliverables

Failure point analysis table for all workflow steps. Error handling strategy document. Working retry mechanism with exponential backoff. Functional dead letter queue with review process. Alert system tested and verified. Recovery runbook.

### Success Criteria

All failure points identified and documented. Retry mechanism handles transient errors appropriately. Dead letter queue captures permanent failures. Alerts fire for critical errors. Recovery process is documented and tested.',

exercise_schema = '{
  "exercise_id": "6.3-error-handling",
  "title": "Build Robust Error Handling",
  "objectives": [
    "Identify all failure points in a workflow",
    "Design error handling strategy for each failure",
    "Implement retry logic with exponential backoff",
    "Build dead letter queue for failed operations",
    "Create error notification system",
    "Test error scenarios",
    "Document recovery procedures"
  ],
  "parts": [
    {
      "part_number": 1,
      "title": "Identify Failure Points",
      "type": "analysis",
      "task": "Document potential failures for each workflow step",
      "elements": ["step", "failure_type", "error_type", "likelihood", "impact"]
    },
    {
      "part_number": 2,
      "title": "Design Error Handling Strategy",
      "type": "design",
      "task": "Define handling approach for each failure",
      "elements": ["strategy", "retry_count", "alert_channel", "fallback"]
    },
    {
      "part_number": 3,
      "title": "Implement Retry Logic",
      "type": "implementation",
      "task": "Build retry mechanism with exponential backoff",
      "pattern": "exponential_backoff",
      "documentation_required": true
    },
    {
      "part_number": 4,
      "title": "Build Dead Letter Queue",
      "type": "implementation",
      "task": "Create system for capturing failed operations",
      "columns": ["timestamp", "operation", "input_data", "error_message", "retry_count", "status"]
    },
    {
      "part_number": 5,
      "title": "Create Error Notification System",
      "type": "implementation",
      "task": "Set up alerts for critical errors",
      "elements": ["thresholds", "channels", "message_content", "testing"]
    },
    {
      "part_number": 6,
      "title": "Test Error Scenarios",
      "type": "testing",
      "task": "Force failures and verify handling",
      "scenarios": ["api_timeout", "invalid_data", "partial_failure", "rapid_failures"],
      "priority": "secondary"
    },
    {
      "part_number": 7,
      "title": "Document Recovery Procedures",
      "type": "documentation",
      "task": "Create recovery runbook",
      "sections": ["api_failures", "data_errors", "cascade_failures"],
      "priority": "secondary"
    }
  ],
  "scope_note": "Parts 1-5 are core. Parts 6-7 are for production readiness.",
  "deliverable": {
    "format": "documentation_and_implementation",
    "components": ["failure_analysis", "strategy_document", "retry_mechanism", "dead_letter_queue", "alert_system", "runbook"]
  },
  "success_criteria": [
    "All failure points documented",
    "Retry mechanism handles transient errors",
    "Dead letter queue captures permanent failures",
    "Alerts fire for critical errors",
    "Recovery process documented"
  ],
  "estimated_time_minutes": 90,
  "connections": {
    "section_5_1": "Data flow failure handling patterns",
    "module_2": "Execution layer reliability",
    "section_6_1": "Action error handling"
  }
}'

WHERE slug = 'error-handling';
