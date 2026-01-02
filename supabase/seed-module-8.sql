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


-- ============================================================================
-- SECTION 8.3: Building Business Cases
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 1,
'What is the primary purpose of a business case?',
'["To show off your technical skills", "To help stakeholders make an informed decision about investment", "To negotiate higher prices", "To document project requirements"]',
1,
'A business case presents evidence and analysis so decision-makers can evaluate whether the investment makes sense for their business.'),

((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 2,
'What should come first in a business case presentation?',
'["Technical specifications", "Your credentials", "The problem and its cost to the business", "The price"]',
2,
'Start with the pain. Decision-makers need to understand the problem before they care about the solution.'),

((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 3,
'Why include risks in your business case?',
'["To scare the client", "To lower expectations", "To demonstrate thorough thinking and build credibility", "Risks should never be included"]',
2,
'Acknowledging risks shows maturity and builds trust. Clients know nothing is risk-free; pretending otherwise damages credibility.'),

((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 4,
'What is a "do nothing" scenario in a business case?',
'["Recommending no action", "The cost of maintaining the current state without change", "A backup plan", "Refusing the project"]',
1,
'The do-nothing scenario shows what happens if they do not invest. It quantifies the ongoing cost of inaction.'),

((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 5,
'How many options should you typically present in a business case?',
'["Only one - your recommendation", "Two to three options with clear trade-offs", "As many as possible", "Let the client decide the options"]',
1,
'Two to three options give clients choice without overwhelming. Include a recommended option with clear reasoning.'),

((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 6,
'What makes an executive summary effective?',
'["Including every detail", "Being comprehensive and thorough", "Capturing the key points in one page that busy executives can scan", "Using technical language to show expertise"]',
2,
'Executives are busy. A one-page summary with headline ROI, key benefits, and investment amount lets them quickly assess the opportunity.'),

((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 7,
'When presenting alternatives, what should each option include?',
'["Only the price", "Scope, investment, expected return, and trade-offs", "Technical architecture", "Timeline only"]',
1,
'Each option should be complete: what is included, what it costs, what it returns, and what trade-offs are involved.'),

((SELECT id FROM quizzes WHERE title = 'Business Case Quiz'), 8,
'What is the best way to handle objections in a business case?',
'["Ignore them and hope they do not come up", "Address common concerns proactively with evidence", "Wait for the client to raise them", "Argue against any objections"]',
1,
'Anticipate objections and address them in your business case. This shows thorough thinking and removes barriers to approval.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id, exercise_schema)
SELECT
  m.id,
  'building-business-cases',
  'Building Business Cases',
  3,
  'Intermediate',
  '# Building Business Cases

A compelling business case gets projects approved. It transforms your proposal from "an expense to consider" into "an opportunity to capture."

## Definitions

**Business Case**: A structured argument for investment that includes problem analysis, proposed solution, costs, benefits, risks, and recommendation.

**Executive Summary**: A one-page overview capturing the essential decision points for busy stakeholders.

**Do-Nothing Scenario**: The cost and consequences of maintaining the current state without investment.

**Options Analysis**: Presentation of multiple approaches with trade-offs to give stakeholders informed choice.

**Stakeholder**: Anyone who influences or is affected by the decision.

**Decision Criteria**: The factors stakeholders use to evaluate options.

**Risk Mitigation**: Strategies to reduce the likelihood or impact of potential problems.

**Success Metrics**: Measurable outcomes that define project success.

## Why Business Cases Matter

### Getting Past "Interesting, But Not Now"

Many good projects never happen. Not because they lack value, but because they lack a compelling case.

Decision-makers face competing priorities. Your project competes for budget, attention, and resources. A strong business case moves your proposal up the priority list.

**Without a business case.** "This automation sounds useful. Let us think about it next quarter."

**With a business case.** "This automation saves 45,000 pounds annually with 6-week payback. Delaying costs 3,750 pounds per month. Let us start immediately."

Same project. Different outcome.

### Who Reads Business Cases

**The person you talk to** often cannot approve the budget alone. Your contact needs to sell the project internally.

Give them ammunition. A well-structured business case becomes their presentation to leadership.

**Budget holders** want financial justification. Show ROI, payback, and risk.

**Technical stakeholders** want feasibility assurance. Show you understand the environment.

**Operations stakeholders** want minimal disruption. Show implementation and transition plans.

Write for all of them.

## Business Case Structure

### Executive Summary

One page. Sometimes one paragraph. The entire case distilled for busy readers.

**Include.** The problem. The solution. The investment. The return. The recommendation.

**Example.**

"Current manual invoice processing costs 67,000 pounds annually in staff time and errors. Automation would reduce this by 80%, delivering 53,600 pounds annual savings. Investment of 12,000 pounds pays back in 11 weeks. Recommend proceeding with Phase 1 implementation starting next month."

Decision-makers often read only this. Make it count.

### Problem Statement

Define the problem in business terms. Quantify the cost.

**Structure.** What is happening. Why it matters. What it costs.

**Example.**

"The sales team manually enters lead data from web forms into the CRM. This takes 2 hours daily across 4 team members. Manual entry causes 15 data errors per week, requiring 3 hours to correct. Total weekly cost: 43 hours at 28 pounds per hour equals 1,204 pounds. Annual cost: 62,608 pounds. Additionally, slow data entry delays follow-up by 4 hours on average, reducing conversion rates."

Use their numbers. Reference discovery conversations. Make it real.

### Current State Analysis

Document what exists today. This becomes your baseline.

**Include.** Process description. People involved. Time spent. Tools used. Error rates. Costs.

**Be specific.** "Three team members spend approximately 2 hours each" is weaker than "Sarah, James, and Priya collectively log 127 hours monthly on this process, verified by time tracking data from October."

### Proposed Solution

Describe what you will deliver and how it solves the problem.

**Focus on outcomes first.** What changes for them. Then explain how.

**Example.**

"Automated lead capture will eliminate manual data entry, ensure 100% data accuracy, and enable sub-5-minute response times.

The solution connects web forms directly to your CRM via API integration. Leads are enriched with company data automatically. Sales team receives instant Slack notification with full lead context. Follow-up tasks are created automatically based on lead score."

Keep it accessible. Technical details go in appendices.

### Options Analysis

Present two to three options. Give stakeholders choice.

**Option structure.**

Option A: Essential
- Scope: Core automation only
- Investment: 8,000 pounds
- Annual value: 35,000 pounds
- Payback: 11 weeks
- Trade-off: Manual enrichment still required

Option B: Recommended
- Scope: Full automation with enrichment
- Investment: 12,000 pounds
- Annual value: 53,000 pounds
- Payback: 12 weeks
- Trade-off: Slightly higher upfront cost

Option C: Comprehensive
- Scope: Full automation plus analytics dashboard
- Investment: 18,000 pounds
- Annual value: 61,000 pounds
- Payback: 15 weeks
- Trade-off: Longer implementation, higher complexity

**Always recommend one option.** Explain why. Make it easy to say yes.

### Do-Nothing Scenario

What happens if they do not proceed?

**Quantify ongoing costs.** Every month of delay costs X pounds.

**Identify growing risks.** The problem gets worse because of Y.

**Note competitive disadvantage.** Competitors who automate will Z.

**Example.**

"Maintaining current state costs 5,217 pounds monthly. Over 12 months: 62,608 pounds. Additionally, as lead volume grows 20% annually, either costs increase proportionally or response times degrade further, reducing conversion rates."

The do-nothing scenario is not free. Make that clear.

### Investment and Returns

Clear financial summary.

**Investment.** Project fee. Implementation costs. Ongoing costs. Internal resource requirements.

**Returns.** Annual value. Breakdown by category. Conservative and expected scenarios.

**Payback.** Weeks or months to recover investment.

**ROI.** Percentage return, clearly calculated.

**Multi-year view.** Year 1, Year 2, Year 3 cumulative value.

### Risks and Mitigation

Acknowledge what could go wrong. Show how you address it.

**Risk format.** Risk. Likelihood. Impact. Mitigation.

**Example.**

Risk: Integration complexity higher than estimated
Likelihood: Medium
Impact: Additional 1-2 weeks, 2,000 pounds
Mitigation: Detailed technical discovery before commitment. Fixed-price phases with go/no-go checkpoints.

Risk: User adoption slower than expected
Likelihood: Low
Impact: Delayed value realization
Mitigation: Training included. Phased rollout. Champion user program.

**Include 3-5 risks.** Too few seems naive. Too many seems risky.

### Implementation Approach

How you will deliver.

**Include.** Phases and milestones. Timeline. What you need from them. How disruption is minimized.

**Example.**

Phase 1 (Weeks 1-2): Discovery and design
Phase 2 (Weeks 3-4): Build and test
Phase 3 (Week 5): Pilot with sales team lead
Phase 4 (Week 6): Full rollout and training

Client involvement: 2 hours for kickoff, 1 hour weekly check-in, 3 hours for testing.

### Success Metrics

How you will measure success.

**Define before starting.** Agree on what success looks like.

**Example metrics.**

- Data entry time reduced by 80% (baseline: 127 hours monthly)
- Data errors reduced to near zero (baseline: 15 weekly)
- Lead response time under 5 minutes (baseline: 4 hours)
- Sales team satisfaction score above 8/10

### Call to Action

What do you want them to do?

**Be specific.** "To proceed, approve the 12,000 pound investment and confirm project start date. I will send a statement of work within 24 hours of approval."

**Create urgency without pressure.** "Starting this month captures the full Q4 benefit. Each week of delay costs approximately 1,200 pounds in ongoing manual processing."

## Tailoring Business Cases

### For Different Stakeholders

**CFO focus.** ROI, payback, risk, cash flow timing.

**COO focus.** Efficiency gains, capacity, operational risk reduction.

**CEO focus.** Strategic alignment, competitive advantage, growth enablement.

**IT focus.** Integration, security, maintenance, technical feasibility.

### For Different Company Sizes

**Small business.** Keep it simple. One to two pages. Focus on cash flow impact.

**Mid-market.** More formal structure. Include options. Address multiple stakeholders.

**Enterprise.** Full documentation. Procurement requirements. Security reviews. Multiple approval layers.

### For Different Project Sizes

**Small projects (under 5,000 pounds).** One-page business case. Focus on quick wins.

**Medium projects (5,000 to 25,000 pounds).** Full business case. Options analysis. Risk section.

**Large projects (over 25,000 pounds).** Comprehensive documentation. Phased approach. Governance structure.

## Common Mistakes

**Leading with solution.** They need to feel the problem first.

**Too much technical detail.** Decision-makers want outcomes, not architecture.

**No clear recommendation.** Do not make them guess what you think they should do.

**Ignoring politics.** Understand who influences decisions and what they care about.

**One-size-fits-all.** Tailor depth and focus to audience.

**No urgency.** Make the cost of delay clear.

## Quick Summary

- Business cases sell projects by showing evidence-based value.
- Structure: problem, solution, options, investment, returns, risks, recommendation.
- Tailor to stakeholders and include clear call to action.

## Operator Principles

- Start with the problem and its cost before presenting solutions.
- Present options with a clear recommendation.
- Quantify the cost of doing nothing.
- Make it easy for your contact to sell internally.',

  '## Exercise: Build a Business Case

**Timebox: 60 minutes | Stretch: 90 minutes**

Create a complete business case for a client scenario.

### Scenario

A marketing agency with 25 employees contacts you. They struggle with their client reporting process.

Discovery findings:
- Produce 40 client reports monthly
- Each report takes 3 hours to create manually
- Account managers pull data from 5 platforms: Google Analytics, Google Ads, Facebook Ads, LinkedIn Ads, HubSpot
- Copy data into spreadsheets, create charts, write summaries
- 3 account managers share this work
- Account manager salary: 42,000 pounds plus 30% overhead
- Approximately 4 reports per month have errors requiring correction
- Error correction takes 2 hours per report
- Clients have complained about inconsistent formatting
- Agency wants to scale to 60 clients but cannot add headcount

Your proposed automation would cost 15,000 pounds and includes:
- Automated data extraction from all platforms
- Template-based report generation
- Quality checks and validation
- Client portal for self-service access

### Part 1: Executive Summary

Write a one-paragraph executive summary.

### Part 2: Problem Statement

Document the problem with quantified costs.

### Part 3: Options Analysis

Present three options with trade-offs.

### Part 4: Risk Analysis

Identify three risks with mitigation strategies.

### Part 5: Implementation Approach

Outline a phased implementation plan.

### Part 6: Call to Action

Write the closing with specific next steps.

### Deliverables

Executive summary. Problem statement. Three options. Risk analysis. Implementation approach. Call to action.',

  45,
  true,
  (SELECT id FROM quizzes WHERE title = 'Business Case Quiz'),
  '{
    "parts": [
      {
        "id": "part1",
        "title": "Part 1: Executive Summary",
        "description": "Write a compelling one-paragraph executive summary.",
        "fields": [
          {
            "id": "executive_summary",
            "type": "textarea",
            "label": "Executive summary:",
            "placeholder": "Current manual reporting costs the agency 78,000 pounds annually in staff time and errors, while limiting growth capacity. Automated reporting would reduce report creation time by 85%, eliminate errors, and enable scaling to 60+ clients without additional headcount. The recommended solution requires a 15,000 pound investment, delivers 66,000+ pounds annual value, and pays back in under 12 weeks. We recommend proceeding with the full automation package to capture Q1 benefits and enable the planned growth trajectory.",
            "required": true,
            "rows": 8
          }
        ]
      },
      {
        "id": "part2",
        "title": "Part 2: Problem Statement",
        "description": "Document the problem with quantified costs.",
        "fields": [
          {
            "id": "problem_statement",
            "type": "textarea",
            "label": "Problem statement with costs:",
            "placeholder": "The Current Reporting Challenge\n\nThe agency produces 40 client reports monthly, each requiring 3 hours of manual work. Three account managers collectively spend 120 hours monthly on reporting—time that could be spent on client strategy and growth.\n\nCost Breakdown:\n- Account manager loaded rate: 54,600 / 1,880 = 29.04/hour\n- Monthly reporting time: 120 hours\n- Monthly labor cost: 3,485 pounds\n- Annual labor cost: 41,820 pounds\n\n- Error correction: 4 reports × 2 hours × 29.04 = 232 pounds monthly\n- Annual error cost: 2,784 pounds\n\n- Client complaints affecting 2 renewals annually: estimated 24,000 pounds at risk\n\nTotal annual cost: 44,604 pounds direct, plus renewal risk\n\nGrowth Constraint:\nCurrent process cannot scale. Adding 20 clients would require either hiring (55,000+ annually) or degrading quality. Neither option is acceptable.",
            "required": true,
            "rows": 24
          }
        ]
      },
      {
        "id": "part3",
        "title": "Part 3: Options Analysis",
        "description": "Present three options with clear trade-offs.",
        "fields": [
          {
            "id": "options",
            "type": "textarea",
            "label": "Three options with trade-offs:",
            "placeholder": "Option A: Essential Automation\nScope: Automated data extraction + template reports for top 3 platforms\nInvestment: 9,000 pounds\nAnnual Value: 35,000 pounds\nPayback: 13 weeks\nTrade-off: LinkedIn and HubSpot remain manual. Limited customization.\n\nOption B: Full Automation (Recommended)\nScope: All 5 platforms, full template system, quality validation\nInvestment: 15,000 pounds\nAnnual Value: 52,000 pounds\nPayback: 15 weeks\nTrade-off: Slightly higher investment, significantly more capability\nWhy Recommended: Covers all platforms, enables full scaling, best ROI trajectory\n\nOption C: Premium with Client Portal\nScope: Full automation plus client self-service portal and real-time dashboards\nInvestment: 24,000 pounds\nAnnual Value: 68,000 pounds\nPayback: 18 weeks\nTrade-off: Higher complexity, longer implementation, but differentiates from competitors\n\nDo-Nothing Cost: 44,604 annually, plus blocked growth, plus competitive disadvantage as other agencies automate.",
            "required": true,
            "rows": 28
          }
        ]
      },
      {
        "id": "part4",
        "title": "Part 4: Risk Analysis",
        "description": "Identify three risks with mitigation strategies.",
        "fields": [
          {
            "id": "risks",
            "type": "textarea",
            "label": "Three risks with mitigation:",
            "placeholder": "Risk 1: Platform API Changes\nLikelihood: Medium (1-2 times per year)\nImpact: Temporary report disruption\nMitigation: Modular architecture allows quick updates. Monitoring alerts for API issues. Maintenance package includes updates.\n\nRisk 2: User Adoption Resistance\nLikelihood: Low-Medium\nImpact: Delayed value realization\nMitigation: Involve account managers in design. Training sessions included. Phased rollout with champion users. Keep manual fallback initially.\n\nRisk 3: Data Quality Issues\nLikelihood: Low\nImpact: Incorrect reports to clients\nMitigation: Validation layer compares automated vs historical data. Human review for first month. Automated anomaly detection.",
            "required": true,
            "rows": 20
          }
        ]
      },
      {
        "id": "part5",
        "title": "Part 5: Implementation Approach",
        "description": "Outline a phased implementation plan.",
        "fields": [
          {
            "id": "implementation",
            "type": "textarea",
            "label": "Phased implementation plan:",
            "placeholder": "Implementation Plan: 6 Weeks\n\nPhase 1: Discovery & Design (Week 1)\n- Document current report templates and variations\n- Map all platform data sources and credentials\n- Define template requirements with account managers\n- Deliverable: Technical specification and template designs\n- Client time: 3 hours\n\nPhase 2: Build Core System (Weeks 2-3)\n- Build data extraction from all 5 platforms\n- Create report template engine\n- Implement validation layer\n- Deliverable: Working system in test environment\n- Client time: 1 hour check-in\n\nPhase 3: Pilot (Week 4)\n- Generate reports for 5 pilot clients\n- Account manager review and feedback\n- Refine templates based on feedback\n- Deliverable: Validated reports ready for client delivery\n- Client time: 2 hours review\n\nPhase 4: Rollout & Training (Weeks 5-6)\n- Extend to all 40 clients\n- Train all account managers\n- Document processes\n- Deliverable: Fully operational system, trained team\n- Client time: 2 hours training\n\nTotal client time required: 8 hours across 6 weeks",
            "required": true,
            "rows": 28
          }
        ]
      },
      {
        "id": "part6",
        "title": "Part 6: Call to Action",
        "description": "Write the closing with specific next steps.",
        "fields": [
          {
            "id": "call_to_action",
            "type": "textarea",
            "label": "Call to action:",
            "placeholder": "Recommended Next Steps\n\nWe recommend proceeding with Option B: Full Automation at 15,000 pounds investment.\n\nThis delivers:\n- 52,000 pounds annual value (347% first-year ROI)\n- Payback in under 15 weeks\n- Capacity to scale to 60+ clients without hiring\n- Consistent, error-free client deliverables\n\nTo proceed:\n1. Confirm approval of 15,000 pound investment\n2. Schedule kickoff meeting for next week\n3. Assign internal project contact\n\nI will send a detailed statement of work within 24 hours of approval.\n\nTiming Consideration:\nStarting this month means the system is operational before quarter-end reporting. Each week of delay costs approximately 850 pounds in manual processing and defers the scaling capability you need for planned growth.\n\nQuestions? I am available for a 30-minute call to discuss any concerns before you decide.",
            "required": true,
            "rows": 24
          }
        ]
      }
    ],
    "deliverables": [
      "One-paragraph executive summary",
      "Problem statement with quantified costs",
      "Three options with clear trade-offs",
      "Risk analysis with mitigation strategies",
      "Phased implementation approach",
      "Call to action with specific next steps"
    ],
    "success_criteria": [
      "Executive summary captures key decision points",
      "Problem is quantified in business terms",
      "Options have clear differentiation and recommendation",
      "Risks are realistic with practical mitigations",
      "Implementation is phased with clear milestones",
      "Call to action is specific and creates appropriate urgency"
    ]
  }'
FROM modules m WHERE m.slug = 'business-value-roi';


-- ============================================================================
-- SECTION 8.4: Pricing Your Services
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 1,
'What is value-based pricing?',
'["Charging based on hours worked", "Pricing based on the value delivered to the client rather than your costs", "Offering the lowest price to win work", "Matching competitor prices"]',
1,
'Value-based pricing ties your fee to the outcome for the client, not your time or costs. Higher value justifies higher prices.'),

((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 2,
'Why is hourly pricing often disadvantageous for operators?',
'["Clients prefer it", "It is too simple", "It punishes efficiency and caps your earnings regardless of value delivered", "It requires too much tracking"]',
2,
'Hourly pricing means getting faster costs you money. The better you get, the less you earn per project.'),

((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 3,
'What percentage of delivered value is a reasonable starting point for pricing?',
'["1-2%", "5-10%", "10-20%", "50-75%"]',
2,
'Pricing at 10-20% of first-year value is common. A project delivering 50,000 pounds annually might be priced at 5,000-10,000 pounds.'),

((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 4,
'What is price anchoring?',
'["Starting with your lowest price", "Presenting a higher reference point first to make your price seem reasonable", "Anchoring your price to competitors", "Keeping prices fixed"]',
1,
'Anchoring establishes context. Showing the cost of alternatives or the do-nothing scenario makes your price feel smaller.'),

((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 5,
'When should you present your price in a proposal?',
'["At the very beginning", "After establishing the problem, value, and solution", "Only when asked", "In a separate document"]',
1,
'Present price after building value. Once they understand the problem costs 50,000 annually, your 8,000 fee seems reasonable.'),

((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 6,
'What is a retainer model?',
'["One-time project fee", "Recurring monthly fee for ongoing access and services", "Hourly billing", "Performance bonus"]',
1,
'Retainers provide predictable recurring revenue. Clients pay monthly for ongoing support, maintenance, or access to your services.'),

((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 7,
'How should you respond when a client says your price is too high?',
'["Immediately offer a discount", "Explore what specifically concerns them and revisit value if needed", "Refuse to negotiate", "Match any lower quote they have"]',
1,
'Price objections often mean value is unclear. Revisit the ROI conversation before discussing discounts.'),

((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 8,
'What is scope-based pricing?',
'["Pricing based on project scope with defined deliverables rather than time", "Charging by the hour", "Pricing based on team size", "Variable pricing based on difficulty"]',
0,
'Scope-based pricing ties your fee to what you deliver, not how long it takes. This rewards efficiency and provides cost certainty for clients.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id, exercise_schema)
SELECT
  m.id,
  'pricing-your-services',
  'Pricing Your Services',
  4,
  'Intermediate',
  '# Pricing Your Services

Pricing is not about what your time is worth. It is about what the outcome is worth to the client.

## Definitions

**Value-Based Pricing**: Setting prices based on the value delivered to the client rather than time or cost inputs.

**Hourly Pricing**: Charging based on time spent, regardless of value delivered.

**Scope-Based Pricing**: Fixed price for defined deliverables, regardless of time required.

**Retainer**: Recurring fee for ongoing access to services, support, or capacity.

**Price Anchoring**: Establishing a reference point that makes your price seem reasonable by comparison.

**Price Elasticity**: How sensitive demand is to price changes.

**Margin**: The difference between your price and your costs.

**Commoditization**: When services become interchangeable, competing primarily on price.

## Pricing Models

### Hourly Pricing

**How it works.** Track time. Multiply by rate. Invoice.

**Advantages.** Simple. Easy to explain. Low risk if scope changes.

**Disadvantages.** Punishes efficiency. Caps earnings. Creates misaligned incentives. Clients watch the clock.

**When to use.** Discovery phases. Highly uncertain scope. Ongoing advisory work. When the client insists.

**The efficiency trap.** You build an automation in 4 hours that would take someone else 20 hours. At 100 pounds per hour, you earn 400 pounds for delivering 2,000 pounds of value. Your expertise costs you money.

### Scope-Based Pricing

**How it works.** Define deliverables. Set a fixed price. Deliver.

**Advantages.** Rewards efficiency. Predictable for client. Focus on outcomes not hours.

**Disadvantages.** Scope creep risk. Requires accurate estimation. Harder to price initially.

**When to use.** Defined projects. Repeatable work. When you can estimate accurately.

**Example.** "CRM automation package: 5,000 pounds. Includes lead capture, data enrichment, and Slack notifications. Delivered in 3 weeks."

### Value-Based Pricing

**How it works.** Calculate the value your solution delivers. Price as a percentage of that value.

**Advantages.** Highest earning potential. Aligns your interests with client outcomes. Justifies premium pricing.

**Disadvantages.** Requires good value discovery. Not always applicable. Harder to explain.

**When to use.** High-value projects. Clear ROI. Sophisticated clients who understand value.

**Example.** Project saves 50,000 pounds annually. You price at 8,000 pounds (16% of first-year value). Client gets 525% ROI. You get paid for value, not time.

### Retainer Pricing

**How it works.** Monthly fee for ongoing services, access, or capacity.

**Advantages.** Predictable recurring revenue. Builds long-term relationships. Easier to plan.

**Disadvantages.** Must deliver consistent value. Scope can be unclear. Renewal risk.

**When to use.** Ongoing support. Maintenance. Advisory relationships. Clients who need consistent access.

**Example.** "2,000 pounds per month. Includes system monitoring, up to 10 hours of enhancements, priority support, monthly review call."

### Hybrid Models

Combine models for flexibility.

**Project plus retainer.** 10,000 pounds project fee plus 1,500 pounds monthly maintenance.

**Base plus performance.** 5,000 pounds base plus 500 pounds per month if system maintains 99% uptime.

**Tiered scope.** Option A: 5,000 pounds. Option B: 8,000 pounds. Option C: 12,000 pounds.

## Calculating Your Price

### The Value-Based Approach

**Step 1.** Calculate annual value delivered to client.

**Step 2.** Determine reasonable percentage (typically 10-20% of first-year value).

**Step 3.** Adjust for context (complexity, risk, relationship, competition).

**Example calculation.**

Value delivered: 45,000 pounds annually
Target: 15% of first-year value
Base price: 6,750 pounds
Adjustment: Complex integration, raise to 8,000 pounds
Final price: 8,000 pounds

Client ROI: 462%
Payback: 10 weeks

### The Minimum Viable Price

What is the lowest price that makes this project worthwhile for you?

**Calculate.** Estimated hours times your minimum hourly target, plus risk buffer.

**Example.** Estimate 40 hours. Minimum target 75 pounds per hour. Base: 3,000 pounds. Add 25% risk buffer: 3,750 pounds.

This is your floor. Never go below without strategic reason.

### The Market Check

What are others charging for similar work?

**Research.** Ask peers. Check freelance platforms. Review case studies.

**Position yourself.** Premium, mid-market, or value. Each has trade-offs.

Being significantly below market often signals low quality. Being above requires clear differentiation.

## Pricing Psychology

### Anchoring

**Present context before price.** Show the cost of alternatives first.

"The current process costs 62,000 annually. Hiring would cost 55,000 per year. Our automation investment is 12,000."

Your price feels smaller next to the alternatives.

### The Rule of Three

**Offer three options.** Most people choose the middle. Make your preferred option the middle.

Option A: 5,000 pounds (basic)
Option B: 8,000 pounds (recommended)
Option C: 14,000 pounds (premium)

Most clients choose B. Those who want premium choose C. You rarely sell A.

### Avoid Round Numbers

**8,500 pounds feels more considered than 8,000 or 10,000.**

Precise numbers suggest careful calculation. Round numbers suggest guessing.

### Price Confidence

**State your price without apologizing or hedging.**

Bad: "So, um, I was thinking maybe around 8,000? But we can discuss..."

Good: "The investment for this project is 8,000 pounds."

Confidence signals value. Hesitation invites negotiation.

## Presenting Price

### Build Value First

Never lead with price. Build the value case thoroughly before presenting cost.

**Sequence.**
1. Problem and its cost (what they lose now)
2. Solution and its outcomes (what changes)
3. ROI and payback (the return)
4. Investment (your price)

By the time you state your price, they understand it is small relative to the value.

### Use Investment Language

"The investment is 8,000 pounds" not "the cost is 8,000 pounds."

Investment implies return. Cost implies expense.

### Connect to Payback

"The investment is 8,000 pounds with payback in 8 weeks. After that, it is pure return."

This reframes price as temporary. The value is permanent.

### Provide Payment Options

"8,000 pounds, payable as 4,000 at start and 4,000 at completion."

"8,000 pounds, or 2,800 monthly for three months."

Options reduce perceived barrier while maintaining price.

## Handling Price Objections

### "That is More Than We Expected"

**Respond with curiosity, not defense.**

"What were you expecting, and what was that based on?"

Often their expectation was uninformed. Revisit value if needed.

### "Can You Do It for Less?"

**Explore before conceding.**

"I can look at the scope. What would you be willing to trade off?"

Never reduce price without reducing scope. It devalues your work.

### "Competitor X is Cheaper"

**Differentiate on value, not price.**

"They may be. What are you comparing? Our approach includes discovery, testing, and 30 days of support. Does theirs?"

Cheaper often means less complete. Make the difference clear.

### "We Do Not Have the Budget"

**Determine if this is real or negotiation.**

"Is budget the only barrier, or are there other concerns?"

If real: "When does your next budget cycle start? Let us plan for that."

If negotiation: Return to value conversation.

### When to Hold vs Negotiate

**Hold your price when.** The value clearly justifies it. Reducing would set bad precedent. The client is testing you.

**Consider adjusting when.** You want the relationship. The scope can be reduced. There is genuine budget constraint for a good client. Strategic reasons exist.

**If you reduce price, reduce scope.** Never discount for the same work. It trains clients to always negotiate.

## Building Pricing Confidence

### Track Your Value Delivered

Document outcomes for every project. When you know you delivered 10x returns, asking for 15% of value feels appropriate.

### Raise Prices Regularly

Every 6-12 months, evaluate your pricing. As you gain experience and efficiency, your value increases.

### Fire Bad Clients

Clients who always negotiate hard, pay late, and complain are not worth keeping. Price them out or decline work.

### Know Your Minimum

Have a clear floor. Know when to walk away. Desperation shows and invites exploitation.

## Quick Summary

- Value-based pricing connects your fee to client outcomes, not your time.
- Build value before presenting price. Use anchoring and options.
- Handle objections by exploring first, then adjusting scope if needed, never just price.

## Operator Principles

- Price based on value delivered, not hours worked.
- Build the value case before presenting price.
- Offer options to give clients choice and anchor toward your preferred option.
- Reduce scope before reducing price.',

  '## Exercise: Develop Your Pricing Strategy

**Timebox: 45 minutes | Stretch: 75 minutes**

Create a pricing approach for your services and practice handling objections.

### Scenario

You have developed expertise in building automation workflows for small businesses. You are preparing to take on more clients and want a clear pricing strategy.

Your services include:
- Discovery and requirements gathering
- Workflow design and documentation
- Implementation and testing
- Training and handover
- 30 days of support post-launch

Typical projects take you 30-50 hours and deliver 15,000-40,000 pounds annual value for clients.

### Part 1: Define Your Pricing Model

Choose your primary pricing model and explain your reasoning.

### Part 2: Calculate Your Price Range

Determine your minimum, target, and premium prices with justification.

### Part 3: Create Pricing Tiers

Design three pricing options you could present to clients.

### Part 4: Write Price Presentation

Write how you would present your price after a discovery call.

### Part 5: Handle Objections

Write responses to three common price objections.

### Part 6: Payment Terms

Define your payment terms and conditions.

### Deliverables

Pricing model selection. Price range with reasoning. Three-tier pricing structure. Price presentation script. Objection responses. Payment terms.',

  35,
  true,
  (SELECT id FROM quizzes WHERE title = 'Pricing Quiz'),
  '{
    "parts": [
      {
        "id": "part1",
        "title": "Part 1: Pricing Model",
        "description": "Choose your primary pricing model and explain reasoning.",
        "fields": [
          {
            "id": "pricing_model",
            "type": "textarea",
            "label": "Your pricing model and reasoning:",
            "placeholder": "Primary Model: Scope-Based Pricing with Value Justification\n\nReasoning:\n1. Hourly punishes my efficiency - I am fast and would earn less\n2. Pure value-based is hard for small businesses to accept\n3. Scope-based gives clients cost certainty they want\n4. I use value calculations to justify the scope price\n\nHow it works:\n- Fixed price for defined project scope\n- Price is set based on value delivered (typically 15% of year 1 value)\n- Includes all discovery, build, training, and 30-day support\n- Change requests priced separately\n\nSecondary Model: Retainer for ongoing work\n- Monthly fee for existing clients\n- Covers maintenance, small changes, priority support",
            "required": true,
            "rows": 18
          }
        ]
      },
      {
        "id": "part2",
        "title": "Part 2: Price Range",
        "description": "Calculate minimum, target, and premium prices.",
        "fields": [
          {
            "id": "price_range",
            "type": "textarea",
            "label": "Your price range with justification:",
            "placeholder": "Minimum Price: 3,500 pounds\n- Based on: 35 hours x 75/hour minimum + 25% buffer\n- Only accept at this price for simple, fast projects\n- Below this is not worth my time\n\nTarget Price: 5,500-7,500 pounds\n- Based on: 15% of typical 40,000 value = 6,000\n- This is my standard range for typical projects\n- Good margin, sustainable business\n\nPremium Price: 10,000-15,000 pounds\n- For complex integrations, tight timelines, or high-value outcomes\n- Justified when value exceeds 60,000 annually\n- Includes extended support and priority access\n\nEffective Hourly Rate:\n- At 6,000 for 40 hours = 150/hour\n- At 10,000 for 50 hours = 200/hour\n- Much better than hourly billing",
            "required": true,
            "rows": 20
          }
        ]
      },
      {
        "id": "part3",
        "title": "Part 3: Pricing Tiers",
        "description": "Design three pricing options to present to clients.",
        "fields": [
          {
            "id": "pricing_tiers",
            "type": "textarea",
            "label": "Your three pricing tiers:",
            "placeholder": "AUTOMATION PACKAGES\n\nEssential - 4,500 pounds\n- Discovery session (2 hours)\n- Core workflow automation (up to 3 integrations)\n- Basic documentation\n- Training session (1 hour)\n- 14 days email support\nBest for: Simple, single-process automations\n\nProfessional - 7,500 pounds (Recommended)\n- Comprehensive discovery (4 hours)\n- Full workflow automation (up to 6 integrations)\n- Detailed documentation and runbooks\n- Training sessions (3 hours)\n- 30 days priority support\n- One optimization review at 30 days\nBest for: Most business automation needs\n\nEnterprise - 12,000 pounds\n- Extended discovery with stakeholder interviews\n- Complex multi-system automation (unlimited integrations)\n- Complete documentation with video walkthroughs\n- Team training program (6 hours)\n- 60 days priority support\n- Quarterly reviews for first year\n- Dedicated Slack channel\nBest for: Critical business processes, multiple teams",
            "required": true,
            "rows": 28
          }
        ]
      },
      {
        "id": "part4",
        "title": "Part 4: Price Presentation",
        "description": "Write how you would present price after discovery.",
        "fields": [
          {
            "id": "price_presentation",
            "type": "textarea",
            "label": "Price presentation script:",
            "placeholder": "\"Based on our discovery conversation, here is what I understand:\n\nYou are spending about 25 hours per week on manual data entry across your team. At your fully loaded cost of 28 pounds per hour, that is 36,400 pounds annually. Plus, the errors are costing you roughly 8,000 in rework and customer issues.\n\nThe automation we discussed would eliminate about 80% of that manual work and virtually all the errors. That is roughly 37,000 pounds in annual value.\n\nI have prepared three options for you:\n\n[Present the three tiers]\n\nI recommend the Professional package at 7,500 pounds. It covers everything you need with proper documentation and support. The investment pays for itself in about 10 weeks, and then you are saving nearly 3,000 per month ongoing.\n\nThe Essential package works if budget is tight, but you would miss the optimization review which typically finds another 20% improvement.\n\nEnterprise is there if you want the extended support and quarterly reviews - some clients like that peace of mind.\n\nWhat questions do you have?\"",
            "required": true,
            "rows": 24
          }
        ]
      },
      {
        "id": "part5",
        "title": "Part 5: Objection Handling",
        "description": "Write responses to three common objections.",
        "fields": [
          {
            "id": "objection_responses",
            "type": "textarea",
            "label": "Responses to price objections:",
            "placeholder": "Objection 1: \"That is more than we budgeted\"\n\nResponse: \"I understand. What were you expecting, and what was that based on? [Listen] The value here is 37,000 annually - at 7,500, you are getting nearly 5x return in year one alone. That said, if cash flow is the concern, I can offer 2,500 at start, 2,500 at midpoint, and 2,500 at completion. Does that help with the budget timing?\"\n\n---\n\nObjection 2: \"We found someone on Upwork for 2,000\"\n\nResponse: \"You definitely can find lower prices. Can I ask what is included in that quote? [Listen] My price includes discovery to make sure we solve the right problem, testing to ensure it works reliably, training so your team can use it confidently, and 30 days of support if anything needs adjustment. I also guarantee the outcome - if it does not deliver the value we discussed, I will fix it. What guarantees are you getting at 2,000?\"\n\n---\n\nObjection 3: \"Can you do it for 5,000?\"\n\nResponse: \"I want to make this work for you. At 5,000, I would need to adjust the scope. We could do the Essential package which covers your core workflow, or I could do the Professional scope but with 14 days support instead of 30. Which would work better for your situation?\"",
            "required": true,
            "rows": 28
          }
        ]
      },
      {
        "id": "part6",
        "title": "Part 6: Payment Terms",
        "description": "Define your payment terms and conditions.",
        "fields": [
          {
            "id": "payment_terms",
            "type": "textarea",
            "label": "Your payment terms:",
            "placeholder": "STANDARD PAYMENT TERMS\n\nProjects Under 5,000 pounds:\n- 50% deposit to begin work\n- 50% upon completion\n- Payment due within 7 days of invoice\n\nProjects 5,000-10,000 pounds:\n- 40% deposit to begin work\n- 30% at project midpoint\n- 30% upon completion\n- Payment due within 14 days of invoice\n\nProjects Over 10,000 pounds:\n- 30% deposit to begin work\n- 30% at first milestone\n- 30% at second milestone\n- 10% upon completion\n- Payment due within 14 days of invoice\n\nRetainer Clients:\n- Monthly fee invoiced on the 1st\n- Payment due within 14 days\n- 10% discount for quarterly prepayment\n\nAdditional Terms:\n- All prices in GBP\n- Bank transfer or card accepted\n- Late payment: 2% per month after 30 days\n- Work pauses if payment is more than 14 days overdue\n- Scope changes quoted separately before work begins",
            "required": true,
            "rows": 28
          }
        ]
      }
    ],
    "deliverables": [
      "Pricing model with reasoning",
      "Minimum, target, and premium price range",
      "Three-tier pricing structure",
      "Price presentation approach",
      "Three objection responses",
      "Payment terms and conditions"
    ],
    "success_criteria": [
      "Pricing model fits your business and clients",
      "Price range is justified by value and costs",
      "Tiers are clearly differentiated",
      "Presentation builds value before stating price",
      "Objection responses explore before conceding",
      "Payment terms are clear and professional"
    ]
  }'
FROM modules m WHERE m.slug = 'business-value-roi';


-- ============================================================================
-- SECTION 8.5: Long-term Value & Client Growth
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Long-term Value Quiz'), 1,
'What is client lifetime value (LTV)?',
'["The value of the first project", "Total revenue generated from a client across the entire relationship", "How long the client stays", "The largest single project value"]',
1,
'LTV measures total value over time. A 5,000 pound first project can lead to 50,000+ over several years with expansions and retainers.'),

((SELECT id FROM quizzes WHERE title = 'Long-term Value Quiz'), 2,
'Why is client retention more profitable than acquisition?',
'["Retained clients are less demanding", "Acquisition costs are high and existing clients buy more with less sales effort", "New clients pay more", "Retention is easier to measure"]',
1,
'Acquiring new clients costs 5-10x more than keeping existing ones. Existing clients already trust you and buy more readily.'),

((SELECT id FROM quizzes WHERE title = 'Long-term Value Quiz'), 3,
'What is an expansion opportunity?',
'["A chance to increase project scope", "Additional work with an existing client beyond the original engagement", "Geographic expansion", "Hiring more staff"]',
1,
'Expansion means selling more services to clients you already have. New projects, new departments, new problems to solve.'),

((SELECT id FROM quizzes WHERE title = 'Long-term Value Quiz'), 4,
'What is the best time to discuss future work with a client?',
'["Before starting the first project", "When they are experiencing the success of current work", "When the project is struggling", "Only when they ask"]',
1,
'When clients are seeing results, they are most receptive to additional investment. Success creates momentum for expansion.'),

((SELECT id FROM quizzes WHERE title = 'Long-term Value Quiz'), 5,
'What is a strategic review meeting?',
'["A project status update", "A scheduled conversation to discuss business changes and uncover new opportunities", "A performance review", "A contract negotiation"]',
1,
'Strategic reviews look beyond current work to understand where the client is heading. They uncover problems you can solve.'),

((SELECT id FROM quizzes WHERE title = 'Long-term Value Quiz'), 6,
'How do referrals typically compare to cold leads?',
'["They are about the same", "Referrals close faster, at higher prices, with less selling required", "Cold leads are better quality", "Referrals are not reliable"]',
1,
'Referrals come with built-in trust. The referring client has already validated you. Conversion rates and prices are typically higher.'),

((SELECT id FROM quizzes WHERE title = 'Long-term Value Quiz'), 7,
'What is a land and expand strategy?',
'["Starting with a large project", "Beginning with a smaller engagement and growing the relationship over time", "Expanding into new markets", "Buying land for an office"]',
1,
'Land and expand means starting small to prove value, then growing the engagement as trust builds. Lower risk for both parties.'),

((SELECT id FROM quizzes WHERE title = 'Long-term Value Quiz'), 8,
'What should you track to identify expansion opportunities?',
'["Only project revenue", "Client business changes, new problems mentioned, and organizational growth", "Competitor activities", "Industry news only"]',
1,
'Pay attention to what is changing in the client business. New hires, new products, new challenges - all signal expansion opportunities.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id, exercise_schema)
SELECT
  m.id,
  'long-term-value-client-growth',
  'Long-term Value & Client Growth',
  5,
  'Intermediate',
  '# Long-term Value & Client Growth

The first project is just the beginning. The real opportunity is building relationships that grow over years.

## Definitions

**Client Lifetime Value (LTV)**: Total revenue generated from a client across the entire relationship.

**Client Retention**: Keeping existing clients engaged and continuing to work with you.

**Expansion Revenue**: Additional revenue from existing clients beyond the original engagement.

**Land and Expand**: Strategy of starting with a smaller project and growing the relationship over time.

**Strategic Review**: Scheduled conversation to understand client business changes and uncover opportunities.

**Referral**: New client introduction from an existing client relationship.

**Churn**: When a client stops working with you.

**Account Development**: Deliberate effort to grow the value of an existing client relationship.

## The Value of Long-term Relationships

### First Project vs Lifetime Value

**Example comparison.**

Single project: 8,000 pounds

Same client over 3 years:
- Initial project: 8,000 pounds
- Phase 2 expansion: 6,000 pounds
- New department project: 12,000 pounds
- Monthly retainer (24 months): 36,000 pounds
- Ad-hoc projects: 8,000 pounds
- Lifetime value: 70,000 pounds

The first project is 11% of the lifetime value. This changes how you think about client relationships.

### Acquisition Cost Reality

Finding new clients is expensive. Marketing, sales calls, proposals, discovery—all before any revenue.

**Typical acquisition cost.** 20-30% of first project value.

An 8,000 pound project might cost 2,000 in time and effort to win.

**Expansion cost.** 5-10% of project value.

Selling to an existing client who trusts you costs far less.

### Trust Compounds

First project: They evaluate everything. High scrutiny. Careful approval.

Second project: They know your work. Faster decisions. Less selling.

Third project: "We have a problem, can you fix it?" Direct request.

By year two, you are a trusted partner, not a vendor being evaluated.

## Land and Expand Strategy

### Start Small, Grow Big

Large projects carry high risk for clients. They do not know you yet.

Small projects are easier to approve. Lower risk. Easier to say yes.

**The pattern.**

Phase 1: 3,000 pound pilot project. Prove you deliver.
Phase 2: 8,000 pound expansion. Apply success to more processes.
Phase 3: 15,000 pound department rollout. Scale across the organization.
Phase 4: 2,000 pound monthly retainer. Ongoing support and enhancement.

Total: 38,000+ pounds from a relationship that started with 3,000.

### Designing Phase 1 for Success

Your first project should:

**Deliver visible results quickly.** Choose something with clear, measurable improvement.

**Be completable in 2-4 weeks.** Short timeframe reduces risk.

**Touch people who influence future decisions.** Impress the right stakeholders.

**Create natural next steps.** Solve one problem that connects to others.

**Example.** Automate one high-volume, manual process. Quick win. Visible improvement. Sets up expansion conversation.

### Building the Expansion Path

During Phase 1, pay attention to:

**Other problems mentioned.** "While you are here, we also struggle with..."

**Connected processes.** "This feeds into our X process which is also manual."

**Other departments.** "Marketing has the same issue."

**Stakeholder reactions.** Who is excited? Who asks questions about what else you could do?

Document everything. These become your expansion proposals.

## Retention Strategies

### Deliver Exceptional Results

Retention starts with delivery. No relationship strategy compensates for poor work.

**What exceptional looks like.**

- Deliver what you promised
- Communicate proactively
- Handle problems quickly
- Exceed expectations where possible
- Document everything clearly

### Stay in Touch

Out of sight, out of mind. Maintain contact between projects.

**Quarterly check-ins.** 30-minute call. How are things going? What is changing in your business?

**Useful updates.** Share relevant articles, tool updates, or ideas. Add value without selling.

**Annual reviews.** Comprehensive look at what you delivered, results achieved, and opportunities ahead.

### Solve Problems Before They Know

Monitor automated systems. Catch issues early. Fix things proactively.

**Example.** "I noticed your form submissions spiked 40% last week—the automation is handling it fine, but I wanted you to know in case this signals a campaign success you should build on."

This demonstrates attention and expertise.

### Make Yourself Indispensable

Become embedded in their operations. Understand their business deeply.

**The more you know, the more you can help.**

- Their strategic priorities
- Key stakeholder preferences
- Business seasonality
- Upcoming initiatives
- Competitive pressures

This knowledge lets you propose solutions to problems they have not articulated yet.

## Identifying Expansion Opportunities

### Listen for Signals

During any client interaction, listen for:

**Pain statements.** "We really struggle with..." "It drives us crazy that..."

**Growth mentions.** "We are hiring 10 people in Q2." "We are launching a new product."

**Tool frustrations.** "We just cannot get X system to do what we need."

**Process complaints.** "Every month we spend days on X."

**Strategic changes.** "We are moving into a new market." "Leadership wants us to focus on Y."

Each signal is a potential project.

### Ask Expansion Questions

**During project work.**

"What other processes does this connect to?"
"Who else in the organization deals with similar challenges?"
"If this works well, what would you want to tackle next?"

**During reviews.**

"What has changed in your business since we last talked?"
"What are your priorities for the next quarter?"
"What is keeping you up at night?"

**After success.**

"Given the results here, where else could we apply this approach?"
"Would it be worth introducing me to the team at X department?"
"What would you want the next phase to achieve?"

### Track Opportunities Systematically

Keep notes on every client:

- Current projects and status
- Future opportunities mentioned
- Key contacts and their priorities
- Business changes and news
- Relationship health indicators

Review quarterly. Look for patterns and timing.

## Strategic Review Meetings

### Purpose

Regular meetings focused not on project status but on business direction.

**Goals.**

- Understand client strategic priorities
- Identify upcoming challenges and opportunities
- Position yourself as strategic partner
- Uncover future work

### Structure

**Preparation.** Review all notes. Research recent company news. Prepare questions.

**Opening.** "I wanted to step back from day-to-day work and understand where your business is heading."

**Discovery questions.**

- "What are your top priorities for the next 12 months?"
- "What challenges do you see coming?"
- "What has changed since we last had this conversation?"
- "Where are you feeling most constrained?"
- "If you could wave a magic wand, what would you fix?"

**Share observations.** Based on your work with them, share insights.

"I have noticed X pattern in your data. Have you considered Y?"
"Other clients in similar situations have found value in Z."

**Close with next steps.** "Based on what you have shared, there might be some ways I can help. Can I put together a brief proposal for X?"

### Frequency

**New clients.** After first project completion.

**Established clients.** Quarterly or bi-annually.

**Key accounts.** Monthly informal touch, quarterly strategic.

## Referral Generation

### Why Referrals Work

Referrals come with pre-built trust. Your existing client has vouched for you.

**Referral advantages.**

- Higher close rate (50%+ vs 10-20% for cold)
- Less price sensitivity
- Faster decision process
- Warmer initial conversation
- Lower acquisition cost

### Earning Referrals

Referrals are earned, not asked for. They come from exceptional work.

**The referral formula.**

Deliver great results + Stay memorable + Make it easy = Referrals

### Asking for Referrals

**Timing.** When clients express satisfaction. After successful delivery. During positive check-ins.

**The ask.**

Direct: "You mentioned this has made a real difference. Do you know anyone else who might benefit from similar work? I would be grateful for an introduction."

Soft: "If you ever come across someone struggling with X, I would love to help. Feel free to share my details."

Specific: "I am looking to work with more companies in your industry. Is there anyone in your network who might be a good fit?"

### Making Referrals Easy

**Provide materials.** One-page summary of what you do and results you deliver.

**Offer warm introduction language.** "Feel free to say: My automation consultant saved us 40 hours per month. Happy to introduce you."

**Remove friction.** "If you share their email, I will reach out mentioning you connected us."

### Referral Programs

Some operators formalize referral incentives:

- 10% of first project value as referral fee
- Free month of retainer service
- Credit toward future work
- Gift or donation to their choice of charity

Keep it professional. Not everyone can accept referral fees.

## Measuring Relationship Health

### Key Indicators

**Positive signs.**

- Quick response to your messages
- Proactive requests for help
- Introductions to other stakeholders
- Willingness to provide testimonials
- Mentioning you to others

**Warning signs.**

- Slow or non-response
- Reduced engagement in meetings
- Questioning invoices
- Not implementing your recommendations
- Organizational changes affecting your champion

### Relationship Scoring

Score each client relationship quarterly:

**1-3.** At risk. Need intervention.
**4-6.** Stable but not growing. Need attention.
**7-8.** Healthy. Maintain and look for expansion.
**9-10.** Champion. Nurture and request referrals.

Focus energy where it matters most.

### Addressing Problems Early

When you see warning signs, address them.

**Example email.**

"I noticed we have not connected in a while, and I want to make sure everything is going well. Is the automation still delivering value? Is there anything I should be aware of? I would love to catch up for 15 minutes this week."

Early intervention saves relationships.

## Building Your Client Portfolio

### The Ideal Mix

**Anchor clients (2-3).** Large relationships with ongoing retainers. Provide stable base revenue.

**Growth clients (3-5).** Active relationships with expansion potential. Invest in development.

**Project clients (varies).** One-off or occasional work. Less investment, less return.

### Client Graduation

Help clients move up the ladder:

Project client → Repeat project client → Growth client → Anchor client

Each stage requires deliberate development.

### Know When to Part Ways

Not every client should be retained.

**Consider ending when.**

- They consistently demand discounts
- Payment is always late
- The work is not in your zone of expertise
- They do not implement recommendations
- The relationship is net negative energy

Respectfully complete current work and do not pursue more.

## Quick Summary

- Lifetime value far exceeds first project value. Think long-term.
- Land and expand: start small, prove value, grow the relationship.
- Stay in touch, ask strategic questions, and track expansion signals.

## Operator Principles

- Every project is an audition for the next one.
- Make expansion conversations part of your delivery process.
- Track client relationships systematically, not just projects.
- Invest most in clients with highest growth potential.',

  '## Exercise: Client Growth Strategy

**Timebox: 45 minutes | Stretch: 75 minutes**

Develop a systematic approach to growing your client relationships.

### Scenario

You have three active clients:

**Client A: TechStart Ltd**
- 18-month relationship
- Initial project: 6,000 pounds (marketing automation)
- Second project: 8,000 pounds (sales pipeline automation)
- Currently on 500/month support retainer
- Main contact: Sarah (Marketing Director)
- Company growing, recently hired 5 new salespeople
- Sarah has mentioned they are considering a new CRM

**Client B: PropertyCo**
- 4-month relationship
- One project completed: 4,500 pounds (tenant communication automation)
- Happy with results, saved 20 hours/month
- Main contact: James (Operations Manager)
- 3 other departments in the company
- James mentioned finance team does a lot of manual reporting

**Client C: HealthFirst Clinic**
- Just completed first project: 7,000 pounds (appointment scheduling)
- Results exceeded expectations
- Main contact: Dr. Patel (Practice Manager)
- She has 2 other clinic locations
- She mentioned knowing other practice managers

### Part 1: Client Analysis

Analyze each client relationship and score them.

### Part 2: Expansion Opportunities

Identify specific expansion opportunities for each client.

### Part 3: Strategic Questions

Write strategic review questions for your next meeting with each client.

### Part 4: Referral Strategy

Develop a referral ask for your strongest client relationship.

### Part 5: 90-Day Action Plan

Create specific actions to grow each relationship over the next 90 days.

### Part 6: Tracking System

Design a simple system to track client relationships and opportunities.

### Deliverables

Client analysis with scores. Expansion opportunities. Strategic review questions. Referral strategy. 90-day action plan. Relationship tracking system.',

  40,
  true,
  (SELECT id FROM quizzes WHERE title = 'Long-term Value Quiz'),
  '{
    "parts": [
      {
        "id": "part1",
        "title": "Part 1: Client Analysis",
        "description": "Analyze each client relationship and score them.",
        "fields": [
          {
            "id": "client_analysis",
            "type": "textarea",
            "label": "Client analysis with relationship scores:",
            "placeholder": "CLIENT A: TechStart Ltd\nRelationship Score: 9/10\nStrengths:\n- Long relationship (18 months)\n- Multiple successful projects\n- Active retainer = ongoing engagement\n- Growing company = more opportunity\n- CRM mention = clear next project\nRisks:\n- Dependency on single contact (Sarah)\nLTV so far: 6,000 + 8,000 + (500 x 18) = 23,000 pounds\nPotential: High - growth trajectory clear\n\nCLIENT B: PropertyCo\nRelationship Score: 7/10\nStrengths:\n- Happy with results (20 hrs/month saved)\n- Multiple departments = expansion potential\n- James mentioned finance team need\nRisks:\n- Only one project so far\n- No retainer = less contact\n- Have not met other stakeholders\nLTV so far: 4,500 pounds\nPotential: Medium-High - need to expand beyond James\n\nCLIENT C: HealthFirst Clinic\nRelationship Score: 8/10\nStrengths:\n- Exceeded expectations first project\n- Multiple locations = easy expansion\n- Network of other practice managers = referrals\nRisks:\n- Brand new relationship\n- Healthcare has specific requirements\nLTV so far: 7,000 pounds\nPotential: High - both expansion and referral potential",
            "required": true,
            "rows": 32
          }
        ]
      },
      {
        "id": "part2",
        "title": "Part 2: Expansion Opportunities",
        "description": "Identify specific expansion opportunities for each client.",
        "fields": [
          {
            "id": "expansion_opportunities",
            "type": "textarea",
            "label": "Expansion opportunities for each client:",
            "placeholder": "CLIENT A: TechStart Ltd\n\n1. CRM Implementation Support (mentioned)\n   - Estimated value: 12,000-18,000 pounds\n   - Timing: When they choose CRM\n   - Approach: Offer to help evaluate and implement\n\n2. New Sales Team Onboarding Automation\n   - Estimated value: 5,000-8,000 pounds\n   - Timing: Now - they just hired 5 people\n   - Approach: Propose automated onboarding workflows\n\n3. Retainer Increase\n   - Current: 500/month\n   - Potential: 1,000/month with added services\n   - Approach: Quarterly review to add reporting\n\nCLIENT B: PropertyCo\n\n1. Finance Reporting Automation (mentioned)\n   - Estimated value: 6,000-10,000 pounds\n   - Timing: Next quarter\n   - Approach: Ask James for intro to finance lead\n\n2. Extend Current Solution to Other Properties\n   - Estimated value: 3,000-5,000 pounds\n   - Timing: After proving more value\n\n3. Retainer Arrangement\n   - Estimated value: 750/month\n   - Timing: After second project\n\nCLIENT C: HealthFirst Clinic\n\n1. Roll Out to Other 2 Clinic Locations\n   - Estimated value: 10,000-12,000 pounds\n   - Timing: Next 3 months\n   - Approach: Propose pilot at second location\n\n2. Additional Practice Automations\n   - Patient reminders, follow-up sequences\n   - Estimated value: 5,000-8,000 pounds\n\n3. Referrals to Other Practices\n   - Potential: 3-5 new clients\n   - Estimated value: 20,000+ in new business",
            "required": true,
            "rows": 40
          }
        ]
      },
      {
        "id": "part3",
        "title": "Part 3: Strategic Questions",
        "description": "Write strategic review questions for each client.",
        "fields": [
          {
            "id": "strategic_questions",
            "type": "textarea",
            "label": "Strategic review questions for each client:",
            "placeholder": "CLIENT A: TechStart Ltd (meeting with Sarah)\n\n1. \"With the 5 new sales hires, what is your biggest challenge in getting them productive quickly?\"\n2. \"You mentioned considering a new CRM - what is driving that decision and what is your timeline?\"\n3. \"The marketing and sales automations are working well - are there gaps between the two that we should address?\"\n4. \"What are your department priorities for the next 6 months?\"\n5. \"Is there anyone else in the company I should be talking to about automation opportunities?\"\n\nCLIENT B: PropertyCo (meeting with James)\n\n1. \"The tenant communication automation saved 20 hours monthly - how has that time been used?\"\n2. \"You mentioned the finance team does a lot of manual reporting - tell me more about what they are struggling with.\"\n3. \"What are the other departments in PropertyCo and what do they handle?\"\n4. \"Are there other property managers in your network who face similar challenges?\"\n5. \"What would make our working relationship even more valuable to you?\"\n\nCLIENT C: HealthFirst Clinic (meeting with Dr. Patel)\n\n1. \"Now that scheduling is automated, what is the next biggest operational headache?\"\n2. \"How are your other two clinic locations handling scheduling currently?\"\n3. \"You mentioned knowing other practice managers - do they face similar challenges?\"\n4. \"What are your growth plans for the practice over the next year?\"\n5. \"If we could automate one more thing that would make your daily life easier, what would it be?\"",
            "required": true,
            "rows": 32
          }
        ]
      },
      {
        "id": "part4",
        "title": "Part 4: Referral Strategy",
        "description": "Develop a referral ask for your strongest relationship.",
        "fields": [
          {
            "id": "referral_strategy",
            "type": "textarea",
            "label": "Referral strategy for strongest client:",
            "placeholder": "REFERRAL STRATEGY: Dr. Patel, HealthFirst Clinic\n\nWhy Dr. Patel:\n- Just delivered excellent results (exceeded expectations)\n- She mentioned knowing other practice managers\n- Healthcare is a great niche (similar problems, similar solutions)\n- Likely to refer genuinely because she is happy\n\nTiming:\n- Next follow-up call, 2 weeks after go-live\n- She will have lived with the results\n- Satisfaction is fresh\n\nThe Ask:\n\"Dr. Patel, I am so pleased the scheduling automation exceeded your expectations. I love working with medical practices - you all have similar challenges and really appreciate when things just work.\n\nYou mentioned knowing other practice managers. If any of them are struggling with scheduling chaos like you were, I would be grateful for an introduction. Would you be open to sharing my details if the topic comes up, or is there anyone specific you think I should speak with?\"\n\nMake It Easy:\n- Prepare one-page case study of her results\n- Offer: \"I can draft a quick email you could forward if that is easier\"\n- Suggest: \"Even just a name and email - I will mention you connected us\"\n\nFollow-up:\n- Thank her genuinely for any referral\n- Update her on outcome\n- Consider referral thank-you (donation to health charity?)",
            "required": true,
            "rows": 28
          }
        ]
      },
      {
        "id": "part5",
        "title": "Part 5: 90-Day Action Plan",
        "description": "Create specific actions for each client over 90 days.",
        "fields": [
          {
            "id": "action_plan",
            "type": "textarea",
            "label": "90-day action plan for each client:",
            "placeholder": "CLIENT A: TechStart Ltd - 90-Day Plan\n\nMonth 1:\n- Week 1: Schedule strategic review with Sarah\n- Week 2: Conduct review, explore CRM timeline\n- Week 3: Send proposal for sales onboarding automation\n- Week 4: Follow up on proposal\n\nMonth 2:\n- Begin onboarding automation project if approved\n- Research CRM options to position as advisor\n- Ask Sarah to introduce to sales lead\n\nMonth 3:\n- Complete onboarding project\n- Propose retainer increase with added reporting\n- Position for CRM implementation support\n\nGoal: Convert onboarding project (8,000) + set up CRM support\n\nCLIENT B: PropertyCo - 90-Day Plan\n\nMonth 1:\n- Week 1: Send check-in email to James\n- Week 2: Schedule call, ask about finance team\n- Week 3: Get introduction to finance lead\n- Week 4: Discovery call with finance\n\nMonth 2:\n- Submit proposal for finance reporting automation\n- Explore other departments with James\n- Document additional opportunities\n\nMonth 3:\n- Execute finance project if approved\n- Propose retainer arrangement\n- Map path to other departments\n\nGoal: Win finance project (8,000) + introduce retainer\n\nCLIENT C: HealthFirst Clinic - 90-Day Plan\n\nMonth 1:\n- Week 1: Check-in call with Dr. Patel\n- Week 2: Make referral ask (see strategy above)\n- Week 3: Propose second clinic location rollout\n- Week 4: Follow up on referrals and proposal\n\nMonth 2:\n- Implement second location if approved\n- Nurture any referral conversations\n- Explore additional automation needs\n\nMonth 3:\n- Propose third location\n- Build case study with Dr. Patel permission\n- Actively pursue referred practices\n\nGoal: Win 2nd location (5,000) + 2 quality referrals",
            "required": true,
            "rows": 44
          }
        ]
      },
      {
        "id": "part6",
        "title": "Part 6: Tracking System",
        "description": "Design a simple system to track relationships and opportunities.",
        "fields": [
          {
            "id": "tracking_system",
            "type": "textarea",
            "label": "Your relationship tracking system:",
            "placeholder": "CLIENT RELATIONSHIP TRACKER\n\nFormat: Simple spreadsheet or Notion database\n\nClient Record Fields:\n- Client name\n- Main contact (name, role, email)\n- Other contacts\n- Relationship start date\n- Relationship score (1-10, updated quarterly)\n- Total LTV to date\n- Current retainer (if any)\n- Last contact date\n- Next scheduled contact\n\nProject History:\n- Project name, date, value, outcome\n- Key results achieved (for case studies)\n\nOpportunity Pipeline:\n- Opportunity description\n- Estimated value\n- Stage (identified/proposed/negotiating/won/lost)\n- Next action and date\n- Notes\n\nRelationship Health Log:\n- Date, score, notes on changes\n- Warning signs observed\n- Actions taken\n\nWeekly Review (15 mins):\n- Check: Any clients not contacted in 30+ days?\n- Check: Any proposals awaiting response?\n- Update: Move opportunities through pipeline\n- Plan: Top 3 relationship actions this week\n\nQuarterly Review (1 hour):\n- Update all relationship scores\n- Review LTV and growth trajectory\n- Identify at-risk relationships\n- Plan strategic reviews\n- Set quarterly relationship goals\n\nTools:\n- Simple: Google Sheets with tabs per client\n- Better: Notion with linked databases\n- Advanced: CRM like Pipedrive or HubSpot",
            "required": true,
            "rows": 40
          }
        ]
      }
    ],
    "deliverables": [
      "Client analysis with relationship scores",
      "Specific expansion opportunities per client",
      "Strategic review questions per client",
      "Referral strategy for strongest client",
      "90-day action plan per client",
      "Relationship tracking system design"
    ],
    "success_criteria": [
      "Analysis identifies realistic opportunities",
      "Expansion ideas are specific and valued",
      "Strategic questions are open-ended and insightful",
      "Referral ask is natural and makes it easy",
      "90-day plan has specific weekly actions",
      "Tracking system is simple enough to actually use"
    ]
  }'
FROM modules m WHERE m.slug = 'business-value-roi';
