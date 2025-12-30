-- ============================================================================
-- MIGRATION: Add Interactive Exercise System
-- ============================================================================
-- This migration adds:
-- 1. exercise_schema column to sections (defines the form fields)
-- 2. user_exercise_responses table (stores user answers)
-- ============================================================================

-- Add exercise_schema column to sections
-- This JSONB column defines the interactive form fields for each exercise
ALTER TABLE sections
ADD COLUMN IF NOT EXISTS exercise_schema JSONB;

-- Add comment explaining the schema format
COMMENT ON COLUMN sections.exercise_schema IS 'JSON schema defining interactive exercise fields. Format:
{
  "parts": [
    {
      "id": "part1",
      "title": "Part 1: Self-Assessment",
      "description": "Optional intro text",
      "fields": [
        {
          "id": "field_id",
          "type": "text|textarea|select|checkbox|checkbox_group|radio|rating|table",
          "label": "Question or prompt",
          "placeholder": "Optional placeholder",
          "required": true|false,
          "options": ["opt1", "opt2"],  // for select, radio, checkbox_group
          "rows": 4,                      // for textarea
          "min": 1, "max": 10,           // for rating
          "columns": ["col1", "col2"],   // for table
          "rowCount": 5                  // for table
        }
      ]
    }
  ],
  "deliverables": ["Item 1", "Item 2"],
  "success_criteria": ["Criterion 1", "Criterion 2"]
}';

-- ============================================================================
-- USER EXERCISE RESPONSES TABLE
-- ============================================================================
CREATE TABLE IF NOT EXISTS user_exercise_responses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  section_id UUID REFERENCES sections(id) ON DELETE CASCADE,

  -- The actual responses stored as JSON
  -- Keys match field IDs from exercise_schema
  responses JSONB NOT NULL DEFAULT '{}',

  -- Progress tracking
  is_complete BOOLEAN DEFAULT false,
  completion_percent INTEGER DEFAULT 0,

  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  submitted_at TIMESTAMPTZ, -- When user marks as "done"

  -- Ensure one response set per user per section
  UNIQUE(user_id, section_id)
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_user_exercise_responses_user
  ON user_exercise_responses(user_id);
CREATE INDEX IF NOT EXISTS idx_user_exercise_responses_section
  ON user_exercise_responses(section_id);
CREATE INDEX IF NOT EXISTS idx_user_exercise_responses_complete
  ON user_exercise_responses(user_id, is_complete);

-- ============================================================================
-- ROW LEVEL SECURITY
-- ============================================================================
ALTER TABLE user_exercise_responses ENABLE ROW LEVEL SECURITY;

-- Users can only see their own responses
CREATE POLICY "Users can view own exercise responses"
  ON user_exercise_responses FOR SELECT
  USING (auth.uid() = user_id);

-- Users can insert their own responses
CREATE POLICY "Users can insert own exercise responses"
  ON user_exercise_responses FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Users can update their own responses
CREATE POLICY "Users can update own exercise responses"
  ON user_exercise_responses FOR UPDATE
  USING (auth.uid() = user_id);

-- Users can delete their own responses (to start over)
CREATE POLICY "Users can delete own exercise responses"
  ON user_exercise_responses FOR DELETE
  USING (auth.uid() = user_id);

-- ============================================================================
-- TRIGGER: Auto-update updated_at
-- ============================================================================
CREATE OR REPLACE FUNCTION update_exercise_response_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS update_exercise_responses_timestamp ON user_exercise_responses;
CREATE TRIGGER update_exercise_responses_timestamp
  BEFORE UPDATE ON user_exercise_responses
  FOR EACH ROW EXECUTE FUNCTION update_exercise_response_timestamp();

-- ============================================================================
-- HELPER FUNCTION: Calculate completion percentage
-- ============================================================================
CREATE OR REPLACE FUNCTION calculate_exercise_completion(
  p_responses JSONB,
  p_schema JSONB
) RETURNS INTEGER AS $$
DECLARE
  total_required INTEGER := 0;
  completed_required INTEGER := 0;
  part JSONB;
  field JSONB;
  field_id TEXT;
  response_value JSONB;
BEGIN
  -- Count required fields and how many are filled
  IF p_schema IS NULL OR p_schema->'parts' IS NULL THEN
    RETURN 0;
  END IF;

  FOR part IN SELECT * FROM jsonb_array_elements(p_schema->'parts')
  LOOP
    IF part->'fields' IS NOT NULL THEN
      FOR field IN SELECT * FROM jsonb_array_elements(part->'fields')
      LOOP
        IF (field->>'required')::boolean = true THEN
          total_required := total_required + 1;
          field_id := field->>'id';
          response_value := p_responses->field_id;

          -- Check if field has a meaningful value
          IF response_value IS NOT NULL
             AND response_value::text != 'null'
             AND response_value::text != '""'
             AND response_value::text != '[]'
             AND response_value::text != '{}' THEN
            completed_required := completed_required + 1;
          END IF;
        END IF;
      END LOOP;
    END IF;
  END LOOP;

  IF total_required = 0 THEN
    RETURN 100;
  END IF;

  RETURN ROUND((completed_required::numeric / total_required::numeric) * 100);
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- ============================================================================
-- TRIGGER: Auto-calculate completion on insert/update
-- ============================================================================
CREATE OR REPLACE FUNCTION auto_calculate_completion()
RETURNS TRIGGER AS $$
DECLARE
  section_schema JSONB;
BEGIN
  -- Get the exercise schema for this section
  SELECT exercise_schema INTO section_schema
  FROM sections
  WHERE id = NEW.section_id;

  -- Calculate completion percentage
  NEW.completion_percent := calculate_exercise_completion(NEW.responses, section_schema);

  -- Mark as complete if 100%
  IF NEW.completion_percent >= 100 THEN
    NEW.is_complete := true;
    IF NEW.submitted_at IS NULL THEN
      NEW.submitted_at := NOW();
    END IF;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS calculate_completion_on_save ON user_exercise_responses;
CREATE TRIGGER calculate_completion_on_save
  BEFORE INSERT OR UPDATE OF responses ON user_exercise_responses
  FOR EACH ROW EXECUTE FUNCTION auto_calculate_completion();
