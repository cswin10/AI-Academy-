-- ============================================================================
-- UPDATE SECTION 7.1: Scoping & Requirements Gathering
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, remove any existing questions 5-8 to allow clean re-runs, then add 4 more to reach 8 total
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Scoping and Planning Quiz')
AND order_index IN (5, 6, 7, 8);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Scoping and Planning Quiz'), 5,
'How does the I-T-O framework apply to requirements gathering?',
'["I-T-O only applies to automation building", "Input is client information and constraints, Task is the scoping process, Output is the scope document and project definition", "Requirements gathering does not follow I-T-O", "Only use I-T-O for technical work"]',
1,
'Scoping itself follows I-T-O: you take client information as input, process it through discovery and analysis, and produce a clear scope document as output.'),

((SELECT id FROM quizzes WHERE title = 'Scoping and Planning Quiz'), 6,
'What is the MoSCoW prioritization method?',
'["A Russian project management technique", "A method to categorize requirements into Must Have, Should Have, Could Have, and Won''t Have to focus effort on critical features first", "A way to organize Moscow-based clients", "An advanced estimation technique"]',
1,
'MoSCoW helps you and the client agree on priorities. Must Haves are critical for success, Should Haves are important but not essential, Could Haves are nice additions, and Won''t Haves are explicitly excluded.'),

((SELECT id FROM quizzes WHERE title = 'Scoping and Planning Quiz'), 7,
'What is the purpose of explicitly listing exclusions in a scope document?',
'["To pad the document", "To prevent assumptions about what is included, avoiding scope creep and misaligned expectations", "Exclusions are not necessary", "Only list exclusions for large projects"]',
1,
'If you do not explicitly exclude something, clients often assume it is included. Listing exclusions prevents the common problem of hearing I thought you were also building that after the project starts.'),

((SELECT id FROM quizzes WHERE title = 'Scoping and Planning Quiz'), 8,
'When should you walk away from a project during scoping?',
'["Never walk away from paying clients", "When requirements are fundamentally unclear, client is unresponsive, constraints make success impossible, or red flags indicate problems", "Only if the budget is too low", "Walking away is unprofessional"]',
1,
'Some projects cannot succeed. Red flags during scoping include unclear objectives, unrealistic timelines, unresponsive stakeholders, or technical constraints that make the project unfeasible. Walking away early saves everyone time and money.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Scoping & Requirements Gathering

**This is how projects succeed or fail before they start.**

The foundation of every successful project is knowing exactly what you are building and why. Poor scoping causes more project failures than any technical challenge. This section teaches you to define clear boundaries, gather complete requirements, and set expectations that protect both you and your client.

## Definitions

**Scope**: The boundaries of a project, defining what is included and what is excluded. A clear scope prevents confusion about deliverables.

**Requirements**: Specific, measurable statements of what the solution must do. Good requirements are testable and unambiguous.

**Scope Creep**: The gradual, uncontrolled expansion of project requirements after work has begun. Scope creep destroys timelines and budgets.

**Stakeholder**: Anyone affected by or interested in the project. Stakeholders include decision makers, end users, and technical teams.

**Deliverable**: A concrete output that you provide to the client. Deliverables are tangible and verifiable.

**Success Criteria**: Measurable conditions that define when the project is complete and successful. Success criteria remove ambiguity about done.

**Change Request**: A formal process for modifying agreed scope. Change requests protect both parties by documenting modifications.

**MoSCoW**: A prioritization method categorizing requirements as Must Have, Should Have, Could Have, or Won''t Have.

## Why Scoping Matters

Every failed project started with poor scoping.

**Without proper scoping** you build the wrong thing because you did not understand the real problem. You face endless "just one more thing" requests that never stop. Timelines extend indefinitely as new requirements appear. Budgets explode because the work keeps growing. The client becomes unhappy and you become exhausted.

**With proper scoping** you have clear boundaries that everyone understands. You have shared expectations documented in writing. Timelines are predictable because the work is defined. Budgets are protected because changes require formal approval. The client is satisfied and the work is sustainable.

## The Scoping Process

### Step 1: Understand the Problem

Do not jump to solutions. Understand the problem first.

Ask questions about the problem itself. What problem are you trying to solve? Why is this a problem? What happens if you do not solve it? Who is affected? What have you tried already?

**Bad conversation approach.** Client says they need a Zapier automation. You immediately ask what it should do. This skips problem understanding.

**Good conversation approach.** Client says they need a Zapier automation. You ask them to start with the problem and describe what is happening now that they want to change. Client explains they spend 10 hours a week manually copying data from emails to their CRM. You ask them to tell you more about this process.

Dig deeper into the details. What specific data is being copied? Which emails and from what sources? Which CRM system? What happens to the data after it is entered? Where do errors occur in the current process? On a scale of 1 to 10, how painful is this problem?

### Step 2: Define Success

Determine what done looks like before you start building.

Ask about success. How will you know this project succeeded? What measurable outcomes matter most? What would make you thrilled with the result? What would constitute a complete failure?

Document success criteria with specificity.

**Vague success criteria (bad)**: Faster lead intake.

**Specific success criteria (good)**: Lead response time under 5 minutes, reduced from current 2 hours. Zero manual data entry, reduced from current 20 entries per day. 100% of leads captured in CRM, improved from current 80%. Team spends less than 1 hour per day on leads, reduced from current 4 hours.

Measurable success criteria equal clear project goals.

### Step 3: Map the Current Process

Document how things work now to establish your baseline.

Create a current-state description. Step 1, lead fills out form on website. Step 2, form email sent to sales@company.com. Step 3, sales person checks email manually and sporadically. Step 4, sales person copies name, email, company, and message. Step 5, sales person pastes information into CRM. Step 6, sales person sends response email manually. Step 7, sales person notifies team in Slack manually.

Document the current metrics. Time per lead is 15 minutes. Errors are frequent, including typos, missed leads, and forgotten notifications. Volume is 20 leads per day. Total time is 5 hours per day.

This becomes your baseline for measuring improvement.

### Step 4: Design the Future Process

Describe how things will work after your solution is implemented.

Create a future-state description. Step 1, lead fills out form on website. Step 2, automation triggers instantly. Step 3, automation creates CRM record automatically. Step 4, automation sends response email automatically. Step 5, automation notifies team in Slack automatically.

Document the future metrics. Time per lead is 30 seconds. Errors are minimal because validation prevents bad data. Volume remains 20 leads per day. Total time is 10 minutes per day. Time saved is 4 hours and 50 minutes per day.

This becomes your scope definition.

### Step 5: Define What Is Included

Explicitly state what you are building.

Example inclusions list. Form submission trigger. Data validation for email and required fields. CRM record creation in Airtable. Automated response email using template provided by client. Slack notification to the sales channel. Error logging. Testing with sample data. Handoff documentation.

Be specific. List every feature, integration, and deliverable.

### Step 6: Define What Is Excluded

Equally important is stating what you are not building.

Example exclusions list. Redesigning the form itself. Setting up the CRM database, which must already exist. Creating email templates, which the client provides. Training the sales team on CRM usage. Integration with other systems such as marketing automation. Custom reporting. Mobile application. Anything not explicitly listed in the inclusions.

Why exclusions matter. When the client asks if you can also add a feature, you respond that it is out of scope and offer to discuss it as a separate project. No scope creep.

### Step 7: Identify Constraints

Document what limitations exist before starting work.

**Technical constraints**: Must use existing CRM without switching. Must integrate with current email system. Cannot store data in certain locations due to compliance. Must use no-code tools without custom development.

**Budget constraints**: Maximum budget of $5,000. Maximum ongoing tool costs of $100 per month.

**Timeline constraints**: Must launch by end of quarter. Critical for upcoming marketing campaign.

**Resource constraints**: Only you working on this project. Client has 5 hours available for meetings and testing.

Document all constraints upfront.

### Step 8: Prioritize Requirements

Not everything is equally important. Use MoSCoW method to categorize.

**Must Have (Critical)**: Form trigger, CRM creation, response email. Without these, the project fails.

**Should Have (Important)**: Slack notification, error logging. Very valuable but not critical for launch.

**Could Have (Nice to have)**: Lead scoring, manager dashboard. Add if time and budget allow.

**Won''t Have (Out of scope)**: Mobile app, custom reporting. Explicitly excluded, potentially for a future phase.

Focus on Must Haves first. Everything else is secondary until those are complete.

## The Scope Document

A scope document is your single source of truth for the project.

**Section 1: Project Overview.** Client name, project name, date, version number.

**Section 2: Problem Statement.** Description of current situation and pain points. Currently the team spends 5 hours per day manually processing leads, resulting in slow response times and frequent errors.

**Section 3: Objectives.** What you are trying to achieve. Reduce lead response time from 2 hours to under 5 minutes. Eliminate manual data entry. Ensure 100% of leads are captured.

**Section 4: Current State.** Diagram or description of current process with metrics.

**Section 5: Proposed Solution.** High-level description of what you will build.

**Section 6: Deliverables.** Explicit list of what you will deliver. Zapier workflow from form to CRM to email to Slack. Data validation rules. Email response template based on client draft. Error handling and logging. Testing and verification. Documentation for team. One hour training session.

**Section 7: Out of Scope.** Explicit list of what you will not deliver. Form redesign. CRM setup or configuration. Email template creation. Integrations beyond those listed. Ongoing maintenance, which requires a separate agreement.

**Section 8: Technical Requirements.** Platforms involved, access required, technical dependencies.

**Section 9: Assumptions.** What you are assuming to be true. Client provides email template. Airtable base structure already exists. Client available for weekly check-ins. All required tool access provided within 1 week.

**Section 10: Success Criteria.** How you will know the project succeeded. 100% of form submissions create CRM records. Response email sent within 30 seconds. Team notified in Slack for all leads. Zero manual data entry required. Error rate below 1%. Client signs off on acceptance testing.

**Section 11: Timeline.** Estimated duration with milestones.

**Section 12: Budget.** Total cost and breakdown.

**Section 13: Risks and Mitigations.** What could go wrong and how you will address it.

**Section 14: Sign-off.** Space for both parties to approve the scope. Any changes require written approval and may affect timeline and budget.

## Requirements Gathering Techniques

### Technique 1: Stakeholder Interviews

Talk to everyone affected by the project.

**Questions for end users.** Walk me through your current process. What frustrates you most? What takes the most time? What errors happen frequently? What would make your life easier?

**Questions for decision makers.** What business problem does this solve? What is the expected ROI? What happens if we do not do this? What is your budget? What is your timeline?

### Technique 2: Process Observation

Watch people work instead of just asking how they work.

Do not just ask how they do it. Watch them do it. You will discover workarounds they forgot to mention. Steps they skip. Errors they make. Time they actually spend. Reality does not match what people say they do.

### Technique 3: Document Review

Examine existing materials.

Look at current forms, email templates, database schemas, existing automations if any, and reports they need. This reveals actual data fields, real formatting requirements, and hidden requirements.

### Technique 4: Use Case Scenarios

Walk through specific examples with the client.

Ask them to show you the last 3 leads they processed and walk through each one. Edge cases emerge: international phone numbers, company names with special characters, leads with multiple contacts, urgent versus normal leads. Cover both normal cases and edge cases.

## Handling Scope Changes

Scope will try to expand. Always. Be prepared with a process.

### Change Request Process

When the client asks to add something, follow this process.

**Acknowledge**: Thank them and say you will evaluate the idea.

**Assess**: Is it in the current scope? Usually no. How much work would it add? Does it affect timeline or budget?

**Offer options**: Add it to scope with new timeline and budget. Defer it to Phase 2 after core functionality launches. Decline if it does not fit project goals.

**Document**: If approved, update the scope document. All parties sign off on the change.

**Template response**: That is a great feature idea. It is outside our current scope, but I would be happy to add it. It would add X hours of work and $Y to the budget, pushing our timeline by Z weeks. Alternatively, we could plan it for Phase 2 after we launch the core functionality. What would you prefer?

### Saying No Effectively

**When to say no.** Feature does not align with objectives. Technically not feasible. Budget or timeline cannot accommodate. Would compromise quality of core features. Outside your expertise.

**How to say no well.** Never say that is stupid. Instead say you understand why that is appealing, but adding it would require a specific reason. Then recommend an alternative that achieves a similar goal within the constraints. Give them choices, not dead ends.

## Common Scoping Mistakes

**Mistake 1: Assuming You Understand.** Do not assume anything. When they say customer data, ask what specific fields they mean. Verify everything.

**Mistake 2: Accepting Vague Requirements.** Bad: make it faster. Good: reduce processing time from 2 hours to under 5 minutes. Get specific.

**Mistake 3: No Written Scope.** Verbal agreements lead to disaster. You hear "I thought you meant" and "I never said that" constantly. Always document. Always get sign-off.

**Mistake 4: Ignoring Constraints.** Client says budget is $1,000. You scope a $5,000 project. Understand constraints first.

**Mistake 5: Technical Jargon.** Do not say you will implement a RESTful API with OAuth2 authentication. Say you will connect their form to their database securely. Speak their language.

**Mistake 6: No Exclusions.** If you do not explicitly exclude it, clients assume it is included. "I thought you were also building..." List exclusions.

**Mistake 7: Confusing Scope with Proposal.** Scope document defines what you are building and is shared with the client. Proposal defines how much it costs and is your business document. Different documents, different purposes.

## Scoping Checklist

Before starting any project, verify you have completed these items.

Understand the problem deeply. Define measurable success criteria. Document current process with metrics. Design future process with expected metrics. List all inclusions explicitly. List all exclusions explicitly. Identify all constraints. Prioritize requirements using MoSCoW. Create detailed scope document. Review with all stakeholders. Get written sign-off. Define change request process.

If you cannot check all boxes, do not start building.

## Operator Principles

**Never start building without a written scope.** Verbal agreements cause disputes. Written scope documents protect both parties and enable successful project completion.

**Explicitly list exclusions.** Anything not excluded is assumed included. Prevent scope creep by stating what you will not build.

**Define success before starting.** Measurable success criteria remove ambiguity about what done means. Without them, projects never end.

**Use change requests for all modifications.** Scope changes happen. A formal process ensures changes are evaluated, approved, and documented rather than quietly expanding the project.',

exercise_markdown = '## Exercise: Scope a Real Project

**Objective:** Practice comprehensive project scoping using a realistic scenario.

### Part 1: Problem Discovery

**Scenario:** You are talking to a potential client.

**Client says:** "We need help automating our customer onboarding. It is a mess right now."

Write 15-20 discovery questions you would ask. Cover questions about the problem, current process, desired outcome, and constraints.

### Part 2: Document Current State

**Based on this client description:**

"Right now when someone buys, we get a Stripe email. Someone on our team, usually me, copies their info into our CRM, then manually sends a welcome email with login credentials, then creates a folder in Google Drive for their files, then adds them to our Slack workspace, and notifies the team. It takes about 20 minutes per customer and we get 5-10 new customers a day. Sometimes we forget steps or make typos. Last week we forgot to send welcome emails to 3 customers."

Create current-state documentation including a process map, pain points, and metrics.

### Part 3: Define Success Criteria

For this project, write specific, measurable success criteria for process metrics, business metrics, and technical metrics. Describe how you will measure each one.

### Part 4: Design Future State

Design the automated process. Create a future-state process map showing the trigger, each automated step, and expected metrics.

### Part 5: Create Scope Document

Write a complete scope document including problem statement, objectives, deliverables with specific items, exclusions with specific items, technical requirements, assumptions, success criteria, and risks with mitigations.

### Part 6: Handle Scope Change

The client says: "Can you also set up automated billing reminders?"

Write your response including how you would assess the request, what options you would offer, and how you would document the decision.

### Part 7: Risk Assessment

Create a risk register with at least 5 risks. For each risk, document the description, likelihood, impact, and mitigation strategy.

### Deliverables

Completed discovery questions list. Current-state documentation with process and metrics. Specific, measurable success criteria. Future-state process design. Complete scope document. Scope change response with options. Risk register with mitigations.

### Success Criteria

Comprehensive scope document created. Problem deeply understood with evidence from documentation. Clear inclusions and exclusions listed. Measurable success criteria defined. Risks identified with practical mitigations. Change process demonstrated. Ready to present to a real client.',

exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Problem Discovery",
      "description": "Write discovery questions for the customer onboarding scenario.",
      "fields": [
        {
          "id": "problem_questions",
          "type": "textarea",
          "label": "Questions about the problem (5+ questions):",
          "placeholder": "1. What specific issues are you experiencing with onboarding?\n2. How long has this been a problem?\n3. What triggered the need to fix it now?\n4. Who is most affected by the current process?\n5. What have you tried before?",
          "required": true,
          "rows": 8
        },
        {
          "id": "process_questions",
          "type": "textarea",
          "label": "Questions about current process (5+ questions):",
          "placeholder": "1. Walk me through exactly what happens when a new customer signs up.\n2. Which systems are involved?\n3. Who performs each step?\n4. How long does each step take?\n5. Where do errors typically occur?",
          "required": true,
          "rows": 8
        },
        {
          "id": "outcome_questions",
          "type": "textarea",
          "label": "Questions about desired outcome (3+ questions):",
          "placeholder": "1. What would the ideal onboarding experience look like?\n2. How will you measure if the new process is successful?\n3. What is the most important improvement?",
          "required": true,
          "rows": 5
        },
        {
          "id": "constraint_questions",
          "type": "textarea",
          "label": "Questions about constraints (3+ questions):",
          "placeholder": "1. What is your budget for this project?\n2. What is your timeline for implementation?\n3. Are there tools you must use or cannot change?",
          "required": true,
          "rows": 5
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Document Current State",
      "description": "Document the current onboarding process based on client description.",
      "fields": [
        {
          "id": "process_map",
          "type": "textarea",
          "label": "Current process map (step by step):",
          "placeholder": "Step 1: Stripe payment received, email notification sent\nStep 2: Team member sees email (timing varies)\nStep 3: Copy customer info to CRM (manual)\nStep 4: Send welcome email with credentials (manual)\nStep 5: Create Google Drive folder (manual)\nStep 6: Add to Slack workspace (manual)\nStep 7: Notify team (manual)",
          "required": true,
          "rows": 10
        },
        {
          "id": "pain_points",
          "type": "textarea",
          "label": "Pain points identified:",
          "placeholder": "1. Takes 20 minutes per customer\n2. Errors occur (typos, missed steps)\n3. Customers sometimes wait hours for welcome email\n4. Steps get forgotten (3 missed last week)\n5. Process depends on one person being available",
          "required": true,
          "rows": 6
        },
        {
          "id": "current_metrics",
          "type": "textarea",
          "label": "Current metrics:",
          "placeholder": "Time per customer: 20 minutes\nDaily volume: 5-10 customers\nTotal daily time: 100-200 minutes\nError rate: Estimated 10-15%\nMissed steps: 3 in one week",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Define Success Criteria",
      "description": "Write specific, measurable success criteria.",
      "fields": [
        {
          "id": "process_metrics",
          "type": "textarea",
          "label": "Process metrics (before and after):",
          "placeholder": "Time per customer: From 20 minutes to under 1 minute\nManual steps: From 7 to 0\nError rate: From 10-15% to under 1%\nTime to first welcome email: From hours to under 1 minute",
          "required": true,
          "rows": 6
        },
        {
          "id": "business_metrics",
          "type": "textarea",
          "label": "Business metrics:",
          "placeholder": "Customer satisfaction: Faster onboarding improves first impression\nTeam time saved: 2-3 hours per day\nCapacity increase: Can handle 10x volume without adding staff",
          "required": true,
          "rows": 5
        },
        {
          "id": "technical_metrics",
          "type": "textarea",
          "label": "Technical metrics:",
          "placeholder": "Success rate: 99%+ of onboardings complete automatically\nProcessing time: Under 60 seconds end-to-end\nUptime: 99.9%",
          "required": true,
          "rows": 4
        },
        {
          "id": "measurement_methods",
          "type": "textarea",
          "label": "How will you measure each metric?",
          "placeholder": "Processing time: Timestamp logs in automation platform\nSuccess rate: Count completed vs triggered runs\nError rate: Count items in error queue\nTeam time: Before/after time tracking for 1 week",
          "required": true,
          "rows": 5
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Design Future State",
      "description": "Design the automated onboarding process.",
      "fields": [
        {
          "id": "future_process",
          "type": "textarea",
          "label": "Future-state process map:",
          "placeholder": "Trigger: Stripe payment webhook\nStep 1: Validate customer data (automatic)\nStep 2: Create CRM record (automatic)\nStep 3: Generate login credentials (automatic)\nStep 4: Send welcome email with credentials (automatic)\nStep 5: Create Google Drive folder (automatic)\nStep 6: Add to Slack workspace (automatic)\nStep 7: Notify team in Slack (automatic)\n\nHuman involvement: Zero for standard onboarding",
          "required": true,
          "rows": 12
        },
        {
          "id": "future_metrics",
          "type": "textarea",
          "label": "Expected future metrics:",
          "placeholder": "Time per customer: 30 seconds\nDaily volume capacity: 100+ customers\nError rate: Under 1%\nTeam time: Review exceptions only\nCustomer wait time: Under 1 minute",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Create Scope Document",
      "description": "Write a complete scope document.",
      "fields": [
        {
          "id": "scope_overview",
          "type": "textarea",
          "label": "Problem statement and objectives:",
          "placeholder": "Problem Statement:\nCurrently the team spends 2-3 hours daily on manual customer onboarding, resulting in delayed welcome emails and occasional missed steps.\n\nObjectives:\n1. Reduce onboarding time from 20 minutes to under 1 minute\n2. Eliminate manual data entry\n3. Ensure 100% of onboarding steps complete automatically",
          "required": true,
          "rows": 10
        },
        {
          "id": "deliverables",
          "type": "textarea",
          "label": "Deliverables (specific items):",
          "placeholder": "1. Stripe webhook integration for payment triggers\n2. CRM record creation automation\n3. Credential generation system\n4. Automated welcome email sequence\n5. Google Drive folder creation automation\n6. Slack workspace invitation automation\n7. Team notification automation\n8. Error handling and logging\n9. Testing with sample customers\n10. Documentation and training",
          "required": true,
          "rows": 12
        },
        {
          "id": "exclusions",
          "type": "textarea",
          "label": "Exclusions (specific items):",
          "placeholder": "1. Stripe account setup or configuration\n2. CRM system selection or setup\n3. Email template design (client provides copy)\n4. Google Workspace administration\n5. Slack workspace setup\n6. Custom reporting or dashboards\n7. Ongoing maintenance (separate agreement)\n8. Integration with other payment processors",
          "required": true,
          "rows": 10
        },
        {
          "id": "technical_assumptions",
          "type": "textarea",
          "label": "Technical requirements and assumptions:",
          "placeholder": "Requirements:\n- Stripe account with webhook access\n- CRM with API access\n- Google Workspace with admin access\n- Slack workspace with admin access\n\nAssumptions:\n- Client provides email template copy\n- All tool access provided within 1 week\n- Client available for weekly check-ins",
          "required": true,
          "rows": 10
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: Handle Scope Change",
      "description": "Respond to a scope change request.",
      "fields": [
        {
          "id": "change_assessment",
          "type": "textarea",
          "label": "Assessment of the billing reminders request:",
          "placeholder": "Assessment:\n- Is it in scope? No, this is a separate workflow\n- How much work? Approximately 4-6 additional hours\n- Affects timeline? Would add 3-5 days\n- Affects budget? Would add $X\n\nThe request requires new trigger logic, additional email templates, and testing of reminder sequences.",
          "required": true,
          "rows": 8
        },
        {
          "id": "change_response",
          "type": "textarea",
          "label": "Your response to the client:",
          "placeholder": "That is a great feature idea. It is outside our current scope for the onboarding automation, but I would be happy to add it.\n\nOption A: Add it now. This would add approximately 6 hours of work and $X to the budget, extending the timeline by about 4 days.\n\nOption B: Phase 2. We complete the onboarding automation first, then tackle billing reminders as a separate project. This lets us validate onboarding is working before adding more complexity.\n\nWhich would you prefer?",
          "required": true,
          "rows": 10
        }
      ]
    },
    {
      "id": "part7",
      "title": "Part 7: Risk Assessment",
      "description": "Create a risk register for the project.",
      "fields": [
        {
          "id": "risk_register",
          "type": "textarea",
          "label": "Risk register (5+ risks with mitigations):",
          "placeholder": "Risk 1: Stripe API changes\n- Likelihood: Low\n- Impact: High\n- Mitigation: Use webhooks (stable), monitor Stripe changelog\n\nRisk 2: Email deliverability issues\n- Likelihood: Medium\n- Impact: Medium\n- Mitigation: Test thoroughly, use authenticated sending, monitor bounces\n\nRisk 3: Client access delays\n- Likelihood: Medium\n- Impact: High\n- Mitigation: Request all access in week 1, have backup contact\n\nRisk 4: CRM data structure issues\n- Likelihood: Low\n- Impact: Medium\n- Mitigation: Review CRM schema before building, document requirements\n\nRisk 5: Volume spikes overwhelm automation\n- Likelihood: Low\n- Impact: Medium\n- Mitigation: Test with high volume, implement queuing if needed",
          "required": true,
          "rows": 20
        }
      ]
    }
  ],
  "deliverables": [
    "Discovery questions covering all areas",
    "Current-state documentation with metrics",
    "Specific, measurable success criteria",
    "Future-state process design",
    "Complete scope document",
    "Scope change response",
    "Risk register with mitigations"
  ],
  "success_criteria": [
    "Comprehensive scope document created",
    "Problem deeply understood",
    "Clear inclusions and exclusions",
    "Measurable success criteria defined",
    "Risks identified with mitigations",
    "Change process demonstrated"
  ]
}'

WHERE slug = 'scoping-requirements';
