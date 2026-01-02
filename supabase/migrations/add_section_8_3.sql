-- ============================================================================
-- SECTION 8.3: Building Business Cases
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 1,
'What is the primary purpose of a business case?',
'["To show off your technical skills", "To justify investment by showing the problem, solution, costs, benefits, and expected outcomes", "To list all the features you will build", "To negotiate a lower price"]',
1,
'A business case justifies investment. It helps stakeholders understand why the project deserves budget and resources.'),

((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 2,
'What should be the first section of a business case?',
'["Technical specifications", "Executive summary with the key recommendation and headline ROI", "Your biography", "A list of competitors"]',
1,
'Busy executives read the summary first. Lead with the recommendation and the compelling numbers.'),

((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 3,
'Why is documenting the current state important in a business case?',
'["To make the document longer", "It establishes the baseline for measuring improvement and shows you understand the problem", "It is not important", "To criticize the client"]',
1,
'The current state shows you understand the problem and provides the baseline for calculating improvements.'),

((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 4,
'What does SMART criteria stand for in objectives?',
'["Simple, Manageable, Achievable, Realistic, Timely", "Specific, Measurable, Achievable, Relevant, Time-bound", "Strategic, Meaningful, Actionable, Reasonable, Tested", "Special, Major, Appropriate, Right, Trackable"]',
1,
'SMART objectives are Specific, Measurable, Achievable, Relevant, and Time-bound. They make success clear.'),

((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 5,
'What should you include in the risks section of a business case?',
'["Nothing, risks scare clients", "Potential risks with their likelihood, impact, and your mitigation strategies", "Only risks outside your control", "A disclaimer that nothing is guaranteed"]',
1,
'Including risks with mitigations shows maturity and builds trust. Hiding risks backfires when they materialize.'),

((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 6,
'How should you present costs in a business case?',
'["Hide them at the end", "Break down one-time and ongoing costs, and compare to the value delivered", "Round up significantly for safety", "Only show your fee"]',
1,
'Transparent cost breakdown builds trust. Show all costs but always in context of the value they enable.'),

((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 7,
'What makes a business case compelling for different stakeholders?',
'["Using lots of technical jargon", "Addressing what each stakeholder cares about: executives want ROI, managers want efficiency, users want ease", "Making it as long as possible", "Including every possible detail"]',
1,
'Different stakeholders have different priorities. Tailor sections to address what each group cares about most.'),

((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 8,
'When should you include alternatives in a business case?',
'["Never, it weakens your proposal", "Always, to show you have considered other options and why yours is best", "Only if the client asks", "Only for expensive projects"]',
1,
'Showing alternatives demonstrates thorough thinking and helps stakeholders understand why your approach is optimal.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id, exercise_schema)
SELECT
  m.id,
  'building-business-cases',
  'Building Business Cases',
  3,
  'Intermediate',
  '# Building Business Cases

A business case is your argument for why a project deserves investment. It combines everything you have learned about value and ROI into a document that gets projects approved.

## Definitions

**Business Case**: A document that justifies investment by presenting the problem, proposed solution, costs, benefits, and expected outcomes.

**Executive Summary**: A brief overview at the start that busy decision-makers can read to understand the key points.

**Current State**: Documentation of how things work now, establishing the baseline for improvement.

**Future State**: Description of how things will work after the project is complete.

**SMART Objectives**: Goals that are Specific, Measurable, Achievable, Relevant, and Time-bound.

**Cost-Benefit Analysis**: Comparison of total costs against total benefits to determine net value.

**Risk Mitigation**: Strategies to reduce the likelihood or impact of potential problems.

**Stakeholder**: Anyone affected by or interested in the project outcome.

## Why Business Cases Matter

### For Clients

Clients need business cases to:

- Justify budget allocation to finance or leadership
- Compare your proposal against alternatives
- Set expectations for what success looks like
- Have documentation for internal approval processes
- Reference during and after the project

### For You

Business cases help you:

- Clarify scope and expectations before starting
- Establish the value baseline for pricing discussions
- Create a reference point for scope management
- Demonstrate professionalism and thoroughness
- Differentiate from competitors who just quote prices

**A strong business case sells the project before you quote a price.**

## Business Case Structure

### 1. Executive Summary

Write this last but put it first.

**Include:**
- The problem in one sentence
- Your recommendation in one sentence
- Headline ROI and payback period
- Investment required
- Key benefits in bullet points

**Example:**

*Your team spends 25 hours per week on manual invoice processing, costing 32,500 pounds annually with an 8% error rate.*

*Recommendation: Implement automated invoice processing for a one-time investment of 12,000 pounds.*

*Expected Results:*
- *First-year ROI: 210%*
- *Payback period: 5 months*
- *Annual savings: 37,200 pounds*
- *Error reduction: 95%*

**Keep it under one page. Decision-makers read this first and sometimes only this.**

### 2. Problem Statement

Document the current pain clearly and specifically.

**Include:**
- What is happening now
- Who is affected
- What it costs (time, money, risk)
- Why it matters
- What happens if nothing changes

**Example:**

*Current Situation:*

*The accounts team manually processes approximately 200 invoices per month. Each invoice requires 7-8 minutes of manual data entry across three systems. With 4 team members sharing this workload, the process consumes 25 hours per week collectively.*

*The manual process creates several problems:*
- *8% error rate requiring correction and reconciliation*
- *Average 3-day processing delay affecting supplier relationships*
- *Month-end bottleneck requiring overtime*
- *Staff frustration and turnover risk*

*Annual cost of current state: 32,500 pounds in direct labor plus 4,800 pounds in error correction.*

**Use their numbers. Specific beats vague.**

### 3. Objectives

Define what success looks like using SMART criteria.

**SMART Objectives:**
- **Specific**: Clear, not vague
- **Measurable**: Has numbers you can track
- **Achievable**: Realistic given constraints
- **Relevant**: Matters to the business
- **Time-bound**: Has a deadline

**Example:**

*Project Objectives:*

*1. Reduce invoice processing time from 7 minutes to under 1 minute per invoice within 60 days of deployment.*

*2. Decrease error rate from 8% to under 1% within 30 days of deployment.*

*3. Eliminate manual data entry for 90% of invoices by end of Q2.*

*4. Reduce month-end processing overtime to zero within 90 days.*

**Each objective should be verifiable. At project end, you can prove success.**

### 4. Proposed Solution

Describe what you will build and how it solves the problem.

**Include:**
- High-level solution description
- How it addresses each problem
- What the user experience will be
- Key features and capabilities
- What is not included (scope boundaries)

**Example:**

*Proposed Solution: Automated Invoice Processing System*

*The solution will automatically capture invoice data from email attachments and uploaded files using optical character recognition. Validated data will flow directly into the accounting system with human review required only for exceptions.*

*Key Components:*
- *Email monitoring for invoice attachments*
- *OCR extraction of invoice data*
- *Validation against vendor database*
- *Automatic posting to accounting system*
- *Exception queue for human review*
- *Dashboard for processing status*

*What Is Not Included:*
- *Changes to the accounting system itself*
- *Vendor portal for direct invoice submission*
- *Integration with payment processing*

**Be clear about boundaries. This prevents scope creep.**

### 5. Benefits Analysis

Detail the value the solution will deliver.

**Quantitative Benefits (with calculations):**

*Time Savings:*
- *Current: 25 hours per week at 25 pounds per hour*
- *Future: 5 hours per week*
- *Savings: 20 hours per week*
- *Annual value: 20 x 52 x 25 = 26,000 pounds*

*Error Reduction:*
- *Current: 8% error rate on 200 invoices*
- *Error correction cost: 50 pounds per error*
- *Annual error cost: 16 x 12 x 50 = 9,600 pounds*
- *95% reduction: 9,120 pounds saved*

*Overtime Elimination:*
- *Current: 20 hours overtime per month at 37.50 pounds*
- *Annual cost: 9,000 pounds*
- *Elimination: 9,000 pounds saved*

*Total Quantified Annual Benefit: 44,120 pounds*

**Qualitative Benefits:**

- *Improved supplier relationships through faster processing*
- *Reduced staff frustration and turnover risk*
- *Better month-end close process*
- *Audit-ready documentation*

**Show your math. Verifiable numbers build trust.**

### 6. Cost Analysis

Be transparent about all costs.

**One-Time Costs:**
- *Solution development: 12,000 pounds*
- *Training: Included*
- *Data migration: Included*

**Ongoing Costs:**
- *Software subscriptions: 200 pounds per month*
- *Maintenance and support: 1,200 pounds per year*

**Total First Year Cost: 14,600 pounds**
**Total Ongoing Annual Cost: 3,600 pounds**

**Include everything. Hidden costs destroy trust when discovered later.**

### 7. ROI and Payback

Present the financial case clearly.

*Investment Summary:*

*First Year:*
- *Total investment: 14,600 pounds*
- *Total benefit: 44,120 pounds*
- *Net benefit: 29,520 pounds*
- *ROI: 202%*
- *Payback period: 4.0 months*

*Years 2-5:*
- *Annual investment: 3,600 pounds*
- *Annual benefit: 44,120 pounds*
- *Annual net benefit: 40,520 pounds*

*5-Year Total:*
- *Total investment: 29,000 pounds*
- *Total benefit: 220,600 pounds*
- *Net benefit: 191,600 pounds*
- *5-Year ROI: 661%*

**Show multiple timeframes. Some stakeholders think short-term, others long-term.**

### 8. Risk Analysis

Address risks proactively.

**Format each risk as:**
- Risk description
- Likelihood (Low/Medium/High)
- Impact (Low/Medium/High)
- Mitigation strategy

**Example:**

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| OCR accuracy below target | Medium | Medium | Include manual review queue; train on actual invoices before launch |
| User adoption resistance | Low | Medium | Involve team in design; provide thorough training; highlight time savings |
| Integration complexity | Low | High | Conduct technical discovery before commitment; phase implementation |
| Vendor changes invoice format | Medium | Low | Build flexible extraction; include format update in maintenance |

**Showing risks with mitigations demonstrates maturity. Hiding risks backfires.**

### 9. Implementation Timeline

Outline the project phases and milestones.

*Phase 1: Discovery and Design (Weeks 1-2)*
- *Document current process in detail*
- *Design solution architecture*
- *Confirm integration requirements*
- *Milestone: Design approval*

*Phase 2: Development (Weeks 3-5)*
- *Build extraction pipeline*
- *Develop validation logic*
- *Create exception handling*
- *Milestone: Working prototype*

*Phase 3: Testing (Week 6)*
- *Test with historical invoices*
- *User acceptance testing*
- *Performance validation*
- *Milestone: Testing complete*

*Phase 4: Deployment (Week 7)*
- *Deploy to production*
- *Train users*
- *Monitor and adjust*
- *Milestone: Go-live*

*Phase 5: Optimization (Weeks 8-10)*
- *Monitor performance*
- *Fine-tune accuracy*
- *Document final process*
- *Milestone: Project complete*

**Milestones create checkpoints for progress review.**

### 10. Recommendation

Close with a clear call to action.

*Recommendation:*

*Based on this analysis, we recommend proceeding with the automated invoice processing project. The investment of 12,000 pounds will deliver 202% first-year ROI with payback in 4 months. Beyond the financial returns, the solution eliminates a significant source of team frustration and positions the accounts function for growth without additional headcount.*

*Next Steps:*
1. *Review and approve this business case*
2. *Schedule kickoff meeting for week of [date]*
3. *Provide access to current systems for discovery*

*We are prepared to begin immediately upon approval.*

**End with confidence. Make it easy to say yes.**

## Tailoring for Stakeholders

Different readers care about different things.

**Executives:**
- Lead with ROI and strategic impact
- Keep it brief
- Focus on business outcomes
- Minimize technical detail

**Finance:**
- Detailed cost breakdown
- Conservative assumptions
- Cash flow implications
- Comparison to alternatives

**Operations Managers:**
- Process improvement details
- Impact on team workload
- Implementation timeline
- Training requirements

**Technical Stakeholders:**
- Integration requirements
- Technical approach
- System dependencies
- Maintenance needs

**Write sections that each stakeholder can focus on.**

## Common Mistakes

### Too Long

Business cases should be comprehensive but not exhaustive. 5-10 pages is usually sufficient. Use appendices for supporting detail.

### Too Technical

Focus on business outcomes. Technical details belong in a separate technical specification if needed.

### Weak Problem Statement

If the problem is not compelling, the solution will not seem valuable. Spend time documenting the real pain.

### Missing Alternatives

Not including alternatives suggests you have not thought it through. Show why your approach is better than doing nothing, doing it manually, or using a competitor.

### Vague Benefits

"Improved efficiency" is not a benefit. "26,000 pounds annual savings from 20 hours per week time reduction" is a benefit.

### Hidden Costs

Discovering costs later destroys trust. Include everything upfront, even if it makes the total higher.

## Quick Summary

- Business cases justify investment through clear problem, solution, costs, and benefits.
- Lead with executive summary containing headline ROI.
- Use SMART objectives that can be verified at project end.
- Show your calculations and include risk mitigations.

## Operator Principles

- Build business cases that make approval easy for decision-makers.
- Use client numbers and client language, not your technical terms.
- Address all stakeholders, not just your direct contact.
- Be transparent about costs and risks to build trust.',

  '## Exercise: Build a Complete Business Case

**Timebox: 60 minutes | Stretch: 120 minutes**

Create a business case document for a real or hypothetical client project.

### Scenario

A mid-sized law firm with 25 solicitors and 15 support staff contacts you about document automation. Through discovery, you learn:

**Current Situation:**
- Support staff spend approximately 4 hours daily creating legal documents from templates
- 15 support staff means 60 hours per day on document creation
- Documents include contracts, letters, and court filings
- Current process: Open template, manually fill client details, check for errors, save, and send for review
- Error rate: Approximately 5% of documents have errors caught in review
- Each error takes 30 minutes to identify and correct
- Support staff fully loaded cost: 22 pounds per hour
- Senior solicitor review time: 15 minutes per document at 85 pounds per hour
- Volume: Approximately 80 documents per day
- Compliance requirement: All documents must be logged and traceable

**Pain Points:**
- Staff frustrated with repetitive work
- Solicitors complain about review burden
- Occasional errors reach clients causing embarrassment
- Month-end and quarter-end create backlogs
- Two support staff planning to leave citing boring work

**Your Proposed Solution:**
- Automated document generation from matter management system
- Template library with merge fields
- Automatic logging and version control
- Review workflow with tracked changes
- Estimated project cost: 25,000 pounds
- Ongoing costs: 400 pounds per month

### Part 1: Executive Summary

Write a compelling executive summary including problem statement, recommendation, headline ROI, and key benefits.

### Part 2: Problem Statement

Document the current state with specific numbers and pain points.

### Part 3: SMART Objectives

Define measurable success criteria for the project.

### Part 4: Benefits Analysis

Calculate quantified benefits showing your math.

### Part 5: Risk Analysis

Identify key risks with likelihood, impact, and mitigations.

### Part 6: ROI Summary

Calculate ROI and payback period for conservative, expected, and optimistic scenarios.

### Deliverables

Executive summary. Problem statement. SMART objectives. Quantified benefits with calculations. Risk analysis table. ROI summary with scenarios.',

  45,
  true,
  (SELECT id FROM quizzes WHERE title = 'Business Case Quiz'),
  '{
    "parts": [
      {
        "id": "part1",
        "title": "Part 1: Executive Summary",
        "description": "Write compelling executive summary.",
        "fields": [
          {
            "id": "executive_summary",
            "type": "textarea",
            "label": "Executive summary:",
            "placeholder": "Problem: Your support team spends 60 hours daily on manual document creation, costing over 280,000 pounds annually with a 5% error rate that affects client perception.\n\nRecommendation: Implement automated document generation for a one-time investment of 25,000 pounds plus 4,800 pounds annually.\n\nExpected Results:\n- First-year ROI: 340%\n- Payback period: 2.5 months\n- Annual savings: 115,000+ pounds\n- Error reduction: 90%\n- Staff retention improvement\n\nThis investment eliminates repetitive work, reduces errors, and frees your team for higher-value activities.",
            "required": true,
            "rows": 16
          }
        ]
      },
      {
        "id": "part2",
        "title": "Part 2: Problem Statement",
        "description": "Document current state with specific numbers.",
        "fields": [
          {
            "id": "problem_statement",
            "type": "textarea",
            "label": "Problem statement:",
            "placeholder": "Current Situation:\n\nYour 15 support staff spend approximately 4 hours daily creating legal documents manually, totaling 60 hours per day or 300 hours per week of repetitive document work.\n\nThe manual process involves:\n- Opening Word templates\n- Copying client information from matter management system\n- Manually filling merge fields\n- Checking for errors\n- Saving with correct naming convention\n- Routing for solicitor review\n\nThis creates several problems:\n\n1. Direct Labor Cost: 60 hours/day x 22/hour x 250 days = 330,000 pounds annually\n\n2. Error Rate: 5% of 80 documents = 4 errors daily\n   Error correction: 4 x 30 min x 22/hour x 250 days = 11,000 pounds annually\n   \n3. Review Burden: 80 docs x 15 min x 85/hour = 1,700 pounds daily\n   Annual review cost: 425,000 pounds\n\n4. Staff Turnover: Two staff leaving citing boring work\n   Recruitment cost per staff: 5,000 pounds\n   Training time: 3 months reduced productivity\n\n5. Compliance Risk: Manual logging creates audit vulnerabilities",
            "required": true,
            "rows": 28
          }
        ]
      },
      {
        "id": "part3",
        "title": "Part 3: SMART Objectives",
        "description": "Define measurable success criteria.",
        "fields": [
          {
            "id": "smart_objectives",
            "type": "textarea",
            "label": "SMART objectives:",
            "placeholder": "Project Objectives:\n\n1. Reduce document creation time from 45 minutes average to under 5 minutes within 60 days of deployment.\n   - Specific: Time reduction target\n   - Measurable: 45 min to 5 min\n   - Achievable: Automation enables this\n   - Relevant: Core pain point\n   - Time-bound: 60 days post-deployment\n\n2. Decrease document error rate from 5% to under 0.5% within 30 days of deployment.\n   - Automation eliminates manual entry errors\n   - Measurable through review tracking\n\n3. Reduce solicitor review time from 15 minutes to 5 minutes per document within 90 days.\n   - Consistent templates reduce review burden\n   - Tracked changes highlight modifications\n\n4. Achieve 100% compliance logging with zero manual effort by project completion.\n   - All documents automatically logged\n   - Audit trail complete\n\n5. Improve support staff satisfaction score from 3.2 to 4.0+ within 6 months.\n   - Measured via quarterly survey\n   - Addresses turnover risk",
            "required": true,
            "rows": 28
          }
        ]
      },
      {
        "id": "part4",
        "title": "Part 4: Benefits Analysis",
        "description": "Calculate quantified benefits.",
        "fields": [
          {
            "id": "benefits_analysis",
            "type": "textarea",
            "label": "Quantified benefits with calculations:",
            "placeholder": "QUANTIFIED BENEFITS:\n\n1. Document Creation Time Savings\n   Current: 60 hours/day on document creation\n   Future: 10 hours/day (83% reduction)\n   Savings: 50 hours/day\n   Annual: 50 x 250 x 22 = 275,000 pounds\n   Conservative (70%): 192,500 pounds\n\n2. Error Correction Savings\n   Current: 4 errors/day x 30 min x 22/hr\n   Annual error cost: 11,000 pounds\n   90% reduction: 9,900 pounds\n   Conservative (70%): 6,930 pounds\n\n3. Solicitor Review Time Savings\n   Current: 80 docs x 15 min = 20 hours/day\n   Future: 80 docs x 5 min = 6.7 hours/day\n   Savings: 13.3 hours/day at 85/hr\n   Annual: 13.3 x 250 x 85 = 282,875 pounds\n   Conservative (50%): 141,438 pounds\n\n4. Staff Retention\n   Avoid 2 replacements: 10,000 pounds\n   Training productivity: 15,000 pounds\n   Conservative: 12,500 pounds\n\nTOTAL CONSERVATIVE ANNUAL BENEFIT: 353,368 pounds\n\nQUALITATIVE BENEFITS:\n- Improved client perception (fewer errors)\n- Better staff morale\n- Compliance confidence\n- Capacity for growth without hiring",
            "required": true,
            "rows": 34
          }
        ]
      },
      {
        "id": "part5",
        "title": "Part 5: Risk Analysis",
        "description": "Identify risks with mitigations.",
        "fields": [
          {
            "id": "risk_analysis",
            "type": "textarea",
            "label": "Risk analysis table:",
            "placeholder": "| Risk | Likelihood | Impact | Mitigation |\n|------|------------|--------|------------|\n| User adoption resistance | Medium | High | Involve staff in template design; provide comprehensive training; emphasize time savings and elimination of boring work |\n| Template complexity | Medium | Medium | Start with highest-volume templates; iterate based on feedback; build template library incrementally |\n| Integration with matter management | Low | High | Conduct technical discovery before commitment; confirm API availability; include integration testing phase |\n| Document format variations | Medium | Low | Design flexible template system; include exception handling for non-standard documents |\n| Data quality in source system | Medium | Medium | Include validation rules; flag incomplete records for review; clean data during implementation |\n| Scope creep to other departments | High | Medium | Define clear boundaries in contract; offer phase 2 for expansion; document out-of-scope requests |",
            "required": true,
            "rows": 16
          }
        ]
      },
      {
        "id": "part6",
        "title": "Part 6: ROI Summary",
        "description": "Calculate ROI and payback with scenarios.",
        "fields": [
          {
            "id": "roi_summary",
            "type": "textarea",
            "label": "ROI summary with scenarios:",
            "placeholder": "INVESTMENT:\nOne-time cost: 25,000 pounds\nFirst year ongoing: 4,800 pounds\nTotal first year: 29,800 pounds\n\nSCENARIO ANALYSIS:\n\nConservative (50% of benefits):\n- Annual benefit: 176,684 pounds\n- First-year net: 146,884 pounds\n- ROI: (176,684 - 29,800) / 29,800 = 493%\n- Payback: 29,800 / (176,684/12) = 2.0 months\n\nExpected (70% of benefits):\n- Annual benefit: 247,358 pounds\n- First-year net: 217,558 pounds\n- ROI: 730%\n- Payback: 1.4 months\n\nOptimistic (90% of benefits):\n- Annual benefit: 318,031 pounds\n- First-year net: 288,231 pounds\n- ROI: 967%\n- Payback: 1.1 months\n\n5-YEAR PROJECTION (Expected):\n- Total investment: 29,800 + (4 x 4,800) = 49,000 pounds\n- Total benefit: 247,358 x 5 = 1,236,790 pounds\n- Net benefit: 1,187,790 pounds\n- 5-Year ROI: 2,424%\n\nRECOMMENDATION:\nEven in the most conservative scenario, this project pays for itself in 2 months and delivers nearly 500% first-year ROI. We recommend immediate approval.",
            "required": true,
            "rows": 34
          }
        ]
      }
    ],
    "deliverables": [
      "Executive summary with headline ROI",
      "Detailed problem statement with numbers",
      "SMART objectives for measurement",
      "Quantified benefits with calculations shown",
      "Risk analysis table with mitigations",
      "Multi-scenario ROI summary"
    ],
    "success_criteria": [
      "Executive summary is under one page and compelling",
      "Problem statement uses specific client numbers",
      "Objectives are truly SMART",
      "Benefits math is correct and verifiable",
      "Risks include realistic mitigations",
      "ROI scenarios show range of outcomes"
    ]
  }'
FROM modules m WHERE m.slug = 'business-value-roi';
