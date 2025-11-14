-- =============================================
-- SEED BADGES
-- =============================================

INSERT INTO public.badges (slug, name, description, icon, rarity, xp_reward) VALUES
-- Beginner Badges
('first-steps', 'First Steps', 'Complete your first module', '🌟', 'common', 50),
('getting-started', 'Getting Started', 'Complete 3 modules', '🎯', 'common', 100),
('dedicated-learner', 'Dedicated Learner', 'Complete 5 modules', '📚', 'common', 150),

-- Streak Badges
('day-one', 'Day One', 'Start your learning journey', '☀️', 'common', 10),
('consistent', 'Consistent', '3-day streak', '🔥', 'common', 25),
('week-warrior', 'Week Warrior', '7-day streak', '💪', 'rare', 75),
('dedicated', 'Dedicated', '14-day streak', '⭐', 'rare', 150),
('unstoppable', 'Unstoppable', '30-day streak', '🚀', 'epic', 300),
('legendary-streak', 'Legendary', '100-day streak', '👑', 'legendary', 1000),

-- Completion Badges
('half-way', 'Half Way There', 'Complete 50% of all modules', '🎊', 'rare', 200),
('almost-there', 'Almost There', 'Complete 75% of all modules', '🎉', 'epic', 400),
('completionist', 'Completionist', 'Complete all 15 modules', '💯', 'legendary', 1000),

-- Speed Badges
('speed-demon', 'Speed Demon', 'Complete a module in one day', '⚡', 'rare', 100),
('marathon-runner', 'Marathon Runner', 'Complete 3 modules in one week', '🏃', 'epic', 250),

-- Engagement Badges
('early-bird', 'Early Bird', 'Login before 8 AM', '🌅', 'common', 20),
('night-owl', 'Night Owl', 'Login after 10 PM', '🦉', 'common', 20),
('weekend-warrior', 'Weekend Warrior', 'Study on both Saturday and Sunday', '🎮', 'common', 50),

-- XP Badges
('rising-star', 'Rising Star', 'Earn 1,000 XP', '⭐', 'common', 100),
('experienced', 'Experienced', 'Earn 5,000 XP', '🌟', 'rare', 250),
('expert', 'Expert', 'Earn 10,000 XP', '💫', 'epic', 500),
('master', 'Master', 'Earn 25,000 XP', '🏆', 'legendary', 1000),

-- Level Badges
('level-10', 'Decade', 'Reach level 10', '🔟', 'common', 100),
('level-20', 'Score', 'Reach level 20', '2️⃣0️⃣', 'rare', 200),
('level-30', 'Triple Threat', 'Reach level 30', '3️⃣0️⃣', 'epic', 400),
('level-40', 'Unstoppable Force', 'Reach level 40', '4️⃣0️⃣', 'epic', 600),
('level-50', 'Maximum Power', 'Reach level 50', '5️⃣0️⃣', 'legendary', 1000),

-- Project Badges
('builder', 'Builder', 'Complete your first project', '🏗️', 'common', 100),
('architect', 'Architect', 'Complete 5 projects', '🏛️', 'rare', 250),
('master-builder', 'Master Builder', 'Complete 10 projects', '🏰', 'epic', 500),

-- Category Badges
('foundation-master', 'Foundation Master', 'Complete all Foundation modules', '🎓', 'rare', 200),
('interface-expert', 'Interface Expert', 'Complete all Interface & Data modules', '💻', 'rare', 200),
('automation-wizard', 'Automation Wizard', 'Complete all Automation & Intelligence modules', '🤖', 'epic', 300),
('business-pro', 'Business Pro', 'Complete all Business & Production modules', '💼', 'epic', 300),

-- Special Badges
('perfectionist', 'Perfectionist', 'Complete a module with 100% checklist on first try', '✨', 'legendary', 500),
('comeback-kid', 'Comeback Kid', 'Return after a 30-day break', '🔄', 'rare', 100),
('early-adopter', 'Early Adopter', 'Join in the first month', '🚀', 'epic', 250);

-- =============================================
-- SEED ACHIEVEMENTS
-- =============================================

INSERT INTO public.achievements (slug, name, description, icon, category, points, max_progress) VALUES
-- Module Completion Achievements
('complete-1-module', 'First Module', 'Complete your first module', '🎯', 'modules', 50, 1),
('complete-5-modules', 'Module Master', 'Complete 5 modules', '📚', 'modules', 150, 5),
('complete-10-modules', 'Module Expert', 'Complete 10 modules', '🎓', 'modules', 300, 10),
('complete-all-modules', 'Ultimate Learner', 'Complete all 15 modules', '👑', 'modules', 1000, 15),

-- Checklist Achievements
('complete-50-items', 'Checkmate', 'Complete 50 checklist items', '✅', 'progress', 100, 50),
('complete-100-items', 'Century', 'Complete 100 checklist items', '💯', 'progress', 250, 100),
('complete-200-items', 'Double Century', 'Complete 200 checklist items', '🎊', 'progress', 500, 200),

-- Streak Achievements
('streak-7', 'Week Strong', '7-day learning streak', '🔥', 'streaks', 75, 7),
('streak-14', 'Two Weeks', '14-day learning streak', '💪', 'streaks', 150, 14),
('streak-30', 'Month Master', '30-day learning streak', '⭐', 'streaks', 300, 30),
('streak-60', 'Two Months', '60-day learning streak', '🌟', 'streaks', 600, 60),
('streak-100', 'Centurion', '100-day learning streak', '👑', 'streaks', 1000, 100),

-- XP Achievements
('earn-1000-xp', 'Rising Star', 'Earn 1,000 total XP', '⭐', 'xp', 100, 1000),
('earn-5000-xp', 'Experienced', 'Earn 5,000 total XP', '🌟', 'xp', 250, 5000),
('earn-10000-xp', 'Expert', 'Earn 10,000 total XP', '💫', 'xp', 500, 10000),
('earn-25000-xp', 'Master', 'Earn 25,000 total XP', '🏆', 'xp', 1000, 25000),
('earn-50000-xp', 'Legend', 'Earn 50,000 total XP', '👑', 'xp', 2000, 50000),

-- Time-based Achievements
('early-bird-10', 'Morning Person', 'Login before 8 AM 10 times', '🌅', 'time', 100, 10),
('night-owl-10', 'Night Owl', 'Login after 10 PM 10 times', '🦉', 'time', 100, 10),
('weekend-learner', 'Weekend Warrior', 'Study on 10 weekends', '📅', 'time', 150, 10),

-- Speed Achievements
('module-in-a-day', 'Speed Run', 'Complete a module in 24 hours', '⚡', 'speed', 100, 1),
('3-modules-week', 'Sprint Master', 'Complete 3 modules in one week', '🏃', 'speed', 250, 3),

-- Project Achievements
('first-project', 'Hands-On', 'Complete your first project', '🛠️', 'projects', 100, 1),
('5-projects', 'Project Pro', 'Complete 5 projects', '🏗️', 'projects', 250, 5),
('10-projects', 'Master Builder', 'Complete 10 projects', '🏰', 'projects', 500, 10),

-- Category Achievements
('foundation-complete', 'Foundation Laid', 'Complete all Foundation modules', '🎓', 'categories', 200, 1),
('interface-complete', 'Interface Master', 'Complete all Interface & Data modules', '💻', 'categories', 200, 1),
('automation-complete', 'Automation Expert', 'Complete all Automation modules', '🤖', 'categories', 300, 1),
('business-complete', 'Business Ready', 'Complete all Business modules', '💼', 'categories', 300, 1),

-- Engagement Achievements
('7-day-active', 'First Week', 'Active for 7 days', '📅', 'engagement', 50, 7),
('30-day-active', 'First Month', 'Active for 30 days', '📆', 'engagement', 200, 30),
('90-day-active', 'Committed', 'Active for 90 days', '🎯', 'engagement', 500, 90),

-- Special Achievements
('perfect-module', 'Perfectionist', 'Complete a module with 100% checklist items on first attempt', '✨', 'special', 500, 1),
('all-badges', 'Badge Collector', 'Earn 25 badges', '🏅', 'special', 1000, 25),
('level-50', 'Maximum Level', 'Reach level 50', '👑', 'special', 2000, 1);
