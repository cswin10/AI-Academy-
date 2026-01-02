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
'["I-T-O only applies to automation building", "Input is client information and constraints, Task is the scoping process, Output is the scope document", "Requirements gathering does not follow I-T-O", "I-T-O is a budgeting framework"]',
1,
'Scoping follows I-T-O: client information goes in, discovery and analysis happen, a clear scope document comes out.'),

((SELECT id FROM quizzes WHERE title = 'Scoping and Planning Quiz'), 6,
'What is the MoSCoW prioritization method?',
'["A cold weather planning technique", "Categorizing requirements into Must Have, Should Have, Could Have, and Won''t Have", "A type of project timeline", "An estimation formula"]',
1,
'MoSCoW forces prioritization conversations. Must Haves are critical, Should Haves are important, Could Haves are nice, Won''t Haves are explicitly excluded.'),

((SELECT id FROM quizzes WHERE title = 'Scoping and Planning Quiz'), 7,
'What is the purpose of explicitly listing exclusions in a scope document?',
'["To pad the document length", "To prevent assumptions about what is included", "Exclusions are optional", "Only list exclusions for projects over 100 hours"]',
1,
'If you do not explicitly exclude something, clients assume it is included. Exclusions prevent scope creep.'),

((SELECT id FROM quizzes WHERE title = 'Scoping and Planning Quiz'), 8,
'When should you walk away from a project during scoping?',
'["Never walk away from paying clients", "When requirements are unclear, constraints make success impossible, or red flags appear", "Only when budget is under $500", "Walking away is always unprofessional"]',
1,
'Some projects cannot succeed. Walking away early saves everyone time and money.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Scoping & Requirements Gathering

The foundation of every successful project is knowing exactly what you are building and why. Poor scoping causes more project failures than any technical challenge.

## Definitions

**Scope**: The boundaries of a project, defining what is included and what is excluded.

**Requirements**: Specific, measurable statements of what the solution must do.

**Scope Creep**: The gradual, uncontrolled expansion of project requirements after work has begun.

**Stakeholder**: Anyone affected by or interested in the project.

**Deliverable**: A concrete output that you provide to the client.

**Success Criteria**: Measurable conditions that define when the project is complete and successful.

**Change Request**: A formal process for modifying agreed scope.

**MoSCoW**: A prioritization method categorizing requirements as Must Have, Should Have, Could Have, or Won''t Have.

## Why Scoping Matters

Every failed project started with poor scoping.

Poor scoping leads to building the wrong thing, endless change requests, exploding timelines, and exhausted operators. Good scoping creates clear boundaries, shared expectations, predictable work, and satisfied clients.

## The Scoping Process

### Step 1: Understand the Problem

Do not jump to solutions. Understand the problem first.

Ask questions about the problem itself. What problem are you trying to solve? Why is this a problem? What happens if you do not solve it? Who is affected? What have you tried already?

**Real-world example: Event ticketing.** An event promoter says they need help with ticket sales. Digging deeper reveals the actual problem: they spend 4 hours after each event manually reconciling ticket sales with door counts, finding discrepancies, and chasing refunds. The automation is not about selling tickets. It is about post-event reconciliation.

### Step 2: Define Success

Determine what done looks like before you start building.

**Vague success criteria (bad)**: Faster lead intake.

**Specific success criteria (good)**: Lead response time under 5 minutes, reduced from current 2 hours. Zero manual data entry. 100% of leads captured in CRM.

### Step 3: Map the Current Process

Document how things work now to establish your baseline.

Create a current-state description with each step, who does it, and how long it takes. Document current metrics: time per task, error rate, volume. This becomes your baseline for measuring improvement.

### Step 4: Design the Future Process

Describe how things will work after your solution is implemented. Create a future-state process map showing the trigger, each automated step, and expected metrics. This becomes your scope definition.

### Step 5: Define What Is Included

Explicitly state what you are building. List every feature, integration, and deliverable. Be specific.

### Step 6: Define What Is Excluded

Equally important is stating what you are not building.

When the client asks if you can also add a feature, you respond that it is out of scope and offer to discuss it as a separate project.

### Step 7: Identify Constraints

Document what limitations exist before starting work. Technical constraints, budget constraints, timeline constraints, and resource constraints should all be captured upfront.

### Step 8: Prioritize Requirements

Not everything is equally important. Use MoSCoW method to categorize.

**Must Have (Critical)**: Form trigger, CRM creation, response email. Without these, the project fails.

**Should Have (Important)**: Slack notification, error logging. Very valuable but not critical for launch.

**Could Have (Nice to have)**: Lead scoring, manager dashboard. Add if time and budget allow.

**Won''t Have (Out of scope)**: These are the tempting extras that feel small but add up. Custom email design. Analytics dashboard. Multi-language support. Backfilling historic data. Mobile app. Explicitly exclude them.

Focus on Must Haves first. Everything else is secondary until those are complete.

## The Scope Document

A scope document is your single source of truth for the project. Most projects only need sections 1 through 10. Sections 11 through 14 are for larger or more complex engagements.

**Required sections:**

**Section 1: Project Overview.** Client name, project name, date, version number.

**Section 2: Problem Statement.** Description of current situation and pain points.

**Section 3: Objectives.** What you are trying to achieve with measurable targets.

**Section 4: Current State.** Diagram or description of current process with metrics.

**Section 5: Proposed Solution.** High-level description of what you will build.

**Section 6: Deliverables.** Explicit list of what you will deliver.

**Section 7: Out of Scope.** Explicit list of what you will not deliver.

**Section 8: Technical Requirements.** Platforms involved, access required, technical dependencies.

**Section 9: Assumptions.** What you are assuming to be true.

**Section 10: Success Criteria.** How you will know the project succeeded.

**Optional sections for larger projects:**

**Section 11: Timeline.** Estimated duration with milestones.

**Section 12: Budget.** Total cost and breakdown.

**Section 13: Risks and Mitigations.** What could go wrong and how you will address it.

**Section 14: Sign-off.** Space for both parties to approve the scope.

## Requirements Gathering Techniques

**Stakeholder Interviews.** Talk to everyone affected by the project. Ask end users about frustrations and workarounds. Ask decision makers about business problems and expected ROI.

**Process Observation.** Watch people work instead of just asking how they work. You will discover workarounds, skipped steps, and errors they forgot to mention.

**Document Review.** Examine existing forms, email templates, database schemas, and reports. This reveals actual data fields and hidden requirements.

**Use Case Scenarios.** Walk through specific examples with the client. Edge cases emerge: international phone numbers, company names with special characters, urgent versus normal requests.

## Handling Scope Changes

Scope will try to expand. Always. Be prepared with a process.

**Acknowledge**: Thank them and say you will evaluate the idea.

**Assess**: Is it in the current scope? How much work would it add? Does it affect timeline or budget?

**Offer options**: Add it to scope with new timeline and budget. Defer it to Phase 2. Decline if it does not fit project goals.

**Document**: If approved, update the scope document. All parties sign off on the change.

### Saying No Effectively

**When to say no.** Feature does not align with objectives. Technically not feasible. Budget or timeline cannot accommodate. Would compromise quality of core features.

**How to say no well.** Never just reject. Explain why it creates a problem, then recommend an alternative that achieves a similar goal within the constraints. Give them choices, not dead ends.

**The trust rule.** People do not get upset when you say no. They get upset when you say yes and fail.

## Common Scoping Mistakes

**Assuming You Understand.** Do not assume anything. When they say customer data, ask what specific fields they mean.

**Accepting Vague Requirements.** Bad: make it faster. Good: reduce processing time from 2 hours to under 5 minutes.

**No Written Scope.** Verbal agreements lead to disputes.

**Ignoring Constraints.** Client says budget is $1,000. You scope a $5,000 project.

**No Exclusions.** If you do not explicitly exclude it, clients assume it is included.

## Quick Summary

- Define what done looks like before building starts.
- Written scope with explicit exclusions prevents disputes.
- Use MoSCoW to force prioritization conversations early.

## Operator Principles

- Write the scope before writing any code.
- List exclusions as explicitly as inclusions.
- Define measurable success criteria upfront.
- Run all changes through a formal change request process.',

exercise_markdown = '## Exercise: Scope a Real Project

**Timebox: 45 minutes | Stretch: 90 minutes**

Practice project scoping using a realistic scenario.

### Part 1: Problem Discovery

**Scenario:** A potential client says: "We need help automating our customer onboarding. It is a mess right now."

Write 15 to 20 discovery questions covering the problem, current process, desired outcome, and constraints.

### Part 2: Document Current State

**Client description:** "Right now when someone buys, we get a Stripe email. Someone copies their info into our CRM, then manually sends a welcome email with login credentials, then creates a folder in Google Drive for their files, then adds them to our Slack workspace, and notifies the team. It takes about 20 minutes per customer and we get 5 to 10 new customers a day. Sometimes we forget steps or make typos."

Create current-state documentation including process map, pain points, and metrics.

### Part 3: Define Success Criteria

Write specific, measurable success criteria for process metrics, business metrics, and technical metrics.

### Part 4: Design Future State

Design the automated process. Show the trigger, each automated step, and expected metrics.

### Part 5: Create Scope Document

Write a scope document including problem statement, objectives, deliverables, exclusions, technical requirements, assumptions, success criteria, and risks.

### Part 6: Handle Scope Change

The client says: "Can you also set up automated billing reminders?"

Write your response with assessment, options, and how you would document the decision.

### Part 7: Risk Assessment

Create a risk register with at least 5 risks. For each, document description, likelihood, impact, and mitigation.

### Deliverables

Discovery questions list. Current-state documentation. Success criteria. Future-state process design. Scope document. Scope change response. Risk register.

### Success Criteria

Scope document is client-ready. Problem deeply understood. Clear inclusions and exclusions. Measurable success criteria. Risks identified with mitigations.',

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
          "placeholder": "1. Takes 20 minutes per customer\n2. Errors occur (typos, missed steps)\n3. Customers sometimes wait hours for welcome email\n4. Steps get forgotten\n5. Process depends on one person being available",
          "required": true,
          "rows": 6
        },
        {
          "id": "current_metrics",
          "type": "textarea",
          "label": "Current metrics:",
          "placeholder": "Time per customer: 20 minutes\nDaily volume: 5-10 customers\nTotal daily time: 100-200 minutes\nError rate: Estimated 10-15%",
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
      "description": "Write a scope document.",
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
          "label": "Deliverables:",
          "placeholder": "1. Stripe webhook integration for payment triggers\n2. CRM record creation automation\n3. Credential generation system\n4. Automated welcome email sequence\n5. Google Drive folder creation automation\n6. Slack workspace invitation automation\n7. Team notification automation\n8. Error handling and logging\n9. Testing with sample customers\n10. Documentation and training",
          "required": true,
          "rows": 12
        },
        {
          "id": "exclusions",
          "type": "textarea",
          "label": "Exclusions:",
          "placeholder": "1. Stripe account setup or configuration\n2. CRM system selection or setup\n3. Email template design (client provides copy)\n4. Google Workspace administration\n5. Slack workspace setup\n6. Custom reporting or dashboards\n7. Ongoing maintenance (separate agreement)\n8. Multi-language support",
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
          "placeholder": "Assessment:\n- Is it in scope? No, this is a separate workflow\n- How much work? Approximately 4-6 additional hours\n- Affects timeline? Would add 3-5 days\n- Affects budget? Would add to cost\n\nThe request requires new trigger logic, additional email templates, and testing of reminder sequences.",
          "required": true,
          "rows": 8
        },
        {
          "id": "change_response",
          "type": "textarea",
          "label": "Your response to the client:",
          "placeholder": "That is a great feature idea. It is outside our current scope for the onboarding automation, but I can add it.\n\nOption A: Add it now. This would add approximately 6 hours of work and extend the timeline by about 4 days.\n\nOption B: Phase 2. We complete the onboarding automation first, then tackle billing reminders as a separate project.\n\nI recommend Option B so we can validate onboarding is working before adding complexity.\n\nWhich would you prefer?",
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
          "placeholder": "Risk 1: Stripe API changes\n- Likelihood: Low | Impact: High\n- Mitigation: Use webhooks (stable), monitor changelog\n\nRisk 2: Email deliverability issues\n- Likelihood: Medium | Impact: Medium\n- Mitigation: Test thoroughly, use authenticated sending\n\nRisk 3: Client access delays\n- Likelihood: Medium | Impact: High\n- Mitigation: Request all access in week 1\n\nRisk 4: CRM data structure issues\n- Likelihood: Low | Impact: Medium\n- Mitigation: Review schema before building\n\nRisk 5: Volume spikes overwhelm automation\n- Likelihood: Low | Impact: Medium\n- Mitigation: Test with high volume, implement queuing",
          "required": true,
          "rows": 20
        }
      ]
    }
  ],
  "deliverables": [
    "Discovery questions covering all areas",
    "Current-state documentation with metrics",
    "Measurable success criteria",
    "Future-state process design",
    "Scope document",
    "Scope change response",
    "Risk register with mitigations"
  ],
  "success_criteria": [
    "Scope document is client-ready",
    "Problem deeply understood",
    "Clear inclusions and exclusions",
    "Measurable success criteria defined",
    "Risks identified with mitigations"
  ]
}'

WHERE slug = 'scoping-requirements';
