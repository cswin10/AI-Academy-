-- ============================================================================
-- UPDATE SECTION 3.2: Structured Output Generation
-- ============================================================================
-- Run this in Supabase SQL Editor to update Section 3.2 content
-- Removes code blocks, uses capability tiers, connects to earlier sections
-- ============================================================================

-- First, rename the quiz
UPDATE quizzes
SET title = 'Structured Output & Schemas Quiz'
WHERE title = 'Structured Output Quiz';

-- Update the section title and content
UPDATE sections
SET
  title = 'Structured Output & Response Schemas',
  content_markdown = '# Structured Output & Response Schemas

Automation requires parseable outputs. This section covers how to reliably get JSON, structured formats, and validated responses from LLMs.

---

## Definitions

**Structured output** means a response that follows a predictable format, typically JSON with defined fields and types. This is essential because structured output can be parsed by code, stored in databases, validated against a schema, used in automated workflows, and logged for observability (Section 2.4).

Compare an unstructured response like "The lead seems interested, they have a budget and mentioned needing a solution by next month" with structured output: classification hot, confidence 0.85, signals budget_mentioned and timeline_specified, next_action schedule_demo. The structured version feeds directly into downstream systems without parsing or guessing.

---

## Format Validity vs Schema Validity

A critical distinction often missed:

**Format validity** means the output is syntactically correct. For JSON, this means it parses without error: braces match, commas are placed correctly, strings are quoted.

**Schema validity** means the output matches your expected structure. The right fields exist, data types are correct, enum values are valid, constraints are satisfied.

JSON mode (offered by many providers) guarantees format validity but not schema validity. You will get valid JSON, but it may contain wrong field names, incorrect types, or missing required fields. Always validate both levels.

---

## Getting Reliable Structured Output

### Strategy 1: Provide a Template

Show the exact structure you want. Include a skeleton with placeholders: classification (one of hot, warm, cold, unqualified), confidence (0.0 to 1.0), signals (array of strings), next_action (recommended action). End with a clear terminator like "JSON:" to signal where output should begin.

### Strategy 2: Define the Schema

Describe the expected structure in prose. State each field name exactly, its data type, allowed values or ranges, and any constraints. Specify that the response should contain ONLY the JSON object with no other text.

### Strategy 3: Example-Driven (from Section 3.1)

Show input/output pairs demonstrating the exact format. Include examples covering common cases (cold lead, hot lead) so the model sees the pattern. This combines naturally with templates when zero-shot prompting produces inconsistent results.

---

## Schema Best Practices

### Specify "JSON Only"

Be explicit about what you do not want: no explanations before or after, no markdown code blocks, no comments within the JSON, just the raw JSON object.

### Define Key Names Exactly

Prevent variation by listing exact keys: use "classification" (not "class", "category", or "type"), use "confidence" (not "score", "certainty", or "probability"), use "signals" (not "indicators", "factors", or "reasons").

### Specify Data Types

State types and constraints explicitly. For numbers, give the range: "confidence: number between 0.0 and 1.0, not a percentage, not a string". For enums, list all valid values. For arrays, specify "array of strings" and note that single items still use array format.

### Handle Arrays Properly

Arrays cause common errors. Specify that signals should always be an array of strings: correct forms are an array with one item, an array with multiple items, or an empty array. Wrong forms include a bare string instead of array or null.

### Define Empty/Null Handling

Decide upfront: if signals is empty, use empty array. If reasoning is empty, use empty string. If next_action has no value, use a sentinel like "none", not null or omission. Documenting this prevents inconsistent outputs.

---

## Provider Features

### JSON Mode

Many providers offer a parameter that constrains output to valid JSON. This ensures format validity (the response parses as JSON) but does not ensure schema validity. Field names, types, and structure can still vary. Use it as a safety net, not a replacement for schema validation.

### Structured Output Parameters

Some providers accept a schema definition (often JSON Schema format) that constrains output more strictly. Check your provider documentation, as implementation varies significantly. Even with schema enforcement, validate outputs defensively.

---

## The Repair Step Pattern

When validation fails, do not simply retry with the same prompt. Instead, add a repair step to your pipeline:

1. Detect the specific validation error (missing field, wrong type, malformed JSON).
2. Construct a repair prompt that includes the original output and the specific error: "This JSON is missing the ''confidence'' field. Add it with a value between 0 and 1."
3. Send the repair prompt to produce a corrected output.
4. Validate again. If still invalid, escalate.

This targeted approach often succeeds where blind retries fail, and it costs fewer tokens than re-generating from scratch.

---

## The Retry Ladder

When structured output fails, escalate through increasingly strict interventions:

1. **Stricter instruction**: Add explicit constraint like "Respond with ONLY valid JSON."
2. **Add template**: Show the exact skeleton structure expected.
3. **Add example**: Provide a complete input/output pair matching the current case.
4. **Escalate**: After three failures, route to human review, return an error response, or apply a safe fallback default.

Each step adds specificity. If stricter instructions fail, the template anchors the format. If the template fails, the example demonstrates exactly what you need. Beyond that, the task may require human judgment.

---

## Output Length and Truncation Risk

LLMs have maximum output limits. If your schema expects long arrays or verbose fields, the response may truncate mid-JSON, producing invalid output. Mitigations:

**Constrain field lengths** in your schema: "reasoning: string, max 50 words". This limits verbosity.

**Limit array sizes**: "signals: up to 5 most important signals". This prevents runaway lists.

**Chunk large outputs**: If you need extensive structured data, split across multiple calls.

**Detect truncation**: If output ends abruptly without closing braces, flag it as truncated rather than malformed.

---

## Validation in Your Pipeline

Never trust raw LLM output. Always validate.

Validation checklist: (1) Is it valid JSON? (2) Are required fields present? (3) Are data types correct? (4) Are enum values valid? (5) Are constraints satisfied (length limits, numeric ranges)?

Validation flow: First, call the LLM. Second, attempt to parse the output. Third, if parsing fails, log the error and enter the retry ladder. Fourth, if parsing succeeds, validate against your schema. Fifth, if validation fails, log the specific errors and enter the repair step or retry ladder. Sixth, if validation succeeds, use the result.

---

## Common Failures and Fixes

**Extra text around JSON**: The model adds preamble like "Here is the analysis:" or follow-up like "Let me know if you need more." Fix by explicitly stating "Respond with ONLY the JSON object. No text before or after."

**Markdown code blocks**: The model wraps output in triple backticks. Fix by adding "Do not wrap in markdown code blocks. Return raw JSON only."

**Trailing commas**: Invalid JSON syntax from training on languages that allow trailing commas. Fix by stating "Use valid JSON syntax. No trailing commas."

**Inconsistent keys**: Sometimes "class", sometimes "classification". Fix by listing exact key names and providing an example.

**Wrong data types**: Confidence returned as "high" instead of 0.85. Fix by specifying "confidence: number between 0.0 and 1.0".

**Missing fields**: Optional fields omitted inconsistently. Fix by specifying all fields are required, or define explicit defaults.

---

## When to Prefer Markdown Over JSON

JSON is not always the right choice. Prefer markdown when:

- Output is primarily for human consumption (meeting notes, summaries, reports)
- Structure is loose or variable (the number of sections may differ)
- You need rich formatting (headers, bullet lists, tables)
- Strict validation is less critical than readability

For markdown, define the expected structure as a template with section headers, bullet format, and table layout. Markdown is easier to generate reliably than JSON for narrative content, and many downstream tools can parse it.

---

## Connecting to Earlier Sections

**From 2.1 (Capability Tiers):** Fast/Cheap tier may need more explicit schema instructions than balanced or reasoning tiers. All tiers can produce structured output with proper prompting. Structured output enables the confidence scoring introduced in Section 2.1.

**From 2.2 (Task Templates):** Schema is part of your task template. Version schemas alongside templates. Output format affects execution boundary decisions.

**From 2.4 (System Instructions):** Response format is a key component of system instructions. Log raw outputs before parsing for debugging. Include schema version in observability metadata.

**From 2.5 (Cost Management):** Structured output with short, fixed fields uses fewer tokens than verbose prose. Retry logic costs tokens, so invest in getting it right first time. Validation failures are hidden cost multipliers.

---

## Key Takeaways

1. **Format validity vs schema validity**, JSON mode helps with the former but you must validate the latter
2. **Structured output enables automation**, unstructured output requires manual processing
3. **Provide templates or schemas**, do not rely on the model guessing your format
4. **Specify exact key names and data types**, prevent variation with explicit constraints
5. **Handle arrays and nulls explicitly**, define exactly what these should look like
6. **Use the repair step pattern**, fix specific errors rather than blind retry
7. **Follow the retry ladder**, stricter instruction then template then example then escalate
8. **Control output length**, long outputs risk truncation mid-JSON
9. **Prefer markdown for human-readable content**, JSON for machine consumption
10. **Log everything**, you need observability for debugging failures',

  exercise_markdown = '## Exercise: Structured Output Pipeline Design

Complete the interactive exercise below to design production-ready structured output systems.'

WHERE slug = 'structured-output';

-- Update quiz questions
DELETE FROM quiz_questions
WHERE quiz_id = (SELECT id FROM quizzes WHERE title = 'Structured Output & Schemas Quiz');

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation) VALUES
((SELECT id FROM quizzes WHERE title = 'Structured Output & Schemas Quiz'), 1,
'What is the difference between format validity and schema validity?',
'["They are the same thing", "Format validity means valid JSON syntax; schema validity means correct fields, types, and constraints", "Schema validity is about formatting; format validity is about content", "Format validity applies to JSON; schema validity applies to XML"]',
1,
'Format validity means the output parses correctly (valid JSON syntax). Schema validity means the output has the right fields, correct data types, valid enum values, and satisfies all constraints. JSON mode gives you format validity but not schema validity.'),

((SELECT id FROM quizzes WHERE title = 'Structured Output & Schemas Quiz'), 2,
'Why is structured output essential for automation?',
'["It looks more professional", "It can be parsed by code and used in automated workflows without manual processing", "It is required by all LLMs", "It uses fewer tokens"]',
1,
'Structured output (JSON, defined schemas) can be parsed programmatically, stored in databases, and used in automated pipelines without manual intervention or string parsing.'),

((SELECT id FROM quizzes WHERE title = 'Structured Output & Schemas Quiz'), 3,
'What is the repair step pattern?',
'["Retry the exact same prompt multiple times", "Send a targeted prompt that includes the original output and the specific error to produce a corrected version", "Skip validation and use the output anyway", "Switch to a different model tier"]',
1,
'The repair step pattern sends a prompt that includes the failed output and the specific validation error, asking the model to fix that exact issue. This is more effective and token-efficient than blind retries.'),

((SELECT id FROM quizzes WHERE title = 'Structured Output & Schemas Quiz'), 4,
'What is the correct order of the retry ladder?',
'["Example → template → stricter instruction → escalate", "Stricter instruction → template → example → escalate", "Escalate → stricter instruction → template → example", "Template → example → stricter instruction → escalate"]',
1,
'The retry ladder escalates through increasingly specific interventions: first stricter instructions, then add a template, then add an example. If all three fail, escalate to human review or fallback.'),

((SELECT id FROM quizzes WHERE title = 'Structured Output & Schemas Quiz'), 5,
'Why should you validate LLM output even when using JSON mode?',
'["JSON mode is always perfect", "JSON mode ensures valid JSON syntax but not your specific schema, field names, or data types", "Validation is unnecessary with JSON mode", "JSON mode prevents all errors"]',
1,
'JSON mode ensures syntactically valid JSON (format validity) but does not guarantee your specific structure, correct field names, or proper data types (schema validity). You must still validate against your schema.'),

((SELECT id FROM quizzes WHERE title = 'Structured Output & Schemas Quiz'), 6,
'What is output truncation risk and how do you mitigate it?',
'["Truncation never happens with structured output", "Long outputs may be cut off mid-JSON; mitigate by constraining field lengths and limiting array sizes", "Truncation only affects markdown output", "Use longer prompts to prevent truncation"]',
1,
'LLMs have output limits. Long arrays or verbose fields can cause truncation mid-JSON, producing invalid output. Mitigate by constraining field lengths in your schema, limiting array sizes, and detecting abrupt endings.'),

((SELECT id FROM quizzes WHERE title = 'Structured Output & Schemas Quiz'), 7,
'When should you prefer markdown over JSON for structured output?',
'["Never, JSON is always better", "When output is for human consumption, structure is variable, or rich formatting is needed", "Only when working with documentation", "When using Fast/Cheap tier models"]',
1,
'Markdown is preferable when output is primarily human-readable (summaries, reports), when structure is loose or variable, when you need rich formatting like headers and tables, or when strict validation is less critical than readability.'),

((SELECT id FROM quizzes WHERE title = 'Structured Output & Schemas Quiz'), 8,
'How should you handle arrays in JSON output specifications?',
'["Arrays are automatic", "Specify that arrays should be used even for single items, and show examples of correct and incorrect forms", "Avoid arrays entirely", "Let the model decide"]',
1,
'Explicitly specify that arrays should remain arrays even with one item, and show examples. Otherwise models often return single values as strings instead of single-item arrays, or use null instead of empty array.');

-- Update exercise schema
UPDATE sections
SET exercise_schema = '{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Schema Design",
      "description": "Design a structured output schema with clear validity criteria.",
      "fields": [
        {
          "id": "schema_design",
          "type": "textarea",
          "label": "Design a JSON schema for lead classification. Include field names, types, constraints, and validity rules:",
          "placeholder": "Schema for Lead Classification:\n\nclassification:\n  type: string\n  allowed values: hot, warm, cold, unqualified\n  required: yes\n\nconfidence:\n  type: number\n  range: 0.0 to 1.0\n  required: yes\n  note: decimal, not percentage\n\nsignals:\n  type: array of strings\n  examples: budget_mentioned, timeline_specified, decision_maker\n  if empty: use []\n  required: yes\n\nobjections:\n  type: array of strings\n  if empty: use []\n  required: yes\n\nreasoning:\n  type: string\n  max length: 100 characters\n  if empty: use empty string\n  required: yes\n\nnext_action:\n  type: string\n  if no action: use \"none\"\n  required: yes",
          "required": true,
          "rows": 28
        },
        {
          "id": "validity_distinction",
          "type": "textarea",
          "label": "Describe what format validity and schema validity mean for your schema. What would a format-valid but schema-invalid output look like?",
          "placeholder": "Format validity for this schema:\n- Output parses as valid JSON (braces match, proper quoting, no trailing commas)\n\nSchema validity for this schema:\n- classification is one of the four allowed values\n- confidence is a number between 0 and 1\n- signals and objections are arrays (not strings or null)\n- reasoning is 100 characters or fewer\n- all six fields are present\n\nFormat-valid but schema-invalid example:\n{\"class\": \"very_hot\", \"confidence\": \"high\", \"reasons\": \"they seemed interested\"}\n\nThis parses as JSON but: wrong field names (class vs classification, reasons vs signals), wrong type (confidence is string not number), wrong value (very_hot not in enum), missing fields (objections, next_action).",
          "required": true,
          "rows": 16
        }
      ]
    },
    {
      "id": "part2",
      "title": "Part 2: Prompt Construction",
      "description": "Build a prompt that reliably produces your schema.",
      "fields": [
        {
          "id": "full_prompt",
          "type": "textarea",
          "label": "Write the complete prompt for your schema. Include schema definition, constraints, and output rules:",
          "placeholder": "Analyze the following lead and return a JSON classification.\n\nSCHEMA:\nclassification: one of hot, warm, cold, unqualified\nconfidence: number from 0.0 to 1.0 (decimal, not percentage)\nsignals: array of strings identifying buying signals\nobjections: array of strings identifying concerns raised\nreasoning: brief explanation, max 100 characters\nnext_action: recommended next step\n\nRULES:\n- Respond with ONLY valid JSON\n- No text before or after the JSON\n- No markdown code blocks\n- Use exact field names as shown\n- Arrays are always arrays, even if empty (use [])\n- All six fields are required\n\nLead to analyze:\n[INPUT]\n\nJSON:",
          "required": true,
          "rows": 24
        }
      ]
    },
    {
      "id": "part3",
      "title": "Part 3: Retry Ladder and Repair Step",
      "description": "Design your escalation strategy for handling failures.",
      "fields": [
        {
          "id": "retry_ladder",
          "type": "textarea",
          "label": "Define your retry ladder. What do you add at each step?",
          "placeholder": "Retry Ladder:\n\nStep 1 - Stricter instruction:\nAdd: \"You MUST return valid JSON only. No other text.\"\n\nStep 2 - Add template:\nAdd: Show the exact skeleton structure with placeholders\nExample: {\"classification\": \"[hot|warm|cold|unqualified]\", \"confidence\": 0.0, ...}\n\nStep 3 - Add example:\nAdd: Complete input/output pair\nInput: \"Budget approved, need solution this quarter\"\nOutput: {\"classification\": \"hot\", \"confidence\": 0.9, \"signals\": [\"budget_confirmed\", \"timeline\"], \"objections\": [], \"reasoning\": \"Clear buying signals present\", \"next_action\": \"schedule_demo\"}\n\nStep 4 - Escalate:\nAfter three failures, route to human review or return error with safe default.",
          "required": true,
          "rows": 20
        },
        {
          "id": "repair_step",
          "type": "textarea",
          "label": "Design a repair step for a specific error. Show the repair prompt for: missing confidence field.",
          "placeholder": "Repair Step for Missing Confidence Field:\n\nOriginal output:\n{\"classification\": \"warm\", \"signals\": [\"interest_expressed\"], \"objections\": [], \"reasoning\": \"Showed interest but no timeline\", \"next_action\": \"follow_up_call\"}\n\nRepair prompt:\nThe following JSON is missing the required \"confidence\" field. Add a confidence value between 0.0 and 1.0 based on how certain the classification is.\n\nOriginal JSON:\n[paste original output]\n\nReturn the corrected JSON with the confidence field added. Return ONLY the corrected JSON.\n\nCorrected JSON:",
          "required": true,
          "rows": 18
        }
      ]
    },
    {
      "id": "part4",
      "title": "Part 4: Length Control and Truncation",
      "description": "Address output length risks.",
      "fields": [
        {
          "id": "length_controls",
          "type": "textarea",
          "label": "What length constraints have you built into your schema? How would you detect truncation?",
          "placeholder": "Length constraints in schema:\n\n- reasoning: max 100 characters (explicit limit)\n- signals: implied limit of 5-7 items (could add explicit \"up to 5 most important\")\n- objections: implied limit of 3-5 items\n- next_action: single action, not a list\n\nTruncation detection:\n\n1. Check if output ends with closing brace\n2. Attempt JSON parse - truncated JSON fails to parse\n3. If parse fails and output ends mid-word or mid-string, flag as truncated vs malformed\n4. Log truncation separately from format errors for monitoring\n\nMitigation if truncation detected:\n- Retry with stricter length constraints\n- Add \"Keep response under 500 characters total\" to prompt",
          "required": true,
          "rows": 18
        }
      ]
    },
    {
      "id": "part5",
      "title": "Part 5: Validation Logic",
      "description": "Design validation covering both format and schema validity.",
      "fields": [
        {
          "id": "validation_rules",
          "type": "textarea",
          "label": "Write validation rules covering format validity and schema validity (pseudocode or description):",
          "placeholder": "Validation Rules:\n\nfunction validateLeadOutput(rawOutput):\n  errors = []\n\n  // FORMAT VALIDITY\n  try:\n    parsed = JSON.parse(rawOutput)\n  catch:\n    errors.push(\"FORMAT_INVALID: not valid JSON\")\n    return {valid: false, errors: errors, level: \"format\"}\n\n  // SCHEMA VALIDITY\n  \n  // classification\n  if \"classification\" not in parsed:\n    errors.push(\"MISSING_FIELD: classification\")\n  else if parsed.classification not in [\"hot\", \"warm\", \"cold\", \"unqualified\"]:\n    errors.push(\"INVALID_ENUM: classification must be hot|warm|cold|unqualified\")\n\n  // confidence\n  if \"confidence\" not in parsed:\n    errors.push(\"MISSING_FIELD: confidence\")\n  else if typeof parsed.confidence != number:\n    errors.push(\"WRONG_TYPE: confidence must be number\")\n  else if parsed.confidence < 0 or parsed.confidence > 1:\n    errors.push(\"OUT_OF_RANGE: confidence must be 0.0-1.0\")\n\n  // signals\n  if \"signals\" not in parsed:\n    errors.push(\"MISSING_FIELD: signals\")\n  else if not isArray(parsed.signals):\n    errors.push(\"WRONG_TYPE: signals must be array\")\n\n  // objections\n  if \"objections\" not in parsed:\n    errors.push(\"MISSING_FIELD: objections\")\n  else if not isArray(parsed.objections):\n    errors.push(\"WRONG_TYPE: objections must be array\")\n\n  // reasoning\n  if \"reasoning\" not in parsed:\n    errors.push(\"MISSING_FIELD: reasoning\")\n  else if length(parsed.reasoning) > 100:\n    errors.push(\"CONSTRAINT_VIOLATED: reasoning over 100 chars\")\n\n  // next_action\n  if \"next_action\" not in parsed:\n    errors.push(\"MISSING_FIELD: next_action\")\n\n  return {valid: errors.length == 0, errors: errors, level: \"schema\"}",
          "required": true,
          "rows": 40
        }
      ]
    },
    {
      "id": "part6",
      "title": "Part 6: Markdown Alternative",
      "description": "Design a markdown format for the same data when human readability matters more.",
      "fields": [
        {
          "id": "markdown_format",
          "type": "textarea",
          "label": "Design a markdown template for lead analysis output. When would you use this instead of JSON?",
          "placeholder": "Markdown Template for Lead Analysis:\n\n## Lead Classification\n\n**Classification:** [hot/warm/cold/unqualified]\n**Confidence:** [X]%\n\n### Buying Signals\n- [Signal 1]\n- [Signal 2]\n\n### Objections Raised\n- [Objection 1]\n- [None identified]\n\n### Analysis\n[Brief reasoning, 1-2 sentences]\n\n### Recommended Next Action\n[Specific action to take]\n\n---\n\nWhen to use markdown instead of JSON:\n\n1. Output goes to sales team in Slack or email (human readers)\n2. Report compilation where multiple analyses are combined\n3. When the downstream system expects formatted text (CRM notes field)\n4. When structure varies by case (some leads have many signals, some have none)\n\nWhen to use JSON:\n1. Output feeds automated workflow (lead scoring, routing)\n2. Data stored in database for later querying\n3. Strict validation required\n4. Downstream code needs to extract specific fields",
          "required": true,
          "rows": 30
        }
      ]
    }
  ],
  "deliverables": [
    "Complete schema with types, constraints, and validity criteria",
    "Format validity vs schema validity distinction with examples",
    "Full prompt with schema and output rules",
    "Retry ladder with four escalation steps",
    "Repair step prompt for specific error",
    "Length controls and truncation detection",
    "Validation logic covering both validity levels",
    "Markdown alternative with use case guidance"
  ],
  "success_criteria": [
    "Schema distinguishes format validity from schema validity",
    "Prompt explicitly constrains output format",
    "Retry ladder follows correct order: instruction, template, example, escalate",
    "Repair step targets specific error with focused prompt",
    "Length constraints prevent truncation risk",
    "Validation covers all fields with specific error messages",
    "Markdown template provided with clear guidance on when to use it"
  ]
}'::jsonb
WHERE slug = 'structured-output';

-- Verify the update
SELECT slug, title,
       LENGTH(content_markdown) as content_length,
       exercise_schema IS NOT NULL as has_schema
FROM sections
WHERE slug = 'structured-output';
