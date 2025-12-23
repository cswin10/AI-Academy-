-- AI Operator Academy Database Schema
-- Run this in your Supabase SQL Editor

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- PROFILES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  display_name TEXT,
  avatar_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),

  -- Gamification
  xp_total INTEGER DEFAULT 0,
  current_streak INTEGER DEFAULT 0,
  longest_streak INTEGER DEFAULT 0,
  last_active_date DATE,

  -- Stats
  total_modules_completed INTEGER DEFAULT 0,
  total_sections_completed INTEGER DEFAULT 0,
  total_quizzes_passed INTEGER DEFAULT 0,
  perfect_quiz_count INTEGER DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_profiles_xp ON profiles(xp_total DESC);
CREATE INDEX IF NOT EXISTS idx_profiles_streak ON profiles(current_streak DESC);

-- ============================================
-- TRACKS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS tracks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  icon TEXT,
  color TEXT,
  order_index INTEGER NOT NULL,
  estimated_hours INTEGER,
  is_required BOOLEAN DEFAULT false,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_tracks_order ON tracks(order_index);

-- ============================================
-- QUIZZES TABLE (Must be created before sections due to FK)
-- ============================================
CREATE TABLE IF NOT EXISTS quizzes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title TEXT NOT NULL,
  description TEXT,
  difficulty TEXT CHECK (difficulty IN ('beginner', 'intermediate', 'advanced', 'challenge')) DEFAULT 'beginner',
  passing_score INTEGER DEFAULT 70,
  xp_reward INTEGER DEFAULT 10,
  time_limit_seconds INTEGER,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================
-- MODULES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS modules (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  track_id UUID REFERENCES tracks(id) ON DELETE CASCADE,
  slug TEXT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  short_description TEXT,
  order_index INTEGER NOT NULL,
  estimated_hours INTEGER,
  level TEXT CHECK (level IN ('Beginner', 'Intermediate', 'Advanced')),
  prerequisite_module_ids UUID[],
  is_active BOOLEAN DEFAULT true,
  xp_reward INTEGER DEFAULT 50,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_modules_track ON modules(track_id, order_index);
CREATE INDEX IF NOT EXISTS idx_modules_slug ON modules(slug);

-- ============================================
-- SECTIONS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS sections (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
  slug TEXT NOT NULL,
  title TEXT NOT NULL,
  order_index INTEGER NOT NULL,
  level TEXT CHECK (level IN ('Beginner', 'Intermediate', 'Advanced')),
  content_markdown TEXT NOT NULL,
  exercise_markdown TEXT,
  estimated_minutes INTEGER,
  is_required BOOLEAN DEFAULT true,
  quiz_id UUID REFERENCES quizzes(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),

  UNIQUE(module_id, slug)
);

CREATE INDEX IF NOT EXISTS idx_sections_module ON sections(module_id, order_index);

-- ============================================
-- EXTERNAL RESOURCES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS external_resources (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  section_id UUID REFERENCES sections(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  url TEXT NOT NULL,
  resource_type TEXT CHECK (resource_type IN ('video', 'article', 'documentation', 'github', 'tool')),
  order_index INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_resources_section ON external_resources(section_id, order_index);

-- ============================================
-- QUIZ QUESTIONS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS quiz_questions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  quiz_id UUID REFERENCES quizzes(id) ON DELETE CASCADE,
  order_index INTEGER NOT NULL,
  question_text TEXT NOT NULL,
  options JSONB NOT NULL,
  correct_option_index INTEGER NOT NULL,
  explanation TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_quiz_questions ON quiz_questions(quiz_id, order_index);

-- ============================================
-- QUIZ ATTEMPTS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS quiz_attempts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  quiz_id UUID REFERENCES quizzes(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  section_id UUID REFERENCES sections(id) ON DELETE CASCADE,
  score_percent NUMERIC(5,2) NOT NULL,
  total_questions INTEGER NOT NULL,
  correct_answers INTEGER NOT NULL,
  passed BOOLEAN NOT NULL,
  completed_at TIMESTAMPTZ DEFAULT NOW(),
  time_taken_seconds INTEGER,
  answers JSONB,
  is_perfect BOOLEAN GENERATED ALWAYS AS (score_percent = 100) STORED
);

CREATE INDEX IF NOT EXISTS idx_quiz_attempts_user ON quiz_attempts(user_id, completed_at DESC);
CREATE INDEX IF NOT EXISTS idx_quiz_attempts_section ON quiz_attempts(section_id, user_id);

-- ============================================
-- USER SECTION PROGRESS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS user_section_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  section_id UUID REFERENCES sections(id) ON DELETE CASCADE,
  module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
  track_id UUID REFERENCES tracks(id) ON DELETE CASCADE,

  started_at TIMESTAMPTZ DEFAULT NOW(),
  completed_at TIMESTAMPTZ,
  is_completed BOOLEAN DEFAULT false,
  last_accessed_at TIMESTAMPTZ DEFAULT NOW(),
  time_spent_seconds INTEGER DEFAULT 0,

  UNIQUE(user_id, section_id)
);

CREATE INDEX IF NOT EXISTS idx_user_section_progress ON user_section_progress(user_id, module_id);
CREATE INDEX IF NOT EXISTS idx_user_section_last_accessed ON user_section_progress(user_id, last_accessed_at DESC);

-- ============================================
-- USER MODULE PROGRESS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS user_module_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  module_id UUID REFERENCES modules(id) ON DELETE CASCADE,
  track_id UUID REFERENCES tracks(id) ON DELETE CASCADE,

  started_at TIMESTAMPTZ DEFAULT NOW(),
  completed_at TIMESTAMPTZ,
  is_completed BOOLEAN DEFAULT false,
  sections_completed INTEGER DEFAULT 0,
  total_sections INTEGER,
  xp_earned INTEGER DEFAULT 0,

  UNIQUE(user_id, module_id)
);

CREATE INDEX IF NOT EXISTS idx_user_module_progress ON user_module_progress(user_id, track_id);

-- ============================================
-- USER TRACK PROGRESS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS user_track_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  track_id UUID REFERENCES tracks(id) ON DELETE CASCADE,

  started_at TIMESTAMPTZ DEFAULT NOW(),
  completed_at TIMESTAMPTZ,
  is_completed BOOLEAN DEFAULT false,
  modules_completed INTEGER DEFAULT 0,
  total_modules INTEGER,
  xp_earned INTEGER DEFAULT 0,

  UNIQUE(user_id, track_id)
);

CREATE INDEX IF NOT EXISTS idx_user_track_progress ON user_track_progress(user_id);

-- ============================================
-- ACHIEVEMENTS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS achievements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  code TEXT UNIQUE NOT NULL,
  category TEXT CHECK (category IN ('completion', 'streak', 'perfection', 'speed', 'mastery', 'social')),
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  icon TEXT,
  xp_reward INTEGER DEFAULT 0,
  rarity TEXT CHECK (rarity IN ('common', 'rare', 'epic', 'legendary')) DEFAULT 'common',
  required_value INTEGER,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_achievements_category ON achievements(category);

-- ============================================
-- USER ACHIEVEMENTS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS user_achievements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  achievement_id UUID REFERENCES achievements(id) ON DELETE CASCADE,
  earned_at TIMESTAMPTZ DEFAULT NOW(),
  progress INTEGER DEFAULT 0,

  UNIQUE(user_id, achievement_id)
);

CREATE INDEX IF NOT EXISTS idx_user_achievements ON user_achievements(user_id, earned_at DESC);

-- ============================================
-- DAILY ACTIVITY TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS daily_activity (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  activity_date DATE NOT NULL,
  sections_completed INTEGER DEFAULT 0,
  quizzes_passed INTEGER DEFAULT 0,
  xp_earned INTEGER DEFAULT 0,
  time_spent_seconds INTEGER DEFAULT 0,

  UNIQUE(user_id, activity_date)
);

CREATE INDEX IF NOT EXISTS idx_daily_activity ON daily_activity(user_id, activity_date DESC);

-- ============================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================

-- Enable RLS on all user-specific tables
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_section_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_module_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_track_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_achievements ENABLE ROW LEVEL SECURITY;
ALTER TABLE daily_activity ENABLE ROW LEVEL SECURITY;

-- Enable RLS on content tables (for read-only access)
ALTER TABLE tracks ENABLE ROW LEVEL SECURITY;
ALTER TABLE modules ENABLE ROW LEVEL SECURITY;
ALTER TABLE sections ENABLE ROW LEVEL SECURITY;
ALTER TABLE external_resources ENABLE ROW LEVEL SECURITY;
ALTER TABLE quizzes ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE achievements ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view own profile" ON profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can insert own profile" ON profiles FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);

-- Quiz attempts policies
CREATE POLICY "Users can insert own attempts" ON quiz_attempts FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can view own attempts" ON quiz_attempts FOR SELECT USING (auth.uid() = user_id);

-- Progress tables policies
CREATE POLICY "Users can view own section progress" ON user_section_progress FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own section progress" ON user_section_progress FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own section progress" ON user_section_progress FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can view own module progress" ON user_module_progress FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own module progress" ON user_module_progress FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own module progress" ON user_module_progress FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "Users can view own track progress" ON user_track_progress FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own track progress" ON user_track_progress FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own track progress" ON user_track_progress FOR UPDATE USING (auth.uid() = user_id);

-- Achievements policies
CREATE POLICY "Users can view own achievements" ON user_achievements FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own achievements" ON user_achievements FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own achievements" ON user_achievements FOR UPDATE USING (auth.uid() = user_id);

-- Daily activity policies
CREATE POLICY "Users can view own activity" ON daily_activity FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own activity" ON daily_activity FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own activity" ON daily_activity FOR UPDATE USING (auth.uid() = user_id);

-- Public read for content tables
CREATE POLICY "Anyone can view active tracks" ON tracks FOR SELECT USING (is_active = true);
CREATE POLICY "Anyone can view active modules" ON modules FOR SELECT USING (is_active = true);
CREATE POLICY "Anyone can view sections" ON sections FOR SELECT USING (true);
CREATE POLICY "Anyone can view resources" ON external_resources FOR SELECT USING (true);
CREATE POLICY "Anyone can view quizzes" ON quizzes FOR SELECT USING (true);
CREATE POLICY "Anyone can view questions" ON quiz_questions FOR SELECT USING (true);
CREATE POLICY "Anyone can view active achievements" ON achievements FOR SELECT USING (is_active = true);

-- ============================================
-- FUNCTIONS
-- ============================================

-- Function to handle new user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, display_name)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'display_name', split_part(NEW.email, '@', 1))
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to create profile on signup
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Function to update profile timestamp
CREATE OR REPLACE FUNCTION public.update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update updated_at on profiles
DROP TRIGGER IF EXISTS update_profiles_updated_at ON profiles;
CREATE TRIGGER update_profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
