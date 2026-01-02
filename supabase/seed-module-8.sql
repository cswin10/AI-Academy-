-- ============================================================================
-- MODULE 8: Business Value & ROI
-- ============================================================================

-- Insert Module 8
INSERT INTO modules (track_id, slug, title, short_description, order_index, estimated_hours, level, xp_reward, is_active)
SELECT
  id,
  'business-value-roi',
  'Business Value & ROI',
  'Learn to quantify business value, calculate ROI, build compelling business cases, price your services effectively, and grow long-term client relationships.',
  8,
  5,
  'Intermediate',
  50,
  true
FROM tracks WHERE slug = 'core-foundation';

-- Create quizzes for Module 8
INSERT INTO quizzes (title, description, difficulty, passing_score, xp_reward) VALUES
('Business Value Quiz', 'Test your understanding of business value concepts', 'intermediate', 75, 15),
('ROI Calculation Quiz', 'Test your knowledge of ROI calculations', 'intermediate', 75, 15),
('Business Case Quiz', 'Test your understanding of building business cases', 'intermediate', 75, 15),
('Pricing Quiz', 'Test your knowledge of pricing strategies', 'intermediate', 75, 15),
('Long-term Value Quiz', 'Test your understanding of client growth', 'intermediate', 75, 15);

-- ============================================================================
-- SECTION 8.1: Understanding Business Value
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Business Value Quiz'), 1,
'What is the difference between features and business value?',
'["They are the same thing", "Features are what you build; business value is the outcome the client gets", "Business value is more technical", "Features are more important"]',
1,
'Clients pay for outcomes, not outputs. Features are the means; business value is the end result.'),

((SELECT id FROM quizzes WHERE title = 'Business Value Quiz'), 2,
'Which type of value is easiest to quantify?',
'["Strategic advantage", "Time savings", "Employee satisfaction", "Brand perception"]',
1,
'Time savings convert directly to money. Hours saved multiplied by hourly cost gives a clear number.'),

((SELECT id FROM quizzes WHERE title = 'Business Value Quiz'), 3,
'What does "value hierarchy" mean in the context of automation?',
'["A ranking of your best clients", "Different types of value from basic efficiency to strategic advantage", "The order in which to build features", "Pricing tiers"]',
1,
'Value hierarchy ranks outcomes from basic (time savings) to advanced (strategic advantage). Higher levels justify higher prices.'),

((SELECT id FROM quizzes WHERE title = 'Business Value Quiz'), 4,
'Why should you focus on outcomes rather than outputs when discussing value?',
'["Outputs are harder to explain", "Clients care about what changes for their business, not the technical details", "Outcomes are easier to build", "Outputs are not measurable"]',
1,
'A client does not buy an automation. They buy fewer errors, faster response times, or freed-up staff hours.'),

((SELECT id FROM quizzes WHERE title = 'Business Value Quiz'), 5,
'What is risk mitigation value?',
'["Avoiding project risks", "The value of preventing costly errors, compliance failures, or security breaches", "Insurance for your services", "A pricing strategy"]',
1,
'Some automations prevent bad outcomes. The value is avoiding the cost of those outcomes, not just saving time.'),

((SELECT id FROM quizzes WHERE title = 'Business Value Quiz'), 6,
'How do you quantify the value of error reduction?',
'["Count the errors", "Calculate average cost per error multiplied by errors prevented", "Ask the client to guess", "Errors cannot be quantified"]',
1,
'Error cost includes time to fix, customer impact, and downstream consequences. Multiply by frequency to get total value.'),

((SELECT id FROM quizzes WHERE title = 'Business Value Quiz'), 7,
'What is capacity value?',
'["Server capacity", "The ability to handle more volume without adding staff", "Storage space", "How much you can charge"]',
1,
'Capacity value means the business can grow without proportional cost increases. Handle 10x leads with the same team.'),

((SELECT id FROM quizzes WHERE title = 'Business Value Quiz'), 8,
'When discussing value with a client, what should you lead with?',
'["Your hourly rate", "Technical specifications", "Their problem and the business outcome you will deliver", "A list of features"]',
1,
'Lead with their pain and the outcome. Technical details come later once they understand the value.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id, exercise_schema)
SELECT
  m.id,
  'understanding-business-value',
  'Understanding Business Value',
  1,
  'Intermediate',
  '# Understanding Business Value

Clients do not buy automations. They buy outcomes. Understanding this changes how you scope, price, and sell your work.

## Definitions

**Business Value**: The measurable benefit a client receives from your work, expressed in terms they care about.

**Outcome**: The change in the client''s situation after your work is complete. What improves for them.

**Output**: What you deliver. The automation, the integration, the workflow.

**Value Hierarchy**: A ranking of value types from basic efficiency gains to strategic competitive advantage.

**Quantified Value**: Business value expressed as a specific number, usually in currency or time.

**Soft Value**: Benefits that are real but harder to measure, like reduced stress or improved morale.

**Hard Value**: Benefits that translate directly to money, like hours saved or errors prevented.

## Outcomes vs Outputs

**The fundamental shift.**

You build an automation that syncs data between two systems. That is the output.

The client gets 15 hours per week back, zero data entry errors, and real-time visibility into their pipeline. That is the outcome.

Clients pay for outcomes. They do not care about the technical details. They care about what changes for their business.

**Example conversation shift.**

Bad framing: "I will build a automation that triggers on form submission, creates a CRM record, and sends a Slack notification."

Good framing: "Your team will respond to every lead within 2 minutes instead of 2 hours. You will capture 100% of leads instead of losing 20% to inbox chaos. Your sales team gets 4 hours per day back to actually sell."

Same project. Completely different perceived value.

## The Value Hierarchy

Not all value is equal. Higher levels justify higher prices.

**Level 1: Time Savings.** The most basic value. Hours saved multiplied by cost per hour. Easy to calculate but often undervalued.

**Level 2: Error Reduction.** Preventing mistakes that cost money. Typos in orders, missed deadlines, wrong data. Each error has a cost; preventing them has value.

**Level 3: Capacity Increase.** Handling more volume without adding staff. Process 10x the leads with the same team. Serve more customers without hiring.

**Level 4: Speed Improvement.** Faster response times, quicker turnaround, reduced delays. Speed often has direct revenue impact.

**Level 5: Risk Mitigation.** Preventing compliance failures, security breaches, or costly mistakes. The value is avoiding the downside.

**Level 6: Strategic Advantage.** Enabling things competitors cannot do. New business models, market expansion, competitive differentiation.

**Real-world example: Lead response automation.**

Level 1 value: Save 4 hours per day on manual data entry.

Level 2 value: Eliminate copy-paste errors that caused 3 lost deals last quarter.

Level 3 value: Handle 5x more leads without hiring additional sales staff.

Level 4 value: Respond in 2 minutes instead of 2 hours, increasing close rate by 15%.

Level 5 value: Ensure every lead gets logged for compliance audit trail.

Level 6 value: Personalized instant response that competitors cannot match.

Same automation. Six different ways to describe the value. Higher levels justify higher prices.

## Types of Business Value

### Time Savings

The most common and easiest to calculate.

**Formula.** Hours saved per week multiplied by weeks per year multiplied by hourly cost.

**Example.** Save 10 hours per week. Employee costs 30 pounds per hour fully loaded. Annual value is 10 times 52 times 30, which equals 15,600 pounds.

**Key insight.** Always use fully loaded cost, not just salary. Include benefits, overhead, and management time.

### Error Reduction

Errors cost more than people think.

**Error cost components.** Time to identify the error. Time to fix the error. Impact on customers or downstream processes. Management time dealing with fallout. Reputation damage.

**Example.** Data entry errors cause 5 order mistakes per month. Each mistake costs 200 pounds to fix and loses 50 pounds in customer goodwill. Monthly error cost is 5 times 250, which equals 1,250 pounds. Annual value of eliminating errors is 15,000 pounds.

### Capacity and Scale

Growth without proportional cost.

**Example.** Currently process 100 orders per day with 2 staff. Automation enables 500 orders per day with same 2 staff. Value is the cost of 8 additional staff you did not have to hire.

### Speed and Responsiveness

Faster often means more revenue.

**Example.** Lead response time drops from 2 hours to 2 minutes. Industry data shows response within 5 minutes is 21x more likely to convert. If you process 50 leads per month and average deal is 5,000 pounds, even a 10% improvement in conversion adds 25,000 pounds annually.

### Risk Mitigation

What is the cost of the bad thing happening?

**Example.** Manual process risks compliance violation. Fine for violation is 50,000 pounds. Automation ensures 100% compliance. Value is weighted by probability: if 10% chance of violation per year, expected value is 5,000 pounds annually plus avoiding the operational disruption.

### Strategic Value

Hardest to quantify but often most valuable.

**Questions to uncover strategic value.** What could you do that you cannot do now? What would this enable for your business? How does this change your competitive position?

## Discovering Value

### Questions That Uncover Value

**About the problem.** What is this costing you right now? How much time does your team spend on this? What happens when errors occur? What opportunities are you missing?

**About the outcome.** What would ideal look like? If this worked perfectly, what would change? How would you measure success? What is this worth to you?

**About constraints.** What have you tried before? Why did it not work? What would make this fail?

### The Value Discovery Conversation

Start broad, then get specific.

"Tell me about the problem you are trying to solve."

"What is happening now that you want to change?"

"How much time does your team spend on this each week?"

"What happens when things go wrong?"

"If we solved this completely, what would that be worth to your business?"

Document specific numbers. Time spent, error rates, volume, cost per error, revenue impact. These become your value calculation inputs.

## Communicating Value

### Lead With Outcomes

**Bad.** "I will build a 15-step automation with 3 integrations."

**Good.** "Your team will save 20 hours per week and eliminate the errors that cost you 3 deals last quarter."

### Use Their Numbers

**Bad.** "This will save you time."

**Good.** "Based on your team spending 4 hours daily at a loaded cost of 35 pounds per hour, this saves 36,400 pounds annually."

### Compare to Alternatives

**Bad.** "My fee is 5,000 pounds."

**Good.** "This investment of 5,000 pounds replaces a solution that would cost 15,000 pounds annually in staff time, with payback in 7 weeks."

## Quick Summary

- Clients buy outcomes, not outputs. Lead with what changes for them.
- Higher levels of value hierarchy justify higher prices.
- Quantify value with their numbers whenever possible.

## Operator Principles

- Discover the business outcome before proposing a solution.
- Quantify value in terms the client already measures.
- Frame your work as an investment with returns, not a cost.
- Move up the value hierarchy to justify premium pricing.',

  '## Exercise: Value Discovery and Quantification

**Timebox: 45 minutes | Stretch: 90 minutes**

Practice identifying and quantifying business value for a client scenario.

### Scenario

A recruitment agency contacts you. They say: "We need help with our candidate tracking. It is a mess."

Through discovery, you learn:

The agency places about 40 candidates per month. Each placement averages 8,000 pounds in fees. They have 4 recruiters who each spend about 6 hours per week on manual admin: updating spreadsheets, sending status emails, copying data between systems. They estimate they lose about 2 placements per month because candidates fall through the cracks or get poached by faster competitors. Their average response time to new candidate applications is 2 days. Competitors respond same-day. The recruiters are paid 45,000 pounds per year each, plus about 30% overhead.

### Part 1: Calculate Time Savings Value

Calculate the annual value of time saved if you eliminate the manual admin work.

### Part 2: Calculate Error and Lost Opportunity Value

Calculate the annual value of the 2 lost placements per month.

### Part 3: Calculate Speed Value

Estimate the value of responding same-day instead of 2 days.

### Part 4: Identify Higher-Level Value

List strategic or capacity value this automation could provide.

### Part 5: Write Value Summary

Write a value summary you would present to this client.

### Deliverables

Time savings calculation. Lost opportunity calculation. Speed value estimate. Higher-level value list. Client-ready value summary.',

  30,
  true,
  (SELECT id FROM quizzes WHERE title = 'Business Value Quiz'),
  '{
    "parts": [
      {
        "id": "part1",
        "title": "Part 1: Time Savings Value",
        "description": "Calculate annual value of eliminated admin work.",
        "fields": [
          {
            "id": "time_calculation",
            "type": "textarea",
            "label": "Time savings calculation:",
            "placeholder": "Hours per recruiter per week: 6\nNumber of recruiters: 4\nTotal hours per week: 24\nWeeks per year: 52\nTotal hours per year: 1,248\n\nRecruiter salary: 45,000\nWith 30% overhead: 58,500\nHourly cost: 58,500 / 1,880 = 31.12\n\nAnnual time savings value:\n1,248 hours x 31.12 = 38,838 pounds",
            "required": true,
            "rows": 12
          }
        ]
      },
      {
        "id": "part2",
        "title": "Part 2: Lost Opportunity Value",
        "description": "Calculate value of preventing lost placements.",
        "fields": [
          {
            "id": "opportunity_calculation",
            "type": "textarea",
            "label": "Lost placement calculation:",
            "placeholder": "Lost placements per month: 2\nLost placements per year: 24\nRevenue per placement: 8,000\n\nAnnual lost revenue: 24 x 8,000 = 192,000 pounds\n\nNote: Even capturing 50% of these losses = 96,000 pounds",
            "required": true,
            "rows": 10
          }
        ]
      },
      {
        "id": "part3",
        "title": "Part 3: Speed Value",
        "description": "Estimate value of faster response times.",
        "fields": [
          {
            "id": "speed_calculation",
            "type": "textarea",
            "label": "Speed improvement value estimate:",
            "placeholder": "Current response time: 2 days\nTarget response time: Same day\n\nIndustry research suggests faster response improves candidate engagement significantly.\n\nConservative estimate: 5% improvement in placement rate\nCurrent placements: 40/month = 480/year\n5% improvement: 24 additional placements\nValue: 24 x 8,000 = 192,000 pounds\n\nEven 2% improvement = 76,800 pounds",
            "required": true,
            "rows": 12
          }
        ]
      },
      {
        "id": "part4",
        "title": "Part 4: Higher-Level Value",
        "description": "Identify strategic and capacity value.",
        "fields": [
          {
            "id": "strategic_value",
            "type": "textarea",
            "label": "Strategic and capacity value:",
            "placeholder": "Capacity Value:\n- Handle 2x candidate volume without adding recruiters\n- Scale to 80+ placements/month with same team\n- Cost of additional recruiter avoided: 58,500/year\n\nStrategic Value:\n- Faster than competitors = win more candidates\n- Better candidate experience = referrals\n- Data for better decision-making\n- Ability to expand into new markets",
            "required": true,
            "rows": 12
          }
        ]
      },
      {
        "id": "part5",
        "title": "Part 5: Value Summary",
        "description": "Write client-ready value summary.",
        "fields": [
          {
            "id": "value_summary",
            "type": "textarea",
            "label": "Value summary for client:",
            "placeholder": "Based on our conversation, here is the value this automation would deliver:\n\nDirect Time Savings: 38,838 pounds annually\nYour recruiters spend 24 hours per week on admin. This gives them that time back to place candidates.\n\nRecovered Revenue: Up to 192,000 pounds annually\nYou estimate losing 2 placements per month to process gaps. Even recovering half of these adds 96,000 pounds.\n\nSpeed Advantage: Estimated 76,000+ pounds annually\nResponding same-day instead of 2 days improves your win rate against competitors.\n\nTotal Quantified Value: 200,000+ pounds annually\n\nAdditionally, you gain capacity to scale without hiring, competitive differentiation, and better data for decisions.\n\nRecommended Investment: [Your fee]\nPayback Period: [Weeks to recover investment]",
            "required": true,
            "rows": 24
          }
        ]
      }
    ],
    "deliverables": [
      "Time savings calculation with math shown",
      "Lost opportunity value calculation",
      "Speed value estimate with reasoning",
      "Higher-level value identification",
      "Client-ready value summary"
    ],
    "success_criteria": [
      "Calculations use provided numbers correctly",
      "Multiple value types identified",
      "Summary leads with outcomes not features",
      "Value expressed in client terms"
    ]
  }'
FROM modules m WHERE m.slug = 'business-value-roi';


-- ============================================================================
-- SECTION 8.2: Calculating ROI
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'ROI Calculation Quiz'), 1,
'What is the basic ROI formula?',
'["Revenue minus cost", "(Gain minus Cost) divided by Cost, expressed as percentage", "Profit divided by revenue", "Value times time"]',
1,
'ROI shows return relative to investment. A 200% ROI means you get back twice what you invested.'),

((SELECT id FROM quizzes WHERE title = 'ROI Calculation Quiz'), 2,
'What is payback period?',
'["How long until the client pays you", "Time required for benefits to exceed the initial investment", "The project timeline", "When the contract ends"]',
1,
'Payback period answers: how long until this pays for itself? Shorter payback means lower risk.'),

((SELECT id FROM quizzes WHERE title = 'ROI Calculation Quiz'), 3,
'Why should you use "fully loaded" employee costs in ROI calculations?',
'["To inflate the numbers", "Because salary alone understates true cost by 25-40%", "Clients prefer bigger numbers", "It is an accounting requirement"]',
1,
'Fully loaded cost includes salary, benefits, taxes, equipment, management overhead. This is the true cost of that time.'),

((SELECT id FROM quizzes WHERE title = 'ROI Calculation Quiz'), 4,
'What is a conservative estimate and why use one?',
'["The lowest possible number to seem humble", "A realistic estimate that accounts for uncertainty and builds credibility", "An estimate for conservative clients", "The first number you calculate"]',
1,
'Conservative estimates account for reality being messier than projections. They build trust and still show compelling value.'),

((SELECT id FROM quizzes WHERE title = 'ROI Calculation Quiz'), 5,
'How do you calculate annual value from weekly time savings?',
'["Multiply by 12", "Hours per week times 52 weeks times hourly cost", "Hours times daily rate", "Estimate based on feeling"]',
1,
'Weekly hours times 52 gives annual hours. Multiply by fully loaded hourly cost for annual value.'),

((SELECT id FROM quizzes WHERE title = 'ROI Calculation Quiz'), 6,
'What hidden costs should you include when calculating current state?',
'["Only direct salary costs", "Management time, error correction, opportunity cost, and tool subscriptions", "Whatever makes the ROI look best", "Hidden costs should not be included"]',
1,
'Hidden costs are real. Management oversight, fixing mistakes, and missed opportunities all have value.'),

((SELECT id FROM quizzes WHERE title = 'ROI Calculation Quiz'), 7,
'If a project costs 10,000 pounds and delivers 50,000 pounds annual value, what is the ROI?',
'["50%", "400%", "500%", "5x"]',
1,
'ROI = (50,000 - 10,000) / 10,000 = 400%. The client gets back 4 pounds for every 1 pound invested.'),

((SELECT id FROM quizzes WHERE title = 'ROI Calculation Quiz'), 8,
'When should you present multiple ROI scenarios?',
'["Never, pick one number", "When there is uncertainty, show conservative, expected, and optimistic cases", "Only for large projects", "When the client asks"]',
1,
'Scenarios show range of outcomes and build credibility. Conservative case shows minimum value; optimistic shows upside.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id, exercise_schema)
SELECT
  m.id,
  'calculating-roi',
  'Calculating ROI',
  2,
  'Intermediate',
  '# Calculating ROI

ROI is the language of business decisions. When you can show clear return on investment, price objections disappear and projects get approved.

## Definitions

**ROI (Return on Investment)**: The percentage return relative to the investment. Calculated as (Gain minus Cost) divided by Cost.

**Payback Period**: The time required for cumulative benefits to equal the initial investment.

**Fully Loaded Cost**: The true cost of an employee including salary, benefits, taxes, equipment, and overhead.

**NPV (Net Present Value)**: The current value of future benefits, accounting for the time value of money.

**Conservative Estimate**: A deliberately cautious projection that accounts for uncertainty.

**Break-even**: The point where total benefits equal total costs.

**Annual Value**: The yearly benefit delivered, used as the baseline for ROI calculations.

**Opportunity Cost**: The value of what could have been done with the time or money instead.

## The Basic ROI Formula

**ROI = (Gain - Cost) / Cost x 100**

**Example.** Project costs 5,000 pounds. Annual benefit is 25,000 pounds.

ROI = (25,000 - 5,000) / 5,000 x 100 = 400%

The client gets 4 pounds back for every 1 pound invested.

**First-year vs multi-year.** For ongoing benefits, specify the timeframe. First-year ROI of 400% is different from 3-year ROI of 1400%.

## Payback Period

How long until the investment pays for itself?

**Formula.** Payback Period = Investment / Monthly Benefit

**Example.** Investment is 5,000 pounds. Monthly benefit is 2,000 pounds.

Payback = 5,000 / 2,000 = 2.5 months

After 2.5 months, everything is profit.

**Why payback matters.** Short payback means low risk. Even if projections are wrong, a 2-month payback is much safer than a 24-month payback.

## Calculating Costs

### Your Project Cost

This is straightforward: what you charge.

Include any additional costs the client incurs: software subscriptions, additional tools, training time, internal resources needed.

### Current State Costs

What does the problem cost them now? This is often larger than clients realize.

**Direct labor costs.** Hours spent on manual tasks times fully loaded hourly rate.

**Fully loaded hourly rate calculation.** Annual salary of 45,000 pounds plus 30% overhead equals 58,500 pounds. Divide by working hours of 1,880 per year. Fully loaded rate is 31.12 pounds per hour.

**Error costs.** Frequency of errors times average cost per error.

**Opportunity costs.** What could that time be used for instead? If salespeople spend 2 hours on admin, that is 2 hours not selling.

**Tool and workaround costs.** Manual processes often require extra tools, spreadsheets, or workarounds.

**Management overhead.** Time supervisors spend on oversight, quality checks, and problem-solving.

## Calculating Benefits

### Time Savings

The most common and easiest to calculate.

**Formula.** Hours saved per week x 52 weeks x Fully loaded hourly rate

**Example.** Save 10 hours per week. Hourly rate is 31 pounds.

Annual value = 10 x 52 x 31 = 16,120 pounds

### Error Reduction

**Formula.** Errors prevented per year x Average cost per error

**Example.** Currently 20 errors per month, costing 150 pounds each to fix.

Annual error cost = 20 x 12 x 150 = 36,000 pounds

If automation eliminates 90% of errors, value is 32,400 pounds.

### Capacity Value

**Formula.** Additional volume handled x Revenue per unit (or cost of additional staff avoided)

**Example.** Automation enables handling 50 additional orders per day. Each order nets 20 pounds.

Annual value = 50 x 250 working days x 20 = 250,000 pounds

### Speed Value

Harder to quantify but often significant.

**Example.** Faster lead response improves conversion by 10%. Current 100 leads per month at 5% conversion with 5,000 pound average deal.

Current: 100 x 5% x 5,000 = 25,000 per month
After: 100 x 5.5% x 5,000 = 27,500 per month
Monthly improvement: 2,500 pounds
Annual value: 30,000 pounds

### Revenue Protection

Value of not losing revenue.

**Example.** Current system has 2% downtime causing lost sales. 1 million annual revenue.

Downtime cost = 1,000,000 x 2% = 20,000 pounds
If automation reduces to 0.5%: Value = 15,000 pounds

## Conservative vs Optimistic Estimates

Always calculate multiple scenarios.

**Conservative.** Assume 50-70% of projected benefits materialize. Use this as your "at minimum" case.

**Expected.** Your realistic projection based on discovery.

**Optimistic.** Full potential if everything goes well.

**Example presentation.**

Conservative (70% of projected): 35,000 pounds annual value
Expected: 50,000 pounds annual value
Optimistic (full potential): 65,000 pounds annual value

At our fee of 8,000 pounds:
Conservative ROI: 337%
Expected ROI: 525%
Optimistic ROI: 712%

Payback period: 2-3 months in all scenarios.

**Why show ranges.** Builds credibility. Shows you understand uncertainty. Client can make informed decision. Even conservative case is compelling.

## Real-World ROI Example

**Client situation.** E-commerce company with manual order processing.

**Current state.**
- 3 staff members process orders
- Each spends 5 hours daily on data entry
- Combined 15 hours per day, 75 hours per week
- Staff cost fully loaded: 28 pounds per hour
- Weekly cost: 75 x 28 = 2,100 pounds
- Annual cost: 109,200 pounds

**Errors.**
- 8 order errors per week
- Each error costs 45 pounds to fix
- Weekly error cost: 360 pounds
- Annual error cost: 18,720 pounds

**Capacity constraint.**
- Currently maxed at 200 orders per day
- Turning away approximately 30 orders per day
- Lost revenue: 30 x 35 profit x 250 days = 262,500 pounds

**Total current state cost: 390,420 pounds annually**

**Proposed solution.**
- Automated order processing
- Project cost: 15,000 pounds

**Projected benefits.**
- Reduce processing time by 80%: Save 87,360 pounds
- Reduce errors by 95%: Save 17,784 pounds
- Handle 50% more volume: Capture 131,250 pounds

**Conservative projection (60% of benefits).**
Annual value: 141,836 pounds
ROI: (141,836 - 15,000) / 15,000 = 846%
Payback: 15,000 / (141,836/12) = 1.3 months

This is the calculation that gets projects approved.

## Presenting ROI

### Structure

Start with the headline. "This project delivers 400% ROI with payback in 6 weeks."

Show current state costs. Use their numbers. Be specific.

Show projected benefits. Break down by category.

Calculate ROI and payback. Show the math.

Present scenarios. Conservative, expected, optimistic.

Address risks. What could reduce benefits? How do you mitigate?

### Common Mistakes

**Inflating numbers.** Destroys credibility. Use conservative estimates.

**Forgetting ongoing costs.** Include software subscriptions, maintenance, updates.

**Ignoring soft benefits.** Mention them but do not over-weight in calculations.

**Not showing your math.** Clients trust calculations they can verify.

## Quick Summary

- ROI formula: (Gain - Cost) / Cost expressed as percentage.
- Use fully loaded costs and conservative estimates.
- Show multiple scenarios to build credibility.

## Operator Principles

- Calculate ROI before proposing price.
- Use conservative estimates that still show compelling value.
- Show your math so clients can verify.
- Present payback period alongside ROI for risk context.',

  '## Exercise: Build an ROI Model

**Timebox: 45 minutes | Stretch: 90 minutes**

Create a complete ROI analysis for a client project.

### Scenario

A property management company manages 150 rental units. They contact you about automating their maintenance request process.

Current situation:
- Tenants email or call with maintenance requests
- Office manager logs requests manually in spreadsheet
- Office manager calls contractors to schedule
- Office manager follows up on completion
- Office manager updates tenants on status

Discovery findings:
- Office manager salary: 35,000 pounds plus 30% overhead
- Spends 3 hours daily on maintenance coordination
- 15 hours per week on this process alone
- Average 40 maintenance requests per month
- 5 requests per month fall through cracks (tenant complaints)
- Each complaint costs 2 hours to resolve plus 50 pound goodwill gesture
- 3 requests per month go to wrong contractor (rework)
- Each rework adds 75 pounds average cost
- Property owners want faster response times
- Considering hiring part-time admin: 18,000 pounds per year

Your proposed solution would cost 8,000 pounds.

### Part 1: Calculate Current Costs

Calculate the fully loaded cost of the current manual process.

### Part 2: Calculate Error Costs

Calculate annual cost of errors and complaints.

### Part 3: Calculate Opportunity Costs

Calculate cost of potential hire and other opportunity costs.

### Part 4: Calculate Projected Benefits

Project benefits of automation with conservative, expected, and optimistic scenarios.

### Part 5: Calculate ROI and Payback

Calculate ROI and payback period for each scenario.

### Part 6: Write ROI Summary

Write the ROI summary you would present to this client.

### Deliverables

Current state cost analysis. Error cost breakdown. Opportunity cost analysis. Benefit projections with scenarios. ROI and payback calculations. Client-ready ROI summary.',

  30,
  true,
  (SELECT id FROM quizzes WHERE title = 'ROI Calculation Quiz'),
  '{
    "parts": [
      {
        "id": "part1",
        "title": "Part 1: Current Labor Costs",
        "description": "Calculate fully loaded cost of manual process.",
        "fields": [
          {
            "id": "labor_calculation",
            "type": "textarea",
            "label": "Current labor cost calculation:",
            "placeholder": "Office manager salary: 35,000\nWith 30% overhead: 45,500\nWorking hours per year: 1,880\nFully loaded hourly rate: 24.20\n\nHours on maintenance per week: 15\nWeeks per year: 52\nAnnual hours: 780\n\nAnnual labor cost: 780 x 24.20 = 18,876 pounds",
            "required": true,
            "rows": 12
          }
        ]
      },
      {
        "id": "part2",
        "title": "Part 2: Error Costs",
        "description": "Calculate annual cost of errors and complaints.",
        "fields": [
          {
            "id": "error_calculation",
            "type": "textarea",
            "label": "Error and complaint cost calculation:",
            "placeholder": "Fallen-through requests: 5 per month x 12 = 60 per year\nResolution time: 2 hours x 24.20 = 48.40\nGoodwill gesture: 50\nCost per complaint: 98.40\nAnnual complaint cost: 60 x 98.40 = 5,904 pounds\n\nWrong contractor rework: 3 per month x 12 = 36 per year\nRework cost: 75 each\nAnnual rework cost: 36 x 75 = 2,700 pounds\n\nTotal error costs: 8,604 pounds",
            "required": true,
            "rows": 14
          }
        ]
      },
      {
        "id": "part3",
        "title": "Part 3: Opportunity Costs",
        "description": "Calculate avoided hire and other opportunity costs.",
        "fields": [
          {
            "id": "opportunity_calculation",
            "type": "textarea",
            "label": "Opportunity cost calculation:",
            "placeholder": "Potential part-time hire avoided: 18,000 pounds\n\nOffice manager time freed for other work:\n15 hours/week on higher-value tasks\nCould handle 20% more properties\nCurrent 150 units, potential 180 units\n30 additional units x 100/month management fee\nPotential additional revenue: 36,000/year\n\nFaster response improves tenant retention\nConservative estimate: Prevent 2 early move-outs\nCost per turnover: 1,500\nValue: 3,000 pounds",
            "required": true,
            "rows": 16
          }
        ]
      },
      {
        "id": "part4",
        "title": "Part 4: Benefit Projections",
        "description": "Project benefits across scenarios.",
        "fields": [
          {
            "id": "benefit_projections",
            "type": "textarea",
            "label": "Benefit projections by scenario:",
            "placeholder": "Potential Annual Benefits:\n- Labor time savings: 18,876\n- Error reduction: 8,604\n- Avoided hire: 18,000\n- Capacity for growth: 36,000\n- Tenant retention: 3,000\nTotal potential: 84,480 pounds\n\nConservative (50%): 42,240 pounds\nExpected (70%): 59,136 pounds\nOptimistic (90%): 76,032 pounds",
            "required": true,
            "rows": 14
          }
        ]
      },
      {
        "id": "part5",
        "title": "Part 5: ROI and Payback",
        "description": "Calculate ROI and payback for each scenario.",
        "fields": [
          {
            "id": "roi_calculation",
            "type": "textarea",
            "label": "ROI and payback calculations:",
            "placeholder": "Project cost: 8,000 pounds\n\nConservative Scenario:\nAnnual value: 42,240\nROI: (42,240 - 8,000) / 8,000 = 428%\nPayback: 8,000 / (42,240/12) = 2.3 months\n\nExpected Scenario:\nAnnual value: 59,136\nROI: (59,136 - 8,000) / 8,000 = 639%\nPayback: 8,000 / (59,136/12) = 1.6 months\n\nOptimistic Scenario:\nAnnual value: 76,032\nROI: (76,032 - 8,000) / 8,000 = 850%\nPayback: 8,000 / (76,032/12) = 1.3 months",
            "required": true,
            "rows": 18
          }
        ]
      },
      {
        "id": "part6",
        "title": "Part 6: ROI Summary",
        "description": "Write client-ready ROI summary.",
        "fields": [
          {
            "id": "roi_summary",
            "type": "textarea",
            "label": "ROI summary for client:",
            "placeholder": "Maintenance Automation ROI Summary\n\nHeadline: This project delivers 428-850% ROI with payback in under 10 weeks.\n\nCurrent State Costs (Annual):\n- Staff time on manual coordination: 18,876\n- Errors and complaints: 8,604\n- Potential hire you are considering: 18,000\nTotal addressable cost: 45,480+ pounds\n\nProjected Benefits:\n- Conservative (50% of potential): 42,240/year\n- Expected (70%): 59,136/year  \n- Optimistic (90%): 76,032/year\n\nPlus: Capacity to grow to 180+ units, faster response times, better tenant satisfaction, eliminated dropped requests.\n\nInvestment: 8,000 pounds\nPayback Period: 6-10 weeks\nFirst-Year ROI: 428% to 850%\n\nEven in the conservative scenario, this investment pays for itself in under 3 months and delivers ongoing value for years.",
            "required": true,
            "rows": 28
          }
        ]
      }
    ],
    "deliverables": [
      "Current labor cost calculation",
      "Error cost breakdown",
      "Opportunity cost analysis",
      "Three-scenario benefit projection",
      "ROI and payback for each scenario",
      "Client-ready summary"
    ],
    "success_criteria": [
      "Math is correct and shown",
      "Uses fully loaded costs",
      "Presents multiple scenarios",
      "Summary leads with headline ROI"
    ]
  }'
FROM modules m WHERE m.slug = 'business-value-roi';
