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
'["Measuring electricity usage", "Categorizing stakeholders by their decision authority and engagement level to tailor communication appropriately", "Project scheduling", "Budget allocation"]',
1,
'The Power/Interest matrix helps you decide how to engage each stakeholder. High power, high interest stakeholders need close management. Low power, low interest stakeholders need minimal updates.'),

((SELECT id FROM quizzes WHERE title = 'Stakeholder Management Quiz'), 6,
'When a client requests a new feature mid-project, what is the best response?',
'["Say no immediately", "Say yes immediately to keep them happy", "Acknowledge the idea, assess scope impact, present options with tradeoffs, and let them decide", "Ignore the request"]',
2,
'Scope requests deserve thoughtful handling. Acknowledge the value, analyze the impact, and present clear options so the client can make an informed decision about tradeoffs.'),

((SELECT id FROM quizzes WHERE title = 'Stakeholder Management Quiz'), 7,
'What should a weekly status update always include?',
'["Only problems", "Progress made, upcoming work, timeline status, blockers, and any actions needed from the client", "Just a statement that things are fine", "Technical implementation details"]',
1,
'Complete status updates cover what happened, what is coming, whether you are on track, any issues, and what you need. This prevents surprises and builds trust.'),

((SELECT id FROM quizzes WHERE title = 'Stakeholder Management Quiz'), 8,
'How should you handle a stakeholder who has unrealistic expectations?',
'["Agree to meet their expectations anyway", "Educate them with specific breakdown of what is actually required, then negotiate a realistic alternative", "Refuse to work with them", "Complain to their manager"]',
1,
'Unrealistic expectations often stem from lack of understanding. Break down the real work involved, explain why it takes that long, and work together to find an acceptable approach.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Managing Stakeholders & Expectations

**This is how operators build relationships that last.**

Technical skills get you started. People skills keep you hired. Managing stakeholders means understanding who matters, what they need, and how to keep them aligned with reality. Projects rarely fail for purely technical reasons. They fail because expectations were not managed.

## Definitions

**Stakeholder**: Anyone affected by or who can affect your project. Stakeholders include clients, end users, decision makers, and supporting teams.

**Expectation**: What a stakeholder believes will happen regarding timeline, deliverables, quality, cost, or experience. Unmanaged expectations cause disappointment even when you deliver well.

**Stakeholder Map**: A document identifying all stakeholders, their interests, their power, and their communication needs.

**Power/Interest Matrix**: A tool for categorizing stakeholders by their decision authority and engagement level to determine appropriate communication strategies.

**Scope Creep**: The gradual expansion of project requirements driven by stakeholder requests. Managing expectations prevents scope creep.

**Status Update**: Regular communication informing stakeholders of progress, issues, and next steps. Proactive updates build trust.

**Escalation**: Raising an issue to someone with more authority when normal processes cannot resolve it. Know when and how to escalate.

**Change Request**: A formal process for stakeholders to request modifications. Change requests document decisions and protect both parties.

## Who Are Your Stakeholders?

### Types of Stakeholders

**Primary Stakeholders with direct impact.** Client or Sponsor who pays for the project and makes decisions. End Users who will actually use the automation daily. Your Team members who work on the project with you.

**Secondary Stakeholders with indirect impact.** Adjacent Teams affected by the changes you make. IT and Security who need to approve integrations. Management interested in outcomes and ROI.

**External Stakeholders.** Vendors providing tools and platforms you use. Partners owning integrated systems you connect to.

Each stakeholder type has different interests, priorities, communication needs, and decision authority. One approach does not fit all.

## Stakeholder Analysis

### Stakeholder Map

For each project, create a stakeholder map documenting key people.

**For each stakeholder record.** Name and role. Their interest in the project. Their power or authority level. Preferred communication method and frequency. Their primary concerns.

**Example stakeholder entries.**

Sarah Johnson, VP of Sales, is the Sponsor. Her interest is reducing team workload and getting faster lead response. She has high power with budget authority. Communication is weekly email updates and bi-weekly calls. Her concerns are cost and disruption to team.

Mike Chen, Sales Manager, is an End User. His interest is easy-to-use automation that does not break workflow. He has medium power because he can veto if the solution is unusable. Communication is via Slack and involvement in testing. His concerns are learning curve and reliability.

IT Department handles Security and Access. Their interest is data security and compliance. They have medium power because they can block integrations. Communication is formal email requests. Their concerns are security risks and support burden.

### Power/Interest Matrix

Categorize stakeholders into four quadrants to tailor your approach.

**High Power, High Interest: Manage Closely.** These stakeholders need weekly updates and involvement in decisions. Example: Sarah the VP. Give her significant attention and keep her deeply informed.

**High Power, Low Interest: Keep Satisfied.** These stakeholders need to be informed of major changes and asked for necessary approvals. Example: IT Department. Do not overwhelm them with details, but never surprise them.

**Low Power, High Interest: Keep Informed.** These stakeholders want to know what is happening and provide feedback. Example: Jessica the Sales Rep. Include her in testing, hear her feedback, but do not require her approval.

**Low Power, Low Interest: Monitor.** These stakeholders need only occasional FYI updates. Example: Adjacent teams. Send summary information, do not require action.

Tailor your communication effort to each quadrant.

## Setting Expectations

### What to Set Expectations About

**Timeline.** This will take 3-4 weeks, with Week 2 focused on building and Week 3 on testing.

**Deliverables.** You will receive a working automation, documentation, and a 1-hour training session.

**Communication.** I will send weekly updates every Friday, and we will have a 30-minute call every other Tuesday.

**Your Availability.** I am available for urgent issues same-day. For non-urgent questions, I respond within 24 hours.

**Their Requirements.** I will need access to your CRM by next Monday and 2 hours of your time for testing in Week 3.

**Risks.** The main risk is if the API does not support what we need. If that happens, we will need to discuss alternatives.

**What Success Looks Like.** Success means 95%+ of form submissions automatically create CRM records with no manual intervention.

### The Expectation-Setting Conversation

At project start, have an explicit conversation covering all key expectations.

"Before we start, I want to make sure we are aligned on a few things.

Timeline. Based on the scope, this will take approximately 3-4 weeks. I will work on it at defined hours per week, which means we are looking at completion by a specific date.

My Process. I will start with setup and planning, then build in Week 2, test thoroughly in Week 3, and deliver in Week 4. You will see regular progress updates.

What I Need From You. Access to all systems by a specific date. Decisions on key questions by a specific date. 2-3 hours for testing and feedback. Response to questions within 2 business days.

Communication. You will get written updates every Friday, check-in calls every other Tuesday, and immediate notification if any blockers arise.

What Could Change Timeline. Timeline could extend if we discover technical limitations, if scope changes, if access is delayed, or if major bugs emerge during testing.

What Happens When We Are Done. Handoff documentation, training session, and a 30-day support period included. After that, we can discuss ongoing maintenance.

Does this align with your expectations?"

Get explicit agreement before starting work.

## Communication Strategies

### Communication Frequency

**Weekly Updates at minimum.** Send every week regardless of whether there are problems.

Weekly update structure. Start with progress this week listing what you completed. Then share next week plans listing what you will do. State whether you are on track or behind and by how much. List any blockers. State what action is needed from them, even if none.

**Daily Updates when needed.** During critical phases, when the client is anxious, or when rapid decisions are required. Keep these brief via Slack or chat.

**Ad-Hoc Updates.** When you discover an issue. When you need a decision. When something changes the project trajectory.

### Update Templates

**Status Update Structure.** Completed items listed with checkmarks. In Progress items currently being worked on. Next items coming up. Timeline status showing on track or days behind. Issues flagged with warning. Actions needed from stakeholder.

**Problem Alert Structure.** Subject line names the issue briefly. Body explains the problem clearly, describes the impact on the project, presents 2-3 options with pros and cons for each, states your recommendation, and describes timeline impact.

**Decision Request Structure.** Subject line states decision needed on a specific topic. Body provides context explaining why this matters, presents options with implications for each, lists considerations and tradeoffs, states your recommendation and reasoning, and gives a deadline for decision to stay on track.

### Communication Channels

**Email.** For formal updates, decision requests, documentation, and anything needing a paper trail.

**Slack or Chat.** For quick questions, informal updates, rapid back-and-forth, and team coordination.

**Calls and Meetings.** For complex discussions, kickoffs, demos, problem-solving, and relationship building.

Choose the right channel for the message. Formal decisions belong in email. Quick clarifications belong in chat.

## Managing Difficult Conversations

### Delivering Bad News

When a project will be delayed, communicate early and completely.

**Bad approach.** "Um, so, it is taking longer than expected... maybe another week?"

**Good approach.** A structured message stating current status and that you are behind schedule due to a specific reason. Show original timeline and revised timeline with the delay duration. Explain why with a specific, honest explanation without excuses. Describe what you are doing to minimize impact and prevent future delays. Present options such as accepting new timeline, reducing scope to hit original date, or adding resources if possible. Request discussion.

**Key principles for bad news.** Communicate early before the deadline. Be specific about what happened. Take responsibility without making excuses. Offer solutions, not just problems.

### Handling Scope Creep

When a client asks for additional features, respond thoughtfully.

"That is a great idea! Let me check how that fits with our current scope.

After reviewing the scope document, I can confirm that feature is not in our current scope, but I can definitely add it.

Adding this feature would require X additional hours, add Y to budget, and extend timeline by Z.

We have a few options. Add it to the current project with adjusted timeline and budget. Deliver core project first, then add this in Phase 2. Swap it for another lower-priority feature.

What works best for you?"

Protect scope while being helpful. Never just say no, always offer alternatives.

### Managing Unrealistic Expectations

When a client underestimates what is required, educate them with specifics.

"I understand why it might seem quick, but let me break down what is involved.

List all actual tasks and time for each. Setup and access takes X hours. Building Y takes X hours. Testing takes X hours. Documentation takes X hours. Buffer for issues takes X hours.

That totals X hours of work, which at my availability of Y hours per week means Z weeks.

Is there a hard deadline we need to hit? If so, we can discuss which features are most critical and possibly phase the work."

Show your math. Specifics are more persuasive than vague pushback.

## Building Trust

### Trust-Building Behaviors

**Deliver what you promise.** If you say Friday, deliver Friday. If you cannot, communicate before Friday.

**Communicate proactively.** Share updates before being asked. Surface problems early. Keep stakeholders informed.

**Admit mistakes.** When you mess up, own it quickly and explain how you will fix it. Excuses destroy trust.

**Be consistent.** Same quality, same communication, same reliability every time.

**Show competence.** Demonstrate that you know what you are doing through your work and your communication.

### Trust-Destroying Behaviors

**Overpromising.** Saying yes to everything, then failing to deliver.

**Disappearing.** Long periods without communication make stakeholders anxious.

**Surprises.** Last-minute news about delays, problems, or changes.

**Blame-shifting.** It was the tool, it was the client, it was the weather. Taking responsibility, even when not entirely your fault, builds trust.

**Inconsistency.** Great one week, terrible the next. Stakeholders never know what to expect.

## Operator Principles

**Identify all stakeholders at project start.** Map who matters, what they care about, and how to communicate with them. Different stakeholders need different approaches.

**Set expectations explicitly.** What seems obvious to you is not obvious to clients. Document timeline, deliverables, communication, requirements, and risks in writing.

**Communicate proactively.** Regular updates prevent surprises. Share good news and bad news before stakeholders have to ask.

**Protect scope with options.** When scope creep appears, acknowledge the request, analyze the impact, and present options. Never just say no.',

exercise_markdown = '## Exercise: Stakeholder Management Practice

**Objective:** Practice stakeholder analysis, expectation setting, and communication strategies.

### Part 1: Stakeholder Analysis

Create a complete stakeholder map for the customer onboarding automation project.

### Part 2: Power/Interest Matrix

Categorize your stakeholders into the four quadrants and define your approach for each.

### Part 3: Expectation-Setting Conversation

Write the complete expectation-setting conversation you would have at project kickoff.

### Part 4: Status Update

Write a Week 2 status update for the project.

### Part 5: Problem Communication

The CRM integration is taking longer than expected. Write the problem alert communication.

### Part 6: Scope Creep Response

The client asks to add automated billing reminders. Write your response.

### Deliverables

Complete stakeholder map. Power/Interest matrix with strategies. Expectation-setting conversation. Sample status update. Problem alert communication. Scope creep response.

### Success Criteria

All stakeholder types identified. Communication strategies matched to power/interest. Expectations set explicitly and completely. Problem communicated with options and recommendations. Scope creep handled professionally with alternatives.',

exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Stakeholder Analysis",
      "description": "Create a complete stakeholder map.",
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
          "placeholder": "Stakeholders: [Names]\n\nApproach:\n- Weekly detailed updates\n- Involved in all major decisions\n- Regular check-in calls\n- First to know about any issues\n- Approval required for scope changes",
          "required": true,
          "rows": 8
        },
        {
          "id": "high_power_low_interest",
          "type": "textarea",
          "label": "High Power, Low Interest (Keep Satisfied):",
          "placeholder": "Stakeholders: [Names]\n\nApproach:\n- Summary updates only\n- Inform of major milestones\n- Request approvals in advance\n- Do not overwhelm with details\n- Escalate blockers quickly",
          "required": true,
          "rows": 8
        },
        {
          "id": "low_power_high_interest",
          "type": "textarea",
          "label": "Low Power, High Interest (Keep Informed):",
          "placeholder": "Stakeholders: [Names]\n\nApproach:\n- Include in testing\n- Gather feedback regularly\n- Share progress updates\n- Make them feel heard\n- Channel input through sponsor",
          "required": true,
          "rows": 8
        },
        {
          "id": "low_power_low_interest",
          "type": "textarea",
          "label": "Low Power, Low Interest (Monitor):",
          "placeholder": "Stakeholders: [Names]\n\nApproach:\n- Occasional FYI updates\n- Include in launch announcement\n- Minimal engagement required\n- Available if they have questions",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Expectation-Setting Conversation",
      "description": "Write the complete kickoff conversation.",
      "fields": [
        {
          "id": "expectation_conversation",
          "type": "textarea",
          "label": "Complete expectation-setting conversation:",
          "placeholder": "Before we start, I want to make sure we are aligned on key aspects of this project.\n\nTimeline:\n[Specific timeline with milestones]\n\nMy Process:\n[How you will work, what they will see]\n\nWhat I Need From You:\n- [Access requirements and dates]\n- [Decision points and dates]\n- [Time required for testing/feedback]\n- [Response time expectations]\n\nCommunication:\n- [Update frequency and format]\n- [Meeting schedule]\n- [How you will handle issues]\n\nWhat Could Change Timeline:\n- [Risks that could extend project]\n\nWhat Happens When Done:\n- [Deliverables]\n- [Training]\n- [Support period]\n\nDoes this align with your expectations?",
          "required": true,
          "rows": 28
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
          "placeholder": "Subject: Onboarding Automation - Week 2 Update\n\nHi [Name],\n\nQuick update on the customer onboarding automation:\n\nProgress This Week:\n✓ [Completed item 1]\n✓ [Completed item 2]\n✓ [Completed item 3]\n\nNext Week:\n- [Planned item 1]\n- [Planned item 2]\n- [Planned item 3]\n\nTimeline Status: On track / [X] days behind\n[Explanation if behind]\n\nBlockers: None / [Description]\n\nAction Needed From You:\n- [Action 1] by [date]\n- None this week\n\nLet me know if you have questions!\n\nBest,\n[Your name]",
          "required": true,
          "rows": 24
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
          "placeholder": "Subject: Issue Found - CRM Integration Taking Longer Than Expected\n\nHi [Name],\n\nI need to update you on a challenge we have encountered.\n\nProblem:\n[Specific description of what happened with CRM integration]\n\nImpact:\n[How this affects the project - timeline, scope, cost]\n\nOptions:\n1. [Option A] - [Pros and cons]\n2. [Option B] - [Pros and cons]\n3. [Option C] - [Pros and cons]\n\nMy Recommendation:\n[Which option you suggest and why]\n\nTimeline Impact:\n[Specific new timeline]\n\nNext Steps:\nCan we discuss this [today/tomorrow]? I am available [times].\n\nI apologize for the delay and am committed to finding the best path forward.\n\n[Your name]",
          "required": true,
          "rows": 26
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
          "placeholder": "Hi [Name],\n\nThat is a great idea! Automated billing reminders would definitely add value for your team.\n\nI reviewed how this fits with our current scope. Billing reminders are not included in our current project, but I can absolutely add them.\n\nAdding this feature would require:\n- [X] additional hours of work\n- [$Y] added to the budget\n- [Z] days/weeks timeline extension\n\nHere are our options:\n\n1. Add to Current Project\n   - Extend timeline by [Z]\n   - Increase budget by [$Y]\n   - You get everything at once\n\n2. Phase 2 (Recommended)\n   - Complete onboarding automation first\n   - Add billing reminders as separate project\n   - Validate onboarding works before adding complexity\n   - No delay to current timeline\n\n3. Swap Features\n   - Replace [lower priority feature] with billing reminders\n   - Keeps timeline and budget the same\n   - You lose [feature]\n\nMy recommendation is Option 2, because [reasoning].\n\nWhat would work best for you?\n\n[Your name]",
          "required": true,
          "rows": 30
        }
      ]
    }
  ],
  "deliverables": [
    "Complete stakeholder map",
    "Power/Interest matrix with strategies",
    "Expectation-setting conversation",
    "Sample status update",
    "Problem alert communication",
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
