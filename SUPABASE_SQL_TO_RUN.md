# 📋 Exact SQL to Run in Supabase

## Overview

Your current Supabase database has the core gamification tables (profiles, badges, achievements, etc.). You need to add the **missing tables and functions** for the complete system.

## What You Have ✅

According to your schema, you already have:
- profiles
- badges
- achievements
- user_badges
- user_achievements
- module_progress
- checklist_progress
- xp_transactions
- certificates

## What You Need to Add ⚠️

These tables and functions are **missing** and need to be created:

### Missing Tables:
1. `quizzes` - Quiz definitions
2. `quiz_questions` - Questions for each quiz
3. `quiz_answers` - Answer options
4. `quiz_attempts` - User quiz attempts
5. `user_activity_log` - Daily activity tracking
6. `email_signups` - Lead magnet tracking
7. `cohorts` - Paid cohort management
8. `user_cohorts` - User enrollments

### Missing Functions:
1. `update_user_streak()` - Updates daily streaks
2. `award_badge_by_slug()` - Awards badges by name
3. `complete_quiz()` - Completes quiz and awards XP
4. `complete_module()` - Completes module and awards badge
5. `complete_checklist_item()` - Completes item and awards XP

### Missing Views:
1. `user_stats` - Aggregated user statistics

---

## 🎯 Step 1: Run the Main Migration

**File**: `supabase/MIGRATION_ADDITIONAL_TABLES.sql` (already created)

### Instructions:

1. Open [Supabase Dashboard](https://supabase.com/dashboard)
2. Select your project
3. Go to **SQL Editor**
4. Click **New query**
5. **Copy the entire contents** of `supabase/MIGRATION_ADDITIONAL_TABLES.sql`
6. **Paste** into the SQL Editor
7. Click **RUN** (bottom right)

### What This Does:
- Creates all 8 missing tables
- Creates all 5 missing functions
- Creates the user_stats view
- Sets up Row Level Security policies
- Creates indexes for performance

### Verification:

After running, verify tables were created:

```sql
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public'
AND table_name IN ('quizzes', 'quiz_questions', 'quiz_answers', 'quiz_attempts', 'user_activity_log', 'email_signups', 'cohorts', 'user_cohorts')
ORDER BY table_name;
```

**Expected result**: 8 rows

Verify functions were created:

```sql
SELECT routine_name FROM information_schema.routines
WHERE routine_schema = 'public'
AND routine_name IN ('update_user_streak', 'award_badge_by_slug', 'complete_quiz', 'complete_module', 'complete_checklist_item');
```

**Expected result**: 5 rows

---

## 🎯 Step 2: Seed Sample Quizzes (OPTIONAL)

**File**: `supabase/migrations/20240101000003_seed_quizzes.sql`

This adds 4 sample quizzes for testing:
- Module 1 (Foundations) - 5 questions
- Module 6 (Tool Primer) - 5 questions
- Module 11 (RAG Systems) - 4 questions
- Module 12 (AI Agents) - 4 questions

### Instructions:

1. In Supabase SQL Editor
2. **Copy entire contents** of `20240101000003_seed_quizzes.sql`
3. **Paste** into editor
4. Click **RUN**

### Verification:

```sql
SELECT id, module_id, title FROM quizzes;
-- Should show 4 quizzes

SELECT COUNT(*) FROM quiz_questions;
-- Should show 18 questions

SELECT COUNT(*) FROM quiz_answers;
-- Should show 72 answers
```

---

## 🎯 Step 3: Set Environment Variables

Add to `.env.local`:

```env
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**How to get these:**

1. Supabase Dashboard → Your Project
2. **Project Settings** (gear icon)
3. **API** tab
4. Copy:
   - `URL` → `NEXT_PUBLIC_SUPABASE_URL`
   - `anon` / `public` key → `NEXT_PUBLIC_SUPABASE_ANON_KEY`

---

## 🎯 Step 4: Enable Authentication

1. Supabase Dashboard → **Authentication** → **Providers**
2. **Email** provider is already enabled ✅
3. Optional: Enable **Google**, **GitHub**, **Magic Link**

### Configure Redirect URLs:

1. Go to **Authentication** → **URL Configuration**
2. Set **Site URL**: `http://localhost:3000`
3. Add **Redirect URLs**:
   ```
   http://localhost:3000/**
   https://yourdomain.com/**
   ```

---

## 🎯 Step 5: Test the Database

### Test 1: Create a Test User

In your app, sign up:

```typescript
const { data, error } = await supabase.auth.signUp({
  email: 'test@example.com',
  password: 'testpass123'
});
```

### Test 2: Verify Profile Created

```sql
SELECT * FROM profiles WHERE id = (
  SELECT id FROM auth.users WHERE email = 'test@example.com'
);
```

**Expected**: 1 row with default XP, level, streak

### Test 3: Award XP

```sql
SELECT award_xp(
  (SELECT id FROM auth.users WHERE email = 'test@example.com'),
  100,
  'Test award',
  '01-foundations'
);

-- Check XP was added
SELECT xp, level FROM profiles WHERE id = (
  SELECT id FROM auth.users WHERE email = 'test@example.com'
);
```

**Expected**: XP = 100, transaction logged

### Test 4: Update Streak

```sql
SELECT update_user_streak(
  (SELECT id FROM auth.users WHERE email = 'test@example.com')
);

-- Check streak updated
SELECT streak_count, last_active_date FROM profiles WHERE id = (
  SELECT id FROM auth.users WHERE email = 'test@example.com'
);
```

**Expected**: streak_count = 1, last_active_date = today

### Test 5: Award Badge

```sql
SELECT award_badge_by_slug(
  (SELECT id FROM auth.users WHERE email = 'test@example.com'),
  'first-steps'
);

-- Check badge awarded
SELECT * FROM user_badges WHERE user_id = (
  SELECT id FROM auth.users WHERE email = 'test@example.com'
);
```

**Expected**: 1 row with badge_id for 'first-steps'

---

## 📊 Full Database Schema (After Migration)

After running the migration, you'll have:

### Core Tables (You already have):
- `profiles` - User profiles with XP, level, streaks
- `badges` - Badge definitions (~30 badges)
- `achievements` - Achievement definitions (~30 achievements)
- `user_badges` - Badges earned by users
- `user_achievements` - Achievement progress
- `module_progress` - Module completion tracking
- `checklist_progress` - Checklist item completion
- `xp_transactions` - XP audit trail
- `certificates` - Module certificates

### New Tables (Added by migration):
- `quizzes` - Quiz definitions
- `quiz_questions` - Questions with types
- `quiz_answers` - Answer options
- `quiz_attempts` - User attempts with scores
- `user_activity_log` - Daily activity for streaks
- `email_signups` - Email collection
- `cohorts` - Paid cohort tiers
- `user_cohorts` - User enrollments

### Functions:
- `award_xp()` - Already exists ✅
- `handle_new_user()` - Already exists ✅
- `update_user_streak()` - NEW ⚠️
- `award_badge_by_slug()` - NEW ⚠️
- `complete_quiz()` - NEW ⚠️
- `complete_module()` - NEW ⚠️
- `complete_checklist_item()` - NEW ⚠️

### Views:
- `leaderboard` - Already exists ✅
- `user_stats` - NEW ⚠️

---

## 🔧 Quick Database Fixes (If Needed)

### If `award_xp` Function Is Missing:

```sql
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
  INSERT INTO public.xp_transactions (user_id, amount, reason, module_id)
  VALUES (p_user_id, p_amount, p_reason, p_module_id);

  UPDATE public.profiles
  SET xp = xp + p_amount
  WHERE id = p_user_id
  RETURNING xp INTO v_new_xp;

  v_new_level := CASE
    WHEN v_new_xp < 1000 THEN (v_new_xp / 100) + 1
    WHEN v_new_xp < 5000 THEN ((v_new_xp - 1000) / 250) + 11
    WHEN v_new_xp < 15000 THEN ((v_new_xp - 5000) / 500) + 27
    ELSE ((v_new_xp - 15000) / 1000) + 47
  END;

  v_new_level := LEAST(v_new_level, 50);

  UPDATE public.profiles
  SET level = v_new_level
  WHERE id = p_user_id AND level < v_new_level;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
```

### If `handle_new_user` Trigger Is Missing:

```sql
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, username, display_name, avatar_url)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'username', 'user_' || substr(NEW.id::text, 1, 8)),
    COALESCE(NEW.raw_user_meta_data->>'display_name', NEW.email),
    COALESCE(NEW.raw_user_meta_data->>'avatar_url', '')
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
```

---

## ✅ Final Checklist

- [ ] Ran `MIGRATION_ADDITIONAL_TABLES.sql`
- [ ] Verified 8 new tables exist
- [ ] Verified 5 new functions exist
- [ ] Ran quiz seed SQL (optional)
- [ ] Set environment variables
- [ ] Configured authentication providers
- [ ] Configured redirect URLs
- [ ] Tested: User signup creates profile
- [ ] Tested: XP can be awarded
- [ ] Tested: Streaks update
- [ ] Tested: Badges can be awarded

---

## 🐛 Common Issues

### "relation does not exist"
**Cause**: Table wasn't created
**Fix**: Re-run the migration SQL

### "function does not exist"
**Cause**: Function wasn't created
**Fix**: Re-run the migration SQL

### "permission denied"
**Cause**: RLS policies not set
**Fix**: Check policies exist:
```sql
SELECT tablename, policyname FROM pg_policies WHERE schemaname = 'public';
```

### "unique constraint violation"
**Cause**: Trying to run migration twice
**Fix**: No problem, tables already exist. Verify with:
```sql
SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';
```

---

## 🚀 You're Ready!

After running the SQL:
1. All database tables will be created ✅
2. All functions will work ✅
3. All hooks will connect ✅
4. All components will display data ✅

Start your app and test!
