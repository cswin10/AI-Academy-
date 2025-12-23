// Database Types

export interface Profile {
  id: string
  email: string
  display_name: string | null
  avatar_url: string | null
  created_at: string
  updated_at: string
  xp_total: number
  current_streak: number
  longest_streak: number
  last_active_date: string | null
  total_modules_completed: number
  total_sections_completed: number
  total_quizzes_passed: number
  perfect_quiz_count: number
}

export interface Track {
  id: string
  slug: string
  name: string
  description: string | null
  icon: string | null
  color: string | null
  order_index: number
  estimated_hours: number | null
  is_required: boolean
  is_active: boolean
  created_at: string
}

export interface Module {
  id: string
  track_id: string
  slug: string
  title: string
  short_description: string | null
  order_index: number
  estimated_hours: number | null
  level: 'Beginner' | 'Intermediate' | 'Advanced'
  prerequisite_module_ids: string[] | null
  is_active: boolean
  xp_reward: number
  created_at: string
}

export interface Section {
  id: string
  module_id: string
  slug: string
  title: string
  order_index: number
  level: 'Beginner' | 'Intermediate' | 'Advanced'
  content_markdown: string
  exercise_markdown: string | null
  estimated_minutes: number | null
  is_required: boolean
  quiz_id: string | null
  created_at: string
}

export interface ExternalResource {
  id: string
  section_id: string
  title: string
  url: string
  resource_type: 'video' | 'article' | 'documentation' | 'github' | 'tool'
  order_index: number
  created_at: string
}

export interface Quiz {
  id: string
  title: string
  description: string | null
  difficulty: 'beginner' | 'intermediate' | 'advanced' | 'challenge'
  passing_score: number
  xp_reward: number
  time_limit_seconds: number | null
  created_at: string
}

export interface QuizQuestion {
  id: string
  quiz_id: string
  order_index: number
  question_text: string
  options: string[]
  correct_option_index: number
  explanation: string | null
  created_at: string
}

export interface QuizAttempt {
  id: string
  quiz_id: string
  user_id: string
  section_id: string
  score_percent: number
  total_questions: number
  correct_answers: number
  passed: boolean
  completed_at: string
  time_taken_seconds: number | null
  answers: Record<string, number> | null
  is_perfect: boolean
}

export interface UserSectionProgress {
  id: string
  user_id: string
  section_id: string
  module_id: string
  track_id: string
  started_at: string
  completed_at: string | null
  is_completed: boolean
  last_accessed_at: string
  time_spent_seconds: number
}

export interface UserModuleProgress {
  id: string
  user_id: string
  module_id: string
  track_id: string
  started_at: string
  completed_at: string | null
  is_completed: boolean
  sections_completed: number
  total_sections: number | null
  xp_earned: number
}

export interface UserTrackProgress {
  id: string
  user_id: string
  track_id: string
  started_at: string
  completed_at: string | null
  is_completed: boolean
  modules_completed: number
  total_modules: number | null
  xp_earned: number
}

export interface Achievement {
  id: string
  code: string
  category: 'completion' | 'streak' | 'perfection' | 'speed' | 'mastery' | 'social'
  name: string
  description: string
  icon: string | null
  xp_reward: number
  rarity: 'common' | 'rare' | 'epic' | 'legendary'
  required_value: number | null
  is_active: boolean
  created_at: string
}

export interface UserAchievement {
  id: string
  user_id: string
  achievement_id: string
  earned_at: string
  progress: number
}

export interface DailyActivity {
  id: string
  user_id: string
  activity_date: string
  sections_completed: number
  quizzes_passed: number
  xp_earned: number
  time_spent_seconds: number
}

// Extended types with relations
export interface TrackWithProgress extends Track {
  modules?: Module[]
  user_progress?: UserTrackProgress | null
  total_modules?: number
}

export interface ModuleWithProgress extends Module {
  track?: Track
  sections?: Section[]
  user_progress?: UserModuleProgress | null
  total_sections?: number
}

export interface SectionWithRelations extends Section {
  module?: Module
  quiz?: Quiz
  resources?: ExternalResource[]
  user_progress?: UserSectionProgress | null
  quiz_attempts?: QuizAttempt[]
}

export interface QuizWithQuestions extends Quiz {
  questions: QuizQuestion[]
}

export interface AchievementWithUserData extends Achievement {
  user_achievement?: UserAchievement | null
  is_earned: boolean
}

// Gamification types
export interface LevelInfo {
  level: number
  currentXP: number
  xpForCurrentLevel: number
  xpForNextLevel: number
  progress: number
}

export interface StreakInfo {
  currentStreak: number
  longestStreak: number
  lastActiveDate: string | null
  isActiveToday: boolean
}

// Quiz submission types
export interface QuizSubmission {
  quizId: string
  sectionId: string
  answers: Record<string, number>
  timeTaken: number
}

export interface QuizResult {
  passed: boolean
  scorePercent: number
  correctAnswers: number
  totalQuestions: number
  xpEarned: number
  isPerfect: boolean
  questionResults: {
    questionId: string
    isCorrect: boolean
    selectedAnswer: number
    correctAnswer: number
    explanation: string | null
  }[]
  newAchievements: Achievement[]
}
