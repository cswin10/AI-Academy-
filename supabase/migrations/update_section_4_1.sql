-- ============================================================================
-- UPDATE SECTION 4.1: LLM Platforms (ChatGPT, Claude, Gemini, Perplexity)
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, add 4 more quiz questions to reach 8 total
INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'LLM Platforms Quiz'), 5,
'How does the capability tiers framework (Fast/Cheap, Balanced, Deep Reasoning) apply to LLM platform selection?',
'["It doesn''t apply to platforms", "Different platforms offer models at different capability tiers, and you should match tier to task complexity", "Always use the highest tier available", "Only use Fast/Cheap tier to save money"]',
1,
'Platform selection should consider which capability tiers each offers. Simple classification tasks need Fast/Cheap tier models, while complex reasoning benefits from Deep Reasoning tier.'),

((SELECT id FROM quizzes WHERE title = 'LLM Platforms Quiz'), 6,
'When designing a multi-step workflow using LLM platforms, what should guide your platform choice for each step?',
'["Use the same platform for consistency", "Match each step''s complexity to the appropriate capability tier across platforms", "Always use the cheapest option", "Use whichever platform is fastest"]',
1,
'The I-T-O framework applies here: each step has different input complexity and output requirements. A classification step might use Fast/Cheap tier while analysis uses Balanced or Deep Reasoning tier.'),

((SELECT id FROM quizzes WHERE title = 'LLM Platforms Quiz'), 7,
'Why is context window size particularly important for operators processing business documents?',
'["Larger windows are always better", "It determines how much of a document can be analyzed in a single request, affecting whether you need chunking strategies", "It only matters for code", "Context size has no practical impact"]',
1,
'Long context windows (200k+ tokens) allow processing entire documents without chunking. Shorter windows require breaking documents into pieces, adding complexity and potential information loss.'),

((SELECT id FROM quizzes WHERE title = 'LLM Platforms Quiz'), 8,
'What is the relationship between platform API access and the automation principles from Module 2?',
'["APIs are only for developers", "API access enables programmatic integration, allowing you to build the execution layer automations discussed in the 4-layer model", "Free tiers are sufficient for automation", "APIs and automation are unrelated"]',
1,
'The 4-layer model''s execution layer often requires API access to integrate LLMs into automated workflows. Without API access, you are limited to manual, chat-based interactions.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# LLM Platforms: Choosing the Right Model Interface

This section builds on the capability tiers introduced in Module 1 and the task design principles from Module 2. Understanding platform differences helps you select the right tool for each step in your workflows.

## Definitions

**LLM Platform**: A service that provides access to large language models through a user interface, API, or both. Platforms differ in available models, pricing structures, and additional features.

**Context Window**: The maximum amount of text (measured in tokens) a model can process in a single request. This includes both your input and the model''s output. Larger context windows enable processing longer documents without chunking.

**API Access**: Programmatic interface allowing you to send requests to models from code or automation tools. Essential for building the execution layer of the 4-layer automation model.

**Model Capability Tier**: As introduced in Module 1, models fall into tiers based on capability and cost. Fast/Cheap tier handles simple tasks efficiently. Balanced tier offers good performance for most operator work. Deep Reasoning tier handles complex analysis and multi-step logic.

**Tokens**: The units used to measure text length. Roughly 4 characters per token in English. A 100-page document contains approximately 75,000 tokens.

**Inference**: The process of sending a prompt to a model and receiving a response. You pay for inference based on input and output tokens consumed.

## Why Platform Selection Matters

Platform selection is not about finding the "best" platform. It is about matching platform strengths to your specific task requirements. This connects directly to the I-T-O framework from Module 2: your Input complexity, Task requirements, and Output format should guide which platform and model tier you choose.

Consider a lead classification task. The input is a form submission with name, company, and message. The task is binary classification (hot or cold). The output is a single word. This simple I-T-O pattern works well with Fast/Cheap tier models on any platform.

Now consider a contract analysis task. The input is a 50-page legal document. The task is identifying non-standard clauses and assessing risk. The output is a structured report with citations. This complex I-T-O pattern requires Deep Reasoning tier and a platform with large context windows.

## Platform Comparison

### ChatGPT (OpenAI)

OpenAI offers models across all capability tiers. GPT-4o-mini serves as a Fast/Cheap option for simple tasks. GPT-4o provides Balanced tier capabilities for most operator work. The o1 series offers Deep Reasoning for complex analysis requiring multi-step logic.

Strengths: Excellent structured output support including JSON mode and function calling. Strong ecosystem of Custom GPTs for creating reusable task-specific interfaces. Web browsing and DALL-E image generation included with Plus subscription. Most widely adopted platform with extensive community resources.

Limitations: Can be verbose in responses when conciseness is needed. Conservative content policies sometimes refuse legitimate requests. Shorter maximum context window than Claude for very long documents.

Best for: Structured data extraction (connect to Module 3.2 on output formatting). Tool-integrated workflows using function calling. Creating reusable Custom GPTs for repeated tasks. Image generation needs via DALL-E integration.

Pricing structure: Plus subscription at 20 dollars monthly provides chat interface access. API pricing is usage-based, approximately 2.50 dollars per million tokens for GPT-4o.

### Claude (Anthropic)

Claude offers Haiku as Fast/Cheap tier, Sonnet as Balanced tier, and Opus as Deep Reasoning tier. The distinctive feature is a 200,000 token context window, enabling analysis of very long documents without chunking.

Strengths: Exceptional code generation and debugging capabilities. 200k context window handles documents that would require chunking on other platforms. Thoughtful, detailed responses that follow complex instructions well. Projects feature allows persistent context across conversations.

Limitations: No native image generation capability. No web browsing (relies on provided content). Smaller third-party integration ecosystem than ChatGPT.

Best for: Code writing and debugging tasks. Analyzing long documents (100+ pages) in single requests. Complex reasoning tasks requiring careful instruction following. System architecture design and technical documentation.

Pricing structure: Pro subscription at 20 dollars monthly for chat interface. API pricing varies by tier, approximately 3 dollars per million tokens for Sonnet.

### Gemini (Google)

Gemini integrates deeply with Google Workspace and Search. The platform offers competitive models but integration with Google ecosystem is the primary differentiator.

Strengths: Native Google Workspace integration (Docs, Sheets, Gmail). Real-time web search through Google Search integration. Strong multimodal capabilities for image and video analysis. Competitive pricing and generous free tier.

Limitations: Less consistent output quality than GPT-4 or Claude for complex tasks. Smaller developer community and fewer third-party resources. Limited availability of advanced features in some regions.

Best for: Teams heavily using Google Workspace. Tasks requiring real-time web information. Multimodal analysis of images and video content.

### Perplexity

Perplexity is purpose-built for research tasks with citation. Unlike general-purpose LLMs, every response includes sources.

Strengths: Always provides citations and source links. Built-in web search that is the default mode. Clean interface focused on research workflow. Multiple search modes (Quick, Pro, Focus) for different needs.

Limitations: Not designed for creative writing or content generation. Limited code generation capabilities. Smaller context window than competitors. No API access currently available.

Best for: Research requiring verifiable sources. Fact-checking and verification tasks. Quick answers about current events. Comparing information across multiple sources.

## Connecting Platform Choice to the 4-Layer Model

From Module 2, recall the 4-layer automation model: Triggers, Logic, Execution, and Outputs. Platform selection primarily affects the Logic and Execution layers.

In the Logic layer, you design how AI processes information. A simple classification might use any platform''s Fast/Cheap tier. A complex analysis chain might use Claude''s long context for document ingestion, then ChatGPT''s function calling for structured extraction.

In the Execution layer, API access becomes critical. Platforms without APIs (like Perplexity currently) cannot integrate into automated workflows. When designing execution layer automations, confirm your chosen platform offers the API capabilities you need.

Consider this workflow: receive customer email (Trigger), classify urgency and extract action items (Logic), route to appropriate team (Execution), send acknowledgment (Output). The Logic layer might use a Fast/Cheap tier model for classification plus a Balanced tier model for extraction. The Execution layer requires API access for programmatic integration with email and ticketing systems.

## Multi-Platform Strategies

Many operators use multiple platforms strategically. This is not about redundancy but about matching platform strengths to task types.

A common pattern uses ChatGPT for 70 percent of tasks (general queries, structured extraction, quick analysis) and Claude for code-heavy or long-document work. This provides coverage when one platform is rate-limited and leverages each platform''s strengths.

For research workflows, the pattern might be: Perplexity for initial research with sources, then ChatGPT or Claude for analysis and synthesis of gathered information.

Consider the cost implications. Two platform subscriptions at 20 dollars each totals 40 dollars monthly. If this saves even one hour of work monthly (at typical operator rates of 50-100 dollars per hour), the investment pays for itself.

## Capability Tier Mapping Across Platforms

Understanding which models on each platform correspond to which capability tier helps you make efficient choices.

Fast/Cheap tier (simple classification, basic extraction): GPT-4o-mini on ChatGPT, Haiku on Claude, Gemini Flash on Google.

Balanced tier (most operator work, moderate complexity): GPT-4o on ChatGPT, Sonnet on Claude, Gemini Pro on Google.

Deep Reasoning tier (complex analysis, multi-step logic, code architecture): o1 series on ChatGPT, Opus on Claude, Gemini Ultra on Google.

For each step in your workflow, ask: what is the minimum capability tier that produces acceptable results? Using Deep Reasoning tier for simple classification wastes money and adds latency.

## Platform-Specific Features

### ChatGPT Custom GPTs

Custom GPTs let you create specialized interfaces for repeated tasks. You define instructions, upload knowledge files, and configure how the GPT behaves. This connects to Module 3''s discussion of optimizing prompts for specific use cases.

Example applications include a Process Analyzer GPT (trained on your frameworks and I-T-O methodology), an Email Response Writer GPT (trained on your communication style), or a Code Reviewer GPT (trained on your team''s standards).

Creating a Custom GPT: access through ChatGPT Plus, navigate to Explore GPTs, then Create. Describe the purpose, add detailed instructions, upload relevant documents, test with sample queries, and iterate until behavior matches expectations.

### Claude Projects

Claude Projects organize work by client or project with persistent context. Upload documents that remain available across all conversations in that project. This reduces repetition and maintains consistency.

Example projects include a specific client engagement (all context about their systems and requirements), a learning project (study materials and notes), or an automation project (your standard frameworks and templates).

### Perplexity Collections

Collections save and organize research for later reference. Group related searches together. Build research libraries over time.

## Decision Framework for Platform Selection

When facing a new task, use this decision process:

First, analyze the I-T-O pattern. What is the input size and complexity? What does the task require (classification, extraction, generation, analysis)? What output format is needed?

Second, identify constraints. Do you need API access for automation? Is there a budget limit? Are there compliance requirements affecting platform choice?

Third, match to platform strengths. Long document? Consider Claude''s 200k context. Need citations? Use Perplexity. Building structured outputs? ChatGPT''s JSON mode and function calling work well.

Fourth, consider capability tier. Simple task? Use Fast/Cheap to save cost and reduce latency. Complex reasoning? Use Deep Reasoning tier.

Quick reference for common scenarios:

For code generation or debugging, use Claude.
For structured data extraction to JSON, use ChatGPT.
For research requiring sources, use Perplexity.
For documents over 100 pages, use Claude.
For Google Workspace integration, use Gemini.
For image generation, use ChatGPT with DALL-E.
For general everyday queries, use ChatGPT or Claude based on preference.
For quick fact verification, use Perplexity.

## API Access and Automation

Module 2 introduced the execution layer of automations. API access transforms platforms from chat interfaces into automation components.

With API access, you can send requests programmatically from code, integrate into Zapier, Make, or n8n workflows (covered in Section 4.3), build custom applications, and process high volumes without manual interaction.

API pricing is usage-based. You pay per token consumed (input plus output). For high-volume automation, calculate expected costs before implementation.

Example cost calculation: A lead classification workflow processes 1,000 leads monthly. Each classification uses approximately 500 input tokens and 50 output tokens. Using GPT-4o-mini at 0.15 dollars per million input tokens and 0.60 dollars per million output tokens results in approximately 0.11 dollars monthly for this workflow.

## Common Mistakes

Mistake: Using only free tiers to avoid cost. Reality: Free tier limits interrupt workflow. Waiting costs more than subscriptions if you value your time.

Mistake: Using one platform for everything. Reality: Platforms have distinct strengths. Using ChatGPT for long document analysis when Claude handles it better wastes time and produces inferior results.

Mistake: Ignoring API access when planning automations. Reality: The execution layer requires programmatic access. Choosing a platform without APIs limits your automation capabilities.

Mistake: Not organizing work with Projects or Custom GPTs. Reality: Repeated tasks benefit from persistent context and customized instructions. Rebuilding context each conversation wastes tokens and time.

Mistake: Over-relying on Deep Reasoning tier. Reality: Many tasks work fine with Balanced or Fast/Cheap tiers. Using the highest capability for everything increases cost without benefit.

## Practical Application

As you work through this module, you will test multiple platforms with identical prompts to experience their different characteristics. This hands-on comparison builds intuition for when to use which platform.

The exercise for this section asks you to run the same analysis task across available platforms, compare results, and document your observations. This connects directly to the I-T-O framework: same input, same task, observe output differences.',

exercise_markdown = '## Exercise: Platform Comparison and Personal Workflow Design

**Objective:** Experience platform differences firsthand and design your personal multi-platform workflow based on evidence.

This exercise connects to Module 2''s I-T-O framework. You will use identical inputs across platforms, observe how each handles the task, and compare outputs systematically.

### Part 1: Identical Task Across Platforms

**Scenario:** You received this process description from a potential client:

"We get about 50 support emails daily to support@company.com. Currently someone manually reads each one, figures out if it''s technical support or billing related, then forwards to the right team. Sometimes emails sit for hours before anyone reads them. We want to improve this."

**Your Task:** Analyze this process and suggest improvements using the 4-layer automation model from Module 2.

**Prompt to use (identical on each platform):**

Analyze this business process and suggest 3 automation improvements, progressing from simplest to most advanced. For each suggestion, identify which layer of the 4-layer automation model (Trigger, Logic, Execution, Output) is primarily affected. Also specify which capability tier (Fast/Cheap, Balanced, Deep Reasoning) would be appropriate for any AI components.

Process description: We receive approximately 50 customer support emails daily to support@company.com. Someone manually reads each email, determines if it is technical support or billing related, then forwards to the appropriate team. Emails sometimes wait hours before being processed.

**Test on at least 2 platforms you have access to:**
- ChatGPT (Free or Plus)
- Claude (Free or Pro)
- Gemini (if available)
- Perplexity (if available)

**Document for each platform:**
1. Response time (approximately how long to generate)
2. Response structure (how well organized)
3. Practical applicability (could you implement these suggestions)
4. Correct use of the 4-layer model terminology
5. Appropriate capability tier recommendations
6. Overall quality rating (1-10)

### Part 2: Code Generation Comparison

**This tests platform strength for code tasks.**

**Prompt to use on ChatGPT and Claude:**

Write a Python function that processes a CSV file of customer records. The function should read the file, filter rows where the status column equals active and the country column equals UK, save matching rows to a new CSV file, and return a summary dictionary containing total rows processed and rows matched. Include error handling for file not found scenarios.

**Compare:**
- Code correctness (does it work)
- Error handling quality
- Code readability and comments
- Which would you trust in a production workflow

**Note:** This exercise uses prose description of code requirements, not actual code files. You are evaluating the platform''s ability to translate requirements into working code.

### Part 3: Long Document Analysis (if you have Claude Pro)

**This tests context window differences.**

Find a publicly available document of 20+ pages (a research paper, company report, or long article).

**Prompt:**

Summarize this document in 5 key points, then identify any specific action items or recommendations mentioned. For each action item, note which section of the document contains it.

**Compare ChatGPT and Claude:**
- Did either struggle with document length
- Quality of summary
- Completeness of action item identification
- Did either miss important information

### Part 4: Research with Sources (if you have Perplexity)

**This tests citation and research capabilities.**

**Perplexity prompt:**

What are current best practices for using AI in customer support automation? Provide sources for each recommendation.

**Compare to ChatGPT with web browsing enabled (if available):**
- Quality and relevance of sources
- Depth of information
- Ease of verifying claims
- Which would you trust for client-facing research

### Part 5: Platform Feature Setup

**Choose your primary platform and set up organization features:**

**If using ChatGPT as primary:**

Create a Custom GPT for "Business Process Analyzer" with these specifications:
- Uses the 4-layer automation model terminology
- Applies I-T-O framework to analyze processes
- Suggests capability tier for any AI components
- Outputs structured analysis with clear sections

Test it on 2-3 different process descriptions.

**If using Claude as primary:**

Create a Project for "Automation Analysis" with these elements:
- Upload a document explaining the 4-layer model
- Upload the I-T-O framework description
- Set project instructions for consistent analysis format

Test across 2-3 conversations to verify context persistence.

**Document:**
- Setup time required
- Does it remember context correctly
- Is the feature useful for your work

### Part 6: Cost-Benefit Analysis

**Calculate your personal ROI for platform subscriptions:**

**Current usage:**
- Hours per week using AI: ___
- Primary tasks: ___
- Current platform(s): ___
- Current monthly cost: ___

**Time saved estimate:**
- Could you do these tasks without AI: Yes / No
- If yes, how much longer would they take: ___ hours
- Your effective hourly rate: ___
- Monthly value of time saved: ___

**Decision factors:**
- If on free tier, how often do you hit limits: ___
- How much productive time do you lose waiting: ___
- What is the minimum value of 5 hours of your time: ___

**Recommendation to yourself:**
- Should you upgrade to paid tier: Yes / No
- Should you subscribe to multiple platforms: Yes / No
- Recommended monthly budget for AI platforms: ___
- Expected monthly ROI at this budget: ___

### Part 7: Personal Workflow Design

**Based on your testing, design your multi-platform workflow:**

**Primary platform for everyday use:** ___
**Reason:** ___

**Secondary platform for specific tasks:** ___
**Tasks it handles better:** ___

**Research platform:** ___
**When you would use it:** ___

**For specific task types:**
- Code generation and debugging: ___
- Long document analysis: ___
- Structured data extraction: ___
- Research requiring sources: ___
- Quick general questions: ___
- Creative writing or content: ___

**Access methods:**
- Web interface for these tasks: ___
- API for these tasks: ___
- Custom GPT or Project for these tasks: ___

**Monthly budget allocation:**
- Primary platform subscription: ___
- Secondary platform subscription: ___
- API credits for automation: ___
- Total monthly AI platform spend: ___

### Deliverable

Create a document containing:
1. Platform comparison results table with scores
2. Code quality comparison notes
3. Research quality comparison (if tested)
4. Your Custom GPT or Project configuration
5. Cost-benefit calculation
6. Your personal platform workflow design
7. Specific recommendations for your use case

### Success Criteria

You have achieved the exercise objectives when:
- You tested at least 2 platforms with identical prompts
- You can articulate specific strengths and weaknesses of each
- You have a justified personal workflow (not just preferences)
- Your cost-benefit analysis shows positive or negative ROI clearly
- You can recommend platforms to others based on their needs
- You understand how platform choice connects to the 4-layer model',

exercise_schema = '{
  "exercise_id": "4.1-platform-comparison",
  "title": "Platform Comparison and Personal Workflow Design",
  "objectives": [
    "Compare LLM platforms using identical prompts",
    "Evaluate platform-specific features",
    "Calculate personal ROI for subscriptions",
    "Design evidence-based multi-platform workflow"
  ],
  "parts": [
    {
      "part_number": 1,
      "title": "Identical Task Across Platforms",
      "type": "comparative_analysis",
      "task": "Run identical process analysis prompt on 2+ platforms",
      "input_scenario": "Email routing process with 50 daily emails",
      "evaluation_criteria": ["response_time", "structure", "practicality", "terminology_accuracy", "quality_rating"],
      "minimum_platforms": 2,
      "connection_to_module_2": "Uses 4-layer model and I-T-O framework"
    },
    {
      "part_number": 2,
      "title": "Code Generation Comparison",
      "type": "skill_comparison",
      "task": "Compare code output quality between platforms",
      "evaluation_criteria": ["correctness", "error_handling", "readability", "production_readiness"],
      "recommended_platforms": ["ChatGPT", "Claude"]
    },
    {
      "part_number": 3,
      "title": "Long Document Analysis",
      "type": "context_window_test",
      "task": "Process 20+ page document and compare handling",
      "evaluation_criteria": ["length_handling", "summary_quality", "completeness", "accuracy"],
      "optional": true,
      "requires": "Claude Pro for full comparison"
    },
    {
      "part_number": 4,
      "title": "Research with Sources",
      "type": "citation_comparison",
      "task": "Compare research and citation quality",
      "evaluation_criteria": ["source_quality", "depth", "verifiability", "trust_level"],
      "optional": true,
      "requires": "Perplexity access"
    },
    {
      "part_number": 5,
      "title": "Platform Feature Setup",
      "type": "hands_on_configuration",
      "task": "Configure Custom GPT or Claude Project",
      "options": {
        "chatgpt": "Create Business Process Analyzer Custom GPT",
        "claude": "Create Automation Analysis Project"
      },
      "evaluation_criteria": ["setup_time", "context_persistence", "practical_utility"]
    },
    {
      "part_number": 6,
      "title": "Cost-Benefit Analysis",
      "type": "financial_calculation",
      "task": "Calculate personal ROI for platform subscriptions",
      "required_calculations": ["hours_per_week", "time_saved", "hourly_rate", "monthly_value"],
      "output": "Subscription recommendation with budget"
    },
    {
      "part_number": 7,
      "title": "Personal Workflow Design",
      "type": "synthesis",
      "task": "Design multi-platform workflow based on testing evidence",
      "required_elements": ["primary_platform", "secondary_platform", "task_mapping", "access_methods", "budget_allocation"]
    }
  ],
  "deliverable": {
    "format": "document",
    "sections": ["comparison_table", "code_comparison", "feature_configuration", "cost_benefit", "workflow_design", "recommendations"]
  },
  "success_criteria": [
    "Tested 2+ platforms with identical prompts",
    "Articulated specific platform strengths and weaknesses",
    "Created justified personal workflow",
    "Completed ROI calculation with clear result",
    "Can recommend platforms based on others'' needs"
  ],
  "estimated_time_minutes": 90,
  "connections": {
    "module_1": "Capability tiers (Fast/Cheap, Balanced, Deep Reasoning)",
    "module_2": "4-layer automation model, I-T-O framework",
    "module_3": "Output formatting, prompt optimization"
  }
}'

WHERE slug = 'llm-platforms';
