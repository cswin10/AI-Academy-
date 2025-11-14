-- =============================================
-- ADDITIONAL TABLES FOR GAMIFICATION
-- Run this in Supabase SQL Editor
-- =============================================

-- =============================================
-- QUIZZES
-- =============================================
CREATE TABLE public.quizzes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  module_id TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  passing_score INTEGER DEFAULT 70 CHECK (passing_score >= 0 AND passing_score <= 100),
  xp_reward INTEGER DEFAULT 100 CHECK (xp_reward >= 0),
  time_limit_minutes INTEGER,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

ALTER TABLE public.quizzes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view active quizzes"
  ON public.quizzes FOR SELECT
  USING (is_active = true);

-- =============================================
-- QUIZ QUESTIONS
-- =============================================
CREATE TABLE public.quiz_questions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  quiz_id UUID NOT NULL REFERENCES public.quizzes(id) ON DELETE CASCADE,
  question_text TEXT NOT NULL,
  question_type TEXT DEFAULT 'multiple_choice' CHECK (question_type IN ('multiple_choice', 'true_false', 'multi_select')),
  explanation TEXT,
  points INTEGER DEFAULT 10 CHECK (points >= 0),
  order_index INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

ALTER TABLE public.quiz_questions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view quiz questions"
  ON public.quiz_questions FOR SELECT
  USING (true);

CREATE INDEX idx_quiz_questions_quiz_id ON public.quiz_questions(quiz_id);

-- =============================================
-- QUIZ ANSWERS
-- =============================================
CREATE TABLE public.quiz_answers (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  question_id UUID NOT NULL REFERENCES public.quiz_questions(id) ON DELETE CASCADE,
  answer_text TEXT NOT NULL,
  is_correct BOOLEAN DEFAULT false,
  order_index INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

ALTER TABLE public.quiz_answers ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view quiz answers"
  ON public.quiz_answers FOR SELECT
  USING (true);

CREATE INDEX idx_quiz_answers_question_id ON public.quiz_answers(question_id);

-- =============================================
-- QUIZ ATTEMPTS
-- =============================================
CREATE TABLE public.quiz_attempts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  quiz_id UUID NOT NULL REFERENCES public.quizzes(id) ON DELETE CASCADE,
  started_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  completed_at TIMESTAMP WITH TIME ZONE,
  score INTEGER CHECK (score >= 0 AND score <= 100),
  passed BOOLEAN,
  time_taken_seconds INTEGER CHECK (time_taken_seconds >= 0),
  xp_awarded INTEGER DEFAULT 0 CHECK (xp_awarded >= 0),
  answers_data JSONB
);

ALTER TABLE public.quiz_attempts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own quiz attempts"
  ON public.quiz_attempts FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own quiz attempts"
  ON public.quiz_attempts FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own quiz attempts"
  ON public.quiz_attempts FOR UPDATE
  USING (auth.uid() = user_id);

CREATE INDEX idx_quiz_attempts_user_id ON public.quiz_attempts(user_id);
CREATE INDEX idx_quiz_attempts_quiz_id ON public.quiz_attempts(quiz_id);

-- =============================================
-- USER ACTIVITY LOG
-- =============================================
CREATE TABLE public.user_activity_log (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  activity_date DATE NOT NULL DEFAULT CURRENT_DATE,
  activity_type TEXT NOT NULL,
  metadata JSONB,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, activity_date, activity_type)
);

ALTER TABLE public.user_activity_log ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own activity"
  ON public.user_activity_log FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own activity"
  ON public.user_activity_log FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE INDEX idx_activity_log_user_id ON public.user_activity_log(user_id);
CREATE INDEX idx_activity_log_date ON public.user_activity_log(activity_date DESC);

-- =============================================
-- EMAIL SIGNUPS
-- =============================================
CREATE TABLE public.email_signups (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email TEXT NOT NULL,
  user_id UUID REFERENCES public.profiles(id) ON DELETE SET NULL,
  lead_magnet TEXT,
  source TEXT,
  subscribed_to_newsletter BOOLEAN DEFAULT true,
  confirmed_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(email)
);

ALTER TABLE public.email_signups ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own email signup"
  ON public.email_signups FOR SELECT
  USING (auth.uid() = user_id OR email = auth.email());

CREATE INDEX idx_email_signups_email ON public.email_signups(email);
CREATE INDEX idx_email_signups_user_id ON public.email_signups(user_id);

-- =============================================
-- COHORTS
-- =============================================
CREATE TABLE public.cohorts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  description TEXT,
  start_date DATE NOT NULL,
  end_date DATE,
  price_cents INTEGER DEFAULT 0,
  max_participants INTEGER,
  perks JSONB,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

ALTER TABLE public.cohorts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can view active cohorts"
  ON public.cohorts FOR SELECT
  USING (is_active = true);

-- =============================================
-- USER COHORTS
-- =============================================
CREATE TABLE public.user_cohorts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  cohort_id UUID NOT NULL REFERENCES public.cohorts(id) ON DELETE CASCADE,
  enrolled_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  payment_status TEXT DEFAULT 'pending' CHECK (payment_status IN ('pending', 'paid', 'refunded')),
  payment_amount_cents INTEGER,
  stripe_payment_id TEXT,
  completed_at TIMESTAMP WITH TIME ZONE,
  certificate_issued_at TIMESTAMP WITH TIME ZONE,
  UNIQUE(user_id, cohort_id)
);

ALTER TABLE public.user_cohorts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own cohort enrollments"
  ON public.user_cohorts FOR SELECT
  USING (auth.uid() = user_id);

CREATE INDEX idx_user_cohorts_user_id ON public.user_cohorts(user_id);
CREATE INDEX idx_user_cohorts_cohort_id ON public.user_cohorts(cohort_id);

-- =============================================
-- FUNCTIONS
-- =============================================

-- Function to update streak on daily login
CREATE OR REPLACE FUNCTION public.update_user_streak(p_user_id UUID)
RETURNS void AS $$
DECLARE
  v_last_active DATE;
  v_current_streak INTEGER;
  v_longest_streak INTEGER;
BEGIN
  SELECT last_active_date, streak_count, longest_streak
  INTO v_last_active, v_current_streak, v_longest_streak
  FROM public.profiles
  WHERE id = p_user_id;

  IF v_last_active = CURRENT_DATE THEN
    RETURN;
  ELSIF v_last_active = CURRENT_DATE - INTERVAL '1 day' THEN
    v_current_streak := v_current_streak + 1;
    v_longest_streak := GREATEST(v_longest_streak, v_current_streak);
  ELSE
    v_current_streak := 1;
  END IF;

  UPDATE public.profiles
  SET
    last_active_date = CURRENT_DATE,
    streak_count = v_current_streak,
    longest_streak = v_longest_streak
  WHERE id = p_user_id;

  INSERT INTO public.user_activity_log (user_id, activity_date, activity_type, metadata)
  VALUES (p_user_id, CURRENT_DATE, 'login', jsonb_build_object('streak', v_current_streak))
  ON CONFLICT (user_id, activity_date, activity_type) DO NOTHING;

  PERFORM public.award_xp(p_user_id, 5, 'Daily login');

  IF v_current_streak = 3 THEN
    PERFORM public.award_badge_by_slug(p_user_id, 'consistent');
  ELSIF v_current_streak = 7 THEN
    PERFORM public.award_badge_by_slug(p_user_id, 'week-warrior');
  ELSIF v_current_streak = 14 THEN
    PERFORM public.award_badge_by_slug(p_user_id, 'dedicated');
  ELSIF v_current_streak = 30 THEN
    PERFORM public.award_badge_by_slug(p_user_id, 'unstoppable');
  ELSIF v_current_streak = 100 THEN
    PERFORM public.award_badge_by_slug(p_user_id, 'legendary-streak');
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to award badge by slug
CREATE OR REPLACE FUNCTION public.award_badge_by_slug(p_user_id UUID, p_badge_slug TEXT)
RETURNS void AS $$
DECLARE
  v_badge_id UUID;
  v_xp_reward INTEGER;
BEGIN
  SELECT id, xp_reward INTO v_badge_id, v_xp_reward
  FROM public.badges
  WHERE slug = p_badge_slug;

  IF v_badge_id IS NULL THEN
    RAISE EXCEPTION 'Badge not found: %', p_badge_slug;
  END IF;

  INSERT INTO public.user_badges (user_id, badge_id)
  VALUES (p_user_id, v_badge_id)
  ON CONFLICT (user_id, badge_id) DO NOTHING;

  IF FOUND THEN
    PERFORM public.award_xp(p_user_id, v_xp_reward, 'Badge earned: ' || p_badge_slug);
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to complete quiz
CREATE OR REPLACE FUNCTION public.complete_quiz(
  p_attempt_id UUID,
  p_score INTEGER,
  p_answers_data JSONB
)
RETURNS void AS $$
DECLARE
  v_user_id UUID;
  v_quiz_id UUID;
  v_passing_score INTEGER;
  v_xp_reward INTEGER;
  v_passed BOOLEAN;
  v_started_at TIMESTAMP WITH TIME ZONE;
BEGIN
  SELECT user_id, quiz_id, started_at
  INTO v_user_id, v_quiz_id, v_started_at
  FROM public.quiz_attempts
  WHERE id = p_attempt_id;

  SELECT passing_score, xp_reward
  INTO v_passing_score, v_xp_reward
  FROM public.quizzes
  WHERE id = v_quiz_id;

  v_passed := p_score >= v_passing_score;

  UPDATE public.quiz_attempts
  SET
    completed_at = NOW(),
    score = p_score,
    passed = v_passed,
    time_taken_seconds = EXTRACT(EPOCH FROM (NOW() - v_started_at))::INTEGER,
    xp_awarded = CASE WHEN v_passed THEN v_xp_reward ELSE 0 END,
    answers_data = p_answers_data
  WHERE id = p_attempt_id;

  IF v_passed THEN
    PERFORM public.award_xp(v_user_id, v_xp_reward, 'Quiz passed', (SELECT module_id FROM public.quizzes WHERE id = v_quiz_id));

    INSERT INTO public.user_activity_log (user_id, activity_date, activity_type, metadata)
    VALUES (v_user_id, CURRENT_DATE, 'quiz_pass', jsonb_build_object('quiz_id', v_quiz_id, 'score', p_score))
    ON CONFLICT DO NOTHING;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to complete module
CREATE OR REPLACE FUNCTION public.complete_module(p_user_id UUID, p_module_id TEXT)
RETURNS void AS $$
DECLARE
  v_module_count INTEGER;
  v_xp_reward INTEGER := 500;
BEGIN
  UPDATE public.module_progress
  SET
    completed_at = NOW(),
    completion_percentage = 100
  WHERE user_id = p_user_id AND module_id = p_module_id AND completed_at IS NULL;

  PERFORM public.award_xp(p_user_id, v_xp_reward, 'Module completed', p_module_id);

  INSERT INTO public.user_activity_log (user_id, activity_date, activity_type, metadata)
  VALUES (p_user_id, CURRENT_DATE, 'module_complete', jsonb_build_object('module_id', p_module_id))
  ON CONFLICT DO NOTHING;

  SELECT COUNT(*) INTO v_module_count
  FROM public.module_progress
  WHERE user_id = p_user_id AND completed_at IS NOT NULL;

  IF v_module_count = 1 THEN
    PERFORM public.award_badge_by_slug(p_user_id, 'first-steps');
  ELSIF v_module_count = 3 THEN
    PERFORM public.award_badge_by_slug(p_user_id, 'getting-started');
  ELSIF v_module_count = 5 THEN
    PERFORM public.award_badge_by_slug(p_user_id, 'dedicated-learner');
  ELSIF v_module_count >= 8 THEN
    PERFORM public.award_badge_by_slug(p_user_id, 'half-way');
  ELSIF v_module_count >= 13 THEN
    PERFORM public.award_badge_by_slug(p_user_id, 'almost-there');
  ELSIF v_module_count = 17 THEN
    PERFORM public.award_badge_by_slug(p_user_id, 'completionist');
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to complete checklist item
CREATE OR REPLACE FUNCTION public.complete_checklist_item(
  p_user_id UUID,
  p_module_id TEXT,
  p_checklist_item_id TEXT
)
RETURNS void AS $$
DECLARE
  v_xp_reward INTEGER := 10;
BEGIN
  INSERT INTO public.checklist_progress (user_id, module_id, checklist_item_id, xp_awarded)
  VALUES (p_user_id, p_module_id, p_checklist_item_id, v_xp_reward)
  ON CONFLICT (user_id, module_id, checklist_item_id) DO NOTHING;

  IF FOUND THEN
    PERFORM public.award_xp(p_user_id, v_xp_reward, 'Checklist item completed', p_module_id);

    INSERT INTO public.user_activity_log (user_id, activity_date, activity_type, metadata)
    VALUES (p_user_id, CURRENT_DATE, 'checklist_item', jsonb_build_object('module_id', p_module_id, 'item_id', p_checklist_item_id))
    ON CONFLICT DO NOTHING;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================
-- VIEWS
-- =============================================

CREATE OR REPLACE VIEW public.user_stats AS
SELECT
  p.id,
  p.username,
  p.display_name,
  p.level,
  p.xp,
  p.streak_count,
  p.longest_streak,
  COUNT(DISTINCT mp.id) FILTER (WHERE mp.completed_at IS NOT NULL) as modules_completed,
  COUNT(DISTINCT cp.id) as checklist_items_completed,
  COUNT(DISTINCT ub.id) as badges_earned,
  COUNT(DISTINCT qa.id) FILTER (WHERE qa.passed = true) as quizzes_passed
FROM public.profiles p
LEFT JOIN public.module_progress mp ON p.id = mp.user_id
LEFT JOIN public.checklist_progress cp ON p.id = cp.user_id
LEFT JOIN public.user_badges ub ON p.id = ub.user_id
LEFT JOIN public.quiz_attempts qa ON p.id = qa.user_id
GROUP BY p.id, p.username, p.display_name, p.level, p.xp, p.streak_count, p.longest_streak;

GRANT SELECT ON public.user_stats TO authenticated;
GRANT SELECT ON public.user_stats TO anon;

-- Trigger for updated_at on quizzes
CREATE TRIGGER handle_quizzes_updated_at
  BEFORE UPDATE ON public.quizzes
  FOR EACH ROW EXECUTE FUNCTION public.handle_updated_at();
