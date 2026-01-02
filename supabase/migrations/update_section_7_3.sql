-- ============================================================================
-- UPDATE SECTION 7.3: Managing Stakeholders & Expectations
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, remove any existing questions 5-8 to allow clean re-runs, then add 4 more to reach 8 total
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Stakeholder Management Quiz')
AND order_index IN (5, 6, 7, 8);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Stakeholder Management Quiz'), 5,
'What is a Power/Interest matrix used for?',
'["Calculating electricity costs", "Categorizing stakeholders by decision authority and engagement level", "Project scheduling", "Budget allocation"]',
1,
'The Power/Interest matrix helps you decide how to engage each stakeholder based on their authority and interest level.'),

((SELECT id FROM quizzes WHERE title = 'Stakeholder Management Quiz'), 6,
'When a client requests a new feature mid-project, what is the best response?',
'["Say no immediately", "Say yes to keep them happy", "Acknowledge the idea, assess impact, and present options with tradeoffs", "Ignore the request"]',
2,
'Scope requests deserve thoughtful handling. Acknowledge value, analyze impact, and present options.'),

((SELECT id FROM quizzes WHERE title = 'Stakeholder Management Quiz'), 7,
'What should a weekly status update always include?',
'["Only problems", "Progress made, upcoming work, timeline status, blockers, and actions needed", "Just a statement that things are fine", "Technical implementation details"]',
1,
'Status updates cover what happened, what is coming, whether you are on track, any issues, and what you need.'),

((SELECT id FROM quizzes WHERE title = 'Stakeholder Management Quiz'), 8,
'How should you handle a stakeholder with unrealistic expectations?',
'["Agree to meet their expectations anyway", "Show specific breakdown of what is required, then negotiate alternatives", "Refuse to work with them", "Escalate to their manager"]',
1,
'Unrealistic expectations often stem from lack of understanding. Break down the real work and find an acceptable approach together.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Managing Stakeholders & Expectations

Technical skills get you started. People skills keep you hired. Managing stakeholders means understanding who matters, what they need, and how to keep them aligned with reality.

**Example company: BrightSales Ltd.** Throughout this section, we will use BrightSales Ltd as our example. They are a 50-person B2B sales consultancy with a VP of Sales (Sarah), Sales Manager (Tom), and a team of sales reps including Jessica.

## Definitions

**Stakeholder**: Anyone affected by or who can affect your project.

**Expectation**: What a stakeholder believes will happen regarding timeline, deliverables, quality, cost, or experience.

**Stakeholder Map**: A document identifying all stakeholders, their interests, their power, and their communication needs.

**Power/Interest Matrix**: A tool for categorizing stakeholders by their decision authority and engagement level.

**Scope Creep**: The gradual expansion of project requirements driven by stakeholder requests.

**Status Update**: Regular communication informing stakeholders of progress, issues, and next steps.

**Escalation**: Raising an issue to someone with more authority when normal processes cannot resolve it.

**Change Request**: A formal process for stakeholders to request modifications.

## Who Are Your Stakeholders?

### Types of Stakeholders

**Primary Stakeholders.** Client or Sponsor who pays for the project. End Users who will use the automation daily. Your Team members working with you.

**Secondary Stakeholders.** Adjacent Teams affected by changes. IT and Security who approve integrations. Management interested in outcomes.

**External Stakeholders.** Vendors providing tools. Partners owning integrated systems.

Each type has different interests, priorities, and communication needs.

**Real-world example: B2B services.** A consulting firm hires you to automate their proposal workflow. Primary stakeholders: Partner who sponsors it, associates who use it daily. Secondary: IT who must approve the document management integration, finance who cares about billing accuracy. Missing the IT stakeholder during scoping causes a 2-week delay when they block the integration for security review.

## Stakeholder Analysis

### Stakeholder Map

For each project, document key people.

**BrightSales Ltd stakeholders:**

Sarah Chen, VP of Sales, is the Sponsor. Her interest is reducing team workload and getting faster lead response. She has high power with budget authority. Communication is weekly email updates and bi-weekly calls. Her concerns are cost and disruption to team.

Tom Rodriguez, Sales Manager, is an End User Champion. His interest is easy-to-use automation that does not break workflow. He has medium power because he can influence adoption. Communication is via Slack and involvement in testing. His concerns are learning curve and reliability.

Jessica Park, Sales Rep, is an End User. Her interest is less manual work, more selling time. She has low power but high interest. Communication is through Tom. Her concerns are whether it actually saves time.

IT Department handles Security and Access. Their interest is data security and compliance. They have medium power because they can block integrations. Communication is formal email requests. Their concerns are security risks and support burden.

### Power/Interest Matrix

Categorize stakeholders into four quadrants.

**High Power, High Interest: Manage Closely.** Sarah the VP. Give significant attention, keep deeply informed, involve in decisions.

**High Power, Low Interest: Keep Satisfied.** IT Department. Do not overwhelm with details, but never surprise them. Inform of major changes.

**Low Power, High Interest: Keep Informed.** Tom and Jessica. Include in testing, hear feedback, but do not require approval for everything.

**Low Power, Low Interest: Monitor.** Adjacent teams. Occasional FYI updates only.

## Setting Expectations

### What to Set Expectations About

**Timeline.** This will take 3 to 4 weeks, with Week 2 focused on building and Week 3 on testing.

**Deliverables.** You will receive a working automation, documentation, and a 1-hour training session.

**Communication.** I will send weekly updates every Friday, and we will have a 30-minute call every other Tuesday.

**Your Availability.** I am available for urgent issues same-day. For non-urgent questions, I respond within 24 hours.

**Their Requirements.** I will need access to your CRM by next Monday and 2 hours of your time for testing in Week 3.

**Risks.** The main risk is if the API does not support what we need. If that happens, we will discuss alternatives.

**What Success Looks Like.** Success means 95 percent or more of form submissions automatically create CRM records.

### The Expectation-Setting Conversation

At project start, have an explicit conversation.

"Before we start, I want to make sure we are aligned.

Timeline: Based on scope, this will take 3 to 4 weeks. Completion target is a specific date.

My Process: Setup and planning, then build in Week 2, test in Week 3, deliver in Week 4.

What I Need From You: Access to all systems by a specific date. Decisions on key questions by a specific date. 2 to 3 hours for testing. Response to questions within 2 business days.

Communication: Written updates every Friday, check-in calls every other Tuesday, immediate notification if blockers arise.

What Could Change Timeline: Technical limitations, scope changes, access delays, or major bugs during testing.

Does this align with your expectations?"

Get explicit agreement before starting.

## Communication Templates

### Weekly Status Update

Subject: BrightSales Automation - Week 2 Update

Progress This Week: Completed Stripe integration. Built CRM record creation. Started email automation.

Next Week: Complete email automation. Begin testing with sample data.

Timeline Status: On track for delivery on target date.

Blockers: None currently.

Action Needed: Please confirm email template copy by Friday.

### Problem Alert

Subject: Issue Found - CRM Integration Delay

Problem: The CRM API requires additional authentication setup that was not documented.

Impact: This adds 3 to 4 days to the timeline.

Options: 1. Accept 4-day delay (recommended). 2. Remove CRM integration and add manually later. 3. Switch to alternative CRM connector.

My Recommendation: Option 1, as the integration is core to the project value.

Timeline Impact: New target date is adjusted date.

Next Steps: Please confirm which option you prefer by end of day tomorrow.

### Decision Request

Subject: Decision Needed - Error Notification Method

Context: When the automation fails, we need to notify someone. This affects how quickly issues get resolved.

Options: 1. Email to Sarah (simple, but may be delayed). 2. Slack to sales-ops channel (faster, visible to team). 3. Both email and Slack (redundant but thorough).

My Recommendation: Option 2. Slack notifications are faster and the team already monitors that channel.

Decision Needed By: Friday to stay on track.

## Managing Difficult Conversations

### Delivering Bad News

When a project will be delayed, communicate early.

**Bad approach.** "It is taking longer than expected... maybe another week?"

**Good approach.** "I need to update you on the timeline. We are currently 3 days behind schedule due to CRM API issues. Revised delivery is next Wednesday instead of this Friday. Here is what I am doing to minimize impact. Here are options for getting back on track."

**Key principles.** Communicate before the deadline. Be specific. Take responsibility. Offer solutions.

### Handling Scope Creep

When Sarah at BrightSales asks for additional features:

"That is a great idea, Sarah. Let me check how that fits with our current scope.

Adding this feature would require 6 additional hours and extend timeline by 3 days.

Options: Add it now with adjusted timeline. Deliver core project first, add this in Phase 2. Swap it for another lower-priority feature.

What works best for you?"

Protect scope while being helpful. Offer alternatives.

### Managing Unrealistic Expectations

When Tom underestimates what is required:

"I understand why it might seem quick. Let me break down what is involved.

Setup and access takes 4 hours. Building the integration takes 12 hours. Testing takes 8 hours. Documentation takes 4 hours. Buffer for issues takes 6 hours.

That totals 34 hours of work, which at my availability means about 2 weeks.

Is there a hard deadline? If so, we can discuss which features are most critical."

Show your math. Specifics are more persuasive than vague pushback.

## Building Trust

### Trust-Building Behaviors

**Deliver what you promise.** If you say Friday, deliver Friday.

**Communicate proactively.** Share updates before being asked.

**Admit mistakes.** When you mess up, own it quickly.

**Be consistent.** Same quality every time.

### Trust-Destroying Behaviors

**Overpromising.** Saying yes to everything, then failing.

**Disappearing.** Long periods without communication.

**Surprises.** Last-minute news about delays or problems.

**Blame-shifting.** Blaming the tool, the client, or circumstances.

## Quick Summary

- Map stakeholders by power and interest at project start.
- Set expectations explicitly in writing before building.
- Send weekly updates whether or not there are problems.

## Operator Principles

- Identify all stakeholders and their communication needs before starting.
- Set expectations explicitly in writing, not just verbally.
- Send proactive updates before stakeholders have to ask.
- Present options when scope creep appears instead of just saying no.',

exercise_markdown = '## Exercise: Stakeholder Management Practice

**Timebox: 45 minutes | Stretch: 90 minutes**

Practice stakeholder analysis, expectation setting, and communication strategies.

### Part 1: Stakeholder Analysis

Create a stakeholder map for the customer onboarding automation project.

### Part 2: Power/Interest Matrix

Categorize your stakeholders into the four quadrants and define your approach for each.

### Part 3: Expectation-Setting Conversation

Write the expectation-setting conversation you would have at project kickoff.

### Part 4: Status Update

Write a Week 2 status update for the project.

### Part 5: Problem Communication

The CRM integration is taking longer than expected. Write the problem alert.

### Part 6: Scope Creep Response

The client asks to add automated billing reminders. Write your response.

### Deliverables

Stakeholder map. Power/Interest matrix with strategies. Expectation-setting conversation. Status update. Problem alert. Scope creep response.

### Success Criteria

All stakeholder types identified. Strategies matched to power/interest. Expectations set explicitly. Problem communicated with options. Scope creep handled professionally.',

exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Stakeholder Analysis",
      "description": "Create a stakeholder map.",
      "fields": [
        {
          "id": "primary_stakeholders",
          "type": "textarea",
          "label": "Primary stakeholders (direct impact):",
          "placeholder": "1. Client Sponsor\n   - Name: [Name]\n   - Role: [Role]\n   - Interest: [What they want from this project]\n   - Power: High/Medium/Low\n   - Communication: [Preferred method and frequency]\n   - Concerns: [What worries them]\n\n2. End User Representative\n   - Name: [Name]\n   - Role: [Role]\n   ...",
          "required": true,
          "rows": 16
        },
        {
          "id": "secondary_stakeholders",
          "type": "textarea",
          "label": "Secondary stakeholders (indirect impact):",
          "placeholder": "1. IT Department\n   - Role: Security and access approval\n   - Interest: Data security, compliance\n   - Power: Medium (can block integrations)\n   - Communication: Email, formal requests\n   - Concerns: Security risks, support burden\n\n2. [Other secondary stakeholders]",
          "required": true,
          "rows": 12
        },
        {
          "id": "external_stakeholders",
          "type": "textarea",
          "label": "External stakeholders:",
          "placeholder": "1. Stripe (payment platform)\n   - Relationship: API provider\n   - Communication: Documentation, support tickets\n\n2. [CRM vendor]\n   - Relationship: Platform provider\n   - Communication: Support, documentation",
          "required": true,
          "rows": 8
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Power/Interest Matrix",
      "description": "Categorize stakeholders and define approach for each quadrant.",
      "fields": [
        {
          "id": "high_power_high_interest",
          "type": "textarea",
          "label": "High Power, High Interest (Manage Closely):",
          "placeholder": "Stakeholders: [Names]\n\nApproach:\n- Weekly detailed updates\n- Involved in all major decisions\n- Regular check-in calls\n- First to know about any issues",
          "required": true,
          "rows": 8
        },
        {
          "id": "high_power_low_interest",
          "type": "textarea",
          "label": "High Power, Low Interest (Keep Satisfied):",
          "placeholder": "Stakeholders: [Names]\n\nApproach:\n- Summary updates only\n- Inform of major milestones\n- Request approvals in advance\n- Escalate blockers quickly",
          "required": true,
          "rows": 8
        },
        {
          "id": "low_power_high_interest",
          "type": "textarea",
          "label": "Low Power, High Interest (Keep Informed):",
          "placeholder": "Stakeholders: [Names]\n\nApproach:\n- Include in testing\n- Gather feedback regularly\n- Share progress updates\n- Channel input through sponsor",
          "required": true,
          "rows": 8
        },
        {
          "id": "low_power_low_interest",
          "type": "textarea",
          "label": "Low Power, Low Interest (Monitor):",
          "placeholder": "Stakeholders: [Names]\n\nApproach:\n- Occasional FYI updates\n- Include in launch announcement\n- Available if they have questions",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Expectation-Setting Conversation",
      "description": "Write the kickoff conversation.",
      "fields": [
        {
          "id": "expectation_conversation",
          "type": "textarea",
          "label": "Expectation-setting conversation:",
          "placeholder": "Before we start, I want to make sure we are aligned.\n\nTimeline:\n[Specific timeline with milestones]\n\nMy Process:\n[How you will work]\n\nWhat I Need From You:\n- [Access requirements and dates]\n- [Decision points]\n- [Time for testing/feedback]\n\nCommunication:\n- [Update frequency]\n- [Meeting schedule]\n\nWhat Could Change Timeline:\n- [Risks]\n\nDoes this align with your expectations?",
          "required": true,
          "rows": 24
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Status Update",
      "description": "Write a Week 2 status update.",
      "fields": [
        {
          "id": "status_update",
          "type": "textarea",
          "label": "Week 2 status update email:",
          "placeholder": "Subject: Onboarding Automation - Week 2 Update\n\nHi [Name],\n\nProgress This Week:\n- [Completed item 1]\n- [Completed item 2]\n\nNext Week:\n- [Planned item 1]\n- [Planned item 2]\n\nTimeline Status: On track / [X] days behind\n\nBlockers: None / [Description]\n\nAction Needed From You:\n- [Action] by [date]",
          "required": true,
          "rows": 20
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Problem Communication",
      "description": "Write a problem alert about CRM integration delays.",
      "fields": [
        {
          "id": "problem_alert",
          "type": "textarea",
          "label": "Problem alert email:",
          "placeholder": "Subject: Issue Found - CRM Integration Taking Longer\n\nHi [Name],\n\nProblem:\n[What happened]\n\nImpact:\n[How this affects timeline]\n\nOptions:\n1. [Option A with pros/cons]\n2. [Option B with pros/cons]\n\nMy Recommendation:\n[Which option and why]\n\nNext Steps:\nCan we discuss this [today/tomorrow]?",
          "required": true,
          "rows": 20
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: Scope Creep Response",
      "description": "Respond to a request to add billing reminders.",
      "fields": [
        {
          "id": "scope_response",
          "type": "textarea",
          "label": "Response to scope change request:",
          "placeholder": "Hi [Name],\n\nThat is a great idea. Let me check how it fits with our current scope.\n\nAdding this would require:\n- [X] additional hours\n- [Y] days timeline extension\n\nOptions:\n\n1. Add to Current Project\n   - Extend timeline by [Z]\n   - You get everything at once\n\n2. Phase 2 (Recommended)\n   - Complete onboarding first\n   - Add billing reminders as separate project\n\nMy recommendation is Option 2 because [reasoning].\n\nWhat works best for you?",
          "required": true,
          "rows": 22
        }
      ]
    }
  ],
  "deliverables": [
    "Stakeholder map",
    "Power/Interest matrix with strategies",
    "Expectation-setting conversation",
    "Status update",
    "Problem alert",
    "Scope creep response"
  ],
  "success_criteria": [
    "All stakeholder types identified",
    "Strategies matched to power/interest",
    "Expectations set explicitly",
    "Problem communicated with options",
    "Scope creep handled professionally"
  ]
}'

WHERE slug = 'stakeholder-management';
