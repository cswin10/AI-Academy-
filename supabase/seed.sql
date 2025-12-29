-- AI Operator Academy Seed Data
-- Run this after schema.sql in your Supabase SQL Editor

-- ============================================
-- TRACKS
-- ============================================
INSERT INTO tracks (slug, name, description, icon, color, order_index, estimated_hours, is_required, is_active) VALUES
('core-foundation', 'Core Foundation', 'Master the fundamentals of AI operations, systems thinking, and the tools that power modern automation. Required for all learners.', '🎯', '#7c3aed', 1, 25, true, true),
('builder-track', 'Builder Track', 'Deep dive into no-code automation platforms and workflow design. Build hands-on projects with Zapier, Make, n8n, and more.', '🛠️', '#3b82f6', 2, 30, false, true),
('business-track', 'Business Track', 'Apply AI operations to real business challenges. Learn client management, pricing, proposals, and entrepreneurship.', '💼', '#10b981', 3, 28, false, true),
('creator-track', 'Creator Track', 'Build AI-powered content workflows. From writing assistance to multimedia production and distribution.', '🎨', '#f59e0b', 4, 18, false, true),
('infrastructure-track', 'Infrastructure Track', 'Set up robust systems infrastructure. Databases, APIs, deployment, monitoring, and scaling strategies.', '🏗️', '#ef4444', 5, 25, false, true);

-- ============================================
-- ACHIEVEMENTS
-- ============================================
INSERT INTO achievements (code, category, name, description, icon, xp_reward, rarity, required_value) VALUES
-- Completion
('FIRST_SECTION', 'completion', 'Journey Begins', 'Complete your first section', '✨', 10, 'common', 1),
('FIRST_MODULE', 'completion', 'First Steps', 'Complete your first module', '🎯', 25, 'common', 1),
('FIVE_MODULES', 'completion', 'Getting Serious', 'Complete 5 modules', '📚', 50, 'common', 5),
('TEN_MODULES', 'completion', 'Dedicated Learner', 'Complete 10 modules', '🏆', 100, 'rare', 10),
('FIRST_TRACK', 'completion', 'Track Master', 'Complete your first track', '🌟', 200, 'rare', 1),

-- Streak
('STREAK_3', 'streak', '3-Day Streak', 'Learn for 3 days in a row', '🔥', 15, 'common', 3),
('STREAK_7', 'streak', 'Week Warrior', 'Learn for 7 days in a row', '⚡', 30, 'rare', 7),
('STREAK_14', 'streak', 'Fortnight Focus', 'Learn for 14 days in a row', '💪', 75, 'epic', 14),
('STREAK_30', 'streak', 'Monthly Master', 'Learn for 30 days in a row', '👑', 200, 'legendary', 30),

-- Perfection
('PERFECT_QUIZ', 'perfection', 'Perfectionist', 'Score 100% on any quiz', '💯', 20, 'common', 1),
('PERFECT_FIVE', 'perfection', 'Ace Student', 'Score 100% on 5 quizzes', '🌟', 50, 'rare', 5),
('PERFECT_TEN', 'perfection', 'Quiz Master', 'Score 100% on 10 quizzes', '🏅', 100, 'epic', 10),

-- Speed
('QUICK_LEARNER', 'speed', 'Quick Learner', 'Pass a quiz on first attempt 10 times', '⚡', 75, 'rare', 10),
('SPEED_DEMON', 'speed', 'Speed Demon', 'Complete 5 sections in one day', '🚀', 50, 'rare', 5);

-- ============================================
-- MODULE 1: Operator Foundations & Mental Models
-- ============================================
INSERT INTO modules (track_id, slug, title, short_description, order_index, estimated_hours, level, xp_reward, is_active)
SELECT
  id,
  'operator-foundations',
  'Operator Foundations & Mental Models',
  'Understand what an AI operator is, how systems work in businesses, and the core mental models you''ll use for every project.',
  1,
  4,
  'Beginner',
  50,
  true
FROM tracks WHERE slug = 'core-foundation';

-- ============================================
-- QUIZZES FOR MODULE 1
-- ============================================

-- Quiz 1.1: What Is an AI Operator?
INSERT INTO quizzes (title, description, difficulty, passing_score, xp_reward) VALUES
('What Is an AI Operator?', 'Test your understanding of the AI operator role', 'beginner', 70, 10);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  1,
  'What is the best description of an AI operator?',
  '["Someone who writes prompts all day", "Someone who installs AI tools without understanding the business", "Someone who understands business processes and uses AI and automation to improve them", "A full-time software engineer"]',
  2,
  'An AI operator bridges business understanding with technical implementation, focusing on process improvement rather than just tool usage.'
FROM quizzes WHERE title = 'What Is an AI Operator?';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  2,
  'Which of the following is NOT a core part of being an AI operator?',
  '["Systems thinking", "Understanding basic data structures", "Communicating clearly with humans", "Memorizing every feature of every tool"]',
  3,
  'AI operators need to understand concepts and know how to find information, not memorize everything. Tools change constantly.'
FROM quizzes WHERE title = 'What Is an AI Operator?';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  3,
  'In a small business, what is a realistic contribution from an AI operator?',
  '["Replacing the entire team with AI in one week", "Designing and implementing simple systems that remove manual work", "Building a fully custom programming language", "Only advising, never building anything"]',
  1,
  'AI operators focus on practical, incremental improvements that deliver real value, not revolutionary overnight changes.'
FROM quizzes WHERE title = 'What Is an AI Operator?';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  4,
  'Why is communication important for an AI operator?',
  '["So they can convince people to buy crypto", "So they can explain systems and changes clearly to non-technical people", "So they can avoid documenting anything", "It is not important"]',
  1,
  'AI operators must translate technical concepts for stakeholders and document their work for future maintenance and improvement.'
FROM quizzes WHERE title = 'What Is an AI Operator?';

-- Quiz 1.2: The 4-Layer System Model
INSERT INTO quizzes (title, description, difficulty, passing_score, xp_reward) VALUES
('The 4-Layer System Model', 'Test your understanding of the system architecture model', 'beginner', 70, 10);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  1,
  'Which layer is responsible for where information is stored long-term?',
  '["Interface", "Automation", "Data", "AI"]',
  2,
  'The Data layer is where information persists - in databases, spreadsheets, or other storage systems.'
FROM quizzes WHERE title = 'The 4-Layer System Model';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  2,
  'A Tally form that users fill in is an example of which layer?',
  '["Interface layer", "Data layer", "AI layer", "Automation layer"]',
  0,
  'Forms, dashboards, and any place where humans interact with your system are part of the Interface layer.'
FROM quizzes WHERE title = 'The 4-Layer System Model';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  3,
  'A Zapier workflow that sends a Slack message when a Notion page is created is part of which layer?',
  '["Interface", "Automation", "Data", "AI"]',
  1,
  'Automation handles the logic and triggers that connect different parts of your system together.'
FROM quizzes WHERE title = 'The 4-Layer System Model';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  4,
  'GPT or Claude summarizing a long email thread belongs to:',
  '["Interface layer", "Data layer", "AI layer", "Automation layer"]',
  2,
  'The AI layer handles reasoning, classification, generation, and transformation of information using language models.'
FROM quizzes WHERE title = 'The 4-Layer System Model';

-- Quiz 1.3: Inputs → Transformations → Outputs
INSERT INTO quizzes (title, description, difficulty, passing_score, xp_reward) VALUES
('Inputs, Transformations, Outputs', 'Test your understanding of workflow design fundamentals', 'beginner', 70, 10);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  1,
  'In a workflow where a user submits a form and you send them a confirmation email, the form submission is:',
  '["A transformation", "An output", "An input", "Part of the data layer only"]',
  2,
  'The form submission is what starts the process - it''s the input that triggers everything else.'
FROM quizzes WHERE title = 'Inputs, Transformations, Outputs';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  2,
  'In the same workflow, the confirmation email is:',
  '["An input", "A transformation", "An output", "None of the above"]',
  2,
  'The confirmation email is the final result delivered to the user - it''s an output of the process.'
FROM quizzes WHERE title = 'Inputs, Transformations, Outputs';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  3,
  'Using GPT to rewrite a customer message into a polite reply is:',
  '["An input", "A transformation", "An output", "A data layer action only"]',
  1,
  'Rewriting or processing information is a transformation - it changes the input into something else.'
FROM quizzes WHERE title = 'Inputs, Transformations, Outputs';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  4,
  'Why is it useful to think in terms of inputs, transformations, and outputs?',
  '["It sounds clever", "It makes it easier to design and debug workflows", "It completely replaces the need for tools", "It''s only relevant for large companies"]',
  1,
  'This framework helps you break down complex processes into manageable steps, making them easier to build, test, and fix.'
FROM quizzes WHERE title = 'Inputs, Transformations, Outputs';

-- Quiz 1.4: Manual First, Simple First
INSERT INTO quizzes (title, description, difficulty, passing_score, xp_reward) VALUES
('Manual First, Simple First', 'Test your understanding of smart automation principles', 'beginner', 70, 10);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  1,
  'Why is it important to do a process manually before automating it?',
  '["To waste time", "To understand the real steps, edge cases, and friction", "Because tools don''t work otherwise", "It is not important"]',
  1,
  'Manual execution reveals the true complexity, edge cases, and pain points that you won''t discover from just theorizing.'
FROM quizzes WHERE title = 'Manual First, Simple First';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  2,
  'What is a "simple first" automation approach?',
  '["Build every possible feature at once", "Start with the smallest useful version and improve it over time", "Never automate anything", "Only use AI, no other tools"]',
  1,
  'Simple first means shipping the minimum version that solves the problem, then iterating based on real usage.'
FROM quizzes WHERE title = 'Manual First, Simple First';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  3,
  'Which of these is a good first automation target?',
  '["The most complex and rare edge case", "A high-impact, repetitive step", "A task that only happens once a year", "Something nobody actually cares about"]',
  1,
  'Automate things that happen frequently and cause real pain. High frequency + high impact = good first target.'
FROM quizzes WHERE title = 'Manual First, Simple First';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  4,
  'What''s the main risk of automating too early?',
  '["You become too productive", "You might scale a broken or confusing process", "You will never understand tools", "There is no risk"]',
  1,
  'Automation multiplies whatever process you feed it. If the process is bad, automation makes it worse faster.'
FROM quizzes WHERE title = 'Manual First, Simple First';

-- Quiz 1.5: Documentation & Communication
INSERT INTO quizzes (title, description, difficulty, passing_score, xp_reward) VALUES
('Documentation & Communication', 'Test your understanding of clear documentation and communication', 'beginner', 70, 10);

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  1,
  'Why is documentation critical for AI operators?',
  '["To show off how smart you are", "So future you and others can understand, maintain, and improve systems", "Because clients demand lots of pages", "It''s not actually that important"]',
  1,
  'Good documentation makes systems maintainable and transferable. Without it, you become the bottleneck.'
FROM quizzes WHERE title = 'Documentation & Communication';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  2,
  'What should good documentation include for an automation?',
  '["Only the code/workflow screenshots", "Purpose, how it works, what to do if it breaks, and how to modify it", "A philosophical essay about automation", "Just the tool names"]',
  1,
  'Documentation should enable someone else to understand, troubleshoot, and modify your work without needing to ask you.'
FROM quizzes WHERE title = 'Documentation & Communication';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  3,
  'When explaining a technical system to a non-technical stakeholder, you should:',
  '["Use as much jargon as possible to sound smart", "Focus on what it does and why it matters, not how it works", "Avoid explaining anything and just say trust me", "Only communicate through memes"]',
  1,
  'Non-technical stakeholders care about outcomes and value, not technical implementation details.'
FROM quizzes WHERE title = 'Documentation & Communication';

INSERT INTO quiz_questions (quiz_id, order_index, question_text, options, correct_option_index, explanation)
SELECT
  id,
  4,
  'How often should you update documentation?',
  '["Never, write it once and forget it", "Only when something breaks", "Continuously as you build and modify systems", "Only if someone asks for it"]',
  2,
  'Documentation should evolve with your systems. Update it as you build and modify things, not after the fact.'
FROM quizzes WHERE title = 'Documentation & Communication';

-- ============================================
-- CORE FOUNDATION: Modules 3-8 (Placeholders)
-- Module 2 (LLM Mastery) is in seed-module-2.sql
-- ============================================

-- Module 3: Data Fundamentals
INSERT INTO modules (track_id, slug, title, short_description, order_index, estimated_hours, level, xp_reward, is_active)
SELECT
  id,
  'data-fundamentals',
  'Data Fundamentals',
  'Understand data types, structures, and storage. Learn to work with spreadsheets, databases, and APIs.',
  3,
  4,
  'Beginner',
  50,
  true
FROM tracks WHERE slug = 'core-foundation';

-- Module 4: Prompt Engineering Foundations
INSERT INTO modules (track_id, slug, title, short_description, order_index, estimated_hours, level, xp_reward, is_active)
SELECT
  id,
  'prompt-engineering',
  'Prompt Engineering Foundations',
  'Master the art of writing effective prompts. Learn techniques for reliable, consistent AI outputs.',
  4,
  4,
  'Beginner',
  50,
  true
FROM tracks WHERE slug = 'core-foundation';

-- Module 5: Workflow Design Principles
INSERT INTO modules (track_id, slug, title, short_description, order_index, estimated_hours, level, xp_reward, is_active)
SELECT
  id,
  'workflow-design',
  'Workflow Design Principles',
  'Learn to design efficient, maintainable workflows. Understand triggers, conditions, loops, and error handling.',
  5,
  3,
  'Intermediate',
  75,
  true
FROM tracks WHERE slug = 'core-foundation';

-- Module 6: Building Your First Automation
INSERT INTO modules (track_id, slug, title, short_description, order_index, estimated_hours, level, xp_reward, is_active)
SELECT
  id,
  'first-automation',
  'Building Your First Automation',
  'Put theory into practice by building a complete automation from scratch. Step-by-step guided project.',
  6,
  3,
  'Intermediate',
  75,
  true
FROM tracks WHERE slug = 'core-foundation';

-- Module 7: Testing & Debugging
INSERT INTO modules (track_id, slug, title, short_description, order_index, estimated_hours, level, xp_reward, is_active)
SELECT
  id,
  'testing-debugging',
  'Testing & Debugging',
  'Learn systematic approaches to testing automations and debugging when things go wrong.',
  7,
  2,
  'Intermediate',
  75,
  true
FROM tracks WHERE slug = 'core-foundation';

-- Module 8: Deployment & Maintenance
INSERT INTO modules (track_id, slug, title, short_description, order_index, estimated_hours, level, xp_reward, is_active)
SELECT
  id,
  'deployment-maintenance',
  'Deployment & Maintenance',
  'Take your automations to production. Learn monitoring, maintenance, and iteration strategies.',
  8,
  2,
  'Intermediate',
  75,
  true
FROM tracks WHERE slug = 'core-foundation';
