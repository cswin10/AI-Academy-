-- ============================================================================
-- ADD EXERCISE SCHEMAS TO MODULE 1 SECTIONS
-- ============================================================================
-- This migration adds interactive exercise_schema JSON to Module 1 sections
-- Run this AFTER running add_exercise_responses.sql
-- ============================================================================

-- Section 1.1: What Is an AI Operator?
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Self-Assessment",
      "description": "Rate your current experience level in each area (1 = no experience, 10 = expert)",
      "fields": [
        {
          "id": "systems_thinking",
          "type": "rating",
          "label": "Systems Thinking: Understanding how processes connect and influence each other",
          "required": true,
          "min": 1,
          "max": 10
        },
        {
          "id": "systems_thinking_example",
          "type": "textarea",
          "label": "Describe a time you identified how one part of a system affected another:",
          "placeholder": "Example: When our returns process changed, I noticed it affected inventory counts which then caused ordering issues...",
          "required": true,
          "rows": 3
        },
        {
          "id": "automation_tools",
          "type": "rating",
          "label": "Automation Tools: Experience with Zapier, Make, n8n, or similar tools",
          "required": true,
          "min": 1,
          "max": 10
        },
        {
          "id": "automation_example",
          "type": "textarea",
          "label": "What automations have you built or used?",
          "placeholder": "List any automations you have created or regularly use...",
          "required": true,
          "rows": 3
        },
        {
          "id": "data_awareness",
          "type": "rating",
          "label": "Data Awareness: Understanding databases, spreadsheets, and data flow",
          "required": true,
          "min": 1,
          "max": 10
        },
        {
          "id": "ai_knowledge",
          "type": "rating",
          "label": "AI Knowledge: Experience with GPT, Claude, or other AI tools",
          "required": true,
          "min": 1,
          "max": 10
        },
        {
          "id": "ai_usage",
          "type": "textarea",
          "label": "How have you used AI in your work or personal projects?",
          "placeholder": "Describe your AI usage...",
          "required": true,
          "rows": 3
        },
        {
          "id": "communication",
          "type": "rating",
          "label": "Communication: Ability to explain technical concepts to non-technical people",
          "required": true,
          "min": 1,
          "max": 10
        },
        {
          "id": "operator_type",
          "type": "radio",
          "label": "Based on the three operator types, which resonates most with you?",
          "required": true,
          "options": [
            "Automation-First (connecting tools, building workflows)",
            "AI-First (prompt engineering, AI applications)",
            "Hybrid (combination of both)"
          ]
        },
        {
          "id": "operator_reason",
          "type": "textarea",
          "label": "Why does this type appeal to you?",
          "placeholder": "Explain your choice...",
          "required": true,
          "rows": 3
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Business Analysis",
      "description": "Choose a real business you know well (your employer, a client, a local business you frequent) and analyze it.",
      "fields": [
        {
          "id": "business_name",
          "type": "text",
          "label": "Business name or description:",
          "placeholder": "e.g., Local dental practice, Marketing agency, E-commerce store",
          "required": true
        },
        {
          "id": "business_type",
          "type": "text",
          "label": "Industry/type:",
          "placeholder": "e.g., Healthcare, Retail, Professional Services",
          "required": true
        },
        {
          "id": "business_size",
          "type": "select",
          "label": "Approximate size:",
          "required": true,
          "options": [
            "Solo (1 person)",
            "Small (2-10 employees)",
            "Medium (11-50 employees)",
            "Large (50+ employees)"
          ]
        },
        {
          "id": "recurring_activities",
          "type": "textarea",
          "label": "List 5+ recurring activities that happen daily or weekly:",
          "placeholder": "1. Responding to customer inquiries\n2. Processing orders\n3. Scheduling appointments\n4. Creating invoices\n5. Following up with leads...",
          "required": true,
          "rows": 6
        },
        {
          "id": "pain_point_1_description",
          "type": "textarea",
          "label": "Pain Point 1: Describe a specific task that wastes time or causes frustration",
          "placeholder": "Be specific - what exactly happens, how long does it take, what goes wrong?",
          "required": true,
          "rows": 3
        },
        {
          "id": "pain_point_1_frequency",
          "type": "select",
          "label": "How often does this pain point occur?",
          "required": true,
          "options": ["Multiple times daily", "Daily", "Several times per week", "Weekly", "Monthly"]
        },
        {
          "id": "pain_point_1_judgment",
          "type": "radio",
          "label": "Does this require human judgment?",
          "required": true,
          "options": ["Yes, requires expertise", "Partially - some judgment needed", "No - purely mechanical"]
        },
        {
          "id": "pain_point_2_description",
          "type": "textarea",
          "label": "Pain Point 2: Describe another specific task that causes problems",
          "placeholder": "Be specific about what happens and why it is painful...",
          "required": true,
          "rows": 3
        },
        {
          "id": "pain_point_2_frequency",
          "type": "select",
          "label": "How often does this pain point occur?",
          "required": true,
          "options": ["Multiple times daily", "Daily", "Several times per week", "Weekly", "Monthly"]
        },
        {
          "id": "pain_point_2_judgment",
          "type": "radio",
          "label": "Does this require human judgment?",
          "required": true,
          "options": ["Yes, requires expertise", "Partially - some judgment needed", "No - purely mechanical"]
        },
        {
          "id": "pain_point_3_description",
          "type": "textarea",
          "label": "Pain Point 3: Describe a third task that could be improved",
          "placeholder": "Be specific about the current process and its problems...",
          "required": true,
          "rows": 3
        },
        {
          "id": "pain_point_3_frequency",
          "type": "select",
          "label": "How often does this pain point occur?",
          "required": true,
          "options": ["Multiple times daily", "Daily", "Several times per week", "Weekly", "Monthly"]
        },
        {
          "id": "pain_point_3_judgment",
          "type": "radio",
          "label": "Does this require human judgment?",
          "required": true,
          "options": ["Yes, requires expertise", "Partially - some judgment needed", "No - purely mechanical"]
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Opportunity Identification",
      "description": "Based on your analysis, identify one specific automation opportunity.",
      "fields": [
        {
          "id": "target_pain_point",
          "type": "textarea",
          "label": "Which pain point would you target first and why?",
          "placeholder": "Consider: frequency, pain level, complexity, and potential impact...",
          "required": true,
          "rows": 3
        },
        {
          "id": "solution_sketch",
          "type": "textarea",
          "label": "What would a solution look like at a high level?",
          "placeholder": "Describe the general approach you would take...",
          "required": true,
          "rows": 4
        },
        {
          "id": "success_metrics",
          "type": "textarea",
          "label": "What would success look like? Be specific (hours saved, errors reduced, etc.)",
          "placeholder": "e.g., Reduce time from 2 hours to 15 minutes, eliminate 90% of manual data entry errors...",
          "required": true,
          "rows": 3
        },
        {
          "id": "layer_interface",
          "type": "textarea",
          "label": "INTERFACE LAYER: What would users interact with?",
          "placeholder": "Forms, dashboards, notifications, etc.",
          "required": true,
          "rows": 2
        },
        {
          "id": "layer_data",
          "type": "textarea",
          "label": "DATA LAYER: Where would information be stored?",
          "placeholder": "Databases, spreadsheets, CRM, etc.",
          "required": true,
          "rows": 2
        },
        {
          "id": "layer_automation",
          "type": "textarea",
          "label": "AUTOMATION LAYER: What would happen automatically?",
          "placeholder": "Triggers, workflows, notifications, etc.",
          "required": true,
          "rows": 2
        },
        {
          "id": "layer_ai",
          "type": "textarea",
          "label": "AI LAYER: Where might AI help, if at all?",
          "placeholder": "Classification, content generation, analysis, etc. (or None if not needed)",
          "required": true,
          "rows": 2
        }
      ]
    }
  ],
  "deliverables": [
    "Completed self-assessment with honest, specific answers",
    "Identified your primary operator type interest",
    "Chosen and analyzed a real business",
    "Listed 5+ recurring activities",
    "Identified 3+ specific pain points with judgment assessment",
    "Identified one automation opportunity",
    "Sketched a potential solution using the 4 layers"
  ],
  "success_criteria": [
    "You can articulate what type of operator you want to become",
    "You have analyzed a real business (not hypothetical)",
    "You have identified specific, concrete pain points",
    "You can see at least one automation opportunity"
  ]
}'::jsonb
WHERE slug = 'what-is-an-ai-operator';

-- Section 1.2: The 4-Layer System Model
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Identify the Layers",
      "description": "For each system below, identify which layer is being described.",
      "fields": [
        {
          "id": "scenario_1",
          "type": "radio",
          "label": "A customer fills out a contact form on your website",
          "required": true,
          "options": ["Interface Layer", "Automation Layer", "Data Layer", "AI Layer"]
        },
        {
          "id": "scenario_2",
          "type": "radio",
          "label": "Customer information is saved to your CRM database",
          "required": true,
          "options": ["Interface Layer", "Automation Layer", "Data Layer", "AI Layer"]
        },
        {
          "id": "scenario_3",
          "type": "radio",
          "label": "A Zapier workflow sends a Slack notification when a new lead arrives",
          "required": true,
          "options": ["Interface Layer", "Automation Layer", "Data Layer", "AI Layer"]
        },
        {
          "id": "scenario_4",
          "type": "radio",
          "label": "GPT analyzes the customer message to determine urgency level",
          "required": true,
          "options": ["Interface Layer", "Automation Layer", "Data Layer", "AI Layer"]
        },
        {
          "id": "scenario_5",
          "type": "radio",
          "label": "A dashboard shows this months sales performance",
          "required": true,
          "options": ["Interface Layer", "Automation Layer", "Data Layer", "AI Layer"]
        },
        {
          "id": "scenario_6",
          "type": "radio",
          "label": "New orders are automatically assigned to available team members",
          "required": true,
          "options": ["Interface Layer", "Automation Layer", "Data Layer", "AI Layer"]
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: System Breakdown",
      "description": "Take a system you use regularly and break it down into the 4 layers.",
      "fields": [
        {
          "id": "system_name",
          "type": "text",
          "label": "Name of the system you are analyzing:",
          "placeholder": "e.g., Our customer support process, Email newsletter system, Order fulfillment",
          "required": true
        },
        {
          "id": "system_purpose",
          "type": "textarea",
          "label": "What is the main purpose of this system?",
          "placeholder": "Describe what the system does and who uses it...",
          "required": true,
          "rows": 2
        },
        {
          "id": "interface_inputs",
          "type": "textarea",
          "label": "INTERFACE: How do users INPUT data into this system?",
          "placeholder": "Forms, emails, chat, voice, etc.",
          "required": true,
          "rows": 3
        },
        {
          "id": "interface_outputs",
          "type": "textarea",
          "label": "INTERFACE: How do users SEE information from this system?",
          "placeholder": "Dashboards, reports, notifications, documents, etc.",
          "required": true,
          "rows": 3
        },
        {
          "id": "automation_triggers",
          "type": "textarea",
          "label": "AUTOMATION: What triggers (events) start processes in this system?",
          "placeholder": "e.g., New form submission, scheduled time, status change...",
          "required": true,
          "rows": 3
        },
        {
          "id": "automation_actions",
          "type": "textarea",
          "label": "AUTOMATION: What actions happen automatically?",
          "placeholder": "e.g., Send notification, create record, update status, route to person...",
          "required": true,
          "rows": 3
        },
        {
          "id": "automation_observability",
          "type": "textarea",
          "label": "AUTOMATION: How do you observe and debug this system?",
          "placeholder": "Where are logs? Who gets alerts when it fails? How do you retry failed runs?",
          "required": true,
          "rows": 3
        },
        {
          "id": "data_storage",
          "type": "textarea",
          "label": "DATA: Where is information stored in this system?",
          "placeholder": "Databases, spreadsheets, CRM, file storage, etc.",
          "required": true,
          "rows": 3
        },
        {
          "id": "data_types",
          "type": "textarea",
          "label": "DATA: What types of data are stored?",
          "placeholder": "Customer info, transactions, messages, files, etc.",
          "required": true,
          "rows": 3
        },
        {
          "id": "data_permissions",
          "type": "textarea",
          "label": "DATA: What permissions exist and what data is sensitive?",
          "placeholder": "Who can read/write/export? Where do secrets live? What needs extra protection?",
          "required": true,
          "rows": 3
        },
        {
          "id": "ai_current",
          "type": "textarea",
          "label": "AI: Is AI currently used in this system? If yes, how?",
          "placeholder": "Describe any AI/ML components, or write None if not applicable...",
          "required": true,
          "rows": 2
        },
        {
          "id": "ai_potential",
          "type": "textarea",
          "label": "AI: Where COULD AI add value to this system?",
          "placeholder": "Classification, content generation, analysis, predictions, etc.",
          "required": true,
          "rows": 3
        },
        {
          "id": "ai_override",
          "type": "textarea",
          "label": "AI: What is the human override and review path?",
          "placeholder": "How would someone correct AI errors? What happens after correction? Is there a manual fallback?",
          "required": true,
          "rows": 3
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Design a New System",
      "description": "Design a simple system from scratch using the 4-layer model.",
      "fields": [
        {
          "id": "new_system_problem",
          "type": "textarea",
          "label": "What problem will your system solve?",
          "placeholder": "Describe the specific problem or need...",
          "required": true,
          "rows": 3
        },
        {
          "id": "new_system_interface",
          "type": "textarea",
          "label": "INTERFACE DESIGN: What interfaces will you need?",
          "placeholder": "Input: (forms, channels, etc.)\nOutput: (dashboards, notifications, etc.)",
          "required": true,
          "rows": 4
        },
        {
          "id": "new_system_automation",
          "type": "textarea",
          "label": "AUTOMATION DESIGN: What automations will connect the system?",
          "placeholder": "Trigger → Action sequences...",
          "required": true,
          "rows": 4
        },
        {
          "id": "new_system_observability",
          "type": "textarea",
          "label": "AUTOMATION DESIGN: How will you observe and debug?",
          "placeholder": "Where will logs live? Who gets alerted on failures? How will you retry?",
          "required": true,
          "rows": 3
        },
        {
          "id": "new_system_data",
          "type": "textarea",
          "label": "DATA DESIGN: What data will you store and where?",
          "placeholder": "Fields, storage location, relationships...",
          "required": true,
          "rows": 4
        },
        {
          "id": "new_system_permissions",
          "type": "textarea",
          "label": "DATA DESIGN: What permissions and protections are needed?",
          "placeholder": "Who can read/write/export? What is sensitive? Where do secrets live?",
          "required": true,
          "rows": 3
        },
        {
          "id": "new_system_ai",
          "type": "textarea",
          "label": "AI DESIGN: Where will AI add value (if anywhere)?",
          "placeholder": "AI capabilities and their purpose, or None if not needed...",
          "required": true,
          "rows": 3
        },
        {
          "id": "new_system_ai_override",
          "type": "textarea",
          "label": "AI DESIGN: What is the human override and accuracy plan?",
          "placeholder": "How will humans correct errors? How will you measure accuracy over time?",
          "required": true,
          "rows": 3
        }
      ]
    }
  ],
  "deliverables": [
    "Correctly identified layers for all 6 scenarios",
    "Broken down an existing system into all 4 layers (including observability, permissions, AI override)",
    "Designed a new system using the 4-layer framework with modern best practices"
  ],
  "success_criteria": [
    "You can quickly identify which layer any component belongs to",
    "You can analyze existing systems using the framework",
    "You consider observability, permissions, and human override in every design"
  ]
}'::jsonb
WHERE slug = 'four-layer-system-model';

-- Section 1.3: Inputs, Transformations, Outputs
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Identify the Components",
      "description": "For each workflow, identify the Input, Transformations, and Output.",
      "fields": [
        {
          "id": "workflow_1_input",
          "type": "text",
          "label": "Workflow: Customer submits support ticket → AI categorizes → Routes to team\n\nINPUT:",
          "placeholder": "What starts this workflow?",
          "required": true
        },
        {
          "id": "workflow_1_transform",
          "type": "textarea",
          "label": "TRANSFORMATIONS (list all steps):",
          "placeholder": "1. ...\n2. ...",
          "required": true,
          "rows": 3
        },
        {
          "id": "workflow_1_output",
          "type": "text",
          "label": "OUTPUT:",
          "placeholder": "What is the end result?",
          "required": true
        },
        {
          "id": "workflow_2_input",
          "type": "text",
          "label": "Workflow: New email arrives → Extract sender info → Add to CRM → Send welcome email\n\nINPUT:",
          "placeholder": "What starts this workflow?",
          "required": true
        },
        {
          "id": "workflow_2_transform",
          "type": "textarea",
          "label": "TRANSFORMATIONS (list all steps):",
          "placeholder": "1. ...\n2. ...",
          "required": true,
          "rows": 3
        },
        {
          "id": "workflow_2_output",
          "type": "text",
          "label": "OUTPUT:",
          "placeholder": "What is the end result?",
          "required": true
        },
        {
          "id": "workflow_3_input",
          "type": "text",
          "label": "Workflow: Daily at 9am → Pull sales data → Generate report → Email to manager\n\nINPUT:",
          "placeholder": "What starts this workflow?",
          "required": true
        },
        {
          "id": "workflow_3_transform",
          "type": "textarea",
          "label": "TRANSFORMATIONS (list all steps):",
          "placeholder": "1. ...\n2. ...",
          "required": true,
          "rows": 3
        },
        {
          "id": "workflow_3_output",
          "type": "text",
          "label": "OUTPUT:",
          "placeholder": "What is the end result?",
          "required": true
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Document Your Own Workflow",
      "description": "Choose a real workflow from your work or life and document it completely.",
      "fields": [
        {
          "id": "own_workflow_name",
          "type": "text",
          "label": "Workflow name:",
          "placeholder": "e.g., Processing customer orders, Onboarding new clients, Creating reports",
          "required": true
        },
        {
          "id": "own_workflow_input_event",
          "type": "text",
          "label": "INPUT - Trigger Event: What starts this workflow?",
          "placeholder": "e.g., Customer clicks buy, Form submitted, Email received",
          "required": true
        },
        {
          "id": "own_workflow_input_data",
          "type": "textarea",
          "label": "INPUT - Data Available: What information is available at the start?",
          "placeholder": "List all the data fields/information available...",
          "required": true,
          "rows": 4
        },
        {
          "id": "own_workflow_transforms",
          "type": "textarea",
          "label": "TRANSFORMATIONS - List all processing steps in order:",
          "placeholder": "1. Validate the input data\n2. Look up customer in database\n3. Calculate pricing\n4. Create order record\n5. ...",
          "required": true,
          "rows": 8
        },
        {
          "id": "own_workflow_outputs",
          "type": "textarea",
          "label": "OUTPUTS - What are all the end results?",
          "placeholder": "List all outputs: records created, notifications sent, documents generated, etc.",
          "required": true,
          "rows": 4
        },
        {
          "id": "own_workflow_edge_cases",
          "type": "textarea",
          "label": "EDGE CASES - What unusual situations could occur?",
          "placeholder": "List at least 3 edge cases and how they should be handled...",
          "required": true,
          "rows": 5
        },
        {
          "id": "own_workflow_trust_level",
          "type": "radio",
          "label": "INPUT TRUST LEVEL - How trustworthy is the input source?",
          "required": true,
          "options": ["Internal system (high trust)", "Verified user (medium trust)", "External/third-party (low trust)", "AI-generated (requires validation)"]
        },
        {
          "id": "own_workflow_partial_failure",
          "type": "textarea",
          "label": "PARTIAL FAILURE - What if some steps succeed but others fail?",
          "placeholder": "Decide: roll back everything, retry failed steps, or continue in degraded mode?",
          "required": true,
          "rows": 3
        },
        {
          "id": "own_workflow_observability",
          "type": "textarea",
          "label": "OBSERVABILITY - How will you know if this workflow fails?",
          "placeholder": "Where are logs? Who gets alerted? How do you replay failed runs?",
          "required": true,
          "rows": 3
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Design a New Workflow",
      "description": "Design a workflow that solves a real problem using the I→T→O framework.",
      "fields": [
        {
          "id": "design_problem",
          "type": "textarea",
          "label": "What problem will this workflow solve?",
          "placeholder": "Describe the current pain point and desired outcome...",
          "required": true,
          "rows": 3
        },
        {
          "id": "design_input_type",
          "type": "select",
          "label": "What type of input will trigger this workflow?",
          "required": true,
          "options": ["User action (form, button, message)", "Time-based (scheduled)", "System event (record change, file upload)", "External event (webhook, API call)"]
        },
        {
          "id": "design_input_details",
          "type": "textarea",
          "label": "Describe the input in detail:",
          "placeholder": "What exactly triggers the workflow? What data is included?",
          "required": true,
          "rows": 3
        },
        {
          "id": "design_transforms",
          "type": "textarea",
          "label": "List all transformation steps:",
          "placeholder": "1. Validate...\n2. Enrich...\n3. Calculate...\n4. Route...\n5. Store...",
          "required": true,
          "rows": 8
        },
        {
          "id": "design_outputs",
          "type": "textarea",
          "label": "Define all outputs:",
          "placeholder": "What records are created? What notifications are sent? What actions are taken?",
          "required": true,
          "rows": 4
        },
        {
          "id": "design_error_handling",
          "type": "textarea",
          "label": "How will you handle errors at each step?",
          "placeholder": "What happens if validation fails? If a service is down? If data is missing?",
          "required": true,
          "rows": 4
        },
        {
          "id": "design_output_finality",
          "type": "textarea",
          "label": "OUTPUT FINALITY - Which outputs are final vs. inputs to other systems?",
          "placeholder": "Final outputs (email sent, record created) vs intermediate outputs (triggers next workflow)...",
          "required": true,
          "rows": 3
        },
        {
          "id": "design_observability",
          "type": "textarea",
          "label": "OBSERVABILITY - How will you ensure failures are visible?",
          "placeholder": "Every transformation should succeed visibly or fail loudly. How will you achieve this?",
          "required": true,
          "rows": 3
        },
        {
          "id": "design_human_override",
          "type": "textarea",
          "label": "HUMAN OVERRIDE - How can humans intervene when needed?",
          "placeholder": "How do you pause, fix data, and resume? Who has override access?",
          "required": true,
          "rows": 3
        }
      ]
    }
  ],
  "deliverables": [
    "Analyzed 3 example workflows into I→T→O components",
    "Documented a real workflow including trust level and failure handling",
    "Designed a new workflow with observability and human override",
    "Identified output finality for all outputs"
  ],
  "success_criteria": [
    "You can break any workflow into Input, Transformations, Output",
    "You assess input trust levels and handle them appropriately",
    "You plan for partial failures and ensure observability",
    "You include human override in every design"
  ]
}'::jsonb
WHERE slug = 'inputs-transformations-outputs';

-- Section 1.4: Manual First, Simple First
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Manual Process Observation",
      "description": "Choose a repetitive task and do it manually at least 3 times while taking detailed notes.",
      "fields": [
        {
          "id": "task_name",
          "type": "text",
          "label": "Task you will observe/perform:",
          "placeholder": "e.g., Processing invoices, Responding to inquiries, Creating reports",
          "required": true
        },
        {
          "id": "estimated_time",
          "type": "text",
          "label": "How long do people SAY this takes?",
          "placeholder": "e.g., 10 minutes",
          "required": true
        },
        {
          "id": "actual_time",
          "type": "text",
          "label": "How long did it ACTUALLY take (average of 3 tries)?",
          "placeholder": "e.g., 25 minutes",
          "required": true
        },
        {
          "id": "steps_documented",
          "type": "textarea",
          "label": "Document every step you performed:",
          "placeholder": "1. Opened email\n2. Downloaded attachment\n3. Opened spreadsheet\n4. Found the right row\n5. ...",
          "required": true,
          "rows": 10
        },
        {
          "id": "friction_points",
          "type": "textarea",
          "label": "What friction points did you discover?",
          "placeholder": "Where did you get stuck? What was annoying? What took longer than expected?",
          "required": true,
          "rows": 4
        },
        {
          "id": "hidden_dependencies",
          "type": "textarea",
          "label": "What hidden dependencies did you find?",
          "placeholder": "What information or access did you need that was not obvious at first?",
          "required": true,
          "rows": 3
        },
        {
          "id": "edge_cases_found",
          "type": "textarea",
          "label": "What edge cases did you encounter?",
          "placeholder": "Any unusual situations or exceptions?",
          "required": true,
          "rows": 3
        },
        {
          "id": "judgment_required",
          "type": "textarea",
          "label": "Where did you need to use judgment or make decisions?",
          "placeholder": "What parts required human thinking vs mechanical execution?",
          "required": true,
          "rows": 3
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Automation Opportunity Assessment",
      "description": "Evaluate whether this task is a good automation candidate.",
      "fields": [
        {
          "id": "frequency_score",
          "type": "rating",
          "label": "Frequency: How often does this task occur?",
          "required": true,
          "min": 1,
          "max": 10
        },
        {
          "id": "frequency_note",
          "type": "text",
          "label": "Frequency detail (e.g., 5x daily, weekly):",
          "placeholder": "Be specific about frequency",
          "required": true
        },
        {
          "id": "pain_score",
          "type": "rating",
          "label": "Pain Level: How annoying/time-consuming is this task?",
          "required": true,
          "min": 1,
          "max": 10
        },
        {
          "id": "risk_score",
          "type": "rating",
          "label": "Risk Level: How bad would it be if automation made mistakes?",
          "required": true,
          "min": 1,
          "max": 10
        },
        {
          "id": "judgment_score",
          "type": "rating",
          "label": "Judgment Required: How much human thinking is needed?",
          "required": true,
          "min": 1,
          "max": 10
        },
        {
          "id": "overall_assessment",
          "type": "radio",
          "label": "Based on your scores, is this a good automation candidate?",
          "required": true,
          "options": [
            "Excellent candidate (high frequency, high pain, low risk, low judgment)",
            "Good candidate with some challenges",
            "Partial automation only (keep human in loop)",
            "Poor candidate (high risk or high judgment required)"
          ]
        },
        {
          "id": "assessment_reasoning",
          "type": "textarea",
          "label": "Explain your assessment:",
          "placeholder": "Why is this a good or poor automation candidate?",
          "required": true,
          "rows": 4
        },
        {
          "id": "blast_radius",
          "type": "textarea",
          "label": "BLAST RADIUS - If this automation fails, how many people/systems are affected?",
          "placeholder": "Who/what depends on this? What is the impact of failure?",
          "required": true,
          "rows": 3
        },
        {
          "id": "kill_criteria",
          "type": "checkbox_group",
          "label": "KILL CRITERIA - Does any of these apply? (If yes, reconsider automating)",
          "required": false,
          "options": [
            "The process changes weekly",
            "The rules are subjective",
            "Cost of failure is very high",
            "Volume is too low to justify",
            "Humans enjoy it / builds relationships"
          ]
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Simple First Design",
      "description": "Design the minimum viable automation for this task.",
      "fields": [
        {
          "id": "mvp_scope",
          "type": "textarea",
          "label": "What is the MINIMUM useful automation you could build?",
          "placeholder": "Focus on the core value only - no nice-to-haves",
          "required": true,
          "rows": 4
        },
        {
          "id": "manual_parts",
          "type": "textarea",
          "label": "What parts will you deliberately keep manual (for now)?",
          "placeholder": "Edge cases, judgment calls, complex scenarios...",
          "required": true,
          "rows": 3
        },
        {
          "id": "success_metric",
          "type": "text",
          "label": "How will you measure success? Be specific.",
          "placeholder": "e.g., Reduce time from 25 min to 5 min, eliminate 80% of manual copying",
          "required": true
        },
        {
          "id": "phase_1",
          "type": "textarea",
          "label": "Phase 1 (Build this first):",
          "placeholder": "The core automation that delivers immediate value...",
          "required": true,
          "rows": 3
        },
        {
          "id": "phase_2",
          "type": "textarea",
          "label": "Phase 2 (Add later if Phase 1 works):",
          "placeholder": "Enhancements to add after proving the concept...",
          "required": true,
          "rows": 3
        },
        {
          "id": "phase_3",
          "type": "textarea",
          "label": "Phase 3 (Nice-to-have for the future):",
          "placeholder": "Features that could be added eventually...",
          "required": true,
          "rows": 3
        },
        {
          "id": "human_override",
          "type": "textarea",
          "label": "HUMAN OVERRIDE - How can humans intervene when needed?",
          "placeholder": "How do you pause, fix data, and resume? Every automation needs an escape hatch.",
          "required": true,
          "rows": 3
        },
        {
          "id": "observability_plan",
          "type": "textarea",
          "label": "OBSERVABILITY - How will you know if it fails?",
          "placeholder": "Logs, alerts, dashboards? Remember: silent failures are the most expensive.",
          "required": true,
          "rows": 3
        }
      ]
    }
  ],
  "deliverables": [
    "Performed a task manually at least 3 times",
    "Documented all steps, friction points, and edge cases",
    "Completed automation assessment including blast radius and kill criteria",
    "Designed a phased automation plan with human override and observability"
  ],
  "success_criteria": [
    "You discovered insights by doing the task manually",
    "You can evaluate automation candidates objectively including kill criteria",
    "Your MVP design includes human override and observability from day one"
  ]
}'::jsonb
WHERE slug = 'manual-first-simple-first';

-- Section 1.5: Documentation & Communication Standards
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Write System Documentation",
      "description": "Document a system you have built or use regularly.",
      "fields": [
        {
          "id": "system_name",
          "type": "text",
          "label": "System Name:",
          "placeholder": "e.g., Customer Onboarding Automation",
          "required": true
        },
        {
          "id": "executive_summary",
          "type": "textarea",
          "label": "Executive Summary (2-3 sentences for non-technical readers):",
          "placeholder": "What does this system do? What problem does it solve? What value does it provide?",
          "required": true,
          "rows": 3
        },
        {
          "id": "how_it_works",
          "type": "textarea",
          "label": "How It Works (step-by-step for users):",
          "placeholder": "1. When a new customer signs up...\n2. The system automatically...\n3. Then...",
          "required": true,
          "rows": 6
        },
        {
          "id": "technical_details",
          "type": "textarea",
          "label": "Technical Details (for other operators/developers):",
          "placeholder": "Tools used, connections, data flow, integrations...",
          "required": true,
          "rows": 6
        },
        {
          "id": "known_limitations",
          "type": "textarea",
          "label": "Known Limitations:",
          "placeholder": "What does this system NOT do? What edge cases are not handled?",
          "required": true,
          "rows": 4
        },
        {
          "id": "troubleshooting",
          "type": "textarea",
          "label": "Troubleshooting Guide (3 common issues):",
          "placeholder": "Issue 1: [Symptom]\nCause: [Why it happens]\nFix: [How to resolve]\n\nIssue 2: ...",
          "required": true,
          "rows": 8
        },
        {
          "id": "decision_log",
          "type": "textarea",
          "label": "Decision Log (Why things are the way they are):",
          "placeholder": "Key Decision: [What was decided]\nOptions Considered: [Alternatives]\nWhy This Approach: [Reasoning]\nTradeoffs Accepted: [What you gave up]",
          "required": true,
          "rows": 6
        },
        {
          "id": "ai_behavior_docs",
          "type": "textarea",
          "label": "AI Behavior Documentation (if AI is used, otherwise write N/A):",
          "placeholder": "What AI is allowed to do:\nWhat AI is NOT allowed to do:\nExpected accuracy:\nHuman override process:\nKnown failure modes:",
          "required": true,
          "rows": 8
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Stakeholder Communication",
      "description": "Practice translating technical concepts for different audiences.",
      "fields": [
        {
          "id": "technical_concept",
          "type": "text",
          "label": "Choose a technical concept to explain:",
          "placeholder": "e.g., API, webhook, automation trigger, database query",
          "required": true
        },
        {
          "id": "explain_executive",
          "type": "textarea",
          "label": "Explain it to an EXECUTIVE (focus on business value):",
          "placeholder": "No jargon. Focus on what it does for the business...",
          "required": true,
          "rows": 4
        },
        {
          "id": "explain_end_user",
          "type": "textarea",
          "label": "Explain it to an END USER (focus on what they experience):",
          "placeholder": "How does this affect their daily work?",
          "required": true,
          "rows": 4
        },
        {
          "id": "explain_technical",
          "type": "textarea",
          "label": "Explain it to a TECHNICAL PERSON (include specifics):",
          "placeholder": "Include technical details they would need...",
          "required": true,
          "rows": 4
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Project Proposal",
      "description": "Write a proposal for an automation project.",
      "fields": [
        {
          "id": "project_title",
          "type": "text",
          "label": "Project Title:",
          "placeholder": "e.g., Customer Support Response Automation",
          "required": true
        },
        {
          "id": "current_situation",
          "type": "textarea",
          "label": "Current Situation (the problem):",
          "placeholder": "What is happening now? What are the pain points? Include numbers if possible.",
          "required": true,
          "rows": 4
        },
        {
          "id": "proposed_solution",
          "type": "textarea",
          "label": "Proposed Solution (what you will build):",
          "placeholder": "High-level description of the automation...",
          "required": true,
          "rows": 4
        },
        {
          "id": "expected_benefits",
          "type": "textarea",
          "label": "Expected Benefits (be specific):",
          "placeholder": "Time saved, errors reduced, capacity increased... Use numbers.",
          "required": true,
          "rows": 4
        },
        {
          "id": "risks_mitigations",
          "type": "textarea",
          "label": "Risks and Mitigations:",
          "placeholder": "What could go wrong? How will you prevent or handle it?",
          "required": true,
          "rows": 4
        },
        {
          "id": "success_criteria",
          "type": "textarea",
          "label": "Success Criteria (how we know it worked):",
          "placeholder": "Specific, measurable outcomes...",
          "required": true,
          "rows": 3
        },
        {
          "id": "next_steps",
          "type": "textarea",
          "label": "Recommended Next Steps:",
          "placeholder": "1. ...\n2. ...\n3. ...",
          "required": true,
          "rows": 4
        }
      ]
    }
  ],
  "deliverables": [
    "Complete system documentation including decision log and AI behavior docs",
    "Technical concept explained to 3 different audiences",
    "Professional project proposal"
  ],
  "success_criteria": [
    "Your documentation could be understood by someone who has never seen the system",
    "You documented WHY decisions were made, not just WHAT was built",
    "AI components have explicit boundaries, accuracy targets, and override paths"
  ]
}'::jsonb
WHERE slug = 'documentation-communication';
