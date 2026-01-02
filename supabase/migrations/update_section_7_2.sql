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
'["A method for classifying projects", "Basing estimates on actual outcomes of similar past projects rather than ideal scenarios", "A type of project documentation", "A client communication technique"]',
1,
'Reference Class Forecasting uses data from similar completed projects to ground your estimates in reality rather than optimism. What actually happened beats what should have happened.'),

((SELECT id FROM quizzes WHERE title = 'Estimation Quiz'), 6,
'What is the three-point estimation formula?',
'["Add all three estimates together", "(Optimistic + 4 × Most Likely + Pessimistic) ÷ 6, which weights toward likely while accounting for variance", "Average the three estimates", "Use the pessimistic estimate always"]',
1,
'The PERT formula weights the most likely estimate four times while still accounting for best and worst cases, producing a realistic estimate with built-in contingency.'),

((SELECT id FROM quizzes WHERE title = 'Estimation Quiz'), 7,
'Why should you give clients a range rather than a single number?',
'["To seem uncertain", "Because ranges acknowledge uncertainty honestly, set realistic expectations, and provide flexibility when issues arise", "Clients prefer ranges", "Single numbers are unprofessional"]',
1,
'A range like 60-70 hours is more honest than 65 hours precisely. It acknowledges uncertainty, gives you flexibility, and clients appreciate the transparency.'),

((SELECT id FROM quizzes WHERE title = 'Estimation Quiz'), 8,
'What should you do when you realize your estimate was wrong mid-project?',
'["Hide it and work overtime", "Communicate early, explain what changed, provide revised estimate, and offer options to the client", "Wait until the deadline passes", "Blame the client for unclear requirements"]',
1,
'Early communication preserves trust. Explain what you learned, provide a revised estimate, and give the client options. Surprises at deadline destroy relationships.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Estimating Time & Effort

**This is how operators set expectations they can actually meet.**

Estimation is hard. Everyone underestimates. Understanding why estimates fail and how to improve them is the difference between sustainable work and constant deadline stress. Good estimates protect your reputation, your income, and your sanity.

## Definitions

**Estimate**: A prediction of how much time or effort a task will require. Estimates are educated guesses, not commitments.

**Planning Fallacy**: The cognitive bias where we underestimate task duration despite past experience showing we consistently underestimate. We believe this time will be different.

**Contingency Buffer**: Extra time added to estimates to account for unknowns and problems. Buffer is not padding; it is realistic acknowledgment of uncertainty.

**Reference Class Forecasting**: Estimating based on actual outcomes of similar past projects rather than ideal-case planning for the current project.

**Three-Point Estimation**: A technique using optimistic, most likely, and pessimistic estimates to calculate a weighted average that accounts for uncertainty.

**T-Shirt Sizing**: A quick estimation method using relative sizes (XS, S, M, L, XL) for early ballpark estimates before detailed scoping.

**Variance**: The difference between estimated and actual time. Tracking variance helps you improve future estimates.

**Productive Hours**: The actual hours available for focused project work after accounting for meetings, interruptions, and other responsibilities.

## Why Estimates Are Always Wrong

Three fundamental problems make estimation difficult.

### Unknown Unknowns

You do not know what you do not know. You estimate 2 days for a task, then discover the API does not support the feature you need, the data format is inconsistent, a third requirement conflicts with the first, client access is delayed by a week, or the tool has undocumented limitations. Your 2-day estimate becomes 2 weeks.

### Optimism Bias (Planning Fallacy)

We are wired to be optimistic. Last time took 3 weeks, but this time will be faster because of various reasons we invent. It will not be faster. It never is. We consistently underestimate despite evidence from every previous project.

### Incomplete Information

You estimate before you have all the details. Early estimate: "Automation project, probably 1 week." After discovery: "Actually they need 5 integrations, complex logic, and migration of historical data. 6 weeks." Estimates improve as information increases.

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

Specific tasks produce better estimates than vague project estimates.

### Step 2: Add Historical Data

What did similar tasks actually take in past projects?

Track your work over time. Past CRM integrations: Project A estimated 4 hours, actual was 6 hours. Project B estimated 3 hours, actual was 5 hours. Project C estimated 5 hours, actual was 7 hours. Average shows estimates are 50% too low.

For the current project you estimate 4 hours, but the reality check says probably 6 hours based on historical pattern.

Your past is the best predictor of your future.

### Step 3: Add Complexity Multipliers

Not all tasks are equal complexity.

**Multipliers by familiarity and complexity.** Standard task done many times: multiply by 1.0. New tool you have not used before: multiply by 1.5. Complex logic with many conditions: multiply by 2.0. Multiple integrations required: multiply by 2.5. Unknown territory: multiply by 3.0.

**Example calculation.** CRM integration base estimate is 4 hours. Multiply by 1.5 for new CRM system. Multiply by 2.0 for complex conditional logic. Adjusted estimate is 4 times 1.5 times 2.0, which equals 12 hours.

### Step 4: Add Contingency Buffer

Things go wrong. Always. Buffer is not dishonest; it is realistic.

**Contingency guidelines by uncertainty level.** Low uncertainty when you have done the exact task before: add 15-25% buffer. Medium uncertainty when you have done similar tasks: add 25-40% buffer. High uncertainty when entering new territory: add 40-100% buffer. Very high uncertainty for R&D or unknown work: add 100-200% buffer.

**Example calculation.** Core work is 44 hours. Uncertainty is medium because of some new tools. Buffer is 30%. Total estimate is 44 times 1.3, which equals 57 hours. Round up to 60 hours, which is about 1.5 weeks.

### Step 5: Consider Context Factors

Not all hours are created equal. Calendar time is not the same as work time.

Eight hours of actual work does not equal 8 hours of calendar time due to interruptions.

**Productivity factors to subtract.** Client calls take about 2 hours per week. Other projects take about 10 hours per week. Urgent issues take about 3 hours per week.

Your 40-hour week typically produces 25 productive hours for a single project.

**Timeline calculation.** Project needs 60 hours of work. Your availability is 25 hours per week. Timeline is 60 divided by 25, which equals 2.4 weeks. Round up to 3 weeks.

## Estimation Techniques

### Technique 1: Reference Class Forecasting

Base estimates on similar past projects, not ideal scenarios.

**Steps.** Find 3-5 similar past projects. Look at actual time, not estimates. Average them. Adjust for differences.

**Example.** Past lead automation projects: Project A took 40 hours. Project B took 55 hours. Project C took 48 hours. Average is 48 hours. Current project is similar but slightly more complex, add 15%, and uses a new CRM you have not used before, add 25%. Estimate is 48 times 1.15 times 1.25, which equals 69 hours. Round to 70 hours or about 2 weeks.

### Technique 2: Three-Point Estimation

Best case, likely case, worst case combined with a weighted formula.

For each task, determine three values. Optimistic assumes everything goes perfectly. Most Likely assumes normal execution. Pessimistic assumes everything goes wrong.

**Formula.** Estimate equals Optimistic plus 4 times Most Likely plus Pessimistic, all divided by 6.

**Example for CRM Integration.** Optimistic is 3 hours with perfect API docs and no issues. Most Likely is 5 hours with standard complexity. Pessimistic is 12 hours with API issues and multiple debugging sessions. Estimate equals 3 plus 20 plus 12, all divided by 6, which equals 5.8 hours. Round to 6 hours.

This naturally builds in contingency.

### Technique 3: T-Shirt Sizing

For early or rough estimates when you need a quick ballpark.

**Sizes.** XS is less than 4 hours. S is 4-8 hours. M is 8-16 hours, about 1-2 days. L is 16-40 hours, about 1 week. XL is 40-80 hours, about 2 weeks. XXL is more than 80 hours and needs to be broken down further.

Useful for quick ballpark estimates, prioritization discussions, and early conversations before detailed scoping. Convert to hours later when you have more information.

### Technique 4: Bottom-Up Estimation

Sum all individual tasks. Task 1 takes 2 hours. Task 2 takes 4 hours. Task 3 takes 3 hours. Continue for all tasks. Total is the sum of all task estimates.

Most accurate when tasks are well-defined, you have done similar tasks before, and uncertainty is low.

### Technique 5: Top-Down Estimation

Based on overall project size. Typical automation project takes 50-70 hours. This one seems standard. Estimate 60 hours.

Useful for very early estimates, comparing to budget constraints, and sanity checking bottom-up estimates.

Combine top-down and bottom-up for best results.

## Common Estimation Mistakes

**Mistake 1: Forgetting Non-Building Time.** People estimate coding time but forget meetings, testing, debugging, documentation, communication, and waiting for access or approvals. Add 30-50% for these activities.

**Mistake 2: No Contingency.** Saying it will take exactly 40 hours is overconfident. It will take 40-70 hours depending on what goes wrong. Always add buffer.

**Mistake 3: Anchoring on Client Expectation.** Client says this should take about 1 week, right? You say sure. Wrong. Do your own estimate. Present it confidently.

**Mistake 4: Ignoring Past Data.** Last time took 3 weeks, but this time will be different. It will not be different. It will take 3 weeks. Maybe more. Learn from history.

**Mistake 5: Too Precise.** Saying this will take 43.7 hours fools no one. Round to reasonable increments. Hours round to 2, 4, 6, or 8. Days round to half days. Weeks round to whole weeks. Say approximately 45 hours or roughly 1.5 weeks.

**Mistake 6: Not Tracking Actuals.** You estimate but never record actual time. How do you improve? Track estimated hours, actual hours, variance, and reasons for variance. Build a historical database.

## Presenting Estimates

### To Clients

Use this format.

"Based on the scope we discussed, I estimate this project will take approximately 60-70 hours of work, which translates to about 2-3 weeks of calendar time.

This includes building the automation at 40 hours, testing and debugging at 15 hours, documentation and training at 10 hours, and project management and meetings at 5 hours.

The timeline assumes timely access to all systems, no major scope changes, and availability for weekly check-ins.

The range accounts for potential integration challenges, edge cases discovered during testing, and minor scope refinements.

I will provide weekly updates on progress and flag any issues early."

**Key points.** Give a range, not a single number. Explain what is included. State assumptions. Explain why there is a range. Commit to communication.

### When You Are Wrong

You will be wrong. Often. What matters is how you handle it.

**Discover early.** Track actual versus estimated regularly. Raise red flags early, not at deadline.

**Communicate quickly.** Tell the client: I originally estimated 2 weeks. I am now 1 week in and about 30% complete. Revised estimate is 3-4 weeks. Here is why.

**Explain, do not excuse.** Share what changed and what you learned. Offer options such as reducing scope to meet deadline, extending timeline, or adding resources.

## Improving Your Estimates

**Strategy 1: Track Everything.** For every project record the project name, estimated hours, actual hours, variance percentage, and reasons for variance.

**Strategy 2: Regular Review.** Monthly review last month''s projects. Calculate average variance. Identify patterns. Adjust your multipliers.

**Strategy 3: Break Your Patterns.** You have estimation patterns. Maybe you always underestimate setup time, forget about testing, or are optimistic about new tools. Identify your patterns. Correct them.

**Strategy 4: Calibrate with Peers.** Ask other operators how long they would estimate a similar task. Compare estimates. Discuss differences. Learn from their experience.

**Strategy 5: Be Honest.** Do not give estimates you do not believe in. If you think it is 3 weeks, do not say 1 week to please the client. Your reputation matters more than one project.

## Operator Principles

**Use historical data, not optimism.** Past project outcomes predict future project outcomes better than ideal-case planning. Track actuals and learn from them.

**Always include buffer.** Contingency is not dishonest padding; it is realistic acknowledgment that things go wrong. Match buffer size to uncertainty level.

**Give ranges, not precise numbers.** A range acknowledges uncertainty honestly and gives you flexibility. Clients appreciate transparency over false precision.

**Communicate early when estimates prove wrong.** Discovering you are over budget at 30% completion allows course correction. Discovering at 90% completion creates crises. Surface problems early.',

exercise_markdown = '## Exercise: Estimate a Real Project

**Objective:** Practice comprehensive project estimation using multiple techniques.

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

Complete work breakdown with estimates. Historical adjustment applied. Three-point estimation for risky tasks. Calendar timeline calculated. Professional client presentation. Variance handling plan.

### Success Criteria

All work types included in breakdown. Buffer appropriate to uncertainty. Range provided rather than single number. Assumptions stated clearly. Communication plan established.',

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
          "placeholder": "Documentation:\nWrite system documentation: 3 hours\nCreate runbook for errors: 2 hours\nTraining materials: 2 hours\nTraining session: 1 hour\n\nProject Management:\nClient meetings (4 × 30 min): 2 hours\nStatus updates: 1 hour\n\nTotal Other: 11 hours",
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
          "placeholder": "Factors:\n- Stripe integration: Done before (×1.0)\n- New CRM system: Never used (×1.3)\n- Multiple integrations (4): Moderate complexity (×1.2)\n- Error handling: Standard approach (×1.0)\n\nCombined factor: 1.3 × 1.2 = 1.56 for complex portions",
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
          "placeholder": "Task: Stripe webhook integration\n\nOptimistic: 2 hours (clean API, no issues)\nMost Likely: 4 hours (standard integration)\nPessimistic: 10 hours (API quirks, authentication issues)\n\nEstimate = (2 + 4×4 + 10) ÷ 6 = 4.7 hours\nRounded: 5 hours",
          "required": true,
          "rows": 8
        },
        {
          "id": "risky_task_2",
          "type": "textarea",
          "label": "Risky task 2 (three-point estimate):",
          "placeholder": "Task: Error handling across all integrations\n\nOptimistic: 2 hours (straightforward)\nMost Likely: 4 hours (typical edge cases)\nPessimistic: 12 hours (complex failure modes)\n\nEstimate = (2 + 4×4 + 12) ÷ 6 = 4.7 hours\nRounded: 5 hours",
          "required": true,
          "rows": 8
        },
        {
          "id": "risky_task_3",
          "type": "textarea",
          "label": "Risky task 3 (three-point estimate):",
          "placeholder": "Task: CRM integration (new system)\n\nOptimistic: 2 hours (great API, familiar patterns)\nMost Likely: 4 hours (learning curve, some issues)\nPessimistic: 8 hours (poor docs, API limitations)\n\nEstimate = (2 + 4×4 + 8) ÷ 6 = 4.3 hours\nRounded: 5 hours",
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
          "placeholder": "Weekly hours: 40\nMinus other projects: -15\nMinus meetings/admin: -5\nMinus interruptions: -5\n\nProductve hours for this project: 15 hours/week",
          "required": true,
          "rows": 7
        },
        {
          "id": "timeline_calc",
          "type": "textarea",
          "label": "Timeline calculation:",
          "placeholder": "Total work: 95 hours\nWeekly availability: 15 hours\nCalendar weeks: 95 ÷ 15 = 6.3 weeks\n\nRounded: 6-7 weeks\n\nWith milestones:\n- Week 1-2: Setup and core building\n- Week 3-4: Complete building, start testing\n- Week 5-6: Testing and bug fixes\n- Week 7: Documentation and handoff",
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
          "placeholder": "Based on the scope we discussed for your customer onboarding automation, I estimate this project will take approximately 90-100 hours of work, which translates to 6-7 weeks of calendar time.\n\nThis includes:\n- Setup and discovery: 8 hours\n- Building the automation: 24 hours\n- Testing and bug fixes: 16 hours\n- Documentation and training: 8 hours\n- Project management: 5 hours\n- Contingency buffer: 35 hours\n\nThe timeline assumes:\n- Timely access to all systems (Stripe, CRM, Drive, Slack)\n- No major scope changes after approval\n- Weekly 30-minute check-in calls\n\nThe range accounts for:\n- Integration complexity with multiple systems\n- Edge cases discovered during testing\n- Your team being a new CRM system\n\nI will provide weekly status updates and flag any issues early. If we encounter significant blockers, I will communicate immediately with options.\n\nInvestment: $X (based on your rate)\n\nNext steps: Sign-off on scope, then I can start Week 1.",
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
          "placeholder": "Early warning communication (at first sign):\n\nSubject: Onboarding Project - Timeline Update\n\nHi [Client],\n\nI wanted to flag something early. We are 3 weeks in and I have completed about 40% of the work (estimated 50% by now).\n\nThe main factor: [specific reason, e.g., CRM API required more debugging than expected]\n\nRevised estimate: 8 weeks total instead of 7.\n\nOptions:\n1. Extend timeline by 1 week (recommended)\n2. Reduce scope by removing [feature] to stay on timeline\n3. Bring in additional help (adds cost)\n\nI recommend option 1 as [feature] adds significant value.\n\nLet me know your preference and I am happy to discuss.\n\n[Your name]",
          "required": true,
          "rows": 20
        }
      ]
    }
  ],
  "deliverables": [
    "Complete work breakdown with estimates",
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
    "Assumptions stated clearly",
    "Communication plan established"
  ]
}'

WHERE slug = 'estimating-time-effort';
