-- ============================================================================
-- CLEANUP AND RESEED MODULES 2-5
-- ============================================================================
-- This script completely removes all data for modules 2-5 and their associated
-- quizzes (regardless of title), then re-runs seeds and migrations in order.
-- Run this in Supabase SQL Editor to fix duplicate data issues.
-- ============================================================================

-- ============================================================================
-- STEP 1: NUCLEAR CLEANUP - Remove ALL data for modules 2-5
-- ============================================================================

DO $$
DECLARE
  v_module_slugs TEXT[] := ARRAY['llm-mastery', 'prompt-engineering-mastery', 'ai-tools-ecosystem', 'data-information-architecture'];
  v_quiz_ids UUID[];
  v_slug TEXT;
BEGIN
  -- For each module, capture and delete all associated data
  FOREACH v_slug IN ARRAY v_module_slugs
  LOOP
    -- Capture quiz IDs linked to this module's sections
    SELECT array_agg(s.quiz_id) INTO v_quiz_ids
    FROM sections s
    INNER JOIN modules m ON s.module_id = m.id
    WHERE m.slug = v_slug AND s.quiz_id IS NOT NULL;

    -- Delete quiz_questions for captured quizzes
    IF v_quiz_ids IS NOT NULL THEN
      DELETE FROM quiz_questions WHERE quiz_id = ANY(v_quiz_ids);
    END IF;

    -- Delete external_resources
    DELETE FROM external_resources WHERE section_id IN (
      SELECT id FROM sections WHERE module_id IN (
        SELECT id FROM modules WHERE slug = v_slug
      )
    );

    -- Delete sections
    DELETE FROM sections WHERE module_id IN (
      SELECT id FROM modules WHERE slug = v_slug
    );

    -- Delete quizzes by captured IDs
    IF v_quiz_ids IS NOT NULL THEN
      DELETE FROM quizzes WHERE id = ANY(v_quiz_ids);
    END IF;

    -- Delete module
    DELETE FROM modules WHERE slug = v_slug;

    RAISE NOTICE 'Cleaned up module: %', v_slug;
  END LOOP;
END $$;

-- Also delete ANY orphaned quizzes that might have these titles (including duplicates)
DELETE FROM quiz_questions WHERE quiz_id IN (
  SELECT id FROM quizzes WHERE title IN (
    -- Module 2 quiz titles (original and ALL renamed versions from migrations)
    'What LLMs Are Quiz',
    'Prompt Patterns Quiz',
    'Task Templates Quiz',
    'Chain-of-Thought Quiz',
    'Structured Reasoning & Verification Quiz',
    'System Prompts Quiz',
    'System Instructions Quiz',
    'Model Selection Quiz',
    'Model Selection & Routing Quiz',
    'Context Windows Quiz',
    'Context Windows & State Management Quiz',
    -- Module 3 quiz titles (original and ALL renamed versions from migrations)
    'Zero-Shot Few-Shot Quiz',
    'Example-Driven Specifications Quiz',
    'Structured Output Quiz',
    'Structured Output & Schemas Quiz',
    'Prompt Chaining Quiz',
    'Multi-Step Task Pipelines Quiz',
    'Self-Critique Quiz',
    'Self-Critique & Verification Quiz',
    'Edge Cases Quiz',
    'Edge Cases & Production Robustness Quiz',
    -- Module 4 quiz titles
    'LLM Platforms Quiz',
    'AI Code Assistants Quiz',
    'No-Code AI Tools Quiz',
    'Specialized AI Tools Quiz',
    'Tool Selection Quiz',
    -- Module 5 quiz titles
    'Data Flow Quiz',
    'Data Structures Quiz',
    'Schema Design Quiz',
    'Data Quality Quiz',
    'Privacy and Security Quiz'
  )
);

DELETE FROM quizzes WHERE title IN (
  -- Module 2 quiz titles (original and ALL renamed versions from migrations)
  'What LLMs Are Quiz',
  'Prompt Patterns Quiz',
  'Task Templates Quiz',
  'Chain-of-Thought Quiz',
  'Structured Reasoning & Verification Quiz',
  'System Prompts Quiz',
  'System Instructions Quiz',
  'Model Selection Quiz',
  'Model Selection & Routing Quiz',
  'Context Windows Quiz',
  'Context Windows & State Management Quiz',
  -- Module 3 quiz titles (original and ALL renamed versions from migrations)
  'Zero-Shot Few-Shot Quiz',
  'Example-Driven Specifications Quiz',
  'Structured Output Quiz',
  'Structured Output & Schemas Quiz',
  'Prompt Chaining Quiz',
  'Multi-Step Task Pipelines Quiz',
  'Self-Critique Quiz',
  'Self-Critique & Verification Quiz',
  'Edge Cases Quiz',
  'Edge Cases & Production Robustness Quiz',
  -- Module 4 quiz titles
  'LLM Platforms Quiz',
  'AI Code Assistants Quiz',
  'No-Code AI Tools Quiz',
  'Specialized AI Tools Quiz',
  'Tool Selection Quiz',
  -- Module 5 quiz titles
  'Data Flow Quiz',
  'Data Structures Quiz',
  'Schema Design Quiz',
  'Data Quality Quiz',
  'Privacy and Security Quiz'
);

-- Verify cleanup
DO $$
DECLARE
  v_count INTEGER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM modules WHERE slug IN ('llm-mastery', 'prompt-engineering-mastery', 'ai-tools-ecosystem', 'data-information-architecture');
  IF v_count = 0 THEN
    RAISE NOTICE 'SUCCESS: All modules 2-5 data has been cleaned up. Now run the seed files followed by migration files.';
  ELSE
    RAISE WARNING 'WARNING: % modules still exist', v_count;
  END IF;
END $$;
