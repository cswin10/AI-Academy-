-- ============================================================================
-- MODULE 7: Project Management for Operators
-- ============================================================================

-- Insert Module 7
INSERT INTO modules (track_id, slug, title, short_description, order_index, estimated_hours, level, xp_reward, is_active)
SELECT
  id,
  'project-management-operators',
  'Project Management for Operators',
  'Learn to scope projects, estimate timelines, manage stakeholders, communicate effectively, and deliver successful automation projects.',
  7,
  5,
  'Intermediate',
  50,
  true
FROM tracks WHERE slug = 'core-foundation';

-- Create quizzes for Module 7
INSERT INTO quizzes (title, description, difficulty, passing_score, xp_reward) VALUES
('Scoping and Planning Quiz', 'Test your understanding of project scoping and planning', 'intermediate', 75, 15),
('Estimation Quiz', 'Test your knowledge of timeline and effort estimation', 'intermediate', 75, 15),
('Stakeholder Management Quiz', 'Test your understanding of stakeholder management', 'intermediate', 75, 15),
('Communication Quiz', 'Test your knowledge of effective communication', 'intermediate', 75, 15),
('Delivery and Handoff Quiz', 'Test your understanding of project delivery', 'intermediate', 75, 15);

-- ============================================================================
-- SECTION 7.1: Scoping & Requirements Gathering
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Scoping and Planning Quiz'), 1,
'Why is proper scoping important before starting a project?',
'["It''s not important", "It prevents scope creep, sets clear expectations, and ensures you build the right thing", "To impress clients", "Only for large projects"]',
1,
'Good scoping defines what you''re building, prevents misunderstandings, and protects against endless changes.'),

((SELECT id FROM quizzes WHERE title = 'Scoping and Planning Quiz'), 2,
'What is scope creep?',
'["A scary bug", "Uncontrolled expansion of project requirements after work has started", "A project management tool", "Getting better at projects"]',
1,
'Scope creep is when requirements keep expanding beyond the original agreement, causing delays and budget overruns.'),

((SELECT id FROM quizzes WHERE title = 'Scoping and Planning Quiz'), 3,
'What should be included in a project scope document?',
'["Just the price", "Problem statement, objectives, deliverables, what''s included/excluded, timeline, success criteria", "Only technical details", "Whatever the client wants"]',
1,
'Comprehensive scope documents define the problem, solution, boundaries, timeline, and success metrics.'),

((SELECT id FROM quizzes WHERE title = 'Scoping and Planning Quiz'), 4,
'When should you say no to a requirement?',
'["Never", "When it''s out of scope, technically unfeasible, or would compromise the project", "Always", "Only if you don''t like it"]',
1,
'Saying no protects project success - some requirements are genuinely problematic and need to be declined or deferred.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'scoping-requirements',
  'Scoping & Requirements Gathering',
  1,
  'Intermediate',
  '# Scoping & Requirements Gathering

The foundation of every successful project: knowing exactly what you''re building and why.

## Why Scoping Matters

**Without proper scoping:**
- Build the wrong thing
- Endless "just one more thing" requests
- Timeline extends indefinitely
- Budget explodes
- Client unhappy, you exhausted

**With proper scoping:**
- Clear boundaries
- Shared expectations
- Predictable timeline
- Protected budget
- Happy client, sustainable work

**Every failed project started with poor scoping.**

## The Scoping Process

### Step 1: Understand the Problem

**Don''t jump to solutions. Understand the problem first.**

**Ask:**
- What problem are you trying to solve?
- Why is this a problem?
- What happens if you don''t solve it?
- Who is affected?
- What have you tried already?

**Example conversation:**

**Bad:**
Client: "We need a Zapier automation"
You: "Okay, what should it do?"

**Good:**
Client: "We need a Zapier automation"
You: "Let''s start with the problem. What''s happening now that you want to change?"
Client: "We spend 10 hours a week manually copying data from emails to our CRM"
You: "Tell me more about this process..."

**Dig deeper:**
- What data?
- Which emails?
- Which CRM?
- What happens to the data after?
- Where do errors happen?
- What''s the current pain level (1-10)?

### Step 2: Define Success

**What does "done" look like?**

**Ask:**
- How will you know this project succeeded?
- What measurable outcomes matter?
- What would make you thrilled with the result?
- What would be a complete failure?

**Document success criteria:**

**Vague (Bad):**
"Faster lead intake"

**Specific (Good):**
- Lead response time < 5 minutes (currently 2 hours)
- Zero manual data entry (currently 20 entries/day)
- 100% of leads in CRM (currently 80%)
- Team spends <1 hour/day on leads (currently 4 hours)

**Measurable success criteria = clear project goals.**

### Step 3: Map Current Process

**Document how things work now.**

**Create current-state diagram:**
```
Current Process:

1. Lead fills form on website
2. Form email sent to sales@company.com
3. Sales person checks email (manually, sporadically)
4. Sales person copies: name, email, company, message
5. Sales person pastes into CRM
6. Sales person sends response email (manually)
7. Sales person notifies team in Slack (manually)

Time: 15 minutes per lead
Errors: Frequent (typos, missed leads, forgot to notify)
Volume: 20 leads/day
Total time: 5 hours/day
```

**This becomes your baseline.**

### Step 4: Design Future Process

**How will it work after your solution?**

**Create future-state diagram:**
```
Future Process:

1. Lead fills form on website
2. Automation triggers instantly
3. Automation creates CRM record (automatic)
4. Automation sends response email (automatic)
5. Automation notifies team in Slack (automatic)

Time: 30 seconds per lead
Errors: Minimal (validation prevents bad data)
Volume: 20 leads/day
Total time: 10 minutes/day

Time saved: 4 hours 50 minutes per day
```

**This becomes your scope.**

### Step 5: Define What''s Included

**Explicitly state what you''re building.**

**Example:**

**Included:**
- Form submission trigger
- Data validation (email, required fields)
- CRM record creation (Airtable)
- Automated response email (template provided by client)
- Slack notification (#sales channel)
- Error logging
- Testing with sample data
- Handoff documentation

**Very specifically: List every feature, integration, and deliverable.**

### Step 6: Define What''s Excluded

**Equally important: what you''re NOT building.**

**Example:**

**Excluded (Out of Scope):**
- Redesigning the form itself
- Setting up the CRM database (must exist)
- Creating email templates (client provides)
- Training sales team on CRM
- Integration with other systems (e.g., marketing automation)
- Custom reporting
- Mobile app
- Anything not explicitly listed in "Included"

**Why this matters:**

Client: "Can you also add a feature to..."
You: "That''s out of scope. We can discuss it as a separate project."

**No scope creep.**

### Step 7: Identify Constraints

**What limitations exist?**

**Technical:**
- Must use existing CRM (no switching)
- Must integrate with current email system
- Can''t store data in certain locations (compliance)
- Must use no-code tools (no custom development)

**Budget:**
- Maximum $5,000
- Maximum $100/month in ongoing tool costs

**Timeline:**
- Must launch by end of quarter
- Critical for upcoming campaign

**Resources:**
- Only you working on this
- Client has 5 hours available for meetings/testing

**Document all constraints upfront.**

### Step 8: Prioritize Requirements

**Not everything is equally important.**

**MoSCoW method:**

**Must Have (Critical):**
- Form trigger
- CRM creation
- Response email
→ Without these, project fails

**Should Have (Important):**
- Slack notification
- Error logging
→ Very valuable but not critical

**Could Have (Nice to have):**
- Lead scoring
- Manager dashboard
→ Add if time/budget allows

**Won''t Have (Out of scope):**
- Mobile app
- Custom reporting
→ Future phase

**Focus on Must Haves first.**

## The Scope Document

### Template
```markdown
# Project Scope: [Project Name]

## 1. Project Overview

**Client:** [Company Name]
**Project:** [One-line description]
**Date:** [Date]
**Version:** 1.0

## 2. Problem Statement

[Describe current situation and pain points]

Currently, the team spends 5 hours/day manually processing leads,
resulting in slow response times and frequent errors.

## 3. Objectives

What we''re trying to achieve:
1. Reduce lead response time from 2 hours to <5 minutes
2. Eliminate manual data entry
3. Ensure 100% of leads are captured

## 4. Current State

[Diagram or description of current process]

## 5. Proposed Solution

[High-level description of what you''ll build]

Automated workflow that captures form submissions, validates data,
creates CRM records, sends response emails, and notifies team.

## 6. Deliverables

What you will deliver:

✓ Zapier workflow (form → CRM → email → Slack)
✓ Data validation rules
✓ Email response template (based on client draft)
✓ Error handling and logging
✓ Testing and verification
✓ Documentation for team
✓ 1 hour training session

## 7. Out of Scope

What you will NOT deliver:

✗ Form redesign
✗ CRM setup or configuration
✗ Email template creation (client provides)
✗ Integrations beyond those listed
✗ Ongoing maintenance (separate agreement)

## 8. Technical Requirements

**Platforms:**
- Typeform (existing form)
- Airtable (existing CRM)
- Gmail (for emails)
- Slack (existing workspace)

**Access Required:**
- Typeform admin access
- Airtable base editor access
- Gmail account credentials
- Slack webhook

## 9. Assumptions

- Client provides email template
- Airtable base structure already exists
- Client available for weekly check-ins
- All required tool access provided within 1 week

## 10. Success Criteria

Project is successful when:
- ✓ 100% of form submissions create CRM records
- ✓ Response email sent within 30 seconds
- ✓ Team notified in Slack for all leads
- ✓ Zero manual data entry required
- ✓ Error rate <1%
- ✓ Client signs off on acceptance testing

## 11. Timeline

[Detailed timeline in next section]

Estimated: 3 weeks

## 12. Budget

Total: $3,500
Breakdown: [in proposal]

## 13. Risks & Mitigations

**Risk:** Typeform API changes
**Mitigation:** Use webhooks, not API

**Risk:** Email deliverability issues
**Mitigation:** Test thoroughly, monitor bounces

## 14. Sign-off

By signing below, both parties agree to this scope.

Client: ___________________ Date: _______
Operator: _________________ Date: _______

Any changes to this scope require written approval and
may affect timeline and budget.
```

## Requirements Gathering Techniques

### Technique 1: Stakeholder Interviews

**Talk to everyone affected.**

**Questions for end users:**
- Walk me through your current process
- What frustrates you most?
- What takes the most time?
- What errors happen?
- What would make your life easier?

**Questions for decision makers:**
- What business problem does this solve?
- What''s the ROI?
- What happens if we don''t do this?
- What''s your budget?
- What''s your timeline?

### Technique 2: Process Observation

**Watch people work.**

Don''t just ask how they do it. Watch them do it.

**You''ll discover:**
- Workarounds they forgot to mention
- Steps they skip
- Errors they make
- Time they actually spend

**Reality ≠ what people say they do.**

### Technique 3: Document Review

**Look at existing materials:**
- Current forms
- Email templates
- Database schemas
- Existing automations (if any)
- Reports they need

**This reveals:**
- Actual data fields
- Real formatting
- Hidden requirements

### Technique 4: Use Case Scenarios

**Walk through specific examples.**

"Show me the last 3 leads you processed. Let''s walk through each one."

**Edge cases emerge:**
- International phone numbers
- Company names with special characters
- Leads with multiple people
- Urgent vs normal leads

**Cover normal + edge cases.**

## Handling Scope Changes

**Scope will try to expand. Always.**

### Change Request Process

**Client:** "Can you also add X?"

**You:**
```
1. Acknowledge: "Good idea, let''s evaluate it"

2. Assess:
   - Is it in scope? (usually no)
   - How much work?
   - Affects timeline/budget?

3. Options:
   a) Add to scope (new timeline/budget)
   b) Defer to Phase 2
   c) Decline (doesn''t fit project goals)

4. Document:
   If approved: Update scope document
   All parties sign off on change
```

**Template response:**

"That''s a great feature idea. It''s outside our current scope, but I''d be happy to add it. It would add X hours of work and $Y to the budget, pushing our timeline by Z weeks. Alternatively, we could plan it for Phase 2 after we launch the core functionality. What would you prefer?"

### Saying No Effectively

**When to say no:**
- Feature doesn''t align with objectives
- Technically not feasible
- Budget/timeline can''t accommodate
- Would compromise quality of core features
- Out of your expertise

**How to say no:**

**Bad:**
"No, that''s stupid."

**Good:**
"I understand why that''s appealing. However, adding that would require [specific reason]. Instead, I recommend [alternative] which achieves [similar goal] within our constraints."

**Or:**
"That''s a valuable feature, but it''s quite complex. If we prioritize that, we''ll need to cut [other feature] or extend the timeline by [X weeks]. Which would you prefer?"

**Give them choices, not dead ends.**

## Common Scoping Mistakes

### Mistake 1: Assuming You Understand

**Don''t assume anything.**

"When you say ''customer data,'' what specific fields do you mean?"

Verify everything.

### Mistake 2: Accepting Vague Requirements

**Bad:**
"Make it faster"

**Good:**
"Reduce processing time from 2 hours to under 5 minutes"

**Get specific.**

### Mistake 3: No Written Scope

**Verbal agreements = disaster**

**"I thought you meant..."**
**"I never said that..."**

**Always document. Always get sign-off.**

### Mistake 4: Ignoring Constraints

**Client:** "Budget is $1,000"
**You:** Scope a $5,000 project

**Understand constraints first.**

### Mistake 5: Technical Jargon

**Don''t:** "We''ll implement a RESTful API with OAuth2 authentication..."

**Do:** "We''ll connect your form to your database securely"

**Speak their language.**

### Mistake 6: No Exclusions

If you don''t explicitly exclude it, clients assume it''s included.

**"I thought you were also building..."**

**List exclusions.**

### Mistake 7: Scope Equals Proposal

**Scope document ≠ sales proposal**

**Scope:** What you''re building (shared with client)
**Proposal:** How much it costs (your business document)

**Different documents, different purposes.**

## Scoping Checklist

**Before starting any project:**

☐ Understand the problem deeply
☐ Define measurable success criteria
☐ Document current process
☐ Design future process
☐ List all inclusions explicitly
☐ List all exclusions explicitly
☐ Identify constraints
☐ Prioritize requirements (MoSCoW)
☐ Create detailed scope document
☐ Review with stakeholders
☐ Get written sign-off
☐ Define change request process

**If you can''t check all boxes, don''t start building.**',

  '## Exercise: Scope a Real Project

**Objective:** Practice comprehensive project scoping.

**Instructions:**

### Part 1: Problem Discovery

**Scenario: You''re talking to a potential client**

**Client says:** "We need help automating our customer onboarding. It''s a mess right now."

**Your questions:**

**About the problem:**
1. __
2. __
3. __
4. __
5. __

**About current process:**
1. __
2. __
3. __
4. __
5. __

**About desired outcome:**
1. __
2. __
3. __

**About constraints:**
1. __
2. __
3. __

**Write 15-20 discovery questions you''d ask**

### Part 2: Document Current State

**Based on this client description:**

"Right now when someone buys, we get a Stripe email. Someone on our team (usually me) copies their info into our CRM, then manually sends a welcome email with login credentials, then creates a folder in Google Drive for their files, then adds them to our Slack workspace, and notifies the team. It takes about 20 minutes per customer and we get 5-10 new customers a day. Sometimes we forget steps or make typos. Last week we forgot to send welcome emails to 3 customers."

**Create current-state documentation:**

**Process map:**
```
Step 1: [What happens]
Step 2: [What happens]
...
```

**Pain points:**
1. __
2. __
3. __

**Metrics:**
- Time per customer: __
- Daily volume: __
- Total time spent: __
- Error rate: __
- Business impact: __

### Part 3: Define Success Criteria

**For this project, write specific, measurable success criteria:**

**Process metrics:**
- Time per customer: From __ to __
- Manual steps: From __ to __
- Error rate: From __ to __

**Business metrics:**
- Customer satisfaction: __
- Team time saved: __
- Revenue impact: __

**Technical metrics:**
- Success rate: __%
- Processing time: __ seconds
- Uptime: __%

**How will you measure each?**

### Part 4: Design Future State

**Design the automated process:**

**Future-state process map:**
```
Trigger: [What starts it]
Step 1: [Automated action]
Step 2: [Automated action]
...
Step N: [Automated action]
```

**Tools required:**
- __
- __
- __

**Integrations needed:**
- __ → __
- __ → __

**Data flow:**
```
[Source] → [Transformation] → [Destination]
```

### Part 5: Create Scope Document

**Write complete scope document for this project:**

**Use the template from the lesson, include:**

1. Project Overview
2. Problem Statement (from Part 2)
3. Objectives
4. Current State (from Part 2)
5. Proposed Solution (from Part 4)
6. Deliverables (be specific)
7. Out of Scope (what you WON''T do)
8. Technical Requirements
9. Assumptions
10. Success Criteria (from Part 3)
11. Risks & Mitigations

**Make it detailed and specific**

### Part 6: Handle Scope Changes

**Mid-project, client says:**

"Can you also add a feature to automatically create invoices in QuickBooks and send them monthly?"

**Your response:**

**Analysis:**
- Is this in scope? __
- How much work? __
- Affects timeline? __
- Affects budget? __

**Your written response to client:**
```
[Draft your response]
```

**Include:**
- Acknowledgment
- Assessment
- Options
- Recommendation

---

**Another request:**

"Actually, can you also build a customer portal where they can download files?"

**Your response:**
- In scope? __
- Feasible? __
- Priority? __
- Your response: __

### Part 7: Identify Exclusions

**For the onboarding project, list 10 things that are OUT OF SCOPE:**

**Explicitly excluded:**
1. __
2. __
3. __
4. __
5. __
6. __
7. __
8. __
9. __
10. __

**Why each is excluded:**
- [Reason]

### Part 8: Prioritize Features

**The client wants all these features:**

- Automated CRM record creation
- Welcome email with login credentials
- Google Drive folder creation
- Slack workspace invitation
- Team notification
- Customer onboarding checklist
- Automated invoice creation
- Weekly progress reports to manager
- Integration with project management tool
- Custom dashboard for customer health

**Categorize using MoSCoW:**

**Must Have:**
- __
- __
- __

**Should Have:**
- __
- __

**Could Have:**
- __
- __

**Won''t Have (Phase 2):**
- __
- __

**Justify each categorization**

### Part 9: Risk Assessment

**Identify potential risks:**

**Technical risks:**
- Risk: __
- Impact: High/Medium/Low
- Probability: High/Medium/Low
- Mitigation: __

**Business risks:**
- Risk: __
- Mitigation: __

**Timeline risks:**
- Risk: __
- Mitigation: __

**List 5-10 risks with mitigations**

### Part 10: Stakeholder Sign-off

**Draft an email requesting scope approval:**
```
Subject: [Your subject]

Hi [Client],

[Your email content requesting sign-off on scope]

[Include what you need from them]
[Include next steps]
[Include timeline]

Best,
[You]
```

**What documents do you attach?**
- __
- __

**What questions do you ask to ensure understanding?**
- __
- __

### Deliverable

**Complete project scope package:**

**Section 1: Discovery Notes**
- All questions asked
- Client responses (simulated)
- Key insights

**Section 2: Current State Analysis**
- Process map
- Pain points
- Metrics
- Business impact

**Section 3: Future State Design**
- Automated process map
- Tools and integrations
- Data flow diagram

**Section 4: Scope Document**
- Complete formal scope document
- All sections filled in
- Professional format

**Section 5: Change Management**
- Responses to scope change requests
- Process for handling changes
- Examples of saying no effectively

**Section 6: Prioritization**
- MoSCoW analysis
- Justifications
- Phase 1 vs Phase 2 plan

**Section 7: Risk Management**
- Risk register
- Mitigation strategies

**Section 8: Sign-off Materials**
- Client-facing summary
- Approval request email
- Sign-off form

**Success Criteria:**
- Comprehensive scope document created
- Problem deeply understood
- Clear inclusions and exclusions
- Measurable success criteria defined
- Risks identified and mitigated
- Change process established
- Ready to present to real client
- You understand the scoping process',

  60,
  true,
  (SELECT id FROM quizzes WHERE title = 'Scoping and Planning Quiz')
FROM modules m
WHERE m.slug = 'project-management-operators';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'How to Scope Projects Effectively',
  'https://www.youtube.com/watch?v=DRkjRlajAkc',
  'video',
  1
FROM sections WHERE slug = 'scoping-requirements'
UNION ALL
SELECT
  id,
  'Requirements Gathering Best Practices',
  'https://www.youtube.com/watch?v=N7o2syzQo4w',
  'video',
  2
FROM sections WHERE slug = 'scoping-requirements';

-- ============================================================================
-- SECTION 7.2: Estimating Time & Effort
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Estimation Quiz'), 1,
'Why are estimates often wrong?',
'["Estimators are bad at math", "Unknown unknowns, optimism bias, and incomplete information", "Clients lie", "Estimates are always accurate"]',
1,
'Estimates fail because we don''t know what we don''t know, we''re optimistic, and requirements change.'),

((SELECT id FROM quizzes WHERE title = 'Estimation Quiz'), 2,
'What is the planning fallacy?',
'["A project management tool", "The tendency to underestimate how long tasks will take despite past experience", "A type of error", "A scheduling technique"]',
1,
'Planning fallacy is our built-in optimism bias - we consistently underestimate time despite knowing better.'),

((SELECT id FROM quizzes WHERE title = 'Estimation Quiz'), 3,
'What should you include in time estimates?',
'["Only coding time", "Building, testing, debugging, documentation, meetings, and buffer", "Just building time", "Whatever the client wants to hear"]',
1,
'Comprehensive estimates include all work: building, testing, debugging, communication, and contingency.'),

((SELECT id FROM quizzes WHERE title = 'Estimation Quiz'), 4,
'What is a good contingency buffer for estimates?',
'["0% (be accurate)", "25-50% depending on uncertainty", "200% to be safe", "Whatever feels right"]',
1,
'25-50% buffer accounts for unknowns without padding excessively - adjust based on project risk.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id)
SELECT
  m.id,
  'estimating-time-effort',
  'Estimating Time & Effort',
  2,
  'Intermediate',
  '# Estimating Time & Effort

Estimation is hard. Everyone underestimates. Here''s how to get closer to reality.

## Why Estimates Are Always Wrong

**Three fundamental problems:**

### 1. Unknown Unknowns

**You don''t know what you don''t know.**

"This should take 2 days"

**Then you discover:**
- API doesn''t support the feature you need
- Data format is inconsistent
- Third requirement conflicts with first
- Client access delayed 1 week
- Tool has undocumented limitations

**Your 2-day estimate became 2 weeks.**

### 2. Optimism Bias (Planning Fallacy)

**We''re wired to be optimistic.**

"Last time took 3 weeks, but THIS time will be faster because [reasons]"

**It won''t be faster. It never is.**

**We consistently underestimate despite evidence.**

### 3. Incomplete Information

**You estimate before you have all details.**

**Early:** "Automation project, probably 1 week"

**After discovery:** "Actually they need 5 integrations, complex logic, migration of historical data... 6 weeks"

**Estimates improve as information increases.**

## The Estimation Process

### Step 1: Break Down the Work

**Don''t estimate "the project." Estimate tasks.**

**Bad:**
"Build automation: 2 weeks"

**Good:**
```
Setup & Discovery:
  - Kickoff meeting: 1 hour
  - Access to systems: 2 hours (includes waiting)
  - Review current process: 2 hours
  Total: 5 hours

Building:
  - Design workflow: 3 hours
  - Set up trigger: 1 hour
  - Build data validation: 2 hours
  - Create CRM integration: 4 hours
  - Set up email automation: 2 hours
  - Add Slack notifications: 1 hour
  - Error handling: 2 hours
  Total: 15 hours

Testing:
  - Unit testing: 3 hours
  - Integration testing: 2 hours
  - Edge case testing: 2 hours
  - Bug fixes: 4 hours
  Total: 11 hours

Documentation & Training:
  - Write documentation: 3 hours
  - Create training materials: 2 hours
  - Training session: 2 hours
  Total: 7 hours

Project Management:
  - Client meetings: 4 hours
  - Updates and communication: 2 hours
  Total: 6 hours

Grand Total: 44 hours
```

**Specific tasks = better estimates.**

### Step 2: Add Historical Data

**What did similar tasks take before?**

**Track your work:**
```
Past CRM integrations:
- Project A: Estimated 4 hours, Actual 6 hours
- Project B: Estimated 3 hours, Actual 5 hours
- Project C: Estimated 5 hours, Actual 7 hours

Average: Estimates are 50% too low

This project: Estimate 4 hours
Reality check: Probably 6 hours
```

**Your past = best predictor of future.**

### Step 3: Add Complexity Multipliers

**Not all tasks are equal complexity.**

**Base task:** Simple form → CRM automation

**Multipliers:**
- **×1.0** Standard (done many times)
- **×1.5** New tool (haven''t used before)
- **×2.0** Complex logic (many conditions)
- **×2.5** Multiple integrations
- **×3.0** Unknown territory

**Example:**
```
CRM integration (base): 4 hours
  × 1.5 (new CRM system)
  × 2.0 (complex conditional logic)

Adjusted estimate: 4 × 1.5 × 2.0 = 12 hours
```

### Step 4: Add Contingency Buffer

**Things go wrong. Always.**

**Contingency guidelines:**

| Uncertainty | Buffer |
|-------------|--------|
| Low (done exact task before) | 15-25% |
| Medium (similar task) | 25-40% |
| High (new territory) | 40-100% |
| Very High (R&D / unknown) | 100-200% |

**Example:**
```
Core work: 44 hours
Uncertainty: Medium (some new tools)
Buffer: 30%

Total estimate: 44 × 1.3 = 57 hours
(Round up to 60 hours = 1.5 weeks)
```

### Step 5: Consider Context Factors

**Not all hours are created equal.**

**Interruptions:**
8 hours of actual work ≠ 8 hours of calendar time

**Productivity factors:**
- Client calls: -2 hours/week
- Other projects: -10 hours/week
- Urgent issues: -3 hours/week

**Your 40-hour week = 25 productive hours**

**So:**
```
Project needs: 60 hours of work
Your availability: 25 hours/week
Timeline: 60 ÷ 25 = 2.4 weeks

Round up: 3 weeks
```

## Estimation Techniques

### Technique 1: Reference Class Forecasting

**Base estimate on similar past projects, not ideal scenario.**

**Steps:**
1. Find 3-5 similar past projects
2. Look at actual time (not estimates)
3. Average them
4. Adjust for differences

**Example:**
```
Past lead automation projects:
- Project A: 40 hours
- Project B: 55 hours
- Project C: 48 hours
Average: 48 hours

Current project is similar but:
- Slightly more complex (+15%)
- New CRM (haven''t used before) (+25%)

Estimate: 48 × 1.15 × 1.25 = 69 hours
Say: 70 hours (2 weeks)
```

### Technique 2: Three-Point Estimation

**Best case, likely case, worst case**

**For each task:**
- **Optimistic (O):** Everything goes perfectly
- **Most Likely (M):** Normal execution
- **Pessimistic (P):** Everything goes wrong

**Formula:**
```
Estimate = (O + 4M + P) ÷ 6
```

**Example: CRM Integration**
```
Optimistic: 3 hours (API docs perfect, no issues)
Most Likely: 5 hours (standard complexity)
Pessimistic: 12 hours (API issues, multiple debugging sessions)

Estimate = (3 + 4×5 + 12) ÷ 6 = 5.8 hours
Round: 6 hours
```

**This naturally builds in contingency.**

### Technique 3: T-Shirt Sizing

**For early/rough estimates**

**Sizes:**
- **XS:** <4 hours
- **S:** 4-8 hours
- **M:** 8-16 hours (1-2 days)
- **L:** 16-40 hours (1 week)
- **XL:** 40-80 hours (2 weeks)
- **XXL:** >80 hours (need to break down)

**Useful for:**
- Quick ballpark
- Prioritization
- Before detailed scope

**Convert to hours later** when you have more info.

### Technique 4: Bottom-Up Estimation

**Sum of all tasks**
```
Task 1: 2 hours
Task 2: 4 hours
Task 3: 3 hours
...
Task N: 1 hour

Total: Σ all tasks
```

**Most accurate when:**
- Tasks well-defined
- Similar tasks done before
- Low uncertainty

### Technique 5: Top-Down Estimation

**Based on overall project size**
```
"Typical automation project: 50-70 hours
This one seems standard
Estimate: 60 hours"
```

**Useful for:**
- Very early estimate
- Comparing to budget
- Sanity check

**Combine with bottom-up for best results.**

## Common Estimation Mistakes

### Mistake 1: Forgetting Non-Building Time

**People estimate coding time, forget:**
- Meetings
- Testing
- Debugging
- Documentation
- Communication
- Waiting for access/approvals

**Add 30-50% for these.**

### Mistake 2: No Contingency

"It''ll take exactly 40 hours"

No. It will take 40-70 hours depending on what goes wrong.

**Always add buffer.**

### Mistake 3: Anchoring on Client Expectation

**Client:** "This should take about 1 week, right?"
**You:** "Uh... sure!"

**Wrong.**

**Do your own estimate. Present it confidently.**

### Mistake 4: Ignoring Past Data

"Last time took 3 weeks, but THIS time..."

**It will take 3 weeks. Maybe more.**

**Learn from history.**

### Mistake 5: Too Precise

"This will take 43.7 hours"

No one believes that.

**Round to reasonable increments:**
- Hours: round to 2, 4, 6, 8
- Days: round to 0.5 days
- Weeks: round to whole weeks

"Approximately 45 hours, roughly 1.5 weeks"

### Mistake 6: Not Tracking Actuals

**You estimate but never record actual time.**

How do you improve?

**Track:**
- Estimated hours
- Actual hours
- Variance
- Reasons for variance

**Build a historical database.**

## Presenting Estimates

### To Clients

**Format:**

"Based on the scope we discussed, I estimate this project will take approximately 60-70 hours of work, which translates to about 2-3 weeks of calendar time.

**This includes:**
- Building the automation (40 hours)
- Testing and debugging (15 hours)
- Documentation and training (10 hours)
- Project management and meetings (5 hours)

**Timeline assumes:**
- Timely access to all systems
- No major scope changes
- Availability for weekly check-ins

**The range accounts for:**
- Potential integration challenges
- Edge cases discovered during testing
- Minor scope refinements

I''ll provide weekly updates on progress and flag any issues early."

**Key points:**
- Give a range, not a single number
- Explain what''s included
- State assumptions
- Explain the range
- Commit to communication

### To Your Team

**More detail:**
```
Project: Lead Automation
Total Estimate: 60 hours

Breakdown:
  Setup: 5 hours
  Building: 30 hours
  Testing: 15 hours
  Documentation: 7 hours
  PM: 3 hours

Confidence: Medium (70%)
  - Have done similar projects
  - One new tool (Typeform)
  - Client responsive

Risks:
  - API limitations unknown (×1.5 multiplier if issues)
  - Complex validation requirements

Timeline: 2-3 weeks
  Based on 20-25 productive hours/week
```

## Estimating Different Work Types

### New Features
```
Base: Historical similar feature
× Complexity multiplier
+ Buffer (30-50%)
```

### Bug Fixes
```
Simple: 1-2 hours
Medium: 4-8 hours
Complex: 1-2 days
Unknown: "Need to investigate" (2-4 hours)
```

### Research/Investigation
```
Minimum: 4 hours
Typical: 8 hours
Maximum: 16 hours (if more, it''s a project)
```

### Documentation
```
Per page: 30-60 minutes
Per hour of automation: 15-30 minutes documentation
```

### Meetings
```
1:1 check-in: 30 minutes
Team meeting: 1 hour
Client presentation: 1-2 hours (inc. prep)
```

## Improving Your Estimates

### Strategy 1: Track Everything

**Template:**
```
Project: [Name]
Estimated: [X hours]
Actual: [Y hours]
Variance: [(Y-X)/X]
Reasons: [Why different]
```

### Strategy 2: Regular Review

**Monthly:**
- Review last month''s projects
- Calculate average variance
- Identify patterns
- Adjust multipliers

### Strategy 3: Break Your Patterns

**You have estimation patterns:**
- Always underestimate setup time?
- Forget about testing?
- Optimistic about new tools?

**Identify your patterns. Correct them.**

### Strategy 4: Calibrate with Peers

**Ask other operators:**
"How long would you estimate this?"

**Compare.**

**Discuss differences.**

**Learn.**

### Strategy 5: Be Honest

**Don''t give estimates you don''t believe in.**

If you think it''s 3 weeks, don''t say 1 week to please client.

**Your reputation > one project.**

## When You''re Wrong

**You will be wrong. Often.**

**What to do:**

**Discover early:**
- Track actual vs. estimated regularly
- Raise red flags early

**Communicate quickly:**
"I originally estimated 2 weeks. I''m now 1 week in and about 30% complete. Revised estimate: 3-4 weeks. Here''s why..."

**Explain, don''t excuse:**
- What changed
- What you learned
- New estimate
- How you''ll prevent it

**Learn:**
- What did you miss?
- What multiplier should you have used?
- How will you estimate this better next time?

**Good operators estimate better over time.**',

  '## Exercise: Estimate a Real Project

**Objective:** Practice comprehensive project estimation.

**Instructions:**

### Part 1: Task Breakdown

**Project:** Customer support ticket automation

**Description:**
"Automate our support ticket workflow. When someone emails support@company.com, create a ticket in our system, categorize it using AI, assign to the right team, and notify them in Slack. Also send an auto-reply to the customer."

**Break this into specific tasks:**

**Category: Setup & Discovery**
- Task: __
- Estimated hours: __

**Category: Building**
- Task: Trigger setup
- Estimated hours: __
- Task: Email parsing
- Estimated hours: __
- Task: AI classification
- Estimated hours: __
- Task: __
- [Continue for all building tasks]

**Category: Testing**
- Task: __
- Estimated hours: __

**Category: Documentation**
- Task: __
- Estimated hours: __

**Category: Project Management**
- Task: __
- Estimated hours: __

**List 20-30 specific tasks**

### Part 2: Apply Historical Data

**Assume these are similar past projects you''ve done:**

**Project A: Email → CRM automation**
- Estimated: 20 hours
- Actual: 28 hours
- Variance: +40%

**Project B: Support ticket system**
- Estimated: 30 hours
- Actual: 42 hours
- Variance: +40%

**Project C: AI classification integration**
- Estimated: 15 hours
- Actual: 23 hours
- Variance: +53%

**Your analysis:**
- Average variance: __%
- Pattern identified: __
- Adjustment for this project: __

### Part 3: Three-Point Estimation

**For these key tasks, provide three estimates:**

**Task: AI Classification Integration**
- Optimistic (everything perfect): __ hours
- Most Likely (normal execution): __ hours
- Pessimistic (lots of issues): __ hours
- Calculated estimate: (O + 4M + P) ÷ 6 = __ hours

**Task: Email Parsing**
- Optimistic: __ hours
- Most Likely: __ hours
- Pessimistic: __ hours
- Calculated: __ hours

**Task: Testing All Integrations**
- Optimistic: __ hours
- Most Likely: __ hours
- Pessimistic: __ hours
- Calculated: __ hours

### Part 4: Apply Complexity Multipliers

**Base estimate from task breakdown: __ hours**

**Multipliers to consider:**

**Tool familiarity:**
- Using familiar tools (1.0x)
- One new tool (1.2x)
- Multiple new tools (1.5x)
- All unfamiliar (2.0x)

**Your assessment: __x**

**Logic complexity:**
- Simple linear (1.0x)
- Some conditionals (1.3x)
- Complex branching (1.8x)
- Very complex (2.5x)

**Your assessment: __x**

**Integration complexity:**
- 1-2 integrations (1.0x)
- 3-4 integrations (1.3x)
- 5+ integrations (1.8x)

**Your assessment: __x**

**Data complexity:**
- Structured, clean (1.0x)
- Some cleanup needed (1.3x)
- Messy/unstructured (1.8x)

**Your assessment: __x**

**Total multiplier: __**

**Adjusted estimate: Base × Multiplier = __ hours**

### Part 5: Add Contingency Buffer

**Your adjusted estimate: __ hours**

**Uncertainty level:**
☐ Low (done exact project before) - 15-25% buffer
☐ Medium (similar project) - 25-40% buffer
☐ High (new territory) - 40-100% buffer

**Your buffer percentage: __%**

**Why this buffer level:** __

**Final estimate: Adjusted × (1 + Buffer) = __ hours**

### Part 6: Convert to Calendar Time

**Your estimate: __ hours of work**

**Your availability:**
- Hours per week available for this project: __
- Other commitments: __
- Client meetings per week: __
- Effective hours per week: __

**Timeline: Work hours ÷ Effective hours/week = __ weeks**

**Calendar timeline (accounting for weekends, holidays): __ weeks**

**Presented to client as: __ to __ weeks**

### Part 7: Create Detailed Estimate Document

**Write professional estimate document:**
```markdown
# Project Estimate: Support Ticket Automation

## Executive Summary
Total Estimated Effort: [X-Y hours]
Timeline: [W-Z weeks]
Confidence Level: [Low/Medium/High]

## Detailed Breakdown

### Phase 1: Setup & Discovery ([X] hours)
- [Task]: [Y hours]
- [Task]: [Y hours]
Total: [X hours]

### Phase 2: Core Development ([X] hours)
- [Task]: [Y hours]
- [Task]: [Y hours]
Total: [X hours]

### Phase 3: Testing & QA ([X] hours)
- [Task]: [Y hours]
Total: [X hours]

### Phase 4: Documentation & Training ([X] hours)
- [Task]: [Y hours]
Total: [X hours]

### Phase 5: Project Management ([X] hours)
- [Task]: [Y hours]
Total: [X hours]

## Assumptions
- [List all assumptions]

## Risks & Contingencies
- [Risk]: [Mitigation] [Buffer: X hours]

## Timeline
Week 1: [What gets done]
Week 2: [What gets done]
...

## What Could Change This Estimate
- [Factor 1]
- [Factor 2]
```

### Part 8: Compare Estimation Methods

**Estimate the same project using different methods:**

**Method 1: Quick T-Shirt Sizing**
- Overall size: __ (XS/S/M/L/XL/XXL)
- Hours range: __
- Time: 5 minutes

**Method 2: Bottom-Up (Task Breakdown)**
- Total hours: __
- Time: 30 minutes

**Method 3: Top-Down (Reference Class)**
- Similar projects averaged: __ hours
- Adjusted for this project: __ hours
- Time: 10 minutes

**Method 4: Three-Point (Key Tasks)**
- Calculated estimate: __ hours
- Time: 45 minutes

**Compare results:**
- Which method gave highest estimate: __
- Which gave lowest: __
- Which feels most accurate: __
- When would you use each: __

### Part 9: Present Estimate

**Draft email to client:**
```
Subject: Project Estimate - Support Ticket Automation

Hi [Client],

[Your estimate presentation]

[Include: total hours, timeline, breakdown, assumptions, what''s included]

[Next steps]

Best,
[You]
```

### Part 10: Track and Review

**Create tracking template:**
```markdown
## Project Tracking: Support Ticket Automation

### Original Estimate
Total: [X] hours
Timeline: [Y] weeks
Date: [Date]

### Actual Progress

#### Week 1
Planned: [X hours on tasks A, B, C]
Actual: [Y hours on tasks A, B, C]
Variance: [+/- Z hours]
Reasons: [Why different]
Revised estimate: [If changed]

#### Week 2
[Same format]

### Final Results
Total estimated: [X] hours
Total actual: [Y] hours
Variance: [Z%]

### Lessons Learned
- Underestimated: [What]
- Overestimated: [What]
- Surprises: [What]
- Next time: [Changes]
```

### Deliverable

**Complete estimation package:**

**Section 1: Task Breakdown**
- 20-30 specific tasks identified
- Categorized by phase
- Initial time estimates

**Section 2: Historical Analysis**
- Past projects reviewed
- Variance patterns identified
- Adjustments calculated

**Section 3: Detailed Estimates**
- Three-point estimates for key tasks
- Complexity multipliers applied
- Contingency buffer added
- Final estimate calculated

**Section 4: Timeline Conversion**
- Work hours → calendar weeks
- Availability factored in
- Realistic timeline

**Section 5: Professional Document**
- Client-ready estimate document
- Clear breakdown
- Assumptions stated
- Risks identified

**Section 6: Method Comparison**
- Multiple methods used
- Results compared
- Best method identified

**Section 7: Communication**
- Client presentation drafted
- Next steps clear

**Section 8: Tracking Template**
- Ready to track actuals
- Variance analysis built in
- Lessons learned section

**Success Criteria:**
- Comprehensive task breakdown
- Multiple estimation methods applied
- Buffer included
- Realistic timeline
- Professional presentation
- Ready to track actuals
- Can explain your estimate
- Confidence in your numbers',

  60,
  true,
  (SELECT id FROM quizzes WHERE title = 'Estimation Quiz')
FROM modules m
WHERE m.slug = 'project-management-operators';

INSERT INTO external_resources (section_id, title, url, resource_type, order_index)
SELECT
  id,
  'How to Estimate Project Time Accurately',
  'https://www.youtube.com/watch?v=v21jg8wb1eU',
  'video',
  1
FROM sections WHERE slug = 'estimating-time-effort'
UNION ALL
SELECT
  id,
  'Project Estimation Techniques',
  'https://www.youtube.com/watch?v=6A5EpqqDOdk',
  'video',
  2
FROM sections WHERE slug = 'estimating-time-effort';
