-- ============================================================================
-- UPDATE SECTION 4.2: AI Code Assistants (Cursor, Windsurf, GitHub Copilot, Cline, Claude Code)
-- Modernized with extensive content, 8 quiz questions, and exercise_schema
-- ============================================================================

-- First, add 4 more quiz questions to reach 8 total
INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'AI Code Assistants Quiz'), 5,
'How do code assistants relate to the I-T-O framework when building automation scripts?',
'["They replace the need for I-T-O thinking", "They help you translate your I-T-O design into working code faster, but you still need to design the transformation", "They only work for simple tasks", "I-T-O framework does not apply to code"]',
1,
'Code assistants accelerate implementation but cannot replace design thinking. You still need to understand what input you have, what transformation is needed, and what output format is required.'),

((SELECT id FROM quizzes WHERE title = 'AI Code Assistants Quiz'), 6,
'What is the recommended approach when a code assistant generates code you do not understand?',
'["Accept it if it works", "Ask the assistant to explain each section before using the code", "Rewrite it yourself", "Delete it and try again"]',
1,
'Understanding generated code is essential for debugging, maintenance, and modification. Use the assistant''s explain capability to learn as you build.'),

((SELECT id FROM quizzes WHERE title = 'AI Code Assistants Quiz'), 7,
'How does iterative prompting apply to code assistants compared to chat-based LLMs?',
'["It does not apply", "The same principle applies: build incrementally with testable steps rather than requesting everything at once", "Code assistants require everything in one prompt", "Only chat LLMs benefit from iteration"]',
1,
'Module 3''s iterative approach applies to code: request basic functionality first, test it, then add error handling, logging, and additional features incrementally.'),

((SELECT id FROM quizzes WHERE title = 'AI Code Assistants Quiz'), 8,
'When building execution layer automations from Module 2, what role do code assistants play?',
'["They eliminate the need for automation platforms", "They help you write custom code components that integrate with or extend automation platforms like Zapier or Make", "They only work for simple scripts", "They replace the execution layer entirely"]',
1,
'Code assistants help you build custom webhook handlers, data processors, and integration scripts that complement no-code platforms when their built-in actions are insufficient.');

-- Update the section content with extensive modernized material
UPDATE sections
SET content_markdown = '# AI Code Assistants: Accelerating Implementation

This section introduces tools that transform how operators build technical solutions. Code assistants do not replace understanding, but they dramatically accelerate the path from design to working code. These tools connect directly to the execution layer of the 4-layer model from Module 2.

## Definitions

**Code Assistant**: An AI tool integrated into a code editor that helps write, explain, modify, and debug code. Unlike chat-based LLMs, code assistants see your entire project context.

**IDE (Integrated Development Environment)**: A software application providing comprehensive facilities for code development. Examples include VS Code, Cursor, and JetBrains products.

**Codebase Context**: The ability of a code assistant to reference other files in your project when generating suggestions. This enables more relevant and consistent code generation.

**Inline Completion**: Suggestions that appear as you type, predicting what you want to write next. Accept with a single keystroke.

**Multi-file Editing**: The ability to make coordinated changes across multiple files in a single operation. Essential for refactoring and feature additions that span multiple components.

**Prompt-to-Code**: Describing what you want in natural language and receiving generated code. The inverse of traditional programming where you write code directly.

## Why Code Assistants Matter for Operators

The statement "I am not a developer" no longer prevents you from building technical solutions. Code assistants bridge the gap between understanding what you need and implementing it.

Consider the execution layer from Module 2. Often, no-code tools handle 80 percent of a workflow, but the remaining 20 percent requires custom code. A webhook processor, a data transformation, a custom integration. Previously, this required hiring a developer or learning to code traditionally.

With code assistants, you can describe what you need in natural language, receive working code, test it, iterate with the assistant''s help, and deploy functional solutions. You learn programming concepts through building real solutions rather than abstract exercises.

This does not make you a "real developer" in the traditional sense. You become something different: an operator who can implement technical solutions when needed. The goal is shipping working automation, not passing coding interviews.

## The Major Code Assistants

### Cursor

Cursor is a code editor rebuilt entirely around AI assistance. It is a fork of VS Code, so it feels familiar, but every feature is designed for AI-first development.

**Core Features:**

Command-K (inline edit): Highlight code, press the keyboard shortcut, describe what you want changed, and the AI modifies it directly. This is the most-used feature for iterative development.

Command-L (chat): Open a sidebar chat to ask questions, request explanations, or generate new code. Reference specific files using @ mentions.

Tab completion: As you type, AI predicts the next code. Press Tab to accept. This accelerates routine coding significantly.

Composer (multi-file): Press Command-I to make changes across multiple files simultaneously. Describe a feature and watch it implement across your project.

**Pricing:** Free tier with limited requests. Pro subscription provides higher limits, priority access, and model choices. Check current pricing, as tiers and limits evolve.

**Best for:** Operators new to coding who want the most supportive environment. Building new projects from scratch. Learning to code through doing rather than studying.

### Windsurf (by Codeium)

Windsurf offers a similar AI-first experience to Cursor at a lower price point. It uses the same VS Code foundation with AI integrated throughout.

**Core Features:** Similar to Cursor with inline editing, chat, and completions. The "Cascade" feature enables multi-file operations similar to Cursor''s Composer.

**Pricing:** Free tier available. Pro subscription is typically priced lower than Cursor. Check current pricing for exact rates.

**Best for:** Operators who want AI-first coding at lower cost. Those who do not need Cursor''s bleeding-edge features.

### GitHub Copilot

Copilot is an AI assistant that integrates into existing editors rather than replacing them. It works within VS Code, JetBrains IDEs, and others.

**Core Features:**

Inline suggestions: As you type, Copilot suggests completions. These appear as ghost text that you accept with Tab.

Copilot Chat: A sidebar for asking questions about code, requesting explanations, or generating new code.

**Pricing:** Individual and business tiers available. Free tier available for students and open source maintainers. Check current pricing for exact rates.

**Best for:** Operators already comfortable with VS Code who want to add AI assistance. Those who prefer enhancing their existing workflow rather than switching editors.

### Cline

Cline is a VS Code agent extension that uses Claude for coding tasks. It brings Claude''s strong code capabilities directly into your editor.

**Core Features:**

Agent-style operation: Cline can read and write files, execute terminal commands, and perform multi-step tasks with your approval.

Approval workflow: Unlike other assistants that suggest code, Cline asks permission before each action. This gives you control over what it does.

Claude integration: Uses Claude''s API directly, benefiting from Claude''s strong code generation.

**Pricing:** Free extension. You provide your own Claude API key and pay per use. Cost depends on usage volume.

**Best for:** Operators who specifically want Claude for code. Those comfortable managing API costs. Users who want explicit control over AI actions.

### Claude Code

Claude Code is Anthropic''s official command-line interface for AI-assisted development. Unlike GUI-based editors, Claude Code runs directly in your terminal, making it powerful for developers who prefer command-line workflows.

**Core Features:**

Agentic operation: Claude Code can read and understand your entire codebase, edit multiple files, and execute terminal commands. It operates as an autonomous agent that completes multi-step tasks.

Terminal-native: Works in any terminal environment. Integrates with your existing command-line workflow, git, and build tools without requiring a specific editor.

Full codebase context: Automatically indexes and understands your project structure. References relevant files when generating or modifying code.

Command execution: Can run shell commands, tests, and build processes as part of completing tasks. You approve actions before execution.

Multi-file editing: Handles refactoring and feature implementation that spans many files in a single operation.

**Pricing:** Free and open source tool. Uses Claude API, so you pay based on API usage. Cost scales with how much you use it.

**Best for:** Developers comfortable in the terminal who want maximum power and flexibility. Those building complex features requiring multi-file changes. Operators who want agentic AI that can handle entire workflows. Users who prefer open source tools.

## How Operators Use Code Assistants

### Use Case 1: Building Automation Scripts

**Scenario:** You need a Python script that reads a CSV file, makes API calls for each row, and logs the results.

**Without code assistant:** Research how to read CSV in Python (30 minutes). Learn the requests library for API calls (30 minutes). Write the code with trial and error (1 hour). Debug errors (1 hour). Add error handling (30 minutes). Total: 3+ hours.

**With code assistant:** Open Cursor. Use Command-K and describe: "Create a Python script that reads customers.csv, posts each row as JSON to the webhook URL I specify, includes retry logic for failed requests, and logs all activity to a file." Review generated code. Test with sample data. Use Command-K to add: "Add a progress indicator showing how many rows processed." Total: 30 minutes.

The assistant handles syntax, library usage, and boilerplate. You focus on specifying what you need using the I-T-O framework: CSV input, HTTP transformation, logged output.

### Use Case 2: Modifying Existing Code

**Scenario:** A Zapier Code step is not handling empty fields correctly.

**Without assistant:** Remember JavaScript syntax. Debug the logic. Test fixes. Time: 30-60 minutes if you know JavaScript, longer if not.

**With assistant:** Paste the code into Cursor. Command-L: "This code fails when the email field is empty. Explain what happens and fix it." Review the explanation, understand the issue, accept the fix. Time: 5 minutes.

### Use Case 3: Learning Through Building

**Traditional learning:** Take a course (weeks). Complete exercises (more weeks). Forget the material before you need it.

**Learning with code assistants:** Identify a real problem you want to solve. Start building with AI help. Ask the assistant to explain each part you do not understand. Learn concepts in context as you create something useful.

This approach is faster because you are motivated (solving a real problem), learning is contextual (understanding why not just what), and you produce working output while learning.

## Connecting to Earlier Modules

### I-T-O Framework for Code Requests

When asking code assistants to generate code, structure your request using Input-Task-Output:

**Input specification:** "Read from customers.csv containing columns: name, email, company, status"

**Task description:** "Filter rows where status equals active and company is not empty"

**Output requirement:** "Write matching rows to active_customers.csv and print how many rows matched"

Clear I-T-O requests produce better code on the first attempt, reducing iteration cycles.

### Capability Tiers in Code Assistants

Code assistants use models internally, and the capability tier matters. Cursor and Copilot use various models, often defaulting to Balanced tier.

For simple tasks (autocomplete, small functions), Fast/Cheap tier works well.

For complex tasks (architecture decisions, multi-file refactoring), you want Balanced or Deep Reasoning tier models.

Cursor Pro lets you select models, enabling tier matching to task complexity.

### Execution Layer Integration

From Module 2, the execution layer performs the actual work. Code assistants help you build custom execution layer components:

**Webhook handlers:** Receive data from triggers and process it.
**Data transformers:** Convert between formats that automation platforms cannot handle natively.
**Integration scripts:** Connect systems without native integrations.
**Scheduled jobs:** Run periodic tasks that complement event-driven automation.

## Best Practices for Code Assistants

### Practice 1: Be Specific in Requests

**Less effective:** "Make this code better"

**More effective:** "Add error handling for cases where the API returns a 429 rate limit response. Implement exponential backoff with a maximum of 3 retries."

Specificity follows from clear I-T-O thinking. If you cannot be specific, you may need to clarify your requirements before coding.

### Practice 2: Build Incrementally

Do not request everything at once. This mirrors Module 3''s iterative approach to prompting.

Step 1: "Create a basic script that reads the CSV and prints each row"
Test that it works.

Step 2: "Add the API call for each row"
Test that it works.

Step 3: "Add error handling for network failures"
Test the error cases.

Each step is testable. Problems are isolated to recent changes.

### Practice 3: Understand Before Accepting

Do not blindly accept generated code. Read it. Ask for explanations of parts you do not understand. Test it.

Accepting code you do not understand creates problems: you cannot debug it when it fails, you cannot modify it when requirements change, you do not learn for future tasks.

Use the assistant''s explain capability: "Explain what this section does and why it is structured this way."

### Practice 4: Use Comments as Specifications

Code assistants can generate code from comments. Write comments describing what you want, then let the assistant fill in the implementation.

Example comment sequence:
"Read customer data from the CSV file"
"Filter to only active UK customers"
"For each customer, check if they exist in the API"
"If not, create them and log the result"
"If yes, update their record and log the result"
"Print summary of created and updated counts"

The assistant generates code matching each comment, creating well-documented code as a byproduct.

### Practice 5: Reference Documentation

In Cursor, use @docs to reference documentation in your request:

"@docs python requests library - how do I add authentication headers to a POST request with both API key and bearer token?"

Referencing docs you include usually improves accuracy compared to relying solely on training data, but you should still verify the output against official documentation.

## Common Workflows

### Workflow: Quick Script Creation

1. Open Cursor, create a new Python file
2. Command-K: describe what you need using I-T-O structure
3. Review generated code
4. Run and test with sample data
5. Command-K: iterate to handle edge cases
6. Save and integrate into your automation

### Workflow: Debug Existing Code

1. Paste problematic code into editor
2. Command-L: "This code produces [wrong behavior]. The expected behavior is [correct behavior]. Diagnose the issue and suggest a fix."
3. Review explanation, understand the root cause
4. Accept fix or modify based on understanding
5. Test to confirm resolution

### Workflow: Learn New Language or Framework

1. Decide on a small project (not a tutorial exercise, a real need)
2. Ask assistant to scaffold the project structure
3. Build features one at a time, asking for explanations
4. When confused, ask "why did you structure it this way" or "what alternatives exist"
5. Complete the project with understanding, not just working code

## Cost Justification

Calculate the return on investment for a code assistant subscription.

**Your effective hourly rate:** Consider what you bill clients or the value of your time to your employer. For most operators, this is 50-150 dollars per hour.

**Code assistant cost:** Typically ranges from free tiers to modest monthly subscriptions.

**Break-even point:** If the assistant saves you 15-30 minutes per month, it pays for itself.

**Realistic time savings:** Most active users report saving 5-15 hours monthly. This represents 10-30x return on investment.

Even if you only write code occasionally, the speed improvement when you do makes the subscription worthwhile.

## What Code Assistants Do Not Replace

Code assistants accelerate implementation. They do not replace:

**Understanding requirements:** You still need to know what you are building. I-T-O clarity is essential.

**Design decisions:** Architecture choices require human judgment about tradeoffs.

**Testing:** Generated code can contain bugs. Testing is still your responsibility.

**Maintenance:** You need to understand code to maintain it over time.

**Security awareness:** Assistants can generate insecure code. You must review for vulnerabilities.

Think of code assistants as very fast, knowledgeable collaborators. They execute what you direct. Directing well requires the frameworks from Modules 2 and 3.',

exercise_markdown = '## Exercise: Build Your First AI-Assisted Automation Component

**Objective:** Use a code assistant to build a working automation component, applying I-T-O framework and iterative development principles from earlier modules.

This exercise has you build real, usable code while learning how code assistants accelerate implementation. You will create components that could integrate into the execution layer of automation workflows.

### Part 1: Environment Setup

**Choose and install one code assistant:**

Option A: Cursor (recommended for beginners)
- Download from cursor.com
- Install and open
- Create a new folder for this exercise
- Verify AI features work with a simple test

Option B: GitHub Copilot with VS Code
- Install VS Code if needed
- Install GitHub Copilot extension
- Sign in with GitHub account
- Verify suggestions appear as you type

Option C: Cline with VS Code
- Install VS Code if needed
- Install Cline extension
- Configure Claude API key
- Test with a simple request

Option D: Claude Code (recommended for terminal users)
- Install via npm, pip, or download from github.com/anthropics/claude-code
- Configure Claude API key
- Open your project folder in terminal
- Test with a simple request like "explain this codebase"

**Document your setup:**
- Which tool you chose and why
- Any setup issues encountered
- Time spent on setup

### Part 2: CSV Processor Script

**Scenario:** You receive customer data exports that need filtering before import into another system.

**Requirements using I-T-O framework:**

Input: A CSV file named customers.csv with columns for name, email, company, country, and status

Task: Filter rows where country equals "UK" and status equals "active", then validate that email contains @ symbol

Output: A new CSV file named uk_active_customers.csv containing only matching rows, plus a printed summary showing total rows, matched rows, and invalid email count

**Build iteratively:**

Step 1: Ask your assistant to create a script that reads the CSV and prints the first 5 rows. Test it with a sample CSV file you create.

Step 2: Ask to add the country and status filtering. Test with rows that should and should not match.

Step 3: Ask to add email validation. Test with valid and invalid emails.

Step 4: Ask to add the output file writing. Verify the output file is correct.

Step 5: Ask to add error handling for missing file, missing columns, and permission errors.

**Document:**
- Each prompt you used
- How many iterations needed
- Code generated at each step
- What you had to manually fix or adjust
- Total time from start to working script

### Part 3: Webhook Handler

**Scenario:** You need a simple web server that receives webhook data from an automation platform and processes it.

**Requirements using I-T-O framework:**

Input: POST requests to /webhook endpoint containing JSON with fields for event_type, timestamp, and payload

Task: Log the received data, validate required fields exist, process based on event_type

Output: Return appropriate HTTP response (200 for success, 400 for validation failure), write all requests to webhook_log.txt with timestamps

**Build iteratively:**

Step 1: Ask for a minimal Flask server with one endpoint that returns "OK".

Step 2: Ask to add JSON body parsing and logging.

Step 3: Ask to add field validation.

Step 4: Ask to add event_type based processing (even if just logging different messages).

Step 5: Ask for instructions on how to test it locally.

**Test using a tool like curl or Postman:**
- Send valid webhook payload
- Send payload missing required fields
- Send malformed JSON
- Verify log file contains expected entries

**Document:**
- Prompts used
- Testing results
- Any issues and how you resolved them

### Part 4: Modify Existing Code

**Take this intentionally problematic code and use your assistant to improve it:**

The code (create a file with this content):

A Python function called process_data that takes a data parameter. It creates an empty list called results. For each item in data, it checks if the item is not None. If not None, it tries to get the name value from item and convert it to uppercase, assigning to processed. It appends processed to results. It returns results.

**Issues to identify and fix:**
- No error handling
- No input validation
- Unclear what data types are expected
- No documentation

**Ask your assistant to:**
1. Explain what this code does
2. Identify potential issues
3. Add type hints
4. Add error handling
5. Add a docstring explaining usage
6. Suggest tests that would verify it works

**Document:**
- Original code and improved version
- What each improvement addressed
- Did you understand the improvements (not just accept them)

### Part 5: Learn Something New

**Pick a technology you do not know:**
- A Python library (requests, pandas, beautifulsoup)
- A JavaScript framework concept
- A command-line tool
- An API integration

**Build a tiny project using it:**

Example: "I want to learn how to use the requests library to interact with a REST API"

Project: Build a script that checks if a website is responding and logs uptime status.

**Process:**
1. Ask your assistant to explain the technology briefly
2. Ask for a minimal example
3. Ask to add one feature at a time
4. When you do not understand something, ask for explanation
5. Modify something yourself to verify understanding

**Document:**
- What you learned
- Which explanations were most helpful
- Could you now extend this code without assistance
- What questions remain

### Part 6: Time Comparison

**Estimate how long each task would take without AI assistance:**

CSV Processor:
- Without assistant (estimate): ___ hours
- With assistant (actual): ___ minutes
- Time saved: ___

Webhook Handler:
- Without assistant (estimate): ___ hours
- With assistant (actual): ___ minutes
- Time saved: ___

Code Modification:
- Without assistant (estimate): ___ hours
- With assistant (actual): ___ minutes
- Time saved: ___

Learning New Technology:
- Traditional learning path (estimate): ___ hours
- With assistant building real project: ___ minutes
- Time saved: ___

**Total time savings this exercise:** ___ hours

**If you did this monthly, annual time savings:** ___ hours

**At your hourly rate, annual value:** ___

### Part 7: Assess Your Experience

**Answer honestly:**

1. Did you understand the code that was generated? (Scale 1-10, where 10 is complete understanding)

2. Could you debug it if something broke? (Yes/Partially/No)

3. Could you modify it for slightly different requirements? (Yes/Partially/No)

4. Did you learn anything that would help with future projects? (List specifics)

5. What was the most effective prompting approach you discovered?

6. Where did the assistant struggle or produce poor results?

7. Would you pay for this tool? (Yes, at what price / No, why not)

### Deliverable

Submit a folder containing:

1. All code files created (CSV processor, webhook handler, modified code, learning project)

2. A document with:
   - Setup notes and tool choice reasoning
   - Prompts used for each part (copy exact text)
   - Iteration count and time for each task
   - Time comparison calculations
   - Self-assessment answers
   - Top 3 lessons learned about using code assistants effectively

3. Screenshots showing:
   - Your assistant in action (at least one interaction)
   - Test results for webhook handler
   - Output from CSV processor

### Success Criteria

You have completed this exercise successfully when:
- All four code projects work (CSV processor, webhook, modification, learning project)
- You can explain what each script does without looking at comments
- You documented your prompts and could reproduce results
- Your time comparison shows measurable savings
- You can articulate when code assistants help most and when they struggle
- You have a clear opinion on whether to subscribe based on your experience',

exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Environment Setup",
      "description": "Choose and install a code assistant.",
      "fields": [
        {
          "id": "tool_choice",
          "type": "radio",
          "label": "Which code assistant did you install?",
          "options": ["Cursor", "GitHub Copilot with VS Code", "Cline with VS Code", "Claude Code", "Other"],
          "required": true
        },
        {
          "id": "setup_notes",
          "type": "textarea",
          "label": "Document your setup experience:",
          "placeholder": "Why I chose this tool: ...\n\nSetup issues encountered: [none / describe issues]\n\nTime spent on setup: ~X minutes\n\nVerification test result: [worked / had issues]",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: CSV Processor Script",
      "description": "Build a CSV filter using I-T-O framework and iterative prompting.",
      "fields": [
        {
          "id": "csv_prompts",
          "type": "textarea",
          "label": "Document the prompts you used for each iteration:",
          "placeholder": "Step 1 prompt: \"Create a script that reads customers.csv and prints first 5 rows\"\nResult: [worked / needed adjustment]\n\nStep 2 prompt: \"Add filtering for country=UK and status=active\"\nResult: [worked / needed adjustment]\n\nStep 3 prompt: \"Add email validation...\"\n...\n\nStep 5 prompt: \"Add error handling for...\"\nResult: ...",
          "required": true,
          "rows": 12
        },
        {
          "id": "csv_iterations",
          "type": "text",
          "label": "Total number of iterations needed:",
          "placeholder": "e.g., 7",
          "required": true
        },
        {
          "id": "csv_time",
          "type": "text",
          "label": "Total time to complete (minutes):",
          "placeholder": "e.g., 25",
          "required": true
        },
        {
          "id": "csv_manual_fixes",
          "type": "textarea",
          "label": "What did you have to manually fix or adjust?",
          "placeholder": "List any issues the assistant got wrong that you had to fix yourself...",
          "required": true,
          "rows": 3
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Webhook Handler",
      "description": "Build a Flask webhook server using iterative development.",
      "fields": [
        {
          "id": "webhook_prompts",
          "type": "textarea",
          "label": "Document your prompts and results:",
          "placeholder": "Step 1: Minimal Flask server\nPrompt: ...\nResult: ...\n\nStep 2: JSON parsing and logging\nPrompt: ...\nResult: ...\n\nStep 3-5: ...",
          "required": true,
          "rows": 10
        },
        {
          "id": "webhook_testing",
          "type": "textarea",
          "label": "Document your testing results:",
          "placeholder": "Valid payload test: [passed / failed]\nMissing fields test: [returned 400 / failed]\nMalformed JSON test: [handled / crashed]\nLog file verification: [correct / issues]",
          "required": true,
          "rows": 5
        },
        {
          "id": "webhook_time",
          "type": "text",
          "label": "Total time to complete (minutes):",
          "placeholder": "e.g., 30",
          "required": true
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Modify Existing Code",
      "description": "Use your assistant to improve problematic code.",
      "fields": [
        {
          "id": "code_analysis",
          "type": "textarea",
          "label": "What issues did your assistant identify in the problematic code?",
          "placeholder": "1. No error handling for...\n2. No input validation for...\n3. Type hints missing...\n4. No documentation...\n5. Other: ...",
          "required": true,
          "rows": 5
        },
        {
          "id": "improvements_made",
          "type": "textarea",
          "label": "Summarize the improvements made:",
          "placeholder": "Type hints added: [describe]\nError handling: [describe what cases are handled]\nDocstring: [summarize what it says]\nTests suggested: [list test cases]",
          "required": true,
          "rows": 6
        },
        {
          "id": "understood_improvements",
          "type": "radio",
          "label": "Did you understand all the improvements (not just accept them)?",
          "options": ["Yes, understood everything", "Mostly, had to ask for clarification on some parts", "Partially, some improvements are unclear", "No, just accepted the output"],
          "required": true
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Learn Something New",
      "description": "Use your assistant to learn an unfamiliar technology.",
      "fields": [
        {
          "id": "technology_chosen",
          "type": "text",
          "label": "What technology did you choose to learn?",
          "placeholder": "e.g., requests library, pandas, an API integration",
          "required": true
        },
        {
          "id": "mini_project",
          "type": "textarea",
          "label": "Describe the mini project you built:",
          "placeholder": "Project: [what it does]\n\nProcess:\n1. Asked for explanation of...\n2. Got minimal example of...\n3. Added feature: ...\n4. Asked for clarification on...\n5. Modified [what] myself to verify understanding",
          "required": true,
          "rows": 8
        },
        {
          "id": "learning_assessment",
          "type": "textarea",
          "label": "Assess what you learned:",
          "placeholder": "Key concepts learned: ...\n\nMost helpful explanation: ...\n\nCould extend without assistance: [Yes / Partially / No]\n\nQuestions that remain: ...",
          "required": true,
          "rows": 6
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: Time Comparison",
      "description": "Compare AI-assisted vs manual development time.",
      "fields": [
        {
          "id": "csv_time_comparison",
          "type": "textarea",
          "label": "CSV Processor time comparison:",
          "placeholder": "Without assistant (estimate): X hours\nWith assistant (actual): X minutes\nTime saved: X hours",
          "required": true,
          "rows": 3
        },
        {
          "id": "webhook_time_comparison",
          "type": "textarea",
          "label": "Webhook Handler time comparison:",
          "placeholder": "Without assistant (estimate): X hours\nWith assistant (actual): X minutes\nTime saved: X hours",
          "required": true,
          "rows": 3
        },
        {
          "id": "learning_time_comparison",
          "type": "textarea",
          "label": "Learning New Technology time comparison:",
          "placeholder": "Traditional learning (estimate): X hours\nWith assistant: X minutes\nTime saved: X hours",
          "required": true,
          "rows": 3
        },
        {
          "id": "annual_value",
          "type": "textarea",
          "label": "Calculate annual value:",
          "placeholder": "Total time savings this exercise: X hours\nIf done monthly, annual savings: X hours\nAt hourly rate of $X: $X annual value",
          "required": true,
          "rows": 3
        }
      ]
    },
    {
      "id": "part7",
      "title": "Part 7: Self-Assessment",
      "description": "Honestly assess your experience with code assistants.",
      "fields": [
        {
          "id": "code_understanding",
          "type": "rating",
          "label": "Did you understand the code that was generated? (1=not at all, 10=completely)",
          "required": true,
          "min": 1,
          "max": 10
        },
        {
          "id": "can_debug",
          "type": "radio",
          "label": "Could you debug it if something broke?",
          "options": ["Yes", "Partially", "No"],
          "required": true
        },
        {
          "id": "can_modify",
          "type": "radio",
          "label": "Could you modify it for slightly different requirements?",
          "options": ["Yes", "Partially", "No"],
          "required": true
        },
        {
          "id": "lessons_learned",
          "type": "textarea",
          "label": "What did you learn that helps with future projects?",
          "placeholder": "1. ...\n2. ...\n3. ...",
          "required": true,
          "rows": 4
        },
        {
          "id": "effective_prompting",
          "type": "textarea",
          "label": "What was the most effective prompting approach you discovered?",
          "placeholder": "Describe your best prompting strategy...",
          "required": true,
          "rows": 3
        },
        {
          "id": "assistant_struggles",
          "type": "textarea",
          "label": "Where did the assistant struggle or produce poor results?",
          "placeholder": "Describe situations where it failed or gave bad output...",
          "required": true,
          "rows": 3
        },
        {
          "id": "would_pay",
          "type": "radio",
          "label": "Would you pay for this tool?",
          "options": ["Yes, at full price", "Yes, but only at lower price", "Maybe, need more experience", "No, not worth it for my use case"],
          "required": true
        }
      ]
    }
  ],
  "deliverables": [
    "Working CSV processor script",
    "Working webhook handler",
    "Improved version of problematic code",
    "Learning project with new technology",
    "Time comparison calculations",
    "Self-assessment answers"
  ],
  "success_criteria": [
    "All four code projects work correctly",
    "Can explain each script without looking at comments",
    "Documented prompts that could reproduce results",
    "Time comparison shows measurable savings",
    "Can articulate when assistants help vs struggle"
  ]
}'

WHERE slug = 'ai-code-assistants';
