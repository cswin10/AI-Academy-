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

Every automation has three core components: what starts it (trigger), what it does (actions), and what decisions it makes (conditions).

## Understanding Triggers

**Trigger** = the event that starts your automation

**Without a trigger, nothing happens.**

### Types of Triggers

**1. Event-Based (Instant)**
Something happens → automation runs immediately

Examples: Form submitted, email received, new database record, payment completed

**2. Scheduled (Time-Based)**
Automation runs at specific times

Examples: Every day at 9am, every Monday, first day of month

**3. Webhook (Push)**
External service sends data to your automation

Examples: Stripe payment notification, Shopify order details

**4. Manual (On-Demand)**
Person clicks a button to run

**5. Polling (Check Periodically)**
Automation checks for changes every X minutes

## Understanding Actions

**Action** = what the automation does

### Types of Actions

- **Data Operations:** Create, Read, Update, Delete
- **Communication:** Email, SMS, Slack, notifications
- **Processing:** Transform, analyze, calculate
- **Integration:** API calls, file operations
- **Control Flow:** Wait, branch, loop

## Understanding Conditions

**Condition** = decision point in automation

"If X, then do Y, otherwise do Z"

### Basic Conditions

- Comparison: If status = "New", If amount > 100
- Existence: If field is not empty
- Multiple: If (A AND B), If (A OR B)

## Building Automations

### Common Patterns

1. **Pipeline:** Trigger → Action 1 → Action 2 → Action 3
2. **Conditional Branch:** Trigger → Check → Path A or Path B
3. **Filter:** Trigger → Check → Continue or Stop
4. **Loop:** Trigger → Get List → For Each → Action
5. **Delay:** Trigger → Wait → Action

## Best Practices

### Triggers
- Choose the right trigger type
- Handle missing triggers
- Avoid duplicate triggers
- Test thoroughly

### Actions
- Make actions atomic (one thing each)
- Make actions idempotent (safe to run twice)
- Order matters
- Handle failures

### Conditions
- Make conditions clear
- Handle edge cases
- Avoid over-nesting
- Always have a default path',

  '## Exercise: Build Your First Complete Automation

**Objective:** Design and build a working automation with triggers, actions, and conditions.

### Part 1: Design a Lead Intake Automation

**Scenario:** You run a small consulting business

**Requirements:**
- Capture leads from website form
- Store in CRM
- Route based on service interest
- Send confirmation
- Notify team

**Design your flow with:**
- Trigger type and platform
- All actions in order
- Conditions for routing

### Part 2: Build It

Choose Zapier, Make, or n8n and build your automation.

### Part 3: Test Scenarios

Test with:
- Normal lead
- Edge case (missing phone)
- Invalid email
- High volume (5 forms rapidly)

### Part 4: Add Error Handling

Identify failure points and add handling.

### Part 5: Build Additional Automations

- Customer onboarding workflow
- Daily scheduled report

**Success Criteria:**
- Built at least 1 working automation
- Tested with multiple scenarios
- Handled edge cases
- Documented completely',

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

Automations need to make decisions. Good decision logic = smart automations. Bad logic = bugs and confusion.

## Boolean Logic Fundamentals

### AND
Both conditions must be true
```
If (amount > 100) AND (country = "US")
  → Apply discount
```

### OR
At least one condition must be true
```
If (source = "Website") OR (source = "Mobile App")
  → Track as digital lead
```

### NOT
Opposite/inverse of condition
```
If NOT (status = "Complete")
  → Continue processing
```

## Branching Patterns

### Pattern 1: If-Then
Single condition, single action

### Pattern 2: If-Then-Else
Two paths based on condition

### Pattern 3: If-Else If-Else
Multiple exclusive paths (first match wins)

### Pattern 4: Nested If
Decisions within decisions

### Pattern 5: Switch/Case
Multiple conditions on same field

## Edge Case Handling

- **Null/Empty Values:** Always check if data exists
- **Unknown States:** Handle unexpected values
- **Type Mismatches:** Verify data types

## Common Mistakes

1. Wrong operator (OR when you need AND)
2. Unreachable code (wrong order of conditions)
3. Missing default path
4. Over-complex nesting
5. Inconsistent data types

## Simplification Techniques

1. De Morgan''s Laws
2. Early returns
3. Lookup tables instead of many conditions',

  '## Exercise: Master Conditional Logic

**Objective:** Build complex conditional logic and test thoroughly.

### Part 1: Design Logic for Scenarios

**Scenario 1: Expense Approval**
- <$100 → Auto-approve
- $100-$500 → Manager approval
- >$500 → Finance approval
- Missing receipt → Always manual review

**Scenario 2: Support Ticket Routing**
- VIP customers → Senior support
- Bug reports → Engineering
- Billing issues → Finance
- Angry customers → Manager

**Scenario 3: E-commerce Order Processing**
- In stock + paid + US → Ship next day
- In stock + paid + International → Ship 3 days
- Out of stock + paid → Refund

### Part 2: Build It

Implement one scenario in your automation platform.

### Part 3: Test All Branches

Create test cases for every possible path.

### Part 4: Debug Broken Logic

Practice fixing logic errors.

**Success Criteria:**
- All scenarios designed correctly
- At least 1 built and tested
- Can explain AND vs OR vs NOT
- Can simplify complex logic',

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

Things will break. Always. The question is: what happens when they do?

## Types of Errors

### 1. Transient (Temporary)
- Network timeout, API rate limit, service temporarily down
- Solution: Retry with backoff

### 2. Permanent (Persistent)
- Invalid data, authorization failure, deleted record
- Solution: Log, alert, manual intervention

### 3. Partial Failures
- Some operations succeed, some fail
- Solution: Transaction management, rollback, completion tracking

## Error Handling Strategies

### Strategy 1: Retry with Exponential Backoff
Try → Wait 1s → Try → Wait 2s → Try → Wait 4s → Give up

### Strategy 2: Dead Letter Queue
Failed items go to a review queue for later processing

### Strategy 3: Graceful Degradation
Continue with reduced functionality if something fails

### Strategy 4: Circuit Breaker
Stop trying if service is consistently down

### Strategy 5: Compensating Transaction
Undo previous operations if later ones fail

## Monitoring & Alerting

**What to monitor:**
- Error rates
- Performance
- Health metrics

**When to alert:**
- Critical: Immediately
- Important: Daily summary
- Minor: Don''t alert

## Logging Best Practices

**Always log:**
- Error message, timestamp, operation, input data, context

**Don''t log:**
- Passwords, API keys, credit cards, sensitive personal data

## Error Handling Checklist

☐ Identified all failure points
☐ Decided handling for each failure
☐ Implemented retry logic
☐ Implemented logging
☐ Set up alerts
☐ Created manual review process
☐ Tested with invalid data
☐ Documented error handling',

  '## Exercise: Build Robust Error Handling

**Objective:** Implement comprehensive error handling in automations.

### Part 1: Identify Failure Points

For a lead intake workflow, identify everything that could fail:
- Form submission
- Email validation
- CRM record creation
- Data enrichment
- Slack notification
- Confirmation email

### Part 2: Design Error Handling Strategy

For each failure point, define:
- Type (transient/permanent)
- Action (retry/log/alert)
- Severity (critical/important/minor)

### Part 3: Implement Retry Logic

Build retry mechanism for API calls with exponential backoff.

### Part 4: Build Dead Letter Queue

Create a "Failed Operations" table and workflow.

### Part 5: Create Error Notification System

Set up alerts for critical errors.

### Part 6: Test Error Scenarios

Force failures and verify handling works.

**Success Criteria:**
- All failure points have handling
- Retry mechanism works
- Dead letter queue functional
- Alert system working
- Recovery process documented',

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

"It works on my machine" is not good enough. Proper testing = fewer bugs, more confidence, better sleep.

## Types of Testing

### 1. Unit Testing
Test individual components in isolation

### 2. Integration Testing
Test how components work together

### 3. End-to-End Testing
Test entire workflow start to finish

### 4. Regression Testing
Verify new changes didn''t break existing functionality

## What to Test

### Happy Path
Most common, normal scenarios

### Edge Cases
Unusual but valid scenarios (long names, special characters, boundary values)

### Error Scenarios
Things that should fail gracefully (missing fields, invalid data, API failures)

### Integration Points
Where systems connect (APIs, databases, email services)

## Debugging Workflow

1. **Reproduce:** Can you make it happen again?
2. **Isolate:** Where does it break?
3. **Check Logs:** What do logs say?
4. **Verify Assumptions:** Question everything
5. **Check Integrations:** External dependencies
6. **Minimal Example:** Strip down to simplest case
7. **Fix and Re-Test:** Apply fix, verify all tests pass

## Common Issues and Fixes

- "It worked yesterday" → API changed, service updated
- "Works sometimes" → Race condition, timeout, rate limiting
- "Wrong data output" → Field mapping, transformation error
- "Nothing happens" → Trigger not firing, filter blocking
- "Too slow" → Sequential operations, no caching

## Testing Checklist

☐ Happy path tested
☐ Edge cases tested
☐ Error scenarios tested
☐ Integration points tested
☐ Performance tested
☐ Security tested
☐ Regression tested
☐ Documentation updated',

  '## Exercise: Comprehensive Testing & Debugging

**Objective:** Learn to test and debug automation workflows systematically.

### Part 1: Create Test Plan

Create test cases for:
- Happy path (5-10 cases)
- Edge cases (5-10 cases)
- Error scenarios (5-10 cases)

### Part 2: Execute Test Plan

Run all test cases and document results.

### Part 3: Debug Failed Tests

For each failure:
1. Reproduce
2. Isolate
3. Find root cause
4. Fix
5. Re-test

### Part 4: Forced Error Testing

Test error handling by simulating:
- API timeout
- Invalid data
- Network failure
- Rate limits

### Part 5: Integration Testing

Test all integration points thoroughly.

### Part 6: Performance Testing

Test under normal and high volume.

### Part 7: Create Regression Suite

Build reusable test set for future changes.

**Success Criteria:**
- Comprehensive test plan
- All tests executed
- Bugs found and fixed
- Error handling verified
- Documentation complete',

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

Working automation ≠ optimized automation. Good automation runs fast, costs less, and scales smoothly.

## Why Optimize?

- **Lower costs:** Fewer operations, cheaper models
- **Faster execution:** Better user experience
- **More reliable:** Less likely to timeout
- **Scales better:** Handles increased volume
- **Maintainable:** Simpler is easier to maintain

## Measure First

**Don''t guess. Measure.**

- Execution time per step
- Total workflow time
- Cost per operation
- Operations per day/month
- Error rate

## Optimization Strategies

### 1. Parallel Execution
Run independent operations simultaneously instead of sequentially.

### 2. Batch Processing
Process multiple items together instead of one-by-one.

### 3. Caching
Store results to avoid recomputing for same inputs.

### 4. Reduce API Calls
Request all needed fields at once, use bulk endpoints.

### 5. Use Cheaper AI Models
Not every task needs GPT-4. Use GPT-4o-mini for simple tasks.

### 6. Optimize Prompts
Shorter prompts = lower costs.

### 7. Filter Early
Don''t process what you don''t need.

### 8. Schedule Non-Urgent Tasks
Batch non-urgent work for off-peak times.

### 9. Eliminate Redundancy
Don''t maintain multiple copies of same data.

### 10. Use Webhooks vs Polling
Webhooks are much more efficient than polling.

## Anti-Patterns

- Premature optimization (before it works)
- Over-engineering
- Optimizing the wrong thing
- Sacrificing reliability for speed
- Optimizing once (needs ongoing attention)

## When to Stop

Stop when:
- Cost savings < time investment
- Performance is "good enough"
- Complexity increases significantly
- Reliability suffers',

  '## Exercise: Optimize an Automation

**Objective:** Apply optimization techniques to real workflows.

### Part 1: Baseline Measurement

Choose an existing automation and measure:
- Total execution time
- Time per step
- Cost per operation
- Monthly cost
- Bottlenecks

### Part 2: Identify Opportunities

Analyze each step for optimization potential:
- Can it be parallelized?
- Can it be cached?
- Can it use cheaper models?
- Can it be filtered earlier?

### Part 3: Implement Optimizations

Apply at least 3 optimization techniques:
- Caching
- Cheaper models
- Parallel processing
- Early filtering

### Part 4: Measure Improvements

Compare before and after:
- Execution time
- Cost per operation
- Monthly cost

### Part 5: Cost-Benefit Analysis

For each optimization:
- Time to implement
- Savings achieved
- Payback period
- Worth it?

### Part 6: Create Optimization Playbook

Document reusable optimization strategies.

**Success Criteria:**
- Measurable improvements achieved
- Performance improved OR cost reduced
- Functionality maintained
- Changes documented
- Can apply to future automations',

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
