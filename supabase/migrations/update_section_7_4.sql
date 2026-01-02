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
'["Planning future projects", "Writing documentation that you will understand 6 months later when you have forgotten the context", "Predicting future requirements", "Setting future deadlines"]',
1,
'Your future self is a stranger who has forgotten all context. Write documentation that explains the why, not just the what, so future-you can understand and maintain the work.'),

((SELECT id FROM quizzes WHERE title = 'Communication Quiz'), 6,
'What should decision documentation always include?',
'["Just the final decision", "The decision, options considered, reasoning, and what to do if the decision proves wrong", "Only technical details", "A list of participants"]',
1,
'Decision documentation captures context, alternatives, reasoning, and fallback plans. Six months later when someone asks why you did it that way, you have the complete answer.'),

((SELECT id FROM quizzes WHERE title = 'Communication Quiz'), 7,
'What is the difference between technical documentation and user guides?',
'["They are the same thing", "Technical documentation explains how things work for maintainers, user guides explain how to use things for end users", "User guides are longer", "Technical documentation is for clients only"]',
1,
'Different audiences need different documentation. Maintainers need technical details. End users need simple instructions. Write for your specific audience.'),

((SELECT id FROM quizzes WHERE title = 'Communication Quiz'), 8,
'How should you handle documentation for a project that changes frequently?',
'["Do not write documentation until the project is stable", "Document as you go and update when things change, keeping a changelog of significant changes", "Write once at the end", "Only document the final version"]',
1,
'Documentation should evolve with the project. Write as you build, update when things change, and note what changed. Living documentation beats outdated documentation.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Effective Communication & Documentation

**This is how operators ensure their work outlasts the project.**

Great operators are great communicators. Your technical skills only matter if people understand your work. Documentation is not extra work; it is part of the work. Good documentation saves you time, protects your reputation, and enables others to succeed.

## Definitions

**Documentation**: Written records that explain how systems work, how to use them, and why decisions were made. Good documentation survives the original creator.

**Status Update**: Regular communication informing stakeholders of progress, issues, and next steps. Status updates prevent surprises.

**Technical Documentation**: Detailed explanation of how systems work, written for maintainers and developers.

**User Guide**: Instructions for end users explaining how to accomplish tasks, written in simple, accessible language.

**Decision Documentation**: Record of why choices were made, what alternatives were considered, and what to do if the decision proves wrong.

**Handoff Documentation**: Complete package enabling someone else to take over responsibility for a system or project.

**Changelog**: Record of what changed, when, and why. Changelogs help track evolution over time.

**Living Documentation**: Documentation that is updated as systems change, rather than becoming stale and misleading.

## Why Communication Matters

**Without good communication** your work goes unrecognized because no one knows what you did. Stakeholders feel uninformed and anxious. Knowledge is lost when you move on. You constantly answer the same questions. Projects feel chaotic to everyone involved.

**With good communication** everyone knows what is happening and why. Work is valued and visible. Knowledge is preserved for the future. Less time is spent on redundant explanations. Projects feel professional and controlled.

Communication is not extra work. It is part of the work.

## Types of Communication

### Status Updates

**Purpose.** Keep stakeholders informed of progress.

**Frequency.** Weekly minimum.

**Structure.** Progress This Week listing completed items. In Progress items with percentage complete. Coming Next Week listing planned items. Timeline status showing on track or days behind with explanation. Blockers listed with what you need and when. Metrics if applicable. Action Items for Stakeholders listing who needs to do what by when.

Status updates should take 10-15 minutes to write. If they take longer, you are overcomplicating them.

### Technical Documentation

**Purpose.** Explain how things work for maintainers.

**Audience.** Future maintainers, including your future self.

**System Overview sections.** Purpose explaining what this automation does and why it exists. Components listing trigger, data sources, processing, outputs, and error handling. Architecture diagram showing visual representation. Data flow explaining how data moves through the system.

**Setup Instructions sections.** Prerequisites listing tools and access needed. Step-by-step setup with details. Configuration explaining settings and why they are set that way. Testing explaining how to verify it works. Troubleshooting covering common issues and solutions.

**Maintenance Guide sections.** Daily, weekly, and monthly tasks. Monitoring explaining what to watch, where to find it, what is normal, and what is a problem. Common issues in table format with issue, cause, and fix. When to call for help listing scenarios requiring escalation. Escalation contact information.

### User Guides

**Purpose.** Help end users use the system.

**Audience.** Non-technical users who need to accomplish tasks.

**Tone.** Simple, friendly, clear. No jargon.

**Structure.** What This Does in one sentence. Quick Start with 3 simple steps. Step-by-Step Guide for each common task with screenshots. Tips and Tricks with helpful hints. Frequently Asked Questions with clear answers. Need Help section with contact information.

Write as if explaining to a smart person who has never seen this system before.

### Decision Documentation

**Purpose.** Record why choices were made.

**Why it matters.** Six months later when someone asks "why did we do it this way?" you have the complete answer.

**Structure.** Decision topic and date. Participants who were involved. Context explaining what situation led to this decision. Options Considered listing each option with pros and cons. Decision stating what was chosen. Reasoning explaining why this option was selected. Implications listing impacts. Alternatives if this does not work as a backup plan.

### Handoff Documentation

**Purpose.** Transfer project to client or team.

**Structure.** Executive Summary covering what was built, why, and key outcomes. What Was Delivered listing deliverables with locations. How to Access with URLs and instructions. How It Works with high-level explanation. Daily Operations explaining what happens automatically. Monitoring and Maintenance with check frequencies. Troubleshooting covering common issues and fixes. Support with documentation links and contact info. Credentials and Access noting where they are stored. Future Enhancements with Phase 2 ideas. Known Limitations explaining what it does not do and why.

## Writing Effective Documentation

### Principles of Good Technical Writing

**Clear beats clever.** Do not write "leverage the synergistic paradigm." Write "use this feature to."

**Concise beats verbose.** Do not write "in order to be able to access the system." Write "to access the system."

**Organized beats stream of consciousness.** Use logical flow, clear sections, and headers. Not random order.

**Specific beats vague.** Do not write "it should work quickly." Write "processing completes in under 30 seconds."

**Examples beat theory.** Do not write "configure the parameters appropriately." Write "set retry_count to 3 for most use cases."

### Write for Your Future Self

Your future self is a stranger who has forgotten all context. Write documentation that future-you will understand 6 months from now.

**Ask yourself.** If I came back to this project in 6 months having forgotten everything, what would I need to know?

**Include.** Why this exists, not just what it does. Why decisions were made, not just what was decided. What to do when things break, not just how it works normally.

### Document As You Go

Do not wait until the project is done. Document as you build.

**Benefits.** Documentation is accurate because you remember the details. It takes less total time because you are not reconstructing from memory. You catch gaps in understanding early. Stakeholders can review documentation during the project.

**Practical approach.** Spend 10-15 minutes at end of each work session updating documentation. Keep a running notes document for each project. Convert notes to formal documentation at project milestones.

### Keep Documentation Alive

Outdated documentation is worse than no documentation because it misleads.

**Strategies.** Update documentation when you change code. Review documentation quarterly even if nothing changed. Add a "last updated" date to every document. Note what changed and when in a changelog section. Delete documentation for deprecated systems.

## Documentation Templates

### Project Documentation Template

**Project Overview.** Project name, date, author. Purpose explaining what problem this solves. Scope referencing scope document if separate.

**System Architecture.** Components listing each part of the system. Data flow explaining how information moves through the system. Integrations listing external systems and how they connect. Trigger explaining what starts the automation. Outputs explaining what the automation produces.

**Technical Details.** Tools and platforms listing what is used. Configuration for each tool. API connections listing integrations with authentication details stored securely. Scheduling explaining when things run.

**Operations.** Normal operation explaining what happens during typical use. Error handling explaining what happens when things fail. Monitoring explaining what to watch. Maintenance tasks with frequency.

**Troubleshooting.** Common issues with symptoms, causes, and fixes. Escalation explaining when and how to get help.

**Change Log.** Record of changes with date, description, and author.

### Runbook Template

For each common operational task, create a runbook.

**Task name.** When to perform. Who can perform. Prerequisites.

**Steps.** Numbered, specific steps with expected result for each step.

**Verification.** How to confirm success.

**Rollback.** What to do if something goes wrong.

**Notes.** Edge cases and warnings.

## Communication Best Practices

### Matching Channel to Message

**Email** for formal updates, decision requests, documentation, anything needing a paper trail.

**Slack or Chat** for quick questions, informal updates, rapid back-and-forth, team coordination.

**Calls and Meetings** for complex discussions, kickoffs, demos, problem-solving, relationship building.

**Video with screen share** for explanations of visual systems, training, debugging sessions.

Choose the right channel. Formal decisions belong in email. Quick clarifications belong in chat.

### Avoiding Jargon

**Know your audience.** Technical documentation can use technical terms. User guides should not.

**When in doubt, simplify.** Instead of "the webhook triggers the zap which updates the row in the base," say "when someone submits the form, the system automatically updates the database."

**Define terms on first use.** If you must use technical terms, define them.

### Giving and Receiving Feedback

**Giving feedback on documentation.** Be specific about what is unclear. Suggest improvements, do not just critique. Acknowledge what works well.

**Receiving feedback.** Do not get defensive. Ask clarifying questions. Thank reviewers for their time.

**Test your documentation.** Have someone unfamiliar with the system follow your instructions. Watch them, note where they struggle. Update documentation based on observations.

## Operator Principles

**Document as you build, not after.** Writing documentation at the end is painful and incomplete. Spend 10-15 minutes after each work session updating docs.

**Write for your future self.** Six months from now you will have forgotten everything. Write documentation that future-you will understand without context.

**Match documentation type to audience.** Technical docs for maintainers, user guides for end users, decision docs for future questioners. One size does not fit all.

**Keep documentation alive.** Outdated documentation is worse than no documentation. Update when things change, review quarterly, delete what is deprecated.',

exercise_markdown = '## Exercise: Create Complete Project Documentation

**Objective:** Practice creating comprehensive documentation for the customer onboarding automation.

### Part 1: Technical Documentation

Write technical documentation that would enable another operator to understand and maintain the system.

### Part 2: User Guide

Write a user guide for the team who will interact with the automation daily.

### Part 3: Decision Documentation

Document a key decision made during the project.

### Part 4: Handoff Package

Create a handoff document for delivering the project to the client.

### Part 5: Status Update

Write a status update for a point mid-project.

### Deliverables

Technical documentation covering architecture and maintenance. User guide suitable for non-technical users. Decision documentation with reasoning and alternatives. Complete handoff document. Sample status update.

### Success Criteria

Technical documentation enables a new operator to maintain the system. User guide enables non-technical users to accomplish tasks. Decision documentation explains why, not just what. Handoff package is complete and professional. Status update is clear and actionable.',

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
          "placeholder": "# Customer Onboarding Automation\n\n## Purpose\nAutomatically onboards new customers when payment is received, eliminating manual data entry and ensuring consistent experience.\n\n## Components\n- Trigger: Stripe payment webhook\n- Data Sources: Stripe customer data\n- Processing: Validation, CRM creation, credential generation\n- Outputs: CRM record, welcome email, Drive folder, Slack invitation\n- Error Handling: Dead letter queue, admin alerts\n\n## Architecture\n[Describe how components connect]\n\n## Data Flow\n1. Stripe sends payment webhook\n2. Automation validates customer data\n3. Creates CRM record with customer info\n4. Generates login credentials\n5. Sends welcome email with credentials\n6. Creates Google Drive folder\n7. Sends Slack workspace invitation\n8. Notifies team in Slack channel",
          "required": true,
          "rows": 24
        },
        {
          "id": "technical_details",
          "type": "textarea",
          "label": "Technical Details and Configuration:",
          "placeholder": "## Tools and Platforms\n- Zapier: Automation orchestration\n- Stripe: Payment processing (webhook source)\n- [CRM Name]: Customer database\n- Google Workspace: Email and Drive\n- Slack: Team communication\n\n## Configuration\n\n### Stripe Webhook\n- Endpoint: [URL]\n- Events: checkout.session.completed\n- Secret: Stored in [password manager location]\n\n### CRM Integration\n- API key location: [password manager location]\n- Base/Table: [specific location]\n- Fields mapped: [list]\n\n### Error Handling\n- Retry: 3 attempts with exponential backoff\n- Dead letter: Failed items stored in [location]\n- Alerts: Sent to [channel/email]",
          "required": true,
          "rows": 22
        },
        {
          "id": "maintenance_guide",
          "type": "textarea",
          "label": "Maintenance Guide:",
          "placeholder": "## Daily Tasks\n- Check error queue for failed items (takes 2 minutes)\n- Review overnight automation runs\n\n## Weekly Tasks\n- Review automation metrics\n- Clear processed items from error queue\n- Spot check 2-3 customer records for accuracy\n\n## Monthly Tasks\n- Review and update email templates if needed\n- Check API usage against limits\n- Archive old logs\n\n## Monitoring\n- What to watch: Success rate, processing time, error count\n- Where: Zapier task history, error Slack channel\n- Normal: 99%+ success rate, <60s processing\n- Problem: <95% success or >5 min processing\n\n## Common Issues\n| Issue | Cause | Fix |\n| No webhook received | Stripe config | Check webhook settings |\n| CRM creation fails | API limit | Wait 1 hour, retry |\n| Email not sent | Template error | Check template syntax |",
          "required": true,
          "rows": 24
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
          "label": "Complete user guide:",
          "placeholder": "# Customer Onboarding System - User Guide\n\n## What This Does\nWhen a customer pays, they are automatically added to our CRM, sent a welcome email with login credentials, given a Google Drive folder, and invited to Slack. You do not need to do anything manually.\n\n## What Happens Automatically\n1. Customer pays on our website\n2. Within 1 minute, all onboarding steps complete automatically:\n   - Customer appears in CRM\n   - Welcome email sent to customer\n   - Google Drive folder created\n   - Slack invitation sent\n3. Team notification appears in #new-customers\n\n## What You Need to Do\n- Nothing for normal onboardings!\n- Check #new-customers channel to see new signups\n- If you see an error notification, contact [admin]\n\n## Checking on a Customer\n1. Go to [CRM URL]\n2. Search for customer name or email\n3. Their record shows onboarding status\n\n## Something Went Wrong?\nIf a customer reports they did not receive their welcome email:\n1. Check CRM for their record\n2. Check if email shows as sent\n3. Ask customer to check spam folder\n4. If still missing, contact [admin]\n\n## Frequently Asked Questions\n\nQ: How long does onboarding take?\nA: Usually under 1 minute after payment.\n\nQ: Can I manually add a customer?\nA: Yes, but contact [admin] for instructions.\n\nQ: What if a customer needs different credentials?\nA: Contact [admin] to reset.\n\n## Need Help?\nContact [admin name] via Slack or email.",
          "required": true,
          "rows": 36
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
          "placeholder": "# Decision: Credential Generation Method\n\nDate: [Date]\nParticipants: [You], [Client contact]\n\n## Context\nNew customers need login credentials for the platform. We needed to decide how to generate and deliver these credentials securely.\n\n## Options Considered\n\n1. Random password generation\n   - Pros: Simple to implement, no external dependencies\n   - Cons: Customers must reset password, extra friction\n\n2. Magic link / passwordless\n   - Pros: Better UX, more secure\n   - Cons: Requires platform support, more complex\n\n3. SSO with existing Google account\n   - Pros: Easiest for users, most secure\n   - Cons: Requires platform changes, not all users have Google\n\n## Decision\nOption 1: Random password generation with required reset on first login.\n\n## Reasoning\n- Platform does not currently support magic links or SSO\n- Random passwords can be implemented immediately\n- Password reset on first login adds security\n- Can upgrade to magic links in Phase 2\n\n## Implications\n- Welcome email must clearly explain first-login process\n- Need secure password generation (minimum 16 chars)\n- Need to track which users have completed first login\n\n## If This Does Not Work\nIf users struggle with password reset flow, we can:\n1. Add video tutorial in welcome email\n2. Implement magic links in Phase 2\n3. Offer manual credential delivery for problematic cases",
          "required": true,
          "rows": 36
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Handoff Document",
      "description": "Create the complete handoff package.",
      "fields": [
        {
          "id": "handoff_doc",
          "type": "textarea",
          "label": "Handoff documentation:",
          "placeholder": "# Project Handoff: Customer Onboarding Automation\n\n## Executive Summary\nWe built an automated customer onboarding system that triggers when a customer completes payment. The system eliminates 20 minutes of manual work per customer and ensures consistent onboarding experience. Processing time is under 1 minute with 99%+ success rate.\n\n## What Was Delivered\n1. Zapier automation workflow - [Link to Zapier]\n2. Technical documentation - [Link]\n3. User guide - [Link]\n4. Training video - [Link]\n5. This handoff document\n\n## How to Access\n- Zapier: [URL] - Login with [account]\n- CRM: [URL] - Your existing access works\n- Error notifications: #onboarding-errors Slack channel\n\n## How It Works\n1. Customer completes Stripe checkout\n2. Stripe sends webhook to Zapier\n3. Zapier validates data and creates CRM record\n4. Zapier generates credentials and sends welcome email\n5. Zapier creates Drive folder and sends Slack invite\n6. Team notified in #new-customers\n\n## Daily Operations\nThe system runs automatically. Check #onboarding-errors daily for any failures.\n\n## Monitoring and Maintenance\n- Daily: Check error channel (2 min)\n- Weekly: Review metrics in Zapier (5 min)\n- Monthly: Review and archive logs (15 min)\n\n## Troubleshooting\nSee Maintenance Guide section of technical documentation.\n\n## Support\n- First 30 days: Contact me for any issues\n- Documentation: [All links]\n- After 30 days: We can discuss ongoing support agreement\n\n## Credentials and Access\nAll API keys and credentials stored in [password manager].\n[Admin name] has access.\n\n## Future Enhancements (Phase 2 ideas)\n- Automated billing reminders\n- Customer satisfaction survey after 7 days\n- Usage tracking and reporting\n\n## Known Limitations\n- System requires valid email (no phone-only signups)\n- Slack invitation requires customer to have Slack account\n- Drive folder creation requires Google Workspace",
          "required": true,
          "rows": 42
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
          "label": "Sample status update:",
          "placeholder": "Subject: Onboarding Automation - Week 3 Update\n\nHi [Name],\n\nQuick update on the customer onboarding automation:\n\n**Progress This Week:**\n✓ Completed Stripe webhook integration\n✓ Built CRM record creation flow\n✓ Implemented credential generation\n✓ Started welcome email automation (80% complete)\n\n**In Progress:**\n⏳ Welcome email automation - finishing template integration\n⏳ Google Drive folder creation - starting tomorrow\n\n**Coming Next Week:**\n📅 Complete email and Drive integrations\n📅 Add Slack invitation and team notification\n📅 Begin testing phase\n\n**Timeline Status:**\n🎯 On track for completion by [date]\n\n**Blockers:**\n❌ None currently\n\n**Metrics So Far:**\n- Processing time: 45 seconds (target: <60s) ✓\n- Test success rate: 100% on sample data ✓\n\n**Action Needed From You:**\n- Please review the welcome email draft I sent yesterday\n- Confirm Slack workspace for testing by Friday\n\nLet me know if you have questions!\n\nBest,\n[Your name]",
          "required": true,
          "rows": 30
        }
      ]
    }
  ],
  "deliverables": [
    "Technical documentation with architecture and maintenance",
    "User guide for non-technical users",
    "Decision documentation with reasoning",
    "Complete handoff document",
    "Sample status update"
  ],
  "success_criteria": [
    "Technical docs enable new operator to maintain",
    "User guide enables non-technical users",
    "Decision doc explains why not just what",
    "Handoff is complete and professional",
    "Status update is clear and actionable"
  ]
}'

WHERE slug = 'communication-documentation';
