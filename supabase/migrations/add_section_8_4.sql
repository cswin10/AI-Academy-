-- ============================================================================
-- SECTION 8.4: Pricing Your Services
-- ============================================================================

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 1,
'What is value-based pricing?',
'["Charging based on your costs plus markup", "Setting prices based on the value delivered to the client, not time spent", "Matching competitor prices", "Charging the maximum the market will bear"]',
1,
'Value-based pricing ties your fee to the outcome the client receives. If you deliver 100,000 pounds of value, a 10,000 pound fee is reasonable regardless of hours.'),

((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 2,
'Why is hourly pricing problematic for automation work?',
'["Clients prefer hourly rates", "It punishes efficiency - the faster you work, the less you earn", "It is too complicated", "Hourly rates are always too low"]',
1,
'Hourly pricing creates a perverse incentive. As you get better and faster, you earn less. Value pricing rewards expertise.'),

((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 3,
'What is a good target for pricing relative to value delivered?',
'["100% of value", "10-20% of first-year value", "50% of value", "As much as possible"]',
1,
'Pricing at 10-20% of first-year value gives clients 5-10x return. This makes the decision easy and leaves room for you to grow.'),

((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 4,
'What is price anchoring?',
'["Setting the lowest price first", "Establishing a reference point that makes your price seem reasonable", "Matching competitor prices", "Changing prices frequently"]',
1,
'Anchoring uses comparison to frame perception. Showing 50,000 pounds annual cost before your 8,000 pound solution makes 8,000 seem small.'),

((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 5,
'When should you present your price in a proposal?',
'["At the very beginning", "After establishing the problem, value, and ROI", "Never in writing", "Only when asked"]',
1,
'Present price after value. If you lead with price, clients evaluate in a vacuum. After value, they evaluate relative to return.'),

((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 6,
'What is a retainer model?',
'["A one-time project fee", "Ongoing monthly fee for continued service, support, or availability", "A discount for large projects", "Payment after project completion"]',
1,
'Retainers provide recurring revenue and ongoing client relationships. They work well for maintenance, support, and continuous improvement.'),

((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 7,
'How should you handle price objections?',
'["Immediately offer a discount", "Revisit the value and ROI, then explore what is driving the concern", "Refuse to negotiate", "Walk away from the deal"]',
1,
'Price objections often mean value was not clear. Revisit the business case. If budget is truly the issue, explore scope adjustments.'),

((SELECT id FROM quizzes WHERE title = 'Pricing Quiz'), 8,
'What is scope-based pricing?',
'["Charging by the hour", "Defining a fixed price for a specific set of deliverables", "Pricing based on company size", "Charging more for difficult clients"]',
1,
'Scope-based pricing ties fee to deliverables. Clear scope prevents disputes. Changes to scope justify price adjustments.');

INSERT INTO sections (module_id, slug, title, order_index, level, content_markdown, exercise_markdown, estimated_minutes, is_required, quiz_id, exercise_schema)
SELECT
  m.id,
  'pricing-your-services',
  'Pricing Your Services',
  4,
  'Intermediate',
  '# Pricing Your Services

Pricing is where value meets revenue. Get it right and you build a sustainable business. Get it wrong and you either leave money on the table or struggle to win work.

## Definitions

**Value-Based Pricing**: Setting prices based on the value delivered to the client rather than time spent or costs incurred.

**Hourly Pricing**: Charging based on time spent, typically problematic for automation work.

**Project Pricing**: A fixed fee for a defined scope of work.

**Retainer**: Ongoing monthly fee for continued service, support, or access.

**Price Anchoring**: Establishing a reference point that influences how your price is perceived.

**Scope-Based Pricing**: Tying price directly to specific deliverables and outcomes.

**Price Objection**: Client pushback on price, often indicating unclear value rather than true budget constraints.

**Minimum Engagement**: The smallest project you will accept, protecting your time and positioning.

## Pricing Models

### Hourly Pricing

**How it works.** Track time, multiply by rate, invoice.

**The problem.** Hourly pricing punishes expertise. The better you get, the faster you work, the less you earn. A junior developer billing 50 hours at 50 pounds earns 2,500 pounds. An expert completing the same work in 10 hours at 100 pounds earns 1,000 pounds. The expert delivered more value but earned less.

**When it works.** Genuinely unpredictable work. Discovery phases. Ongoing advisory relationships. Situations where scope cannot be defined.

**When to avoid.** Project work with clear outcomes. Automation delivery. Anything where efficiency should be rewarded.

### Project Pricing

**How it works.** Define scope, set fixed price, deliver.

**Benefits:**
- Rewards efficiency
- Predictable for client
- Clear expectations
- No time tracking debates

**Challenges:**
- Requires accurate scoping
- Scope creep risk
- Need clear change process

**Best practice.** Define scope precisely. Document what is included and excluded. Include process for handling changes.

### Value-Based Pricing

**How it works.** Price based on value delivered, not time or cost.

**Example.** Automation saves client 50,000 pounds annually. You charge 10,000 pounds. Client gets 5x return. Your actual time invested is irrelevant to the price.

**Benefits:**
- Captures fair share of value created
- Rewards expertise and efficiency
- Aligns your incentives with client outcomes
- Higher earning potential

**Requirements:**
- Must quantify value during discovery
- Client must understand and agree to value calculation
- Need confidence to hold price

**The 10-20% rule.** A reasonable starting point is 10-20% of first-year value. Client gets 5-10x return, you get fair compensation.

### Retainer Pricing

**How it works.** Client pays monthly fee for ongoing service.

**Types of retainers:**

*Maintenance retainer.* You maintain and update existing automations. Fix issues. Make minor improvements.

*Support retainer.* You provide availability for questions, troubleshooting, guidance. May include SLA commitments.

*Development retainer.* Reserved hours for ongoing development work. Priority access to your time.

*Strategic retainer.* Ongoing advisory relationship. Regular check-ins. Proactive recommendations.

**Benefits:**
- Recurring revenue
- Predictable income
- Deeper client relationships
- Lower sales effort per pound earned

**Pricing retainers.** Base on value of availability plus expected work. Include clear scope of what is covered.

## Setting Your Prices

### Know Your Costs

Before pricing, understand your costs.

**Direct costs.** Software subscriptions, tools, subcontractors.

**Overhead.** Office, equipment, insurance, professional development.

**Your time.** What do you need to earn? Factor in non-billable time.

**Formula.** Target annual income plus overhead divided by billable hours gives minimum hourly rate. But this is a floor, not a pricing strategy.

### Know Your Value

**What outcomes do you consistently deliver?**

- Time savings
- Error reduction
- Revenue increase
- Risk mitigation
- Capacity expansion

**What is your track record?**

- Case studies with results
- Client testimonials
- Measurable outcomes delivered

**What is your expertise worth?**

- Years of experience
- Specialized knowledge
- Speed of delivery
- Quality of work

### Know Your Market

**What are others charging?**

Research competitor pricing. Understand the range. Position yourself appropriately.

**What can clients afford?**

Different markets have different budgets. A startup and an enterprise have different thresholds.

**What is the alternative cost?**

If they hire an employee, what would that cost? If they use a competitor, what would they pay? Your price should compare favorably to alternatives.

### The Pricing Formula

**Price = Value Delivered x Value Capture Percentage**

**Example:**
- Annual value: 75,000 pounds
- Value capture: 15%
- Price: 11,250 pounds

**Check against:**
- Minimum viable rate (covers costs plus margin)
- Market comparables
- Client budget signals
- Your confidence level

## Presenting Price

### Frame Before You Quote

Never lead with price. Always lead with value.

**Bad sequence:**
1. Here is my price: 8,000 pounds
2. Here is what you get
3. Here is why it is worth it

**Good sequence:**
1. Here is your problem (costs you 45,000 per year)
2. Here is the solution (eliminates 80% of that cost)
3. Here is the ROI (36,000 per year in savings)
4. Here is the investment (8,000 pounds)
5. Here is the payback (under 3 months)

**The client now evaluates 8,000 against 36,000, not 8,000 in isolation.**

### Use Anchoring

**Anchor against current costs.**

"Your current process costs 52,000 pounds annually. This solution eliminates 85% of that cost for an investment of 9,500 pounds."

**Anchor against alternatives.**

"A full-time hire would cost 55,000 pounds per year. This automation delivers the same capacity for a one-time investment of 12,000 pounds."

**Anchor against risk.**

"The compliance violation you are risking carries fines up to 100,000 pounds. This solution ensures 100% compliance for 15,000 pounds."

### Present Options

Offering options increases conversion and average deal size.

**Three-tier structure:**

*Basic:* Core solution only. Lower price. Good for budget-conscious clients.

*Standard:* Core plus enhancements. Mid price. Best value. Most clients choose this.

*Premium:* Everything plus extras. Higher price. For clients who want the best.

**Example:**

*Basic (6,000 pounds):* Core automation. Email trigger. CRM integration. Basic notifications.

*Standard (9,000 pounds):* Everything in Basic plus error handling, reporting dashboard, 30-day support.

*Premium (14,000 pounds):* Everything in Standard plus priority support for 90 days, two enhancement rounds, training session.

**Most clients choose Standard. Some choose Premium. Few choose Basic. Average price increases.**

### Written Proposals

**Structure:**
1. Executive summary
2. Understanding of the problem
3. Proposed solution
4. Expected outcomes and ROI
5. Investment and terms
6. Timeline
7. Next steps

**Key principles:**
- Lead with their problem, not your solution
- Quantify value before stating price
- Make the ROI obvious
- Include clear next steps
- Make it easy to say yes

## Handling Objections

### "It is too expensive"

**Do not immediately discount.** First, understand the objection.

**Questions to ask:**
- "Compared to what?"
- "Help me understand your budget expectations."
- "Which part of the value did not resonate?"

**Possible responses:**

*Value was not clear:* Revisit the ROI calculation. Emphasize the business case.

*Budget is genuinely limited:* Explore reducing scope while maintaining core value.

*Comparing to wrong alternative:* Clarify what they are comparing against.

### "We need to think about it"

**Clarify what they need to think about.**

- Is it price? Revisit value.
- Is it timing? Understand their timeline.
- Is it internal approval? Offer to help make the case.
- Is it uncertainty? Address specific concerns.

**Set a follow-up.** "When would be a good time to reconnect? I want to make sure you have everything you need to make a decision."

### "Can you do it cheaper?"

**Options:**

*Hold firm:* "This price reflects the value delivered. At 5x ROI, it is a strong investment."

*Reduce scope:* "We could reduce the scope to fit your budget. What is most critical?"

*Offer terms:* "We could split the payment across milestones if that helps with cash flow."

*Walk away:* "I understand. This might not be the right fit right now. Happy to reconnect when timing is better."

**Never discount without removing scope. Discounting trains clients to negotiate.**

### "Competitor quoted less"

**Understand the comparison.**
- Same scope?
- Same experience level?
- Same support included?

**Respond to the difference, not the price.**

"I appreciate you sharing that. Often lower quotes come with different scope or experience levels. Can you share what is included in their proposal? I want to make sure you are comparing like with like."

**If truly comparable, either match or differentiate.** Explain why you are worth the difference.

## Minimum Engagement

### Why Have a Minimum

Small projects have disproportionate overhead. A 500 pound project takes nearly as much sales, admin, and context-switching as a 5,000 pound project.

**Minimum protects:**
- Your time
- Your positioning
- Your profitability
- Your sanity

### Setting Your Minimum

**Consider:**
- Smallest project that is profitable
- Smallest project worth your attention
- Price that attracts right clients
- Price that filters wrong clients

**Common minimums:**
- Starting out: 1,000-2,000 pounds
- Established: 3,000-5,000 pounds
- Expert: 10,000+ pounds

### Enforcing Your Minimum

"Our minimum engagement is 3,000 pounds. For smaller needs, I can recommend some alternatives, or we could discuss bundling this with other work you might have."

**Never apologize for your minimum.** It signals professionalism, not arrogance.

## Quick Summary

- Value-based pricing captures fair share of value delivered.
- Present price after establishing value and ROI.
- Use anchoring to frame price against alternatives.
- Handle objections by revisiting value, not discounting.

## Operator Principles

- Price based on value delivered, not time spent.
- Establish value before presenting price.
- Maintain minimums that protect your time and positioning.
- Never discount without reducing scope.',

  '## Exercise: Build Your Pricing Strategy

**Timebox: 45 minutes | Stretch: 90 minutes**

Develop a pricing approach for your automation services.

### Part 1: Define Your Minimum

Calculate your costs and determine your minimum viable project price.

Consider:
- Your target annual income
- Your overhead costs
- Your realistic billable hours
- The smallest project worth your time

### Part 2: Create Pricing Tiers

Design a three-tier pricing structure for a common automation project.

For each tier, define:
- What is included
- What is excluded
- The price
- The target client

### Part 3: Write Value-First Pricing Presentation

Take this scenario and write the pricing presentation:

A marketing agency spends 20 hours per week on manual reporting. Four team members each spend 5 hours compiling data from various platforms into client reports. Their fully loaded cost is 35 pounds per hour. They produce 15 client reports per week. Error rate is about 10%, requiring rework. They want to automate this process.

Write the value-first pricing presentation including:
- Problem quantification
- Solution overview
- Value calculation
- Price presentation with anchoring

### Part 4: Prepare Objection Responses

Write responses to these common objections:

1. "That is more than we budgeted."
2. "Another provider quoted half that price."
3. "Can you break that into hourly so we can compare?"

### Part 5: Design a Retainer Offering

Create a retainer package for ongoing automation support. Include:
- What is covered
- What is not covered
- Monthly price
- Value proposition

### Deliverables

Minimum engagement price with rationale. Three-tier pricing structure. Value-first pricing presentation. Three objection response scripts. Retainer package design.',

  35,
  true,
  (SELECT id FROM quizzes WHERE title = 'Pricing Quiz'),
  '{
    "parts": [
      {
        "id": "part1",
        "title": "Part 1: Define Your Minimum",
        "description": "Calculate minimum viable project price.",
        "fields": [
          {
            "id": "minimum_calculation",
            "type": "textarea",
            "label": "Minimum engagement calculation:",
            "placeholder": "Target annual income: 80,000 pounds\nOverhead (software, insurance, etc.): 10,000 pounds\nTotal needed: 90,000 pounds\n\nRealistic billable hours: 1,200 per year\n(accounting for sales, admin, learning, holidays)\n\nMinimum hourly rate: 90,000 / 1,200 = 75 pounds\n\nSmallest worthwhile project: 20 hours\n(including sales, delivery, follow-up)\n\nMinimum project price: 20 x 75 = 1,500 pounds\n\nRounded to professional number: 2,000 pounds\n\nRationale: Below 2,000 pounds, the overhead of sales and onboarding is not worth the revenue. This minimum ensures every project is profitable and allows me to focus on quality over volume.",
            "required": true,
            "rows": 18
          }
        ]
      },
      {
        "id": "part2",
        "title": "Part 2: Pricing Tiers",
        "description": "Design three-tier pricing structure.",
        "fields": [
          {
            "id": "pricing_tiers",
            "type": "textarea",
            "label": "Three-tier pricing structure:",
            "placeholder": "Project: Lead Capture Automation\n\nBASIC - 3,000 pounds\nIncluded:\n- Form submission trigger\n- CRM record creation\n- Basic email notification\n- 14-day support\n\nExcluded:\n- Custom validation\n- Multi-step workflows\n- Reporting\n\nTarget: Small businesses with simple needs\n\n---\n\nSTANDARD - 5,500 pounds (Most Popular)\nIncluded:\n- Everything in Basic\n- Data validation and enrichment\n- Slack/Teams notification\n- Lead scoring logic\n- Reporting dashboard\n- 30-day support\n\nExcluded:\n- Advanced integrations\n- Custom development\n\nTarget: Growing businesses wanting reliability\n\n---\n\nPREMIUM - 9,000 pounds\nIncluded:\n- Everything in Standard\n- Advanced lead routing\n- Custom integrations (up to 2)\n- Training session\n- 90-day priority support\n- Monthly optimization review\n\nTarget: Established businesses wanting best-in-class",
            "required": true,
            "rows": 40
          }
        ]
      },
      {
        "id": "part3",
        "title": "Part 3: Value-First Pricing Presentation",
        "description": "Write pricing presentation with value framing.",
        "fields": [
          {
            "id": "pricing_presentation",
            "type": "textarea",
            "label": "Value-first pricing presentation:",
            "placeholder": "THE PROBLEM\n\nYour team spends 20 hours per week on manual reporting. At a fully loaded cost of 35 pounds per hour, that is 700 pounds per week, or 36,400 pounds annually, spent on copy-paste work.\n\nWith a 10% error rate on 15 weekly reports, you are also spending approximately 3 additional hours per week on rework - another 5,460 pounds annually.\n\nTotal annual cost of manual reporting: 41,860 pounds\n\nTHE SOLUTION\n\nAutomated reporting that:\n- Pulls data from all platforms automatically\n- Generates client-ready reports on schedule\n- Eliminates manual data entry\n- Reduces errors to near zero\n- Frees 20+ hours per week for strategic work\n\nTHE VALUE\n\nTime savings: 20 hours/week x 52 weeks x 35/hour = 36,400 pounds\nError reduction: 3 hours/week x 52 weeks x 35/hour = 5,460 pounds\nTotal annual value: 41,860 pounds\n\nTHE INVESTMENT\n\nOne-time investment: 8,500 pounds\n\nCompare to:\n- Current annual cost: 41,860 pounds\n- Hiring a reporting specialist: 45,000+ pounds/year\n- Continuing as-is: Growing frustration and turnover risk\n\nPayback period: 10 weeks\nFirst-year ROI: 393%\n\nRecommendation: Proceed with automation to reclaim 1,000+ hours annually and redirect your team to client-facing work that grows revenue.",
            "required": true,
            "rows": 42
          }
        ]
      },
      {
        "id": "part4",
        "title": "Part 4: Objection Responses",
        "description": "Prepare responses to common objections.",
        "fields": [
          {
            "id": "objection_responses",
            "type": "textarea",
            "label": "Three objection response scripts:",
            "placeholder": "OBJECTION 1: \"That is more than we budgeted.\"\n\nResponse: \"I understand budget is a consideration. Let me ask - what were you expecting to invest for a solution that saves 40,000 pounds annually? \n\nOur price of 8,500 pounds pays for itself in 10 weeks. After that, you are saving 3,200 pounds every month.\n\nIf budget is the primary concern, we could explore a phased approach - starting with the highest-impact reports and expanding later. What is the budget range you are working with?\"\n\n---\n\nOBJECTION 2: \"Another provider quoted half that price.\"\n\nResponse: \"Thanks for sharing that. To make sure we are comparing fairly, could you tell me what is included in their quote?\n\nOften lower quotes differ in scope, experience, or support. I would want to understand:\n- Are they including all 15 report types?\n- What is their track record with your specific platforms?\n- What support is included after delivery?\n\nI am confident in our pricing because we have delivered this exact solution successfully before, and our 30-day support ensures you are not left on your own. Happy to walk through the differences if helpful.\"\n\n---\n\nOBJECTION 3: \"Can you break that into hourly so we can compare?\"\n\nResponse: \"I price based on value delivered rather than hours spent. Here is why that benefits you:\n\nIf I quoted hourly and the project took 100 hours at 85 pounds, that is 8,500 pounds. But if my experience means I complete it in 60 hours, you would pay 5,100 pounds - and I would be penalized for being efficient.\n\nWith value-based pricing, you know exactly what you are investing upfront, and I am incentivized to deliver the best solution as efficiently as possible.\n\nThe real comparison is not hours - it is the 40,000 pounds in annual value you receive for an 8,500 pound investment.\"",
            "required": true,
            "rows": 42
          }
        ]
      },
      {
        "id": "part5",
        "title": "Part 5: Retainer Offering",
        "description": "Design a retainer package.",
        "fields": [
          {
            "id": "retainer_design",
            "type": "textarea",
            "label": "Retainer package design:",
            "placeholder": "AUTOMATION SUPPORT RETAINER\n\nMonthly Investment: 750 pounds\n\nWHAT IS COVERED:\n- Monitoring of all active automations\n- Bug fixes and error resolution (response within 4 business hours)\n- Minor adjustments and tweaks (up to 3 per month)\n- Monthly performance review\n- Priority access for new projects\n- Quarterly optimization recommendations\n\nWHAT IS NOT COVERED:\n- New automation development (quoted separately at 15% discount)\n- Major feature additions\n- Third-party platform changes requiring rebuild\n- Training for new staff (available as add-on)\n\nMINIMUM COMMITMENT: 3 months\n\nVALUE PROPOSITION:\n\n\"Your automations are critical infrastructure. When something breaks, you need it fixed fast - not after a sales conversation and contract negotiation.\n\nThis retainer guarantees:\n- 4-hour response time when issues arise\n- Ongoing optimization so performance improves over time\n- Peace of mind that your systems are monitored\n- Priority access when you need new development\n\nCompare to: Hiring an in-house automation specialist at 4,000+ pounds per month, or scrambling to find help when something breaks.\n\nFor 750 pounds monthly, you have an automation partner on call.\"",
            "required": true,
            "rows": 38
          }
        ]
      }
    ],
    "deliverables": [
      "Minimum engagement calculation with rationale",
      "Three-tier pricing structure with clear differentiation",
      "Value-first pricing presentation with ROI",
      "Three objection response scripts",
      "Retainer package with coverage and value proposition"
    ],
    "success_criteria": [
      "Minimum is justified by real costs",
      "Tiers have clear value progression",
      "Pricing presentation leads with value",
      "Objection responses revisit value before discussing price",
      "Retainer has clear scope boundaries"
    ]
  }'
FROM modules m WHERE m.slug = 'business-value-roi';
