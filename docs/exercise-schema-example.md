# Interactive Exercise Schema Design

## Field Types Available

| Type | Use Case | Options |
|------|----------|---------|
| `text` | Short answer (1 line) | `placeholder`, `required` |
| `textarea` | Long answer (multi-line) | `placeholder`, `rows`, `required` |
| `select` | Dropdown choice | `options[]`, `required` |
| `radio` | Single choice from list | `options[]`, `required` |
| `checkbox` | Yes/no toggle | `label`, `required` |
| `checkbox_group` | Multiple selections | `options[]`, `required` |
| `rating` | 1-10 scale | `min`, `max`, `required` |
| `table` | Grid of inputs | `columns[]`, `rowCount`, `required` |

---

## Example: Section 1.1 Exercise Schema

```json
{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Self-Assessment",
      "estimated_minutes": 15,
      "fields": [
        {
          "id": "current_role",
          "type": "textarea",
          "label": "What's your current work or experience?",
          "placeholder": "Describe your current role, responsibilities, and relevant background...",
          "rows": 4,
          "required": true
        },
        {
          "id": "useful_skills",
          "type": "textarea",
          "label": "What skills do you already have that might be useful as an AI operator?",
          "placeholder": "List skills like problem-solving, tool usage, communication, etc.",
          "rows": 3,
          "required": true
        },
        {
          "id": "interest_reason",
          "type": "textarea",
          "label": "What attracts you to becoming an AI operator?",
          "placeholder": "What outcomes do you want from this training?",
          "rows": 3,
          "required": true
        },
        {
          "id": "automation_first_rating",
          "type": "rating",
          "label": "Rate your interest in Automation-First Operator (connecting tools, building workflows)",
          "min": 1,
          "max": 10,
          "required": true
        },
        {
          "id": "automation_first_why",
          "type": "text",
          "label": "Why this rating?",
          "placeholder": "Brief explanation...",
          "required": false
        },
        {
          "id": "ai_first_rating",
          "type": "rating",
          "label": "Rate your interest in AI-First Operator (leveraging AI for content and analysis)",
          "min": 1,
          "max": 10,
          "required": true
        },
        {
          "id": "ai_first_why",
          "type": "text",
          "label": "Why this rating?",
          "placeholder": "Brief explanation...",
          "required": false
        },
        {
          "id": "hybrid_rating",
          "type": "rating",
          "label": "Rate your interest in Hybrid Operator (combining both for comprehensive solutions)",
          "min": 1,
          "max": 10,
          "required": true
        },
        {
          "id": "hybrid_why",
          "type": "text",
          "label": "Why this rating?",
          "placeholder": "Brief explanation...",
          "required": false
        },
        {
          "id": "career_path",
          "type": "radio",
          "label": "Which career path interests you most?",
          "options": [
            "Freelance/Consultant",
            "In-House Operator",
            "Agency Owner",
            "Product Builder"
          ],
          "required": true
        },
        {
          "id": "career_path_reasoning",
          "type": "textarea",
          "label": "Why does this path interest you?",
          "rows": 3,
          "required": true
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Business Analysis",
      "estimated_minutes": 25,
      "fields": [
        {
          "id": "business_name",
          "type": "text",
          "label": "Business name",
          "placeholder": "Name of the business you're analyzing",
          "required": true
        },
        {
          "id": "business_industry",
          "type": "text",
          "label": "Industry",
          "placeholder": "e.g., Real estate, Healthcare, E-commerce",
          "required": true
        },
        {
          "id": "business_size",
          "type": "select",
          "label": "Approximate size",
          "options": [
            "Solo/Freelancer",
            "2-5 employees",
            "6-20 employees",
            "21-50 employees",
            "51-200 employees",
            "200+ employees"
          ],
          "required": true
        },
        {
          "id": "business_description",
          "type": "textarea",
          "label": "What does this business do?",
          "rows": 3,
          "required": true
        },
        {
          "id": "recurring_activities",
          "type": "table",
          "label": "List 5-7 recurring activities that happen every week",
          "columns": ["Activity", "How often?", "Who does it?"],
          "rowCount": 7,
          "required": true
        },
        {
          "id": "information_sources",
          "type": "checkbox_group",
          "label": "Where does information come from? (Check all that apply)",
          "options": [
            "Emails",
            "Forms (website, paper)",
            "Phone calls",
            "Messages (Slack, WhatsApp, etc.)",
            "Spreadsheets",
            "Physical documents",
            "Software/apps",
            "Other"
          ],
          "required": true
        },
        {
          "id": "information_sources_details",
          "type": "textarea",
          "label": "Describe how information flows from these sources",
          "rows": 4,
          "required": true
        },
        {
          "id": "pain_point_1",
          "type": "textarea",
          "label": "Pain Point 1: What happens and how often?",
          "placeholder": "Be specific: 'I copy data from emails into a spreadsheet 20 times a day'",
          "rows": 3,
          "required": true
        },
        {
          "id": "pain_point_1_time",
          "type": "text",
          "label": "Time wasted on Pain Point 1",
          "placeholder": "e.g., 2 hours/week",
          "required": true
        },
        {
          "id": "pain_point_1_judgment",
          "type": "radio",
          "label": "Does Pain Point 1 require human judgment?",
          "options": ["Yes - requires thinking", "No - purely repetitive", "Partially - some judgment needed"],
          "required": true
        },
        {
          "id": "pain_point_2",
          "type": "textarea",
          "label": "Pain Point 2: What happens and how often?",
          "rows": 3,
          "required": true
        },
        {
          "id": "pain_point_2_time",
          "type": "text",
          "label": "Time wasted on Pain Point 2",
          "required": true
        },
        {
          "id": "pain_point_2_judgment",
          "type": "radio",
          "label": "Does Pain Point 2 require human judgment?",
          "options": ["Yes - requires thinking", "No - purely repetitive", "Partially - some judgment needed"],
          "required": true
        },
        {
          "id": "pain_point_3",
          "type": "textarea",
          "label": "Pain Point 3: What happens and how often?",
          "rows": 3,
          "required": true
        },
        {
          "id": "pain_point_3_time",
          "type": "text",
          "label": "Time wasted on Pain Point 3",
          "required": true
        },
        {
          "id": "pain_point_3_judgment",
          "type": "radio",
          "label": "Does Pain Point 3 require human judgment?",
          "options": ["Yes - requires thinking", "No - purely repetitive", "Partially - some judgment needed"],
          "required": true
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Opportunity Identification",
      "estimated_minutes": 15,
      "fields": [
        {
          "id": "target_pain_point",
          "type": "radio",
          "label": "Which pain point would you target first?",
          "options": ["Pain Point 1", "Pain Point 2", "Pain Point 3"],
          "required": true
        },
        {
          "id": "why_this_target",
          "type": "textarea",
          "label": "Why this one? Consider frequency, pain level, and complexity.",
          "rows": 3,
          "required": true
        },
        {
          "id": "solution_description",
          "type": "textarea",
          "label": "What would a solution look like at a high level?",
          "rows": 4,
          "required": true
        },
        {
          "id": "success_metrics",
          "type": "textarea",
          "label": "What would success look like? Be specific (hours saved, errors reduced, etc.)",
          "rows": 3,
          "required": true
        },
        {
          "id": "interface_layer",
          "type": "textarea",
          "label": "INTERFACE: What would users interact with?",
          "placeholder": "Forms, dashboards, notifications, etc.",
          "rows": 2,
          "required": true
        },
        {
          "id": "data_layer",
          "type": "textarea",
          "label": "DATA: Where would information be stored?",
          "placeholder": "Spreadsheet, database, CRM, etc.",
          "rows": 2,
          "required": true
        },
        {
          "id": "automation_layer",
          "type": "textarea",
          "label": "AUTOMATION: What would happen automatically?",
          "placeholder": "Triggers, notifications, data transfers, etc.",
          "rows": 2,
          "required": true
        },
        {
          "id": "ai_layer",
          "type": "textarea",
          "label": "AI: Where might AI help, if at all?",
          "placeholder": "Classification, drafting, analysis, or 'Not needed for this solution'",
          "rows": 2,
          "required": true
        }
      ]
    }
  ],
  "deliverables": [
    "Completed self-assessment with honest, specific answers",
    "Identified your primary operator type interest",
    "Analyzed a real business (not hypothetical)",
    "Listed 5+ recurring activities",
    "Identified 3+ specific pain points",
    "Assessed judgment requirements for each pain point",
    "Identified one automation opportunity",
    "Sketched a potential solution using the 4 layers"
  ],
  "success_criteria": [
    "You can articulate what type of operator you want to become",
    "You've analyzed a real business (not hypothetical)",
    "You've identified specific, concrete pain points",
    "You can see at least one automation opportunity"
  ]
}
```

---

## How It Works

### In the Database
- `sections.exercise_schema` stores the JSON above
- `sections.exercise_markdown` remains for context/instructions that aren't form fields
- `user_exercise_responses.responses` stores the user's answers keyed by field ID

### In the Frontend
1. Fetch section with `exercise_schema`
2. Render form fields based on field types
3. Auto-save to `user_exercise_responses` as user types
4. Show completion percentage based on required fields
5. Allow user to mark as "complete" when done

### Example User Response
```json
{
  "current_role": "I'm a marketing coordinator at a small agency...",
  "useful_skills": "I'm good at Excel, have used Zapier a bit...",
  "automation_first_rating": 8,
  "automation_first_why": "I love connecting tools together",
  "ai_first_rating": 6,
  "business_name": "Smith Real Estate",
  "business_industry": "Real Estate",
  "pain_point_1": "Manually copying lead info from website forms into our CRM..."
}
```

---

## Benefits

1. **Clean UX** - No more `_____` lines that can't be filled
2. **Progress tracking** - Users see % complete
3. **Persistent** - Answers saved to their account
4. **Portfolio** - Completed exercises become reference material
5. **Analytics** - You can see which questions people skip or struggle with
