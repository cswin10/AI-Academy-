-- ============================================================================
-- UPDATE SECTION 7.2: Estimating Time & Effort
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, remove any existing questions 5-8 to allow clean re-runs, then add 4 more to reach 8 total
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Estimation Quiz')
AND order_index IN (5, 6, 7, 8);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Estimation Quiz'), 5,
'What is Reference Class Forecasting?',
'["A method for classifying projects by size", "Basing estimates on actual outcomes of similar past projects", "A type of project documentation", "Sorting clients into reference groups"]',
1,
'Reference Class Forecasting uses data from similar past projects to ground estimates in reality rather than optimism.'),

((SELECT id FROM quizzes WHERE title = 'Estimation Quiz'), 6,
'What is the three-point estimation formula?',
'["Add optimistic plus pessimistic, divide by two", "(Optimistic + 4 times Most Likely + Pessimistic) divided by 6", "Average all three estimates equally", "Always use the pessimistic number"]',
1,
'The PERT formula weights the most likely estimate four times while accounting for best and worst cases.'),

((SELECT id FROM quizzes WHERE title = 'Estimation Quiz'), 7,
'Why should you give clients a range rather than a single number?',
'["To avoid commitment", "Ranges acknowledge uncertainty honestly and provide flexibility", "Clients prefer ranges", "Single numbers are unprofessional"]',
1,
'A range like 60 to 70 hours is more honest than 65 hours. It acknowledges uncertainty and gives you flexibility.'),

((SELECT id FROM quizzes WHERE title = 'Estimation Quiz'), 8,
'What should you do when you realize your estimate was wrong mid-project?',
'["Work overtime to meet the original deadline", "Communicate early with a revised estimate and options", "Wait until the deadline passes to explain", "Add buffer to future projects only"]',
1,
'Early communication preserves trust. Explain what changed and give the client options.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Estimating Time & Effort

Estimation is hard. Everyone underestimates. Understanding why estimates fail and how to improve them is the difference between sustainable work and constant deadline stress.

## Definitions

**Estimate**: A prediction of how much time or effort a task will require. Estimates are educated guesses, not commitments.

**Planning Fallacy**: The cognitive bias where we underestimate task duration despite past experience.

**Contingency Buffer**: Extra time added to estimates to account for unknowns. Buffer is realistic acknowledgment of uncertainty.

**Reference Class Forecasting**: Estimating based on actual outcomes of similar past projects rather than ideal-case planning.

**Three-Point Estimation**: A technique using optimistic, most likely, and pessimistic estimates to calculate a weighted average.

**T-Shirt Sizing**: A quick estimation method using relative sizes (XS, S, M, L, XL) for early ballpark estimates.

**Variance**: The difference between estimated and actual time. Tracking variance improves future estimates.

**Productive Hours**: The actual hours available for focused project work after accounting for meetings and interruptions.

## Why Estimates Are Difficult

Three fundamental problems make estimation challenging.

### Unknown Unknowns

You do not know what you do not know. You estimate 2 days for a task, then discover the API does not support the feature you need, the data format is inconsistent, or client access is delayed. Your 2-day estimate becomes 2 weeks.

### Optimism Bias (Planning Fallacy)

We are wired to be optimistic. Last time took 3 weeks, but we tell ourselves this time will be faster. It rarely is.

### Incomplete Information

You estimate before you have all the details. Early estimate: "Automation project, probably 1 week." After discovery: "Actually they need 5 integrations and migration of historical data. 6 weeks." Estimates improve as information increases.

**Real-world example: Agency lead flow.** A marketing agency asks for help automating their lead handoff to sales. Initial estimate: 20 hours. After discovery call: they have 4 different lead sources, 3 different CRMs for different clients, and need custom routing logic based on lead score. Revised estimate: 60 hours.

## The Estimation Process

### Step 1: Break Down the Work

Do not estimate "the project." Estimate individual tasks.

**Bad approach**: Build automation, 2 weeks.

**Good approach**: Break it into components.

Setup and Discovery. Kickoff meeting takes 1 hour. Getting access to systems takes 2 hours including waiting. Reviewing current process takes 2 hours. Total setup is 5 hours.

Building. Design workflow takes 3 hours. Set up trigger takes 1 hour. Build data validation takes 2 hours. Create CRM integration takes 4 hours. Set up email automation takes 2 hours. Add Slack notifications takes 1 hour. Error handling takes 2 hours. Total building is 15 hours.

Testing. Unit testing takes 3 hours. Integration testing takes 2 hours. Edge case testing takes 2 hours. Bug fixes take 4 hours. Total testing is 11 hours.

Documentation and Training. Write documentation takes 3 hours. Create training materials takes 2 hours. Training session takes 2 hours. Total documentation is 7 hours.

Project Management. Client meetings take 4 hours. Updates and communication take 2 hours. Total project management is 6 hours.

Grand total is 44 hours.

### Step 2: Add Historical Data

What did similar tasks actually take in past projects?

Track your work over time. Past CRM integrations: Project A estimated 4 hours, actual was 6 hours. Project B estimated 3 hours, actual was 5 hours. Project C estimated 5 hours, actual was 7 hours. Average shows estimates are 50% too low.

For the current project you estimate 4 hours, but the reality check says probably 6 hours based on historical pattern.

### Step 3: Add Complexity Multipliers

Not all tasks are equal complexity.

**Multipliers by familiarity and complexity.** Standard task done many times: multiply by 1.0. New tool you have not used before: multiply by 1.5. Complex logic with many conditions: multiply by 2.0. Multiple integrations required: multiply by 2.5. Unknown territory: multiply by 3.0.

**Caution:** Multipliers are a starting point. Always validate with detailed breakdown and historical data.

**Example calculation.** CRM integration base estimate is 4 hours. Multiply by 1.5 for new CRM system. Multiply by 2.0 for complex conditional logic. Adjusted estimate is 4 times 1.5 times 2.0, which equals 12 hours.

### Step 4: Add Contingency Buffer

Things go wrong. Buffer is realistic, not dishonest.

**Contingency guidelines by uncertainty level.** Low uncertainty when you have done the exact task before: add 15 to 25 percent buffer. Medium uncertainty when you have done similar tasks: add 25 to 40 percent buffer. High uncertainty when entering new territory: add 40 to 100 percent buffer.

**Example calculation.** Core work is 44 hours. Uncertainty is medium. Buffer is 30 percent. Total estimate is 44 times 1.3, which equals 57 hours. Round up to 60 hours.

### Step 5: Consider Context Factors

Calendar time is not the same as work time.

Eight hours of actual work does not equal 8 hours of calendar time due to interruptions.

**Productivity factors to subtract.** Client calls take about 2 hours per week. Other projects take about 10 hours per week. Urgent issues take about 3 hours per week.

Your 40-hour week typically produces 25 productive hours for a single project.

**Timeline calculation.** Project needs 60 hours of work. Your availability is 25 hours per week. Timeline is 60 divided by 25, which equals 2.4 weeks. Round up to 3 weeks.

## Estimation Techniques

### Technique 1: Reference Class Forecasting

Base estimates on similar past projects, not ideal scenarios.

**Steps.** Find 3 to 5 similar past projects. Look at actual time, not estimates. Average them. Adjust for differences.

### Technique 2: Three-Point Estimation

Best case, likely case, worst case combined with a weighted formula.

**Formula.** Estimate equals Optimistic plus 4 times Most Likely plus Pessimistic, all divided by 6.

**Example for CRM Integration.** Optimistic is 3 hours with perfect API docs. Most Likely is 5 hours with standard complexity. Pessimistic is 12 hours with API issues. Estimate equals 3 plus 20 plus 12, all divided by 6, which equals 5.8 hours.

### Technique 3: T-Shirt Sizing

For early or rough estimates when you need a quick ballpark.

**Sizes.** XS is less than 4 hours. S is 4 to 8 hours. M is 8 to 16 hours. L is 16 to 40 hours. XL is 40 to 80 hours. XXL is more than 80 hours and needs to be broken down further.

### Technique 4: Bottom-Up Estimation

Sum all individual tasks. Most accurate when tasks are well-defined and you have done similar work before.

### Technique 5: Top-Down Estimation

Based on overall project size. Useful for very early estimates and sanity checking bottom-up estimates.

Combine top-down and bottom-up for best results.

## Common Estimation Mistakes

**Forgetting Non-Building Time.** People estimate coding time but forget meetings, testing, debugging, documentation, and waiting for access. Add 30 to 50 percent for these activities.

**No Contingency.** Saying it will take exactly 40 hours is overconfident. It will take 40 to 70 hours depending on what goes wrong.

**Anchoring on Client Expectation.** Client says this should take about 1 week. You agree without doing your own estimate.

**Ignoring Past Data.** Last time took 3 weeks, but you tell yourself this time will be different.

**Too Precise.** Saying 43.7 hours fools no one. Round to reasonable increments.

**Not Tracking Actuals.** You estimate but never record actual time. Track estimated hours, actual hours, variance, and reasons for variance.

## Presenting Estimates

### To Clients

Use this format with appropriate currency for your client.

"Based on the scope we discussed, I estimate this project will take approximately 60 to 70 hours of work, which translates to about 2 to 3 weeks of calendar time.

This includes building the automation at 40 hours, testing and debugging at 15 hours, documentation and training at 10 hours, and project management and meetings at 5 hours.

The timeline assumes timely access to all systems, no major scope changes, and availability for weekly check-ins.

The range accounts for potential integration challenges and edge cases discovered during testing.

I will provide weekly updates on progress and flag any issues early."

**Key points.** Give a range, not a single number. Explain what is included. State assumptions. Explain why there is a range.

### When You Are Wrong

What matters is how you handle it.

**Discover early.** Track actual versus estimated regularly. Raise red flags early.

**Communicate quickly.** Tell the client: I originally estimated 2 weeks. I am now 1 week in and about 30 percent complete. Revised estimate is 3 to 4 weeks. Here is why.

**Explain, do not excuse.** Share what changed. Offer options such as reducing scope to meet deadline or extending timeline.

## Improving Your Estimates

**Track Everything.** For every project record estimated hours, actual hours, variance percentage, and reasons for variance.

**Regular Review.** Monthly review last month''s projects. Calculate average variance. Identify patterns.

**Break Your Patterns.** Identify whether you always underestimate setup time, forget about testing, or are optimistic about new tools.

**Calibrate with Peers.** Ask other operators how long they would estimate a similar task.

**Be Honest.** Do not give estimates you do not believe in. If you think it is 3 weeks, do not say 1 week to please the client.

## Quick Summary

- Break projects into tasks before estimating the whole.
- Historical data beats optimism every time.
- Present ranges with assumptions, not single numbers.

## Operator Principles

- Base estimates on past actuals, not ideal scenarios.
- Add buffer proportional to uncertainty level.
- Present ranges and state assumptions explicitly.
- Communicate early when estimates prove wrong.',

exercise_markdown = '## Exercise: Estimate a Real Project

**Timebox: 45 minutes | Stretch: 90 minutes**

Practice project estimation using multiple techniques.

### Part 1: Break Down Work

Using the customer onboarding automation from Section 7.1, break down all work into specific tasks with time estimates.

Include setup and discovery, building, testing, documentation, and project management.

### Part 2: Apply Historical Adjustment

Think about similar projects you have done or imagine realistic historical data.

Apply historical adjustment factors to your estimates.

### Part 3: Three-Point Estimation

For the 3 riskiest tasks in your breakdown, apply three-point estimation with optimistic, most likely, and pessimistic values.

### Part 4: Calculate Timeline

Convert your work hours to calendar time considering realistic productive hours per week.

### Part 5: Present to Client

Write a professional estimate presentation suitable for sending to a client.

### Part 6: Plan for Variance

Describe how you would track and communicate if the project takes longer than estimated.

### Deliverables

Work breakdown with estimates. Historical adjustment applied. Three-point estimation for risky tasks. Calendar timeline. Client presentation. Variance handling plan.

### Success Criteria

All work types included in breakdown. Buffer appropriate to uncertainty. Range provided rather than single number. Assumptions stated clearly.',

exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Work Breakdown",
      "description": "Break down the customer onboarding automation into specific tasks.",
      "fields": [
        {
          "id": "setup_tasks",
          "type": "textarea",
          "label": "Setup and Discovery tasks with hours:",
          "placeholder": "Kickoff meeting: 1 hour\nGet access to Stripe, CRM, Drive, Slack: 3 hours\nReview current process in detail: 2 hours\nDocument requirements: 2 hours\n\nTotal Setup: 8 hours",
          "required": true,
          "rows": 8
        },
        {
          "id": "building_tasks",
          "type": "textarea",
          "label": "Building tasks with hours:",
          "placeholder": "Design workflow architecture: 3 hours\nStripe webhook integration: 4 hours\nCRM record creation: 3 hours\nCredential generation: 2 hours\nWelcome email automation: 3 hours\nGoogle Drive folder creation: 2 hours\nSlack invitation automation: 2 hours\nTeam notification: 1 hour\nError handling: 4 hours\n\nTotal Building: 24 hours",
          "required": true,
          "rows": 14
        },
        {
          "id": "testing_tasks",
          "type": "textarea",
          "label": "Testing tasks with hours:",
          "placeholder": "Unit testing each component: 4 hours\nIntegration testing end-to-end: 3 hours\nEdge case testing: 2 hours\nBug fixes: 5 hours\nUser acceptance testing: 2 hours\n\nTotal Testing: 16 hours",
          "required": true,
          "rows": 8
        },
        {
          "id": "other_tasks",
          "type": "textarea",
          "label": "Documentation and PM tasks with hours:",
          "placeholder": "Documentation:\nWrite system documentation: 3 hours\nCreate runbook for errors: 2 hours\nTraining materials: 2 hours\nTraining session: 1 hour\n\nProject Management:\nClient meetings (4 x 30 min): 2 hours\nStatus updates: 1 hour\n\nTotal Other: 11 hours",
          "required": true,
          "rows": 12
        },
        {
          "id": "total_calculation",
          "type": "textarea",
          "label": "Total hours calculation:",
          "placeholder": "Setup: 8 hours\nBuilding: 24 hours\nTesting: 16 hours\nDocs/PM: 11 hours\n\nSubtotal: 59 hours",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Historical Adjustment",
      "description": "Apply adjustments based on past project data.",
      "fields": [
        {
          "id": "historical_data",
          "type": "textarea",
          "label": "Similar past projects (real or imagined):",
          "placeholder": "Past onboarding automation projects:\n- Project A: Estimated 50 hours, Actual 65 hours (+30%)\n- Project B: Estimated 40 hours, Actual 52 hours (+30%)\n- Project C: Estimated 55 hours, Actual 60 hours (+9%)\n\nAverage variance: +23%",
          "required": true,
          "rows": 8
        },
        {
          "id": "complexity_factors",
          "type": "textarea",
          "label": "Complexity multipliers for this project:",
          "placeholder": "Factors:\n- Stripe integration: Done before (x1.0)\n- New CRM system: Never used (x1.3)\n- Multiple integrations (4): Moderate complexity (x1.2)\n- Error handling: Standard approach (x1.0)\n\nCombined factor: 1.3 x 1.2 = 1.56 for complex portions",
          "required": true,
          "rows": 8
        },
        {
          "id": "adjusted_estimate",
          "type": "textarea",
          "label": "Adjusted estimate with buffer:",
          "placeholder": "Base estimate: 59 hours\nHistorical adjustment (+23%): 73 hours\nUncertainty buffer (medium, +30%): 95 hours\n\nRounded: 95-100 hours",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Three-Point Estimation",
      "description": "Apply three-point estimation to the riskiest tasks.",
      "fields": [
        {
          "id": "risky_task_1",
          "type": "textarea",
          "label": "Risky task 1 (three-point estimate):",
          "placeholder": "Task: Stripe webhook integration\n\nOptimistic: 2 hours (clean API, no issues)\nMost Likely: 4 hours (standard integration)\nPessimistic: 10 hours (API quirks, authentication issues)\n\nEstimate = (2 + 4x4 + 10) / 6 = 4.7 hours\nRounded: 5 hours",
          "required": true,
          "rows": 8
        },
        {
          "id": "risky_task_2",
          "type": "textarea",
          "label": "Risky task 2 (three-point estimate):",
          "placeholder": "Task: Error handling across all integrations\n\nOptimistic: 2 hours (straightforward)\nMost Likely: 4 hours (typical edge cases)\nPessimistic: 12 hours (complex failure modes)\n\nEstimate = (2 + 4x4 + 12) / 6 = 4.7 hours\nRounded: 5 hours",
          "required": true,
          "rows": 8
        },
        {
          "id": "risky_task_3",
          "type": "textarea",
          "label": "Risky task 3 (three-point estimate):",
          "placeholder": "Task: CRM integration (new system)\n\nOptimistic: 2 hours (great API, familiar patterns)\nMost Likely: 4 hours (learning curve, some issues)\nPessimistic: 8 hours (poor docs, API limitations)\n\nEstimate = (2 + 4x4 + 8) / 6 = 4.3 hours\nRounded: 5 hours",
          "required": true,
          "rows": 8
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Calendar Timeline",
      "description": "Convert work hours to calendar time.",
      "fields": [
        {
          "id": "availability",
          "type": "textarea",
          "label": "Your realistic availability:",
          "placeholder": "Weekly hours: 40\nMinus other projects: -15\nMinus meetings/admin: -5\nMinus interruptions: -5\n\nProductive hours for this project: 15 hours/week",
          "required": true,
          "rows": 7
        },
        {
          "id": "timeline_calc",
          "type": "textarea",
          "label": "Timeline calculation:",
          "placeholder": "Total work: 95 hours\nWeekly availability: 15 hours\nCalendar weeks: 95 / 15 = 6.3 weeks\n\nRounded: 6-7 weeks\n\nWith milestones:\n- Week 1-2: Setup and core building\n- Week 3-4: Complete building, start testing\n- Week 5-6: Testing and bug fixes\n- Week 7: Documentation and handoff",
          "required": true,
          "rows": 12
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Client Presentation",
      "description": "Write a professional estimate for the client.",
      "fields": [
        {
          "id": "client_estimate",
          "type": "textarea",
          "label": "Professional estimate presentation:",
          "placeholder": "Based on the scope we discussed for your customer onboarding automation, I estimate this project will take approximately 90 to 100 hours of work, which translates to 6 to 7 weeks of calendar time.\n\nThis includes:\n- Setup and discovery: 8 hours\n- Building the automation: 24 hours\n- Testing and bug fixes: 16 hours\n- Documentation and training: 8 hours\n- Project management: 5 hours\n- Contingency buffer: 35 hours\n\nThe timeline assumes:\n- Timely access to all systems (Stripe, CRM, Drive, Slack)\n- No major scope changes after approval\n- Weekly 30-minute check-in calls\n\nThe range accounts for:\n- Integration complexity with multiple systems\n- Edge cases discovered during testing\n- Learning curve with your CRM system\n\nI will provide weekly status updates and flag any issues early.\n\nNext steps: Sign-off on scope, then I can start Week 1.",
          "required": true,
          "rows": 24
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: Variance Handling",
      "description": "Plan for tracking and communicating variance.",
      "fields": [
        {
          "id": "tracking_plan",
          "type": "textarea",
          "label": "How will you track actual vs estimated?",
          "placeholder": "Tracking method:\n- Time tracking tool for all work on this project\n- Weekly comparison: hours spent vs % complete\n- Simple spreadsheet: Task, Estimated, Actual, Notes\n\nTriggers for concern:\n- At 25% of time, should be 25% complete\n- If 15+ hours behind at week 3, need to reassess\n- Any task taking 2x estimate gets flagged",
          "required": true,
          "rows": 12
        },
        {
          "id": "communication_plan",
          "type": "textarea",
          "label": "How will you communicate if over budget?",
          "placeholder": "Early warning communication (at first sign):\n\nSubject: Onboarding Project - Timeline Update\n\nHi [Client],\n\nI wanted to flag something early. We are 3 weeks in and I have completed about 40% of the work (estimated 50% by now).\n\nThe main factor: CRM API required more debugging than expected.\n\nRevised estimate: 8 weeks total instead of 7.\n\nOptions:\n1. Extend timeline by 1 week (recommended)\n2. Reduce scope by removing [feature] to stay on timeline\n\nI recommend option 1 as [feature] adds significant value.\n\nLet me know your preference.",
          "required": true,
          "rows": 20
        }
      ]
    }
  ],
  "deliverables": [
    "Work breakdown with estimates",
    "Historical adjustment applied",
    "Three-point estimation for risky tasks",
    "Calendar timeline calculated",
    "Professional client presentation",
    "Variance handling plan"
  ],
  "success_criteria": [
    "All work types included in breakdown",
    "Buffer appropriate to uncertainty",
    "Range provided rather than single number",
    "Assumptions stated clearly"
  ]
}'

WHERE slug = 'estimating-time-effort';
