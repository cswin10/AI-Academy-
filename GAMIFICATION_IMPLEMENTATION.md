# Gamification Implementation Guide

## Overview

This document describes the complete gamification system implementation for AI Academy.

## What's Already Done ✅

### Database Schema (Supabase Migrations)

1. **`20240101000000_initial_schema.sql`** - Core tables:
   - `profiles` - User profiles with XP, level, streaks
   - `module_progress` - Track module completion
   - `checklist_progress` - Track checklist items
   - `badges` - Badge definitions
   - `user_badges` - User-earned badges
   - `achievements` - Achievement definitions
   - `user_achievements` - User achievement progress
   - `xp_transactions` - XP audit trail
   - `certificates` - Module certificates
   - Functions: `award_xp()`, `handle_new_user()`
   - View: `leaderboard`

2. **`20240101000001_seed_gamification.sql`** - Seed data:
   - 30+ pre-configured badges (streaks, completions, XP, levels)
   - 30+ achievements with progress tracking
   - Categories: modules, streaks, XP, time-based, projects, special

3. **`20240101000002_quizzes_and_activity.sql`** - NEW:
   - `quizzes` - Quiz definitions
   - `quiz_questions` - Questions with types (multiple choice, true/false)
   - `quiz_answers` - Answer options
   - `quiz_attempts` - User quiz attempts with scores
   - `user_activity_log` - Daily activity tracking for streaks
   - `email_signups` - Lead magnet and newsletter tracking
   - `cohorts` - Paid cohort management
   - `user_cohorts` - User cohort enrollments
   - Functions: `update_user_streak()`, `award_badge_by_slug()`, `complete_quiz()`, `complete_module()`, `complete_checklist_item()`
   - View: `user_stats`

4. **`20240101000003_seed_quizzes.sql`** - NEW:
   - Sample quizzes for Module 1 (Foundations)
   - Sample quizzes for Module 6 (Tool Primer)
   - Sample quizzes for Module 11 (RAG Systems)
   - Sample quizzes for Module 12 (AI Agents)

## What Needs to Be Implemented

### 1. React Hooks (`/hooks`)

- ✅ `useSupabase.ts` - Auth state management
- ✅ `useUserProfile.ts` - User profile with real-time updates
- 🔲 `useModuleProgress.ts` - Track module completion
- 🔲 `useChecklistProgress.ts` - Track checklist items
- 🔲 `useBadges.ts` - User badges and awarding
- 🔲 `useAchievements.ts` - Achievement tracking
- 🔲 `useXPSystem.ts` - XP and leveling
- 🔲 `useStreak.ts` - Daily streak tracking
- 🔲 `useQuiz.ts` - Quiz taking and results
- 🔲 `useLeaderboard.ts` - Leaderboard data

### 2. Context Providers (`/contexts`)

- 🔲 `ProgressProvider.tsx` - Global progress state
- 🔲 `GamificationProvider.tsx` - Badges, XP, streaks
- 🔲 `NotificationProvider.tsx` - Achievement/badge notifications

### 3. UI Components (`/components`)

#### Gamification Components (`/components/gamification`)

- 🔲 `XPDisplay.tsx` - Show XP and level
- 🔲 `ProgressBar.tsx` - Visual progress bar
- 🔲 `StreakDisplay.tsx` - Fire icon with streak count
- 🔲 `BadgeCard.tsx` - Individual badge display
- 🔲 `BadgeGrid.tsx` - Grid of badges
- 🔲 `LevelIndicator.tsx` - Level badge with tooltip
- 🔲 `XPGainPopup.tsx` - "+10 XP" floating animation
- 🔲 `AchievementNotification.tsx` - Toast notification for unlocks
- 🔲 `Leaderboard.tsx` - Top users list

#### Quiz Components (`/components/quiz`)

- 🔲 `QuizIntro.tsx` - Quiz start screen
- 🔲 `QuizQuestion.tsx` - Individual question
- 🔲 `QuizResults.tsx` - Results with score and explanations
- 🔲 `QuizProgress.tsx` - Question X of Y progress

#### Dashboard Components (`/components/dashboard`)

- 🔲 `UserDashboard.tsx` - Main dashboard
- 🔲 `StatsCard.tsx` - Individual stat (modules, XP, streak)
- 🔲 `RecentActivity.tsx` - Recent completions
- 🔲 `BadgeShowcase.tsx` - Featured badges
- 🔲 `ProgressOverview.tsx` - Module completion grid

### 4. Page Updates

- 🔲 `/app/dashboard/page.tsx` - User dashboard
- 🔲 `/app/modules/[moduleId]/page.tsx` - Integrate progress tracking
- 🔲 `/app/modules/[moduleId]/quiz/page.tsx` - Quiz page
- 🔲 `/app/leaderboard/page.tsx` - Leaderboard page
- 🔲 `/app/badges/page.tsx` - All badges showcase

### 5. Integration Points

- 🔲 Module pages: Track start/completion
- 🔲 Checklist items: Award XP on completion
- 🔲 Daily login: Update streak, award XP
- 🔲 Quiz completion: Award XP and badges
- 🔲 Homepage: Add CTA for dashboard/login
- 🔲 Header: Show XP, level, streak when logged in

## Architecture

### Data Flow

```
User Action (e.g., complete checklist)
  ↓
React Hook (e.g., useChecklistProgress)
  ↓
Supabase Function (e.g., complete_checklist_item)
  ↓
Database Updates:
  - checklist_progress (insert)
  - profiles (update XP)
  - xp_transactions (insert)
  - user_badges (maybe insert if milestone)
  ↓
Real-time Subscriptions Update UI
  ↓
Notification/Animation Shows Reward
```

### Key Functions (Already in DB)

1. **`award_xp(user_id, amount, reason, module_id)`**
   - Adds XP to user
   - Logs in xp_transactions
   - Auto-calculates and updates level

2. **`update_user_streak(user_id)`**
   - Call this on daily login
   - Updates streak count
   - Awards streak badges automatically

3. **`complete_module(user_id, module_id)`**
   - Marks module as complete
   - Awards XP
   - Checks and awards module milestone badges

4. **`complete_checklist_item(user_id, module_id, item_id)`**
   - Marks item as complete
   - Awards small XP
   - Logs activity

5. **`complete_quiz(attempt_id, score, answers_data)`**
   - Finalizes quiz attempt
   - Awards XP if passed
   - Logs activity

## Environment Variables Needed

```env
# .env.local
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbG...
```

## Getting Started

### 1. Apply Migrations

```bash
# If using Supabase CLI
supabase db push

# Or manually in Supabase Dashboard > SQL Editor
# Run migrations in order:
# 1. 20240101000000_initial_schema.sql
# 2. 20240101000001_seed_gamification.sql
# 3. 20240101000002_quizzes_and_activity.sql
# 4. 20240101000003_seed_quizzes.sql
```

### 2. Set Up Environment

1. Go to Supabase Dashboard > Project Settings > API
2. Copy `URL` and `anon/public key`
3. Add to `.env.local`

### 3. Enable Auth (Optional)

If you want user authentication:

1. Supabase Dashboard > Authentication > Providers
2. Enable Email/Password or OAuth providers
3. Add redirect URLs for your domain

### 4. Test Database

```javascript
// Test in Supabase Dashboard > SQL Editor
SELECT * FROM badges LIMIT 5;
SELECT * FROM achievements LIMIT 5;
SELECT * FROM quizzes LIMIT 5;
```

## Next Steps

1. ✅ Create remaining React hooks
2. ✅ Build UI components
3. ✅ Create context providers
4. ✅ Integrate into module pages
5. ✅ Add dashboard page
6. ✅ Test user flows
7. ✅ Add notifications/animations

## XP and Level System

### XP Sources

- Daily login: +5 XP
- Checklist item: +10 XP
- Quiz passed: +100 XP
- Module complete: +500 XP
- Badges: +50 to +1000 XP (varies by rarity)

### Level Formula

Already implemented in `award_xp()` function:
- Levels 1-10: 100 XP per level
- Levels 11-26: 250 XP per level
- Levels 27-46: 500 XP per level
- Levels 47-50: 1000 XP per level

### Badge Rarities

- **Common** (🌟): Easy to earn, low XP
- **Rare** (⭐): Moderate effort, medium XP
- **Epic** (💫): Significant achievement, high XP
- **Legendary** (👑): Ultimate achievements, massive XP

## Quiz System

### Quiz Types

1. **Multiple Choice**: Single correct answer
2. **True/False**: Boolean questions
3. **Multi-Select**: Multiple correct answers (future)

### Quiz Flow

1. User clicks "Take Quiz" on module page
2. `QuizIntro` shows quiz info (time limit, passing score)
3. `QuizQuestion` displays one question at a time
4. User submits answers
5. `complete_quiz()` function calculates score
6. `QuizResults` shows score, pass/fail, explanations
7. If passed: Award XP and unlock next module

### Passing Requirements

- Default: 70% score
- Quiz-specific passing scores in `quizzes` table
- Can retake unlimited times
- Best score is tracked

## Leaderboard

### Metrics

- Overall XP (primary)
- Level (secondary)
- Modules completed
- Current streak
- Longest streak

### Privacy

- Public by default (all users can see)
- Top 100 only
- No sensitive data exposed

## Email Opt-in & Lead Magnets

### Lead Magnets

- "AI Operator Starter Kit PDF"
- "Complete Roadmap PDF"
- "Tool Comparison Guide"

### Flow

1. User enters email (before or after sign-up)
2. Record in `email_signups` table
3. Tag with lead_magnet type
4. Send email via service (Resend, SendGrid, etc.)
5. Track confirmation in `confirmed_at`

## Paid Cohorts

### Structure

- Free tier: Self-paced, community support
- Paid cohort: Live sessions, feedback, certification

### Implementation

1. Create cohort in `cohorts` table
2. Users enroll via Stripe checkout
3. Record in `user_cohorts` with payment info
4. Grant access to cohort perks
5. Issue certificate on completion

## Monitoring & Analytics

### Key Metrics to Track

- Daily Active Users (DAU)
- Module completion rate
- Average time to complete modules
- Quiz pass rate
- Streak retention (% users maintaining streaks)
- Badge earn rate
- Leaderboard engagement

### Suggested Tools

- PostHog (already mentioned in roadmap)
- Plausible Analytics
- Custom dashboard in Supabase

## Future Enhancements

1. **Social Features**
   - Share progress on Twitter/LinkedIn
   - Team challenges
   - Buddy system

2. **Advanced Gamification**
   - Seasonal events
   - Limited-time badges
   - Community challenges

3. **Personalization**
   - AI-recommended next steps
   - Custom learning paths
   - Adaptive difficulty

4. **Monetization**
   - Premium badges
   - Fast-track courses
   - 1-on-1 coaching

## Troubleshooting

### Common Issues

1. **"Permission denied" errors**
   - Check RLS policies are enabled
   - Verify user is authenticated
   - Check policy filters match user_id

2. **Functions not working**
   - Verify migrations ran successfully
   - Check function exists: `SELECT routine_name FROM information_schema.routines;`
   - Check logs in Supabase Dashboard

3. **Real-time not updating**
   - Verify replication is enabled for tables
   - Check subscription channel matches table
   - Ensure filter syntax is correct

## Resources

- [Supabase Documentation](https://supabase.com/docs)
- [Next.js with Supabase](https://supabase.com/docs/guides/getting-started/quickstarts/nextjs)
- [Row Level Security Guide](https://supabase.com/docs/guides/auth/row-level-security)
- [Real-time Subscriptions](https://supabase.com/docs/guides/realtime)
