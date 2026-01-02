-- ============================================================================
-- UPDATE SECTION 4.5: Tool Selection Framework & Decision Matrix
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, add 4 more quiz questions to reach 8 total
INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Tool Selection Quiz'), 5,
'How do the capability tiers from Module 1 inform tool selection decisions?',
'["They only apply to LLMs", "Match tool capability tier to task complexity: use Fast/Cheap tier tools for simple tasks, Balanced tier for most work, Deep Reasoning tier for complex analysis", "Always use the highest tier", "Tiers do not affect selection"]',
1,
'Tool selection should consider capability requirements. Over-provisioning (using Deep Reasoning for simple tasks) wastes money; under-provisioning produces poor results.'),

((SELECT id FROM quizzes WHERE title = 'Tool Selection Quiz'), 6,
'When evaluating a new AI tool, what role should the I-T-O framework play?',
'["It does not apply to evaluation", "Test the tool against your specific I-T-O requirements: can it handle your input formats, perform your needed transformations, and produce your required outputs?", "Only evaluate based on price", "Just try it and see"]',
1,
'Tool evaluation should be grounded in actual requirements. Define your I-T-O needs, then test whether tools meet them, rather than evaluating tools in the abstract.'),

((SELECT id FROM quizzes WHERE title = 'Tool Selection Quiz'), 7,
'What is the relationship between tool selection and the 4-layer automation model?',
'["Tools only affect the execution layer", "Different tools serve different layers: LLMs for logic, code assistants for execution, no-code platforms for orchestration. Selection depends on which layer you are building", "The 4-layer model is separate from tool selection", "Use one tool for all layers"]',
1,
'The 4-layer model helps organize tool selection. Consider which layer each tool serves and ensure your toolkit covers all layers effectively.'),

((SELECT id FROM quizzes WHERE title = 'Tool Selection Quiz'), 8,
'How should you approach tool lock-in risk when building your toolkit?',
'["Ignore it and use whatever works", "Keep core skills transferable (prompting, workflow design), prefer tools with data export, and avoid over-reliance on proprietary features", "Never use tools that could create lock-in", "Lock-in is always bad"]',
1,
'Lock-in is a tradeoff. Proprietary features may add value, but core skills should be transferable and data should be exportable to maintain flexibility.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# Tool Selection Framework: Building Your AI Toolkit

The AI tool landscape expands constantly. New tools launch weekly, and existing tools add capabilities. This section provides a systematic approach to tool selection that remains useful as the landscape evolves.

## Definitions

**Tool Stack**: The combination of AI tools you use regularly for your work. A well-designed stack covers your needs without excessive overlap or gaps.

**Tool Evaluation**: The process of assessing whether a tool fits your specific requirements before committing to it. Involves testing against real use cases.

**Lock-in Risk**: The difficulty of switching away from a tool once you have invested in learning, integrating, and storing data within it.

**Build versus Buy**: The decision of whether to create custom solutions or use existing tools. Both have costs; the question is which costs fit your situation.

**Total Cost of Ownership**: The complete cost of a tool, including subscription fees, API usage, integration time, learning curve, and ongoing maintenance.

**Tier Matching**: Selecting tool capability levels that match task requirements. Using expensive tools for simple tasks wastes money; using simple tools for complex tasks produces poor results.

## The Tool Selection Problem

The AI tool market presents a paradox of choice. Hundreds of tools exist, many with overlapping capabilities. Making decisions is difficult because:

Marketing obscures real capabilities. Every tool claims to be powerful and easy.

Requirements vary by use case. The "best" tool depends on what you need.

Costs are often hidden. Subscription fees are visible; integration time and learning curves are not.

The landscape changes rapidly. Today''s recommendation may be obsolete in months.

You need a framework that cuts through the noise and produces decisions you can justify.

## The Selection Framework

### Step 1: Define Your Need Precisely

Before evaluating tools, articulate exactly what you need to accomplish.

Bad: "I need an AI tool for my business"

Better: "I need to classify incoming customer emails into five categories automatically"

Best: "I need to classify 50-100 customer emails daily into Technical, Billing, Sales, Feedback, or Spam categories, with 95 percent accuracy, integrating with our Zendesk ticketing system"

The precision of your need statement determines the precision of your evaluation.

Apply the I-T-O framework to your need:

Input: What data or content does the tool need to process? What formats, volumes, sources?

Task: What transformation or analysis is required? Classification, generation, extraction, modification?

Output: What result format is needed? How does it integrate with your other systems?

### Step 2: Identify Non-Negotiable Requirements

List the constraints that eliminate options immediately.

**Examples of must-haves:**

Budget ceiling: Cannot exceed X dollars monthly
Integration requirement: Must work with specific platform (Zapier, Salesforce)
Compliance requirement: Must meet specific standards (SOC 2, GDPR)
Performance requirement: Must handle X volume in Y timeframe
Technical requirement: Must have API access
Feature requirement: Must support specific capability

These hard constraints filter out unsuitable options before detailed evaluation.

### Step 3: Evaluate Remaining Options

For tools that pass your must-have filter, score on these five dimensions (1-10 each, max 50 points total):

**Fit for Purpose**

Does the tool solve your specific problem well?
Is this what the tool was designed for, or is it a workaround?
How well does it handle your I-T-O requirements?

**Ease of Use**

Can you figure it out quickly enough?
Is the learning curve acceptable for your timeline?
How much support and documentation exists?

**Cost**

What is the total cost at your expected usage?
Is pricing predictable or highly variable?
What is the ROI given time savings or output value?

**Integration**

Does it work with your existing systems?
Is API access available if needed?
How much integration work is required?

**Reliability and Longevity**

Is the tool stable and mature?
What is the company''s track record?
Is the tool likely to exist in two years?

Score each dimension 1-10 and sum for a total (max 50).

**Interpretation:**

40+ points: Excellent fit, proceed confidently
30-39 points: Good fit, proceed with awareness of gaps
20-29 points: Acceptable but not ideal, consider alternatives
Under 20 points: Look elsewhere

### Step 4: Test Before Committing

Never commit to a paid plan or significant integration based on marketing materials.

**Test protocol:**

Use free tier or trial period
Run through your actual use cases (not generic examples)
Measure results against your requirements
Note friction points and limitations
Compare to at least one alternative

**Document your test:**

What scenarios did you test?
What results did you achieve?
What did not work as expected?
How does it compare to alternatives?

### Step 5: Plan for Exit

Before committing, consider how you would leave if needed.

**Exit considerations:**

Is data exportable?
Are skills transferable to other tools?
What would switching cost (time, money, disruption)?
Are there dependencies that create lock-in?

Lower lock-in risk is valuable, but some lock-in may be acceptable for sufficient value.

## Connecting to Earlier Modules

### Capability Tier Matching

From Module 1, remember that AI models and tools have capability tiers:

Fast/Cheap tier: Simple tasks, high volume, low cost per operation
Balanced tier: Most typical work, good performance, reasonable cost
Deep Reasoning tier: Complex analysis, multi-step logic, higher cost

Tool selection should match capability to requirement.

**Example decision:**

Need: Classify emails into 5 categories

Wrong approach: Use a Deep Reasoning tier model for simple classification

Right approach: Use a Fast/Cheap tier model for this simple task

Need: Complex contract analysis

Wrong approach: Use a Fast/Cheap tier model for complex legal reasoning

Right approach: Use a Deep Reasoning tier model for complex legal analysis

Over-provisioning wastes money. Under-provisioning produces poor results. Match tier to task.

### 4-Layer Model for Tool Stack Design

From Module 2, every automation has four layers: Triggers, Logic, Execution, Outputs.

Your tool stack should cover all layers appropriately.

**Trigger layer tools:**

Form platforms (Tally, Typeform)
Email systems (Gmail, Outlook)
Webhook receivers
Scheduling tools (Cron, scheduler services)

**Logic layer tools:**

LLM platforms (ChatGPT, Claude) for AI processing
No-code platforms (Zapier, Make) for workflow logic
Code assistants (Cursor, Copilot) for custom logic

**Execution layer tools:**

Automation platforms (Zapier, Make, n8n) for orchestration
Code assistants for custom execution components
Specialized tools (Midjourney, ElevenLabs) for specific outputs

**Output layer tools:**

Notification services (Slack, email)
Database and storage systems
Document generation tools
Reporting and dashboard tools

Map your tools to layers to identify gaps or overlaps.

## Common Selection Scenarios

### Scenario: Choosing Between LLM Platforms

**Context:** You need a primary LLM platform for operator work.

**Apply the framework:**

Step 1 (Define need): General-purpose AI assistant for text analysis, code help, and content drafting. Daily use, moderate volume, need long document handling and code quality.

Step 2 (Must-haves): Reasonable monthly subscription cost, API access available (for future automation), large context window.

Step 3 (Evaluate options using 1-10 scores, summed):

ChatGPT Plus: Fit 8, Ease 9, Cost 9, Integration 9, Reliability 9, Total 44
Claude Pro: Fit 9, Ease 8, Cost 9, Integration 7, Reliability 8, Total 41
Gemini Advanced: Fit 7, Ease 7, Cost 9, Integration 6, Reliability 7, Total 36

Step 4 (Test): Both ChatGPT and Claude score highly. Test both with your actual workflows for a week.

**Likely outcome:** ChatGPT for general use, Claude for code-heavy and long-document work. Two subscriptions may be justified by the combined capabilities if you use both regularly.

### Scenario: No-Code versus Code for Automation

**Context:** You need to process incoming form data and route to different systems based on classification.

**Apply the framework:**

Step 1 (Define need): Receive 50-100 form submissions daily, classify into 3 categories, create records in appropriate systems (CRM, support tickets, or general inbox).

Step 2 (Must-haves): Handle volume reliably, integrate with existing CRM and ticketing system, manageable ongoing cost.

**Compare options using 1-10 scores, summed:**

**Option A: Zapier with AI actions**

Fit 8: Handles the use case well
Ease 9: No code, visual builder
Cost 5: Higher cost at this volume
Integration 9: Pre-built integrations exist
Reliability 9: Mature platform
Total: 40

**Option B: Make with OpenAI API**

Fit 9: More control over AI prompts
Ease 7: Steeper learning curve
Cost 8: Lower cost at volume
Integration 8: Good but requires more setup
Reliability 8: Stable platform
Total: 40

**Option C: Custom code solution**

Fit 10: Complete control
Ease 3: Requires development time
Cost 9: Lowest ongoing cost
Integration 6: Must build integrations
Reliability 7: Depends on your hosting and maintenance
Total: 35

**Decision logic:**

If development time is available and volume is high, custom code wins on cost.
If speed to deployment matters and volume is moderate, Zapier is fastest.
If control and moderate cost matter, Make offers a good balance.

### Scenario: Adding Image Generation

**Context:** You create client presentations and need custom images rather than stock photos.

**Apply the framework:**

Step 1 (Define need): Generate 10-20 professional images monthly for client presentations. Need consistent style, business-appropriate content, 16:9 format.

Step 2 (Must-haves): Commercial usage rights, business-appropriate content policies, reasonable quality for client-facing work.

**Compare options using 1-10 scores, summed:**

**Midjourney (paid tier)**

Fit 10: High quality for artistic and photorealistic images
Ease 6: Interface may feel unfamiliar
Cost 8: Reasonable for this volume
Integration 5: Limited API options
Reliability 8: Consistent quality
Total: 37

**DALL-E via ChatGPT Plus (if already subscribed)**

Fit 7: Good quality but not as artistic
Ease 9: Integrated into existing workflow
Cost 10: Already paying for ChatGPT
Integration 8: Conversational iteration
Reliability 8: Consistent availability
Total: 42

**Decision logic:**

If you already have ChatGPT Plus, start with DALL-E (zero incremental cost).
If DALL-E quality is insufficient for client work, add Midjourney.
The hybrid approach: DALL-E for quick mockups, Midjourney for final client images.

## Building Your Tool Stack

### The Tiered Approach

Organize your toolkit in tiers based on importance:

**Tier 1: Core (essential, daily use)**

These are the tools you cannot work without. Pay full price, learn deeply, rely on completely.

Examples: Primary LLM (ChatGPT or Claude), code assistant (Cursor or Copilot), automation platform (Zapier or Make)

**Tier 2: Regular (frequent use, weekly or more)**

These tools provide significant value for specific tasks. Worth paying for if you use them regularly.

Examples: Secondary LLM, image generation, voice synthesis, specialized analysis tools

**Tier 3: Occasional (specific needs, monthly or less)**

These tools serve specific purposes but are not daily drivers. Use free tiers when possible, pay only when needed.

Examples: Specialized video tools, niche research platforms, one-off project tools

### The Budget Framework

Calculate your AI tool budget rationally:

**Your hourly value:** What you bill clients or equivalent internal value. For most operators, 50-150 dollars per hour.

**Time saved by tools:** Estimate conservatively. Most operators save 5-20 hours monthly with good tools.

**Value of time saved:** Hours saved times hourly value.

**Budget guideline:** Spend 10-25 percent of the value created on tools.

**Example calculation:**

Your hourly value: 75 dollars
Hours saved monthly by AI tools: 15 hours
Value created: 1,125 dollars monthly
Tool budget range: 112-280 dollars monthly

This creates a clear ROI framework. Tools that save time are worth their cost.

### Avoiding Common Traps

**Trap: Shiny object syndrome**

You try every new tool that launches, never mastering any.

Fix: Evaluate new tools only when you have a specific unmet need. Master your core tools first.

**Trap: Feature comparison paralysis**

You compare endlessly, never choosing.

Fix: Set a decision deadline. Choose the option that passes your must-haves and scores highest. You can switch later if needed.

**Trap: Subscription creep**

You accumulate subscriptions for tools you rarely use.

Fix: Quarterly audit. Cancel anything unused in the past 30 days unless there is a specific future need.

**Trap: Wrong tool for task**

You use ChatGPT for everything when other tools would work better.

Fix: Match tool to task. Reference your framework when facing a new task type.

**Trap: Refusing to switch**

You stick with the first tool you learned even as better options emerge.

Fix: Annual review of core tools. Test alternatives to ensure you are not missing significant improvements.

## Future-Proofing Your Stack

The AI landscape evolves rapidly. Build flexibility into your approach.

**Keep skills transferable:**

Prompting skills transfer across LLMs.
Workflow design skills transfer across automation platforms.
I-T-O thinking applies regardless of tools.

Focus on principles, not tool-specific tricks.

**Prefer data portability:**

Choose tools that export your data.
Document your workflows so they can be rebuilt.
Avoid storing critical data only in proprietary formats.

**Stay informed, not reactive:**

Follow developments without chasing every trend.
Evaluate quarterly whether your stack still fits.
Switch when clear improvements exist, not on hype.

**Build relationships, not dependencies:**

Choose tools with good support and community.
Prefer companies likely to exist in 3-5 years.
Have backup options for critical capabilities.

## The Selection Checklist

Use this checklist for any significant tool decision:

**Before evaluation:**

Have I clearly defined what I need (I-T-O)?
Have I listed my must-have requirements?
Have I identified at least 2-3 options to compare?

**During evaluation:**

Have I scored each option on the five dimensions?
Have I tested with my real use cases?
Have I measured against my specific requirements?

**Before committing:**

Have I verified the total cost at my expected usage?
Have I considered lock-in and exit costs?
Have I confirmed integration requirements are met?
Can I justify this decision to myself (or my team)?

**After committing:**

Have I scheduled a review (30 days to assess fit)?
Have I documented my workflow with this tool?
Have I identified what would trigger reconsideration?',

exercise_markdown = '## Exercise: Build Your Personal Tool Stack

**Objective:** Apply the tool selection framework to design, justify, and document your AI tool stack.

This is a synthesis exercise that draws on everything in Module 4. You will create a documented toolkit that serves your actual needs, with clear reasoning for each choice.

### Part 1: Audit Your Current State

**Inventory every AI tool you currently have access to:**

Create a table with columns for: Tool Name, Category (LLM/Code/No-Code/Specialized/Other), Monthly Cost, Last Used Date, Primary Use Case, Satisfaction (1-10)

Include free tools and trials. Be thorough.

**Calculate your current total:**

Total monthly cost: ___
Tools used in last 7 days: ___
Tools used in last 30 days: ___
Tools not used in 30+ days: ___

**Identify obvious candidates for elimination:**

Which tools have you paid for but not used?
Which free tools are you not actually using?
Which tools duplicate capabilities of others?

### Part 2: Define Your Requirements

**List your top 5 most frequent AI-assisted tasks:**

For each task, specify:
- Task description
- Frequency (daily/weekly/monthly)
- Current tool used
- I-T-O summary (input type, task performed, output format)
- Satisfaction with current approach (1-10)

**Identify gaps:**

What tasks do you struggle with?
What tasks take too long?
What outputs are lower quality than you want?
What manual work could be automated?

**Specify your must-haves:**

Budget ceiling: ___
Required integrations: ___
Compliance requirements: ___
Technical requirements: ___

### Part 3: Map Tools to the 4-Layer Model

**For each layer, identify your current and ideal tools:**

**Trigger layer:**
Current tools: ___
Gaps or issues: ___
Ideal state: ___

**Logic layer:**
Current tools: ___
Gaps or issues: ___
Ideal state: ___

**Execution layer:**
Current tools: ___
Gaps or issues: ___
Ideal state: ___

**Output layer:**
Current tools: ___
Gaps or issues: ___
Ideal state: ___

**Identify the biggest layer gap:** Which layer is least well-served by your current tools?

### Part 4: Evaluate Key Decisions

**Pick your 3 most important tool categories and evaluate options:**

**Category 1: Primary LLM**

Options to evaluate: ChatGPT Plus, Claude Pro, Gemini Advanced (or others)

For each option, score (1-10):
- Fit for your specific tasks
- Ease of use for your workflow
- Cost relative to your budget
- Integration with your other tools
- Reliability and track record

Calculate weighted total for each.

Decision: ___ because ___

**Category 2: Code Assistant (if applicable) OR No-Code Platform**

Options to evaluate: (list 2-3 relevant options)

Apply same scoring framework.

Decision: ___ because ___

**Category 3: Specialized Tool (image, voice, or other)**

Options to evaluate: (list 2-3 relevant options)

Apply same scoring framework.

Decision: ___ because ___

### Part 5: Test Your Decisions

**For each decision you made, run a real test:**

**Test 1: Primary LLM**

Take a real task from your work
Run it through your chosen platform
Measure: Quality, speed, satisfaction
Compare to an alternative if possible
Confirm or revise decision

**Test 2: Second tool category**

Same process with a real task

**Test 3: Third tool category**

Same process with a real task

**Document test results:**

Did the tool perform as expected?
What surprised you?
Does your decision still hold?

### Part 6: Design Your Stack

**Organize your final toolkit:**

**Tier 1: Core (daily use, essential)**

Tool 1: ___ for ___
Monthly cost: ___
Justification: ___

Tool 2: ___ for ___
Monthly cost: ___
Justification: ___

Tool 3: ___ for ___
Monthly cost: ___
Justification: ___

**Tier 2: Regular (weekly use, valuable)**

Tool 1: ___ for ___
Monthly cost: ___
Justification: ___

Tool 2: ___ for ___
Monthly cost: ___
Justification: ___

**Tier 3: Occasional (as needed)**

Tool 1: ___ for ___
Cost approach: Free tier / pay when needed
Justification: ___

**Stack changes from current state:**

Tools to add: ___
Tools to cancel: ___
Tools to upgrade: ___
Tools to downgrade: ___

### Part 7: Calculate ROI

**Estimate the value your stack creates:**

Your hourly value (what you bill or equivalent): ___

Time saved by Tier 1 tools (hours monthly): ___
Time saved by Tier 2 tools (hours monthly): ___
Total time saved: ___

Value of time saved: ___ (hours x hourly value)

**Calculate ROI:**

Total stack cost (monthly): ___
Value created (monthly): ___
ROI ratio: ___ (value / cost)

**Is this a good investment?**

What would have to change for this not to be worth it?
At what point would you add more tools?
At what point would you reduce spending?

### Part 8: Plan Your Implementation

**If making changes to your stack:**

**Week 1:**
Actions: ___
Cancellations: ___
New signups: ___

**Week 2-4:**
Learning priorities: ___
Integration work: ___
Workflow updates: ___

**30-day review plan:**
What will you measure?
What would trigger changes?
When specifically will you review?

### Deliverable

Create a comprehensive document containing:

**Section 1: Current State Analysis**
- Tool inventory with usage and cost data
- Identified redundancies and gaps
- Total current spend

**Section 2: Requirements Definition**
- Top 5 tasks with I-T-O specifications
- Identified gaps and pain points
- Must-have requirements list

**Section 3: 4-Layer Model Mapping**
- Current tools by layer
- Gaps by layer
- Ideal state by layer

**Section 4: Key Decisions**
- Evaluation matrices for 3 categories
- Scoring with reasoning
- Final decisions with justification

**Section 5: Test Results**
- Real task test outcomes
- Comparison data
- Decision confirmations or revisions

**Section 6: Final Stack Design**
- Tiered tool list with justifications
- Changes from current state
- Total monthly cost

**Section 7: ROI Analysis**
- Time savings estimates
- Value calculations
- ROI ratio and interpretation

**Section 8: Implementation Plan**
- Week-by-week actions
- Success metrics
- Review schedule

### Success Criteria

You have completed this exercise successfully when:
- Audited your current tool usage honestly
- Defined requirements using I-T-O framework
- Applied the 4-layer model to organize your toolkit
- Evaluated at least 3 tool decisions with the scoring framework
- Tested decisions with real tasks
- Created a justified, organized tool stack
- Calculated ROI showing positive return
- Have a concrete implementation plan
- Can explain your choices to someone else',

exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Audit Current State",
      "description": "Inventory all AI tools you currently have access to.",
      "fields": [
        {
          "id": "tool_inventory",
          "type": "textarea",
          "label": "List every AI tool you have access to (include free tools and trials):",
          "placeholder": "Tool 1: [name]\n- Category: [LLM/Code/No-Code/Specialized]\n- Monthly cost: $X\n- Last used: [date]\n- Primary use: [what you use it for]\n- Satisfaction: X/10\n\nTool 2: [name]\n...",
          "required": true,
          "rows": 12
        },
        {
          "id": "current_totals",
          "type": "textarea",
          "label": "Calculate current totals:",
          "placeholder": "Total monthly cost: $X\nTools used in last 7 days: X\nTools used in last 30 days: X\nTools not used in 30+ days: X",
          "required": true,
          "rows": 4
        },
        {
          "id": "elimination_candidates",
          "type": "textarea",
          "label": "Tools to consider eliminating:",
          "placeholder": "Paid but unused: ...\nFree but unused: ...\nDuplicates of other tools: ...",
          "required": true,
          "rows": 4
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Define Requirements",
      "description": "List your top AI-assisted tasks and identify gaps.",
      "fields": [
        {
          "id": "top_tasks",
          "type": "textarea",
          "label": "Your top 5 most frequent AI-assisted tasks:",
          "placeholder": "Task 1: [description]\n- Frequency: [daily/weekly/monthly]\n- Current tool: [name]\n- I-T-O: Input=[type], Task=[what], Output=[format]\n- Satisfaction: X/10\n\nTask 2: ...",
          "required": true,
          "rows": 15
        },
        {
          "id": "gaps_identified",
          "type": "textarea",
          "label": "Identify gaps in your current setup:",
          "placeholder": "Tasks I struggle with: ...\nTasks that take too long: ...\nLower quality outputs: ...\nManual work that could be automated: ...",
          "required": true,
          "rows": 5
        },
        {
          "id": "must_haves",
          "type": "textarea",
          "label": "Your must-have requirements:",
          "placeholder": "Budget ceiling: $X/month\nRequired integrations: ...\nCompliance requirements: ...\nTechnical requirements: ...",
          "required": true,
          "rows": 4
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: 4-Layer Model Mapping",
      "description": "Map your tools to each automation layer.",
      "fields": [
        {
          "id": "layer_mapping",
          "type": "textarea",
          "label": "Current and ideal tools for each layer:",
          "placeholder": "TRIGGER LAYER:\n- Current tools: ...\n- Gaps: ...\n- Ideal: ...\n\nLOGIC LAYER:\n- Current tools: ...\n- Gaps: ...\n- Ideal: ...\n\nEXECUTION LAYER:\n- Current tools: ...\n- Gaps: ...\n- Ideal: ...\n\nOUTPUT LAYER:\n- Current tools: ...\n- Gaps: ...\n- Ideal: ...",
          "required": true,
          "rows": 16
        },
        {
          "id": "biggest_gap",
          "type": "text",
          "label": "Which layer is least well-served?",
          "placeholder": "e.g., Logic layer - no good AI routing tool",
          "required": true
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Evaluate Key Decisions",
      "description": "Score and compare options for your 3 most important categories.",
      "fields": [
        {
          "id": "llm_evaluation",
          "type": "textarea",
          "label": "Primary LLM evaluation (score each 1-10):",
          "placeholder": "Option 1: ChatGPT Plus\n- Fit for my tasks: X\n- Ease of use: X\n- Cost vs budget: X\n- Integrations: X\n- Reliability: X\n- Total: XX\n\nOption 2: Claude Pro\n[same format]\n\nDecision: [choice] because [reason]",
          "required": true,
          "rows": 12
        },
        {
          "id": "second_category",
          "type": "textarea",
          "label": "Second category evaluation (Code Assistant or No-Code Platform):",
          "placeholder": "Category: [Code Assistant / No-Code Platform]\n\nOption 1: [name]\n- Scores...\n\nOption 2: [name]\n- Scores...\n\nDecision: [choice] because [reason]",
          "required": true,
          "rows": 10
        },
        {
          "id": "third_category",
          "type": "textarea",
          "label": "Third category evaluation (Specialized Tool):",
          "placeholder": "Category: [Image/Voice/Other]\n\nOption 1: [name]\n- Scores...\n\nOption 2: [name]\n- Scores...\n\nDecision: [choice] because [reason]",
          "required": true,
          "rows": 10
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Test Decisions",
      "description": "Test each decision with a real task.",
      "fields": [
        {
          "id": "test_results",
          "type": "textarea",
          "label": "Document test results for each tool decision:",
          "placeholder": "Test 1: Primary LLM\n- Real task used: [describe]\n- Quality: X/10\n- Speed: [fast/medium/slow]\n- Satisfaction: X/10\n- Decision confirmed: [Yes/No, revised to...]\n\nTest 2: Second tool\n[same format]\n\nTest 3: Third tool\n[same format]",
          "required": true,
          "rows": 14
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: Design Your Stack",
      "description": "Organize your final toolkit in tiers.",
      "fields": [
        {
          "id": "tier1_core",
          "type": "textarea",
          "label": "Tier 1: Core tools (daily use, essential):",
          "placeholder": "Tool 1: [name] for [purpose]\n- Monthly cost: $X\n- Justification: ...\n\nTool 2: [name] for [purpose]\n- Monthly cost: $X\n- Justification: ...\n\nTool 3: [name] for [purpose]\n- Monthly cost: $X\n- Justification: ...",
          "required": true,
          "rows": 10
        },
        {
          "id": "tier2_regular",
          "type": "textarea",
          "label": "Tier 2: Regular tools (weekly use, valuable):",
          "placeholder": "Tool 1: [name] for [purpose]\n- Monthly cost: $X\n- Justification: ...\n\nTool 2: [name] for [purpose]\n- Monthly cost: $X\n- Justification: ...",
          "required": true,
          "rows": 6
        },
        {
          "id": "tier3_occasional",
          "type": "textarea",
          "label": "Tier 3: Occasional tools (as needed):",
          "placeholder": "Tool 1: [name] for [purpose]\n- Cost approach: [Free tier / Pay when needed]\n\nTool 2: ...",
          "required": true,
          "rows": 4
        },
        {
          "id": "stack_changes",
          "type": "textarea",
          "label": "Changes from current state:",
          "placeholder": "Tools to add: ...\nTools to cancel: ...\nTools to upgrade: ...\nTools to downgrade: ...",
          "required": true,
          "rows": 4
        }
      ]
    },
    {
      "id": "part7",
      "title": "Part 7: Calculate ROI",
      "description": "Estimate the value your stack creates.",
      "fields": [
        {
          "id": "hourly_value",
          "type": "text",
          "label": "Your hourly value (billing rate or equivalent):",
          "placeholder": "e.g., $75",
          "required": true
        },
        {
          "id": "time_savings",
          "type": "textarea",
          "label": "Calculate time savings:",
          "placeholder": "Time saved by Tier 1 tools: X hours/month\nTime saved by Tier 2 tools: X hours/month\nTotal time saved: X hours/month\nValue of time saved: X hours x $X = $X/month",
          "required": true,
          "rows": 4
        },
        {
          "id": "roi_calculation",
          "type": "textarea",
          "label": "Calculate ROI:",
          "placeholder": "Total stack cost: $X/month\nValue created: $X/month\nROI ratio: X (value / cost)\n\nIs this a good investment? [Yes/No]\nWhat would change this assessment? ...",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part8",
      "title": "Part 8: Implementation Plan",
      "description": "Plan how to implement changes to your stack.",
      "fields": [
        {
          "id": "week1_actions",
          "type": "textarea",
          "label": "Week 1 actions:",
          "placeholder": "Cancellations: ...\nNew signups: ...\nImmediate changes: ...",
          "required": true,
          "rows": 4
        },
        {
          "id": "month1_actions",
          "type": "textarea",
          "label": "Week 2-4 actions:",
          "placeholder": "Learning priorities: ...\nIntegration work: ...\nWorkflow updates: ...",
          "required": true,
          "rows": 4
        },
        {
          "id": "review_plan",
          "type": "textarea",
          "label": "30-day review plan:",
          "placeholder": "What will I measure: ...\nWhat would trigger changes: ...\nSpecific review date: ...",
          "required": true,
          "rows": 4
        }
      ]
    }
  ],
  "deliverables": [
    "Tool inventory with usage and cost data",
    "Requirements with I-T-O specifications",
    "4-layer model mapping",
    "Evaluation matrices for 3 categories",
    "Test results with real tasks",
    "Tiered tool stack with justifications",
    "ROI analysis",
    "Implementation plan"
  ],
  "success_criteria": [
    "Audited current tool usage honestly",
    "Defined requirements using I-T-O framework",
    "Applied 4-layer model to organize toolkit",
    "Evaluated 3 tool decisions with scoring",
    "Tested decisions with real tasks",
    "Created justified, organized tool stack",
    "Calculated ROI showing return",
    "Have concrete implementation plan"
  ]
}'

WHERE slug = 'tool-selection';
