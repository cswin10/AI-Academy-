-- ============================================================================
-- UPDATE SECTION 7.4: Effective Communication & Documentation
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, remove any existing questions 5-8 to allow clean re-runs, then add 4 more to reach 8 total
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Communication Quiz')
AND order_index IN (5, 6, 7, 8);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Communication Quiz'), 5,
'What is the principle of writing for your "future self"?',
'["Planning future projects", "Writing documentation that you will understand 6 months later without context", "Predicting future requirements", "Setting future deadlines"]',
1,
'Your future self has forgotten everything. Write documentation that explains the why, not just the what.'),

((SELECT id FROM quizzes WHERE title = 'Communication Quiz'), 6,
'What should decision documentation always include?',
'["Just the final decision", "The decision, options considered, reasoning, and fallback plan", "Only technical details", "A list of meeting attendees"]',
1,
'Decision docs capture context, alternatives, reasoning, and what to do if it proves wrong.'),

((SELECT id FROM quizzes WHERE title = 'Communication Quiz'), 7,
'What is the difference between technical documentation and user guides?',
'["They are the same thing", "Technical docs explain how things work for maintainers; user guides explain how to use things for end users", "User guides are longer", "Technical docs are for clients only"]',
1,
'Different audiences need different documentation. Maintainers need technical details; users need simple instructions.'),

((SELECT id FROM quizzes WHERE title = 'Communication Quiz'), 8,
'How should you handle documentation for a project that changes frequently?',
'["Wait until the project is stable", "Document as you go, update when things change, and keep a changelog", "Write once at the end", "Only document the final version"]',
1,
'Living documentation evolves with the project. Write as you build, update when things change.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Effective Communication & Documentation

Great operators are great communicators. Your technical skills only matter if people understand your work. Documentation is not extra work; it is part of the work.

## Definitions

**Documentation**: Written records that explain how systems work, how to use them, and why decisions were made.

**Status Update**: Regular communication informing stakeholders of progress, issues, and next steps.

**Technical Documentation**: Detailed explanation of how systems work, written for maintainers.

**User Guide**: Instructions for end users explaining how to accomplish tasks.

**Decision Documentation**: Record of why choices were made, what alternatives were considered, and fallback plans.

**Handoff Documentation**: Package enabling someone else to take over responsibility for a system.

**Changelog**: Record of what changed, when, and why.

**Living Documentation**: Documentation that is updated as systems change.

## The 5 Documents You Always Ship

Every project needs these five documents. Skip any and you create problems for yourself later.

**1. System Overview.** One page explaining what the automation does, why it exists, and how the pieces connect.

**2. Technical Documentation.** How things work for maintainers, including configuration, data flow, and troubleshooting.

**3. User Guide.** How to use the system for end users, written in simple language with screenshots.

**4. Runbook.** Step-by-step instructions for common operational tasks.

**5. Decision Log.** Why key choices were made, what alternatives were rejected, and what to do if decisions prove wrong.

**Real-world example: Ticketing ops.** An event company hires you to automate ticket reconciliation. Six months later, their new ops manager calls with questions. Because you shipped all five documents, she finds her answers in 10 minutes instead of scheduling a call with you.

## The Weekly Update That Stops 90% of Problems

Most client anxiety comes from not knowing what is happening. Weekly updates prevent this.

**Structure.** Progress This Week listing completed items. In Progress items with percentage. Coming Next Week. Timeline status showing on track or days behind. Blockers. Action Items for Stakeholders.

**Rules.** Send every week, even when there is nothing new. Send on the same day every week. Keep it under 200 words. Take 10 to 15 minutes to write, no more.

Consistent updates build trust. Sporadic updates create anxiety.

## Decision Logs That Save You Months Later

When someone asks "why did we do it this way?" you need the answer.

**For each decision, record.** Decision topic and date. Context explaining what situation led to this. Options Considered with pros and cons. Decision stating what was chosen. Reasoning explaining why. Fallback explaining what to do if this proves wrong.

Six months from now, this log saves you hours of archaeology.

## Technical Documentation

**Purpose.** Enable future maintainers to understand and fix the system.

**Audience.** Future you, colleagues, or whoever takes over.

**Contents.** System purpose. Components and how they connect. Data flow. Configuration details. Error handling. Monitoring.

**Setup Instructions.** Prerequisites. Step-by-step setup. Configuration with reasoning. Testing and verification. Troubleshooting.

**Maintenance Guide.** Daily, weekly, and monthly tasks. What to monitor. Common issues with fixes. When to escalate.

## User Guides

**Purpose.** Help end users accomplish tasks.

**Audience.** Non-technical users who need to get things done.

**Tone.** Simple, friendly, clear. No jargon.

**Structure.** What This Does in one sentence. Quick Start in 3 steps. Step-by-Step for each common task. Tips and Tricks. Frequently Asked Questions. Need Help section.

**Visual principle.** If it is visual, explain it visually. One screenshot can replace a paragraph.

Write as if explaining to a smart person who has never seen this system before.

## Runbook Template

For each common operational task, create a runbook.

**Task:** [What you are doing]

**When:** [Trigger or schedule]

**Steps:**
1. [Step with expected result]
2. [Step with expected result]
3. [Step with expected result]

**Expected Result:** [How you know it worked]

**Rollback:** [What to do if something goes wrong]

**Escalate If:** [Conditions that require help]

Keep runbooks simple. If someone cannot follow it at 2am while tired, it is too complex.

## Writing Principles

**Clear beats clever.** Write "use this feature" not "leverage the synergistic paradigm."

**Concise beats verbose.** Write "to access the system" not "in order to be able to access the system."

**Specific beats vague.** Write "processing completes in under 30 seconds" not "it should work quickly."

**Examples beat theory.** Write "set retry_count to 3" not "configure the parameters appropriately."

## Write for Your Future Self

Your future self is a stranger who has forgotten all context.

**Ask yourself.** If I came back to this project in 6 months having forgotten everything, what would I need to know?

**Include.** Why this exists, not just what it does. Why decisions were made, not just what was decided. What to do when things break.

## Document As You Go

Do not wait until the project is done.

**Benefits.** Documentation is accurate because you remember details. It takes less time because you are not reconstructing from memory. You catch gaps early.

**Practical approach.** Spend 10 to 15 minutes at end of each work session. Keep running notes. Convert notes to formal documentation at milestones.

## Keep Documentation Alive

Outdated documentation misleads.

**Strategies.** Update documentation when you change code. Review quarterly. Add a last updated date. Note what changed in a changelog. Delete documentation for deprecated systems.

## Communication Channels

**Email** for formal updates, decision requests, anything needing a paper trail.

**Slack or Chat** for quick questions, informal updates, rapid back-and-forth.

**Calls and Meetings** for complex discussions, kickoffs, demos, relationship building.

**Video with screen share** for visual explanations, training, debugging sessions.

Choose the right channel. Formal decisions belong in email. Quick clarifications belong in chat.

## Quick Summary

- Ship all five document types with every project.
- Send weekly updates on the same day, every week.
- Write for your future self who has forgotten everything.

## Operator Principles

- Document as you build, not after.
- Write for someone who has zero context.
- Match documentation type to audience needs.
- Update documentation when the system changes.',

exercise_markdown = '## Exercise: Create Project Documentation

**Timebox: 45 minutes | Stretch: 90 minutes**

Practice creating documentation for the customer onboarding automation.

### Part 1: Technical Documentation

Write technical documentation that enables another operator to understand and maintain the system.

### Part 2: User Guide

Write a user guide for the team who interacts with the automation daily.

### Part 3: Decision Documentation

Document a key decision made during the project.

### Part 4: Handoff Package

Create a handoff document for delivering the project to the client.

### Part 5: Status Update

Write a status update for a point mid-project.

### Deliverables

Technical documentation. User guide. Decision documentation. Handoff document. Status update.

### Success Criteria

Technical documentation enables a new operator to maintain the system. User guide enables non-technical users to accomplish tasks. Decision documentation explains why, not just what. Handoff is professional. Status update is clear and actionable.',

exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Technical Documentation",
      "description": "Write documentation for maintainers.",
      "fields": [
        {
          "id": "system_overview",
          "type": "textarea",
          "label": "System Overview:",
          "placeholder": "# Customer Onboarding Automation\n\n## Purpose\nAutomatically onboards new customers when payment is received.\n\n## Components\n- Trigger: Stripe payment webhook\n- Processing: Validation, CRM creation, credential generation\n- Outputs: CRM record, welcome email, Drive folder, Slack invitation\n- Error Handling: Dead letter queue, admin alerts\n\n## Data Flow\n1. Stripe sends payment webhook\n2. Automation validates customer data\n3. Creates CRM record\n4. Generates credentials\n5. Sends welcome email\n6. Creates Drive folder\n7. Sends Slack invitation\n8. Notifies team",
          "required": true,
          "rows": 20
        },
        {
          "id": "technical_details",
          "type": "textarea",
          "label": "Technical Details and Configuration:",
          "placeholder": "## Tools and Platforms\n- Automation platform for orchestration\n- Stripe for payment processing\n- CRM for customer database\n- Google Workspace for email and Drive\n- Slack for team communication\n\n## Configuration\n\n### Stripe Webhook\n- Events: checkout.session.completed\n- Secret location: [password manager]\n\n### Error Handling\n- Retry: 3 attempts with backoff\n- Dead letter: Failed items in [location]\n- Alerts: Sent to [channel]",
          "required": true,
          "rows": 18
        },
        {
          "id": "maintenance_guide",
          "type": "textarea",
          "label": "Maintenance Guide:",
          "placeholder": "## Daily Tasks\n- Check error queue (2 minutes)\n\n## Weekly Tasks\n- Review automation metrics\n- Spot check 2-3 customer records\n\n## Common Issues\n| Issue | Cause | Fix |\n| No webhook | Config | Check webhook settings |\n| CRM fails | API limit | Wait 1 hour, retry |\n\n## Escalate If\n- Success rate drops below 95%\n- Errors persist after retry",
          "required": true,
          "rows": 16
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: User Guide",
      "description": "Write a guide for non-technical end users.",
      "fields": [
        {
          "id": "user_guide",
          "type": "textarea",
          "label": "User guide:",
          "placeholder": "# Customer Onboarding - User Guide\n\n## What This Does\nWhen a customer pays, they are automatically added to CRM, sent a welcome email, given a Drive folder, and invited to Slack.\n\n## What Happens Automatically\n1. Customer pays\n2. Within 1 minute:\n   - Customer appears in CRM\n   - Welcome email sent\n   - Drive folder created\n   - Slack invitation sent\n3. Team notification in #new-customers\n\n## What You Need to Do\nNothing for normal onboardings.\n\n## Checking on a Customer\n1. Go to CRM\n2. Search for customer\n3. Record shows onboarding status\n\n## Something Went Wrong?\nContact [admin name] via Slack.",
          "required": true,
          "rows": 28
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Decision Documentation",
      "description": "Document a key decision made during the project.",
      "fields": [
        {
          "id": "decision_doc",
          "type": "textarea",
          "label": "Decision documentation:",
          "placeholder": "# Decision: Credential Generation Method\n\nDate: [Date]\n\n## Context\nNew customers need login credentials. We needed to decide how to generate and deliver them securely.\n\n## Options Considered\n\n1. Random password with reset on first login\n   - Pros: Simple, immediate\n   - Cons: Extra friction for user\n\n2. Magic link / passwordless\n   - Pros: Better UX\n   - Cons: Requires platform changes\n\n## Decision\nOption 1: Random password with required reset.\n\n## Reasoning\nPlatform does not support magic links yet. Can upgrade in Phase 2.\n\n## Fallback\nIf users struggle, add video tutorial or implement magic links.",
          "required": true,
          "rows": 26
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Handoff Document",
      "description": "Create the handoff package.",
      "fields": [
        {
          "id": "handoff_doc",
          "type": "textarea",
          "label": "Handoff documentation:",
          "placeholder": "# Project Handoff: Customer Onboarding\n\n## Summary\nAutomated customer onboarding that triggers on payment. Eliminates 20 minutes of manual work per customer.\n\n## Delivered\n1. Automation workflow\n2. Technical documentation\n3. User guide\n4. Training session\n5. This handoff document\n\n## How to Access\n- Automation platform: [URL]\n- Error notifications: #onboarding-errors\n\n## Daily Operations\nCheck #onboarding-errors daily for failures.\n\n## Support\n- First 30 days: Contact me\n- After: Discuss ongoing support\n\n## Credentials\nAll credentials in [password manager].\n\n## Future Ideas\n- Billing reminders\n- Customer survey after 7 days",
          "required": true,
          "rows": 28
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Status Update",
      "description": "Write a mid-project status update.",
      "fields": [
        {
          "id": "status_update",
          "type": "textarea",
          "label": "Status update:",
          "placeholder": "Subject: Onboarding Automation - Week 3 Update\n\nHi [Name],\n\nProgress This Week:\n- Completed Stripe webhook integration\n- Built CRM record creation\n- Started welcome email automation (80%)\n\nIn Progress:\n- Welcome email - finishing template\n- Drive folder creation - starting tomorrow\n\nComing Next Week:\n- Complete email and Drive\n- Begin testing phase\n\nTimeline Status: On track\n\nBlockers: None\n\nAction Needed:\n- Please review welcome email draft by Friday\n\nBest,\n[Your name]",
          "required": true,
          "rows": 24
        }
      ]
    }
  ],
  "deliverables": [
    "Technical documentation",
    "User guide",
    "Decision documentation",
    "Handoff document",
    "Status update"
  ],
  "success_criteria": [
    "Technical docs enable maintenance",
    "User guide enables non-technical users",
    "Decision doc explains reasoning",
    "Handoff is professional",
    "Status update is actionable"
  ]
}'

WHERE slug = 'communication-documentation';
