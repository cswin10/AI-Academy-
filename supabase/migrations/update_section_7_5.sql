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
'["Just paperwork", "Formal acknowledgment that deliverables are complete and requirements are met, protecting both parties", "To get paid faster", "Clients always require it"]',
1,
'Written acceptance confirms the project is complete per the agreed scope. It protects you from scope disputes and gives the client clear ownership of the delivered work.'),

((SELECT id FROM quizzes WHERE title = 'Delivery and Handoff Quiz'), 6,
'What should training include beyond a live demo?',
'["Nothing, demos are sufficient", "Hands-on practice, recorded video, written materials, troubleshooting exercises, and Q&A", "Just documentation", "Whatever time allows"]',
1,
'Effective training includes multiple formats: live demo for overview, hands-on for muscle memory, recordings for reference, and documentation for troubleshooting. Different people learn differently.'),

((SELECT id FROM quizzes WHERE title = 'Delivery and Handoff Quiz'), 7,
'How should you handle support requests during the post-launch period?',
'["Ignore them until you have time", "Acknowledge quickly, gather details, investigate, communicate findings, and resolve or escalate", "Tell them to read the docs", "Only respond to emergencies"]',
1,
'Support requests deserve prompt, professional handling. Acknowledge quickly, ask clarifying questions, investigate thoroughly, and communicate clearly. Good support turns one-time clients into long-term relationships.'),

((SELECT id FROM quizzes WHERE title = 'Delivery and Handoff Quiz'), 8,
'What is a retrospective and when should you do one?',
'["A type of documentation", "A structured review after project completion to identify what worked, what did not, and how to improve future projects", "Looking at old code", "Something only agile teams do"]',
1,
'Retrospectives improve your practice. After each project, review what went well, what did not, and what you will change. This continuous improvement compounds over time.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Project Delivery & Handoff

**This is how operators turn one-time clients into long-term relationships.**

How you finish a project determines if you get hired again. A smooth handoff makes clients confident and generates referrals. A sloppy handoff makes clients anxious and creates ongoing support burden. Nail the landing.

## Definitions

**Handoff**: The structured transfer of ownership, knowledge, and responsibility from you to the client or team.

**Acceptance**: Formal acknowledgment that deliverables are complete and requirements have been met. Written acceptance protects both parties.

**Training**: Structured learning experience that enables users to operate the system confidently. Training goes beyond documentation.

**Support Period**: Defined time after delivery when you provide assistance. Support periods have clear scope and boundaries.

**Retrospective**: A structured review after project completion to identify lessons learned. Retrospectives improve future performance.

**Hypercare**: An intensive support period immediately after launch with heightened monitoring and rapid response.

**Runbook**: Step-by-step instructions for handling specific operational scenarios. Runbooks enable consistent handling of common situations.

**Knowledge Transfer**: The process of ensuring all relevant knowledge moves from you to the people who will operate and maintain the system.

## Why Handoff Matters

**Bad handoff**: You say "here is the thing, it works, good luck!" The client is confused. Questions come for weeks. Things break. The client is unhappy. No referral.

**Good handoff**: Clear documentation, comprehensive training, smooth transition. The client is confident. Minimal questions. Successful long-term use. Great referral.

Handoff is the difference between one-time client and long-term relationship.

## Handoff Components

### Working System

The delivered system must be fully functional, thoroughly tested, with error handling in place, monitoring enabled, and completely documented.

It must not be "mostly works" or "just need to fix a few bugs" or "test it yourself." Complete means complete.

### Complete Documentation

**Required documentation.** System overview explaining what it does and why. Setup instructions for recreation if needed. User guide for daily operators. Maintenance procedures for ongoing operation. Troubleshooting guide for common issues. Architecture diagrams showing how components connect. Contact information for escalation.

See Section 7.4 for documentation templates and best practices.

### Credentials and Access

Organize all access information in a secure location like a password manager.

**For each system, document.** URL or access point. Login credentials or API keys. Two-factor authentication details. Who has access. How to change access if needed.

**Credential handoff process.** Share credentials via secure method. Client confirms they can access everything. Client changes passwords to take ownership. Remove your admin access if appropriate.

### Training

**Live training session structure.** Part 1, Overview for 10 minutes covering what you built, why it matters, and how it helps. Part 2, Demo for 20 minutes with live walkthrough showing normal operations, edge cases, and error handling. Part 3, Hands-on for 20 minutes where the client tries the system, performs common tasks, and practices troubleshooting. Part 4, Maintenance for 10 minutes covering daily operations, what to watch, and common issues. Part 5, Support for 5 minutes explaining how to get help and next steps. Part 6, Q&A for 15 minutes.

Total training time is approximately 90 minutes.

**Recorded training.** Record the live session and share the recording afterward. Create separate short videos for specific topics if the system is complex.

**Training materials.** User guide in PDF or shared document. Quick reference card with most common tasks. Troubleshooting flowchart for self-service problem solving.

### Support Plan

Define the support period and scope clearly.

**Included in support period (example: first 30 days).** Unlimited questions via email. Bug fixes at no charge. One round of minor adjustments. Response time under 24 hours on weekdays.

**Not included.** New features different from bugs. Integration with new tools. Major scope changes. Training for new team members after initial training.

**After support period ends.** Offer options for ongoing support agreement if they want continued assistance.

**How to get support.** Specify contact method, expected subject line format, information to include in requests, and response time commitment.

### Acceptance and Sign-Off

Get formal written acceptance before final invoice.

**Acceptance document includes.** Project name, client, date. Deliverables completed with checkboxes. Success criteria met with checkboxes. Training completed with dates. Access provided and confirmed.

**Acceptance statement.** By signing, the client acknowledges all deliverables are complete, the system meets requirements, training was provided, and documentation is sufficient. Space for client signature and date, operator signature and date.

Get this signed before sending final invoice.

## Handoff Process

### Pre-Handoff Checklist

**Two weeks before handoff.** Finalize all features. Complete all testing. Fix all known bugs. Complete documentation. Prepare training materials. Schedule handoff meeting. Organize credentials. Set up monitoring. Prepare acceptance form.

**One week before handoff.** Send documentation to client for review. Send training agenda. Confirm handoff meeting time. Test everything one final time. Prepare demo environment. Create backup of system. Conduct final quality check.

**Day before handoff.** Verify system is running perfectly. Check all integrations. Prepare demo script. Ensure devices are charged and internet is reliable. Have backup plans ready for technical issues.

### Handoff Meeting

**Meeting structure.** Celebrate for 5 minutes acknowledging project completion and reviewing accomplishments. Overview for 10 minutes reminding them of the original problem and showing what you built. Live Demo for 20 minutes walking through entire workflow including normal operations, error scenarios, and monitoring. Hands-On Training for 30 minutes where the client logs in, performs tasks, and practices troubleshooting. Documentation Review for 10 minutes showing where everything is and how to find answers. Support and Next Steps for 10 minutes reviewing support plan, exchanging contact info, and signing acceptance form.

Total meeting time is approximately 85 minutes.

### Post-Handoff Actions

**Immediately after meeting.** Send meeting notes summarizing what was covered. Share recording if the session was recorded. Send all materials mentioned during meeting. Confirm they have access to everything.

**Within first week.** Check in asking "how is it going?" Answer any initial questions. Fix any issues discovered in real-world use.

**Ongoing during support period.** Monitor error logs if accessible. Respond to support requests promptly. Track usage if visible.

## Common Handoff Mistakes

**Mistake 1: Assuming They Know.** What is obvious to you is not obvious to them. Explain everything. Assume zero knowledge.

**Mistake 2: Rushing the Handoff.** A quick "here are the docs, bye" leaves clients anxious. Take time. Make them comfortable and confident.

**Mistake 3: No Training.** "Just read the docs" does not work. Documentation is reference material. Training is essential for understanding.

**Mistake 4: Incomplete Documentation.** Missing troubleshooting, credentials, or contact info creates problems. Use documentation checklist from Section 7.4.

**Mistake 5: No Support Plan.** Vague "contact me if issues come up" leaves expectations unclear. Define support period, scope, and process explicitly.

**Mistake 6: Not Testing Before Demo.** Demo failing during handoff meeting destroys confidence. Test everything before the meeting.

**Mistake 7: No Acceptance Sign-Off.** Verbal "looks good" provides no protection. Get written acceptance.

## Post-Launch Support

### Support Request Process

When a client reports an issue, follow a structured process.

**Step 1: Acknowledge quickly, within 2 hours.** Thank them for reaching out. Tell them you will investigate and get back to them within a specific timeframe. Ask clarifying questions: what they were trying to do, what happened instead, any error messages, when it started happening.

**Step 2: Investigate thoroughly.** Check error logs. Test the scenario yourself. Identify root cause. Document what you find.

**Step 3: Communicate findings.** Explain what happened in simple terms. Describe what you did to fix it or what options exist. Provide timeline for resolution.

**Step 4: Resolve and confirm.** Implement the fix. Test to verify. Ask client to confirm the issue is resolved. Document the issue and solution for future reference.

### Distinguishing Bugs from Features

**Bug (covered by support).** Something that worked before and now does not. Something that does not work as documented. Error that prevents normal operation.

**Feature request (separate scope).** New functionality not in original scope. Enhancement to existing capability. Integration with new system.

When you receive a feature request during support period: acknowledge the idea, explain it is outside support scope, offer to discuss as separate project, document the request for future reference.

## Retrospective

After every project, conduct a retrospective to improve your practice.

### Retrospective Questions

**What went well?** What aspects of the project were successful? What would you repeat?

**What did not go well?** What caused problems or frustration? What would you avoid?

**What would you do differently?** With hindsight, what would you change? What will you change for next project?

**What did you learn?** New skills, tools, or knowledge gained. Insights about clients, process, or yourself.

### Retrospective Format

Set aside 30 minutes after project completion. Write answers to each question. Identify 2-3 specific changes for next project. Save retrospective notes for future reference.

### Common Retrospective Insights

**Scoping.** Needed more detail in scope document. Should have asked more discovery questions. Exclusions were not explicit enough.

**Estimation.** Underestimated testing time. Did not account for client availability. Buffer was appropriate or too small.

**Communication.** Weekly updates worked well or were not frequent enough. Should have communicated issue earlier. Client appreciated specific communication style.

**Technical.** New tool took longer than expected. Integration approach worked well. Error handling saved time during testing.

Use retrospectives to continuously improve your practice.

## Module 7 Recap

This module covered project management for operators: the non-technical skills that determine project success.

**Section 7.1: Scoping and Requirements Gathering.** This is how projects succeed or fail before they start. Define clear boundaries, gather complete requirements, and document everything.

**Section 7.2: Estimating Time and Effort.** This is how operators set expectations they can meet. Use historical data, add buffers, and present ranges honestly.

**Section 7.3: Managing Stakeholders and Expectations.** This is how operators build relationships that last. Understand who matters, communicate proactively, and handle difficult conversations well.

**Section 7.4: Effective Communication and Documentation.** This is how operators ensure their work outlasts the project. Write for your future self, document as you go, and match format to audience.

**Section 7.5: Project Delivery and Handoff.** This is how operators turn one-time clients into long-term relationships. Deliver completely, train thoroughly, and support professionally.

The professional mindset: Technical skills get you started, but project management skills keep you hired. Every project is an opportunity to demonstrate professionalism and build lasting relationships.

## Operator Principles

**Complete handoff before final invoice.** Documentation, training, credentials, acceptance sign-off. Do not consider a project done until the client can operate independently.

**Train, do not just document.** Documentation is reference material. Training builds understanding and confidence. Both are required.

**Define support boundaries clearly.** Scope, duration, response time, what is included, what is not. Clear boundaries prevent scope creep and set expectations.

**Conduct retrospectives after every project.** What worked, what did not, what you will change. Continuous improvement compounds over time.',

exercise_markdown = '## Exercise: Complete Project Handoff

**Objective:** Practice creating all components of a professional project handoff.

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

Customized pre-handoff checklist. Complete training agenda. Project acceptance document. Detailed support plan. Project retrospective.

### Success Criteria

Checklist covers all handoff components. Training agenda is practical and complete. Acceptance document is professional and signable. Support plan has clear boundaries. Retrospective identifies specific improvements.',

exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Handoff Checklist",
      "description": "Create a customized pre-handoff checklist.",
      "fields": [
        {
          "id": "two_weeks_before",
          "type": "textarea",
          "label": "2 weeks before handoff:",
          "placeholder": "☐ All onboarding automation steps working correctly\n☐ Error handling tested with simulated failures\n☐ Technical documentation completed\n☐ User guide completed\n☐ Training materials prepared (agenda, demo script)\n☐ Handoff meeting scheduled with client\n☐ All credentials organized in secure location\n☐ Monitoring dashboard configured\n☐ Acceptance form prepared with deliverables listed",
          "required": true,
          "rows": 12
        },
        {
          "id": "one_week_before",
          "type": "textarea",
          "label": "1 week before handoff:",
          "placeholder": "☐ Documentation sent to client for review\n☐ Training agenda sent to client\n☐ Handoff meeting confirmed (date, time, attendees)\n☐ Full end-to-end test completed\n☐ Demo environment prepared with test data\n☐ Backup of entire automation created\n☐ Final quality review completed\n☐ Any client questions from doc review answered",
          "required": true,
          "rows": 10
        },
        {
          "id": "day_before",
          "type": "textarea",
          "label": "Day before handoff:",
          "placeholder": "☐ Automation running successfully (check logs)\n☐ All integrations verified (Stripe, CRM, Drive, Slack)\n☐ Demo script reviewed and practiced\n☐ Screen share and recording tools tested\n☐ Backup plan ready (what if demo fails)\n☐ All materials ready to share during meeting\n☐ Calendar blocked for handoff meeting",
          "required": true,
          "rows": 10
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
          "label": "Complete training agenda with timing:",
          "placeholder": "# Customer Onboarding Automation Training\nDuration: 90 minutes\nAttendees: [Names]\n\n## Part 1: Overview (10 min)\n- Welcome and goals for today\n- Recap of original problem (manual onboarding taking 20 min per customer)\n- What we built (end-to-end automated onboarding)\n- Key benefits (time savings, consistency, error reduction)\n\n## Part 2: Live Demo (25 min)\n- Complete walkthrough of automated flow\n  - Trigger a test payment in Stripe\n  - Watch automation process in real-time\n  - Show CRM record creation\n  - Show welcome email received\n  - Show Drive folder created\n  - Show Slack notification\n- Show error handling\n  - What happens if CRM fails\n  - Where errors appear\n  - How to find and retry failed items\n\n## Part 3: Hands-On Practice (25 min)\n- Client triggers test payment\n- Client views automation logs\n- Client finds customer record in CRM\n- Client checks error queue\n- Client practices manual retry\n\n## Part 4: Daily Operations (10 min)\n- What to check daily (2-minute routine)\n- Where to find automation status\n- Interpreting success metrics\n- What is normal vs concerning\n\n## Part 5: Troubleshooting (10 min)\n- Most common issues and fixes\n- Using the troubleshooting guide\n- When to contact support\n\n## Part 6: Support and Next Steps (5 min)\n- 30-day support period details\n- How to contact for help\n- Sign acceptance form\n\n## Q&A (5 min)\n- Open questions",
          "required": true,
          "rows": 45
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
          "placeholder": "# Project Acceptance\n\nProject: Customer Onboarding Automation\nClient: [Company Name]\nOperator: [Your Name]\nDate: [Date]\n\n## Deliverables Completed\n\n☑ Stripe webhook integration for payment triggers\n☑ CRM record creation automation\n☑ Credential generation system\n☑ Automated welcome email with credentials\n☑ Google Drive folder creation automation\n☑ Slack workspace invitation automation\n☑ Team notification in Slack\n☑ Error handling with retry and alerting\n☑ Technical documentation\n☑ User guide\n☑ Training session completed\n\n## Success Criteria Met\n\n☑ Processing time under 60 seconds (achieved: ~45 seconds)\n☑ Success rate above 99% (achieved: 99.5% in testing)\n☑ Zero manual intervention for standard onboarding\n☑ Team notified for all new customers\n☑ Errors captured and visible for review\n\n## Training Provided\n\n☑ Live training session on [date]\n☑ Training recording shared\n☑ User guide provided\n☑ Troubleshooting guide provided\n\n## Access Confirmed\n\n☑ Client has Zapier account access\n☑ All credentials shared securely\n☑ Client confirmed working access\n\n---\n\n## Acceptance\n\nBy signing below, the client acknowledges:\n- All deliverables listed above have been completed\n- The system meets the agreed-upon requirements\n- Training has been provided and is sufficient\n- Documentation enables ongoing operation\n- The project is accepted as complete\n\nClient Signature: _________________________\nPrint Name: _________________________\nDate: _________________________\n\nOperator Signature: _________________________\nPrint Name: _________________________\nDate: _________________________",
          "required": true,
          "rows": 50
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
          "label": "Complete support plan:",
          "placeholder": "# Post-Launch Support Plan\n\nProject: Customer Onboarding Automation\nSupport Period: 30 days from acceptance date\n\n## Included in Support Period\n\n✓ Unlimited questions via email\n✓ Bug fixes at no additional charge\n✓ One round of minor adjustments (wording changes, notification timing, etc.)\n✓ Response time: Within 24 hours on weekdays\n✓ Urgent issues (automation completely down): Same-day response\n\n## Not Included\n\n✗ New features (e.g., adding billing reminders, new integrations)\n✗ Integration with additional tools\n✗ Major scope changes\n✗ Training for new team members (after initial training)\n✗ Support for systems not part of this project\n\n## How to Request Support\n\n1. Email: [your email]\n2. Subject line: \"Onboarding Automation Support - [brief description]\"\n3. Include in your email:\n   - What you were trying to do\n   - What happened (expected vs actual)\n   - Screenshots or error messages if applicable\n   - When it started happening\n4. Response time: Within 24 hours on weekdays\n\n## What Constitutes a Bug vs Feature\n\nBug (covered):\n- Something that worked before and stopped working\n- Something not working as documented\n- Error preventing normal operation\n\nFeature (separate project):\n- New capability not in original scope\n- Enhancement to existing functionality\n- Integration with new system\n\n## After Support Period Ends\n\nOption 1: No ongoing support\n- Use documentation for self-service\n- Contact for new projects as needed\n\nOption 2: Retainer support agreement\n- Monthly retainer of $[X]\n- Includes [Y] hours of support\n- Priority response time\n- Quarterly system review\n\nWe can discuss the right option for you as the support period ends.\n\n## Emergency Contact\n\nFor critical issues (automation completely down affecting customers):\n- Email with \"URGENT\" in subject line\n- [Phone/Slack for true emergencies]\n- Same-day response guaranteed",
          "required": true,
          "rows": 50
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
          "placeholder": "1. Scoping process was thorough - clear deliverables and exclusions prevented scope creep\n2. Weekly updates kept client informed and built trust\n3. Testing caught several edge cases before launch\n4. Documentation-as-you-go approach made handoff smoother\n5. Three-point estimation for risky tasks proved accurate\n6. Client was responsive to requests for access and feedback",
          "required": true,
          "rows": 8
        },
        {
          "id": "what_didnt_go_well",
          "type": "textarea",
          "label": "What did not go well?",
          "placeholder": "1. CRM integration took 50% longer than estimated - API documentation was poor\n2. Initial training agenda was too ambitious - had to cut Q&A short\n3. Did not test with high volume - discovered queuing issue after launch\n4. Credential handoff was clunky - no clear password manager process",
          "required": true,
          "rows": 8
        },
        {
          "id": "what_would_change",
          "type": "textarea",
          "label": "What would you do differently next time?",
          "placeholder": "1. Add 50% buffer for any new API integration, not just 25%\n2. Limit training agenda to 75 minutes max with built-in buffer\n3. Always test with 10x expected volume before launch\n4. Create standardized credential handoff checklist for all projects\n5. Ask about client password manager preferences during scoping",
          "required": true,
          "rows": 8
        },
        {
          "id": "lessons_learned",
          "type": "textarea",
          "label": "Key lessons learned:",
          "placeholder": "1. Poor third-party documentation is a major risk factor - add buffer and flag early\n2. Training is better shorter and repeated than long and comprehensive\n3. Volume testing matters even for low-volume automations\n4. Security handoff deserves its own checklist\n5. Client responsiveness is a leading indicator of project success",
          "required": true,
          "rows": 8
        }
      ]
    }
  ],
  "deliverables": [
    "Customized pre-handoff checklist",
    "Complete training agenda",
    "Professional acceptance document",
    "Detailed support plan",
    "Project retrospective"
  ],
  "success_criteria": [
    "Checklist covers all handoff components",
    "Training agenda is practical and complete",
    "Acceptance document is professional",
    "Support plan has clear boundaries",
    "Retrospective identifies specific improvements"
  ]
}'

WHERE slug = 'delivery-handoff';
