-- =============================================
-- SEED BADGES FOR AI ACADEMY
-- Run this AFTER FUNCTIONS_TO_RUN.sql
-- =============================================

-- Clear existing badges (optional - comment out if you want to keep existing)
-- TRUNCATE public.badges CASCADE;

INSERT INTO public.badges (slug, name, description, icon, rarity, xp_reward) VALUES
-- Streak badges
('consistent', '3 Day Streak', 'Logged in for 3 days in a row', '🔥', 'common', 50),
('week-warrior', 'Week Warrior', 'Logged in for 7 days in a row', '💪', 'rare', 100),
('dedicated', 'Dedicated', 'Logged in for 14 days in a row', '⭐', 'epic', 200),
('unstoppable', 'Unstoppable', 'Logged in for 30 days in a row', '🚀', 'epic', 500),
('legendary-streak', 'Legendary Streak', 'Logged in for 100 days in a row', '👑', 'legendary', 1000),

-- Module completion badges
('first-steps', 'First Steps', 'Completed your first module', '👶', 'common', 100),
('getting-started', 'Getting Started', 'Completed 3 modules', '🎯', 'common', 150),
('dedicated-learner', 'Dedicated Learner', 'Completed 5 modules', '📚', 'rare', 250),
('half-way', 'Half Way There', 'Completed 8 modules', '🏃', 'rare', 400),
('almost-there', 'Almost There', 'Completed 13 modules', '🎖️', 'epic', 600),
('completionist', 'Completionist', 'Completed all 17 modules', '🏆', 'legendary', 1500),

-- Learning path badges
('rag-master', 'RAG Master', 'Completed the RAG Systems module', '🧠', 'epic', 300),
('agent-builder', 'Agent Builder', 'Completed the AI Agents module', '🤖', 'epic', 300),
('full-stack-ai', 'Full Stack AI', 'Completed all technical modules', '💻', 'legendary', 800),

-- Special badges
('early-adopter', 'Early Adopter', 'Joined during beta', '🌟', 'rare', 200),
('quiz-master', 'Quiz Master', 'Passed 10 quizzes', '🎓', 'rare', 350),
('perfect-score', 'Perfect Score', 'Got 100% on a quiz', '💯', 'epic', 400)

ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  icon = EXCLUDED.icon,
  rarity = EXCLUDED.rarity,
  xp_reward = EXCLUDED.xp_reward;
