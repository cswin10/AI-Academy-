# 🚀 Phase 2A+B Setup Guide: Authentication & Gamification

## 🎯 What's Been Built

### Phase 2A - Foundation ✅
- ✅ Complete Supabase database schema (profiles, progress, badges, achievements, XP, leaderboard)
- ✅ Row Level Security (RLS) policies for all tables
- ✅ Authentication system with email/password + OAuth (Google, GitHub)
- ✅ Supabase client configuration (browser + server)
- ✅ Next.js middleware for auth
- ✅ Auth context provider

### Phase 2B - Gamification ✅
- ✅ XP and leveling system (50 levels)
- ✅ 35+ badges with rarity system
- ✅ 30+ achievements with progress tracking
- ✅ Streak tracking with daily rewards
- ✅ Leaderboard view
- ✅ XP transaction audit trail
- ✅ Automated badge/achievement checking

## 📋 Setup Instructions

### Step 1: Create Supabase Project

1. Go to [https://supabase.com](https://supabase.com) and create an account
2. Click **"New Project"**
3. Fill in:
   - **Name:** AI Operator Roadmap
   - **Database Password:** (save this somewhere secure)
   - **Region:** Choose closest to you
4. Click **"Create new project"** (takes ~2 minutes)

### Step 2: Run Database Migrations

1. In your Supabase dashboard, go to **SQL Editor**
2. Copy the contents of `supabase/migrations/20240101000000_initial_schema.sql`
3. Paste into the SQL Editor and click **"Run"**
4. Repeat for `supabase/migrations/20240101000001_seed_gamification.sql`

**Alternatively**, if you have Supabase CLI:
```bash
# Install Supabase CLI
npm install -g supabase

# Link to your project
supabase link --project-ref your-project-ref

# Run migrations
supabase db push
```

### Step 3: Configure OAuth Providers (Optional but Recommended)

#### Google OAuth:
1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create a new project or select existing
3. Enable Google+ API
4. Create OAuth 2.0 credentials
5. Add authorized redirect URI: `https://your-project.supabase.co/auth/v1/callback`
6. In Supabase dashboard → Authentication → Providers → Google:
   - Enable Google provider
   - Add your Client ID and Client Secret

#### GitHub OAuth:
1. Go to GitHub → Settings → Developer settings → OAuth Apps
2. Click **"New OAuth App"**
3. Fill in:
   - Application name: AI Operator Roadmap
   - Homepage URL: Your site URL
   - Authorization callback URL: `https://your-project.supabase.co/auth/v1/callback`
4. In Supabase dashboard → Authentication → Providers → GitHub:
   - Enable GitHub provider
   - Add your Client ID and Client Secret

### Step 4: Get Your Supabase Credentials

1. In Supabase dashboard, go to **Settings** → **API**
2. Copy:
   - **Project URL** (looks like: `https://xxxxx.supabase.co`)
   - **Anon/Public Key** (starts with `eyJ...`)

### Step 5: Configure Environment Variables

1. Copy `.env.local.example` to `.env.local`:
```bash
cp .env.local.example .env.local
```

2. Edit `.env.local`:
```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```

### Step 6: Install Dependencies & Run

```bash
# Install dependencies (if not already done)
npm install

# Run development server
npm run dev
```

Visit [http://localhost:3000](http://localhost:3000)

## 🎮 Testing the Gamification System

### Test User Registration:
1. Click "Sign Up" (when UI is built)
2. Create an account with email/password
3. Check Supabase dashboard → Authentication → Users (you should see your user)
4. Check Table Editor → profiles (your profile should be auto-created)

### Test XP System:
Open browser console and run:
```javascript
// Award yourself some XP
const { awardXP } = await import('./lib/gamification');
await awardXP('your-user-id', 100, 'Test XP');
```

### Test Streak System:
The streak updates automatically on login. Check your profile in Supabase to see `streak_count`.

### Test Leaderboard:
Query the leaderboard view:
```sql
SELECT * FROM leaderboard LIMIT 10;
```

## 📊 Database Structure

### Core Tables:
- **profiles** - User profiles with XP, level, streaks
- **module_progress** - Per-module completion tracking
- **checklist_progress** - Individual checklist item completion
- **badges** - Badge definitions (35+ seeded)
- **user_badges** - Badges earned by users
- **achievements** - Achievement definitions (30+ seeded)
- **user_achievements** - User achievement progress
- **xp_transactions** - Audit trail of all XP awards
- **certificates** - Module completion certificates

### Views:
- **leaderboard** - Top 100 users by XP (refreshes automatically)

### Functions:
- **award_xp()** - Award XP and auto-update level
- **handle_new_user()** - Auto-create profile on signup

## 🎯 XP Rewards Configuration

```typescript
COMPLETE_CHECKLIST_ITEM: 10 XP
COMPLETE_SECTION: 25 XP
COMPLETE_MODULE: 100 XP
COMPLETE_PROJECT: 250 XP
COMPLETE_ALL_MODULES: 1000 XP
DAILY_LOGIN: 5 XP
STREAK_7_DAYS: 50 XP
STREAK_14_DAYS: 100 XP
STREAK_30_DAYS: 200 XP
STREAK_60_DAYS: 400 XP
STREAK_100_DAYS: 750 XP
```

## 🏆 Badge Rarity Levels

- **Common** ⚪ - Easy to earn, basic milestones
- **Rare** 🔵 - Moderate effort, consistent engagement
- **Epic** 🟣 - Significant achievement
- **Legendary** 🟡 - Ultimate accomplishments

## 📈 Level System

- **Levels 1-10:** 100 XP per level
- **Levels 11-20:** 250 XP per level
- **Levels 21-30:** 500 XP per level
- **Levels 31-50:** 1000 XP per level

**Maximum Level:** 50 (50,000 XP)

## 🔧 Troubleshooting

### "Invalid API key" error:
- Check that `.env.local` exists and has correct values
- Restart dev server after changing `.env.local`

### Tables not found:
- Make sure you ran both migration files in Supabase SQL Editor
- Check SQL Editor for any error messages

### User profile not created:
- Check that the `handle_new_user()` trigger exists
- Run this in SQL Editor:
```sql
SELECT * FROM pg_trigger WHERE tgname = 'on_auth_user_created';
```

### RLS policies blocking access:
- Make sure you're authenticated
- Check browser console for detailed error messages
- Verify RLS policies in Supabase dashboard → Authentication → Policies

## 🚀 Next Steps (For You to Complete)

### UI Components Needed:
1. **Login Page** (`app/login/page.tsx`)
2. **Signup Page** (`app/signup/page.tsx`)
3. **Profile Page** (`app/profile/page.tsx`)
4. **Leaderboard Page** (`app/leaderboard/page.tsx`)
5. **Badges Page** (`app/badges/page.tsx`)
6. **XP Bar Component** (show in header)
7. **Badge Display Component**
8. **Level Progress Indicator**
9. **Streak Counter**
10. **Achievement Notifications** (toast on unlock)

### Integration Tasks:
1. Update `ProgressContext` to sync with Supabase instead of localStorage
2. Add authentication guards to protected routes
3. Connect checklist completion to XP awards
4. Trigger badge checks on module completion
5. Show level-up celebrations

## 📚 Useful Queries

### Check a user's stats:
```sql
SELECT
  p.*,
  COUNT(DISTINCT ub.id) as badges_earned,
  COUNT(DISTINCT mp.id) as modules_completed,
  l.rank
FROM profiles p
LEFT JOIN user_badges ub ON p.id = ub.user_id
LEFT JOIN module_progress mp ON p.id = mp.user_id AND mp.completed_at IS NOT NULL
LEFT JOIN leaderboard l ON p.id = l.id
WHERE p.id = 'user-id-here'
GROUP BY p.id, l.rank;
```

### Award a badge manually:
```sql
INSERT INTO user_badges (user_id, badge_id)
VALUES ('user-id', (SELECT id FROM badges WHERE slug = 'first-steps'));
```

### Reset a user's progress (for testing):
```sql
DELETE FROM module_progress WHERE user_id = 'user-id';
DELETE FROM checklist_progress WHERE user_id = 'user-id';
DELETE FROM user_badges WHERE user_id = 'user-id';
DELETE FROM user_achievements WHERE user_id = 'user-id';
DELETE FROM xp_transactions WHERE user_id = 'user-id';
UPDATE profiles SET xp = 0, level = 1, streak_count = 0 WHERE id = 'user-id';
```

## 🎉 You're Ready!

The backend infrastructure is complete. Now you just need to:
1. Create the auth UI (login/signup pages)
2. Build the gamification UI (badges, leaderboard, profile)
3. Integrate progress tracking with Supabase

All the hard backend work is done! 🚀
