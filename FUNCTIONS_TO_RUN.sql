-- =============================================
-- FUNCTIONS & TRIGGERS FOR AI ACADEMY
-- Run this in Supabase SQL Editor
-- =============================================

-- =============================================
-- AUTO-CREATE PROFILE TRIGGER
-- =============================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, username, display_name)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'username', SPLIT_PART(NEW.email, '@', 1)),
    COALESCE(NEW.raw_user_meta_data->>'display_name', SPLIT_PART(NEW.email, '@', 1))
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- =============================================
-- AWARD XP FUNCTION
-- =============================================
CREATE OR REPLACE FUNCTION public.award_xp(
  p_user_id UUID,
  p_amount INTEGER,
  p_reason TEXT,
  p_module_id TEXT DEFAULT NULL
)
RETURNS void AS $$
DECLARE
  v_new_xp INTEGER;
  v_new_level INTEGER;
BEGIN
  -- Insert XP transaction
  INSERT INTO public.xp_transactions (user_id, amount, reason, module_id)
  VALUES (p_user_id, p_amount, p_reason, p_module_id);

  -- Update user XP
  UPDATE public.profiles
  SET xp = xp + p_amount
  WHERE id = p_user_id
  RETURNING xp INTO v_new_xp;

  -- Calculate new level
  v_new_level := CASE
    WHEN v_new_xp < 1000 THEN (v_new_xp / 100) + 1
    WHEN v_new_xp < 5000 THEN ((v_new_xp - 1000) / 250) + 11
    WHEN v_new_xp < 15000 THEN ((v_new_xp - 5000) / 500) + 27
    ELSE ((v_new_xp - 15000) / 1000) + 47
  END;

  v_new_level := LEAST(v_new_level, 50);

  -- Update level if changed
  UPDATE public.profiles
  SET level = v_new_level
  WHERE id = p_user_id AND level < v_new_level;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================
-- AWARD BADGE BY SLUG
-- =============================================
CREATE OR REPLACE FUNCTION public.award_badge_by_slug(p_user_id UUID, p_badge_slug TEXT)
RETURNS void AS $$
DECLARE
  v_badge_id UUID;
  v_xp_reward INTEGER;
  v_inserted BOOLEAN := false;
BEGIN
  SELECT id, xp_reward INTO v_badge_id, v_xp_reward
  FROM public.badges
  WHERE slug = p_badge_slug;

  IF v_badge_id IS NULL THEN
    RETURN; -- Silently fail if badge doesn't exist
  END IF;

  INSERT INTO public.user_badges (user_id, badge_id)
  VALUES (p_user_id, v_badge_id)
  ON CONFLICT (user_id, badge_id) DO NOTHING
  RETURNING true INTO v_inserted;

  IF v_inserted THEN
    PERFORM public.award_xp(p_user_id, v_xp_reward, 'Badge earned: ' || p_badge_slug);
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================
-- UPDATE USER STREAK
-- =============================================
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
  ON CONFLICT (user_id, activity_date) DO NOTHING;

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

-- =============================================
-- COMPLETE CHECKLIST ITEM
-- =============================================
CREATE OR REPLACE FUNCTION public.complete_checklist_item(
  p_user_id UUID,
  p_module_id TEXT,
  p_checklist_item_id TEXT
)
RETURNS void AS $$
DECLARE
  v_xp_reward INTEGER := 10;
  v_inserted BOOLEAN := false;
BEGIN
  INSERT INTO public.checklist_progress (user_id, module_id, checklist_item_id, xp_awarded)
  VALUES (p_user_id, p_module_id, p_checklist_item_id, v_xp_reward)
  ON CONFLICT (user_id, module_id, checklist_item_id) DO NOTHING
  RETURNING true INTO v_inserted;

  IF v_inserted THEN
    PERFORM public.award_xp(p_user_id, v_xp_reward, 'Checklist item completed', p_module_id);

    INSERT INTO public.user_activity_log (user_id, activity_date, activity_type, metadata)
    VALUES (p_user_id, CURRENT_DATE, 'checklist_item', jsonb_build_object('module_id', p_module_id, 'item_id', p_checklist_item_id))
    ON CONFLICT (user_id, activity_date) DO NOTHING;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================
-- COMPLETE MODULE
-- =============================================
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

  IF FOUND THEN
    PERFORM public.award_xp(p_user_id, v_xp_reward, 'Module completed', p_module_id);

    INSERT INTO public.user_activity_log (user_id, activity_date, activity_type, metadata)
    VALUES (p_user_id, CURRENT_DATE, 'module_complete', jsonb_build_object('module_id', p_module_id))
    ON CONFLICT (user_id, activity_date) DO NOTHING;

    SELECT COUNT(*) INTO v_module_count
    FROM public.module_progress
    WHERE user_id = p_user_id AND completed_at IS NOT NULL;

    IF v_module_count = 1 THEN
      PERFORM public.award_badge_by_slug(p_user_id, 'first-steps');
    ELSIF v_module_count = 3 THEN
      PERFORM public.award_badge_by_slug(p_user_id, 'getting-started');
    ELSIF v_module_count = 5 THEN
      PERFORM public.award_badge_by_slug(p_user_id, 'dedicated-learner');
    ELSIF v_module_count = 8 THEN
      PERFORM public.award_badge_by_slug(p_user_id, 'half-way');
    ELSIF v_module_count = 13 THEN
      PERFORM public.award_badge_by_slug(p_user_id, 'almost-there');
    ELSIF v_module_count = 17 THEN
      PERFORM public.award_badge_by_slug(p_user_id, 'completionist');
    END IF;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================
-- COMPLETE QUIZ
-- =============================================
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
  v_already_passed BOOLEAN;
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

  -- Check if user already passed this quiz before
  SELECT EXISTS(
    SELECT 1 FROM public.quiz_attempts
    WHERE user_id = v_user_id
      AND quiz_id = v_quiz_id
      AND id != p_attempt_id
      AND passed = true
  ) INTO v_already_passed;

  UPDATE public.quiz_attempts
  SET
    completed_at = NOW(),
    score = p_score,
    passed = v_passed,
    time_taken_seconds = EXTRACT(EPOCH FROM (NOW() - v_started_at))::INTEGER,
    xp_awarded = CASE WHEN v_passed AND NOT v_already_passed THEN v_xp_reward ELSE 0 END,
    answers_data = p_answers_data
  WHERE id = p_attempt_id;

  -- Only award XP if passed and haven't passed before
  IF v_passed AND NOT v_already_passed THEN
    PERFORM public.award_xp(v_user_id, v_xp_reward, 'Quiz passed', (SELECT module_id FROM public.quizzes WHERE id = v_quiz_id));

    INSERT INTO public.user_activity_log (user_id, activity_date, activity_type, metadata)
    VALUES (v_user_id, CURRENT_DATE, 'quiz_pass', jsonb_build_object('quiz_id', v_quiz_id, 'score', p_score))
    ON CONFLICT (user_id, activity_date) DO NOTHING;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================
-- USER STATS VIEW
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

-- =============================================
-- LEADERBOARD VIEW
-- =============================================
CREATE OR REPLACE VIEW public.leaderboard AS
SELECT
  p.id,
  p.username,
  p.display_name,
  p.avatar_url,
  p.level,
  p.xp,
  p.streak_count,
  COUNT(DISTINCT mp.id) FILTER (WHERE mp.completed_at IS NOT NULL) as modules_completed,
  ROW_NUMBER() OVER (ORDER BY p.xp DESC, p.level DESC) as rank
FROM public.profiles p
LEFT JOIN public.module_progress mp ON p.id = mp.user_id
GROUP BY p.id, p.username, p.display_name, p.avatar_url, p.level, p.xp, p.streak_count
ORDER BY p.xp DESC, p.level DESC;

-- Grant permissions
GRANT SELECT ON public.user_stats TO authenticated;
GRANT SELECT ON public.user_stats TO anon;
GRANT SELECT ON public.leaderboard TO authenticated;
GRANT SELECT ON public.leaderboard TO anon;
