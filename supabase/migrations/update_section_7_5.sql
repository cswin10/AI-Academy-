-- ============================================================================
-- UPDATE SECTION 7.5: Project Delivery & Handoff
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, remove any existing questions 5-8 to allow clean re-runs, then add 4 more to reach 8 total
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Delivery and Handoff Quiz')
AND order_index IN (5, 6, 7, 8);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Delivery and Handoff Quiz'), 5,
'What is the purpose of a project acceptance sign-off?',
'["Just paperwork", "Formal acknowledgment that deliverables are complete, protecting both parties", "To speed up payment", "Clients always require it by law"]',
1,
'Written acceptance confirms the project is complete per agreed scope. It protects you and gives the client clear ownership.'),

((SELECT id FROM quizzes WHERE title = 'Delivery and Handoff Quiz'), 6,
'What should training include beyond a live demo?',
'["Nothing, demos are sufficient", "Hands-on practice, recorded video, written materials, and troubleshooting exercises", "Just documentation", "Whatever fits the schedule"]',
1,
'Effective training includes multiple formats. Live demo for overview, hands-on for practice, recordings for reference.'),

((SELECT id FROM quizzes WHERE title = 'Delivery and Handoff Quiz'), 7,
'How should you handle support requests during the post-launch period?',
'["Wait until you have time", "Acknowledge quickly, gather details, investigate, and communicate findings", "Tell them to read the documentation", "Only respond to emergencies"]',
1,
'Support requests deserve prompt handling. Acknowledge quickly, investigate thoroughly, and communicate clearly.'),

((SELECT id FROM quizzes WHERE title = 'Delivery and Handoff Quiz'), 8,
'What is a retrospective and when should you do one?',
'["A type of documentation", "A structured review after project completion to identify improvements", "Reviewing old code", "Something only large teams do"]',
1,
'Retrospectives improve your practice. After each project, review what went well, what did not, and what to change.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Project Delivery & Handoff

How you finish a project determines if you get hired again. A smooth handoff makes clients confident and generates referrals. A sloppy handoff creates ongoing support burden.

Your handoff is part of what the client is buying, not an afterthought.

## Definitions

**Handoff**: The structured transfer of ownership, knowledge, and responsibility from you to the client.

**Acceptance**: Formal acknowledgment that deliverables are complete and requirements have been met.

**Training**: Structured learning experience that enables users to operate the system confidently.

**Support Period**: Defined time after delivery when you provide assistance with clear scope.

**Retrospective**: A structured review after project completion to identify lessons learned.

**Hypercare**: Intensive support period immediately after launch with heightened monitoring.

**Runbook**: Step-by-step instructions for handling specific operational scenarios.

**Knowledge Transfer**: The process of ensuring all relevant knowledge moves from you to the people who operate the system.

## Handoff Components

### Working System

The delivered system must be fully functional, thoroughly tested, with error handling in place and monitoring enabled.

Complete means complete. Not "mostly works" or "just need to fix a few bugs."

### Documentation

See Section 7.4. You need all five document types: system overview, technical documentation, user guide, runbook, and decision log.

### Credentials and Access

Organize all access information in a secure location.

**For each system, document.** URL or access point. Login credentials or API keys. Two-factor authentication details. Who has access. How to change access.

**Credential handoff process.** Share credentials via secure method. Client confirms access. Client changes passwords to take ownership. Remove your admin access if appropriate.

### Training

**Session structure (90 minutes total).**

Overview, 10 minutes. What you built, why it matters, how it helps.

Demo, 25 minutes. Live walkthrough showing normal operations, edge cases, and error handling.

Hands-On, 25 minutes. Client performs tasks, practices troubleshooting.

Daily Operations, 10 minutes. What to check, what is normal, what is concerning.

Troubleshooting, 10 minutes. Common issues and fixes, when to escalate.

Support and Next Steps, 5 minutes. Support plan, contact information, sign acceptance.

Q&A, 5 minutes.

Record the session. Share the recording afterward.

### Support Plan

Define the support period clearly.

**Included (example: 30 days).** Questions via email. Bug fixes at no charge. Minor adjustments. Response within 24 hours on weekdays.

**Not included.** New features. Integration with additional tools. Major scope changes. Training for new team members.

**The support boundary rule.** If it changes what the system does, it is a feature. Features are new scope.

**After support period.** Offer ongoing support agreement or close out cleanly.

### Acceptance Sign-Off

Get formal written acceptance before final invoice.

**Acceptance document includes.** Project name, client, date. Deliverables completed with checkboxes. Success criteria met. Training completed. Access confirmed. Signatures from both parties.

**Real-world example: Event promoter.** An event company signs off on ticket reconciliation automation. Three months later, they request free changes claiming you never finished. You pull out the signed acceptance showing they confirmed completion. Clear documentation protects you.

## Handoff Process

### Pre-Handoff Checklist

**Two weeks before.** Finalize features. Complete testing. Fix bugs. Complete documentation. Prepare training. Schedule meeting. Organize credentials. Set up monitoring. Prepare acceptance form.

**One week before.** Send documentation for review. Send training agenda. Confirm meeting. Test everything. Prepare demo environment.

**Day before.** Verify system running. Check integrations. Prepare demo script. Have backup plans ready.

### Handoff Meeting

**Structure (85 minutes).**

Celebrate, 5 minutes. Acknowledge completion, review accomplishments.

Overview, 10 minutes. Original problem, what you built.

Live Demo, 20 minutes. Walkthrough including error scenarios.

Hands-On Training, 30 minutes. Client performs tasks.

Documentation Review, 10 minutes. Where to find answers.

Support and Next Steps, 10 minutes. Support plan, sign acceptance.

### Post-Handoff Actions

**Immediately after.** Send meeting notes. Share recording. Send all materials. Confirm access works.

**First week.** Check in asking how it is going. Answer initial questions. Fix any issues discovered.

**Ongoing during support.** Monitor error logs if accessible. Respond promptly.

## Common Handoff Mistakes

**Assuming They Know.** What is obvious to you is not obvious to them. Explain everything.

**Rushing.** A quick "here are the docs, bye" leaves clients anxious. Take time.

**No Training.** "Just read the docs" does not work.

**Incomplete Documentation.** Missing troubleshooting, credentials, or contact info creates problems.

**No Support Plan.** Vague "contact me if issues" leaves expectations unclear.

**Not Testing Before Demo.** Demo failing during handoff destroys confidence.

**No Acceptance Sign-Off.** Verbal "looks good" provides no protection.

## Post-Launch Support

### Support Request Process

**Step 1: Acknowledge quickly.** Within 2 hours. Thank them. Tell them when you will investigate. Ask clarifying questions.

**Step 2: Investigate.** Check error logs. Test the scenario. Identify root cause.

**Step 3: Communicate findings.** Explain what happened. Describe the fix or options. Give timeline.

**Step 4: Resolve and confirm.** Implement fix. Test. Ask client to confirm resolution. Document for future.

### Bugs vs Features

**Bug (covered).** Something that worked before and now does not. Something not working as documented. Error preventing normal operation.

**Feature (new scope).** New functionality. Enhancement to existing capability. Integration with new system.

When feature requests arrive during support: acknowledge the idea, explain it is outside support scope, offer to discuss as separate project.

## Retrospective

After every project, review what happened.

### Questions

**What went well?** What was successful? What would you repeat?

**What did not go well?** What caused problems? What would you avoid?

**What would you do differently?** What will you change for next project?

**What did you learn?** New skills, tools, insights?

### Format

Set aside 30 minutes after project completion. Write answers to each question. Identify 2 to 3 specific changes.

**Save and reuse.** Keep retrospectives in a single folder. Skim before every new project. Patterns emerge over time.

## Module 7 Recap

This module covered project management for operators.

**Section 7.1: Scoping and Requirements Gathering.** Define clear boundaries and document everything.

**Section 7.2: Estimating Time and Effort.** Use historical data, add buffers, present ranges honestly.

**Section 7.3: Managing Stakeholders and Expectations.** Understand who matters, communicate proactively.

**Section 7.4: Effective Communication and Documentation.** Write for your future self, ship all five document types.

**Section 7.5: Project Delivery and Handoff.** Deliver completely, train thoroughly, support professionally.

Technical skills get you started. Project management skills keep you hired.

## Quick Summary

- Handoff is a product. Deliver it with the same care as the automation.
- Get written acceptance before final invoice.
- Conduct a retrospective after every project and save it.

## Operator Principles

- Complete handoff before sending final invoice.
- Train users rather than just handing them documentation.
- Define support boundaries explicitly in writing.
- Conduct and save a retrospective after every project.',

exercise_markdown = '## Exercise: Project Handoff

**Timebox: 45 minutes | Stretch: 90 minutes**

Practice creating all components of a professional project handoff.

### Part 1: Handoff Checklist

Create a pre-handoff checklist customized for the customer onboarding automation project.

### Part 2: Training Agenda

Design the training session agenda with timing and content for each section.

### Part 3: Acceptance Document

Create the project acceptance document for client sign-off.

### Part 4: Support Plan

Define the post-launch support plan including scope, boundaries, and process.

### Part 5: Retrospective

Conduct a retrospective on the customer onboarding automation project.

### Deliverables

Pre-handoff checklist. Training agenda. Acceptance document. Support plan. Retrospective.

### Success Criteria

Checklist covers all handoff components. Training agenda is practical. Acceptance document is professional and signable. Support plan has clear boundaries. Retrospective identifies specific improvements.',

exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Handoff Checklist",
      "description": "Create a pre-handoff checklist.",
      "fields": [
        {
          "id": "two_weeks_before",
          "type": "textarea",
          "label": "2 weeks before handoff:",
          "placeholder": "- All automation steps working\n- Error handling tested\n- Technical documentation done\n- User guide done\n- Training materials prepared\n- Meeting scheduled\n- Credentials organized\n- Monitoring configured\n- Acceptance form prepared",
          "required": true,
          "rows": 10
        },
        {
          "id": "one_week_before",
          "type": "textarea",
          "label": "1 week before handoff:",
          "placeholder": "- Documentation sent for review\n- Training agenda sent\n- Meeting confirmed\n- End-to-end test completed\n- Demo environment prepared\n- Backup created",
          "required": true,
          "rows": 8
        },
        {
          "id": "day_before",
          "type": "textarea",
          "label": "Day before handoff:",
          "placeholder": "- Automation running successfully\n- All integrations verified\n- Demo script reviewed\n- Screen share tools tested\n- Backup plan ready\n- Materials ready to share",
          "required": true,
          "rows": 8
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Training Agenda",
      "description": "Design the training session structure.",
      "fields": [
        {
          "id": "training_agenda",
          "type": "textarea",
          "label": "Training agenda with timing:",
          "placeholder": "# Customer Onboarding Training\nDuration: 90 minutes\n\n## Overview (10 min)\n- Original problem\n- What we built\n- Key benefits\n\n## Live Demo (25 min)\n- Complete walkthrough\n- Error handling demo\n\n## Hands-On Practice (25 min)\n- Client triggers test payment\n- Client views logs\n- Client practices retry\n\n## Daily Operations (10 min)\n- What to check\n- What is normal vs concerning\n\n## Troubleshooting (10 min)\n- Common issues\n- Using the guide\n\n## Support and Next Steps (5 min)\n- 30-day support details\n- Sign acceptance\n\n## Q&A (5 min)",
          "required": true,
          "rows": 28
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Acceptance Document",
      "description": "Create the project acceptance form.",
      "fields": [
        {
          "id": "acceptance_doc",
          "type": "textarea",
          "label": "Project acceptance document:",
          "placeholder": "# Project Acceptance\n\nProject: Customer Onboarding Automation\nClient: [Company Name]\nDate: [Date]\n\n## Deliverables Completed\n- Stripe webhook integration\n- CRM record creation\n- Credential generation\n- Welcome email automation\n- Drive folder creation\n- Slack invitation\n- Team notification\n- Error handling\n- Documentation\n- Training\n\n## Success Criteria Met\n- Processing under 60 seconds\n- Success rate above 99%\n- Zero manual intervention\n\n## Acceptance\nBy signing, client acknowledges all deliverables complete, requirements met, training provided.\n\nClient Signature: _______________\nDate: _______________\n\nOperator Signature: _______________\nDate: _______________",
          "required": true,
          "rows": 32
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Support Plan",
      "description": "Define post-launch support.",
      "fields": [
        {
          "id": "support_plan",
          "type": "textarea",
          "label": "Support plan:",
          "placeholder": "# Post-Launch Support Plan\n\nSupport Period: 30 days from acceptance\n\n## Included\n- Unlimited questions via email\n- Bug fixes at no charge\n- Minor adjustments\n- Response within 24 hours (weekdays)\n- Same-day for urgent issues\n\n## Not Included\n- New features\n- Integration with additional tools\n- Major scope changes\n- Training for new team members\n\n## Support Boundary Rule\nIf it changes what the system does, it is a feature. Features are new scope.\n\n## How to Request Support\n1. Email: [your email]\n2. Subject: Onboarding Support - [brief description]\n3. Include: what you tried, what happened, screenshots\n\n## After Support Ends\nOption 1: No ongoing support\nOption 2: Monthly retainer",
          "required": true,
          "rows": 30
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Retrospective",
      "description": "Conduct a project retrospective.",
      "fields": [
        {
          "id": "what_went_well",
          "type": "textarea",
          "label": "What went well?",
          "placeholder": "1. Scoping prevented scope creep\n2. Weekly updates built trust\n3. Testing caught edge cases early\n4. Documentation made handoff smooth",
          "required": true,
          "rows": 6
        },
        {
          "id": "what_didnt_go_well",
          "type": "textarea",
          "label": "What did not go well?",
          "placeholder": "1. CRM integration took 50% longer than estimated\n2. Training agenda was too ambitious\n3. Did not test with high volume before launch",
          "required": true,
          "rows": 6
        },
        {
          "id": "what_would_change",
          "type": "textarea",
          "label": "What would you do differently?",
          "placeholder": "1. Add 50% buffer for new API integrations\n2. Limit training to 75 minutes\n3. Always test with 10x expected volume",
          "required": true,
          "rows": 6
        },
        {
          "id": "lessons_learned",
          "type": "textarea",
          "label": "Key lessons to carry forward:",
          "placeholder": "1. Poor third-party docs are a risk factor\n2. Shorter training works better than longer\n3. Volume testing matters even for low-volume automations",
          "required": true,
          "rows": 6
        }
      ]
    }
  ],
  "deliverables": [
    "Pre-handoff checklist",
    "Training agenda",
    "Acceptance document",
    "Support plan",
    "Retrospective"
  ],
  "success_criteria": [
    "Checklist covers all components",
    "Training agenda is practical",
    "Acceptance document is signable",
    "Support plan has clear boundaries",
    "Retrospective identifies improvements"
  ]
}'

WHERE slug = 'delivery-handoff';
