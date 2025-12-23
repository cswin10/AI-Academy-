'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import { createClient } from '@/lib/supabase/client'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { RadioGroup, RadioGroupItem } from '@/components/ui/radio-group'
import { Label } from '@/components/ui/label'
import { Badge } from '@/components/ui/badge'
import { Progress } from '@/components/ui/progress'
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog'
import {
  CheckCircle,
  XCircle,
  Loader2,
  Trophy,
  ArrowRight,
  RotateCcw,
  BookOpen,
  Sparkles,
} from 'lucide-react'
import type { Quiz, QuizQuestion, Section } from '@/lib/types'
import { cn } from '@/lib/utils/cn'

interface QuizComponentProps {
  quiz: Quiz & { questions: QuizQuestion[] }
  section: Section
  userId: string
  hasPassedBefore: boolean
  nextSectionSlug?: string | null
}

interface QuizResult {
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
}

export function QuizComponent({
  quiz,
  section,
  userId,
  hasPassedBefore,
  nextSectionSlug,
}: QuizComponentProps) {
  const [answers, setAnswers] = useState<Record<string, number>>({})
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [result, setResult] = useState<QuizResult | null>(null)
  const [showResults, setShowResults] = useState(false)
  const [startTime] = useState(Date.now())

  const router = useRouter()
  const supabase = createClient()

  const questions = quiz.questions.sort((a, b) => a.order_index - b.order_index)
  const allAnswered = questions.every((q) => answers[q.id] !== undefined)

  const handleSubmit = async () => {
    if (!allAnswered) return

    setIsSubmitting(true)

    try {
      const timeTaken = Math.floor((Date.now() - startTime) / 1000)

      // Calculate results
      const questionResults = questions.map((q) => ({
        questionId: q.id,
        isCorrect: answers[q.id] === q.correct_option_index,
        selectedAnswer: answers[q.id],
        correctAnswer: q.correct_option_index,
        explanation: q.explanation,
      }))

      const correctAnswers = questionResults.filter((r) => r.isCorrect).length
      const scorePercent = Math.round((correctAnswers / questions.length) * 100)
      const passed = scorePercent >= quiz.passing_score
      const isPerfect = scorePercent === 100
      const xpEarned = passed ? quiz.xp_reward : 0

      // Save quiz attempt
      await supabase.from('quiz_attempts').insert({
        quiz_id: quiz.id,
        user_id: userId,
        section_id: section.id,
        score_percent: scorePercent,
        total_questions: questions.length,
        correct_answers: correctAnswers,
        passed,
        time_taken_seconds: timeTaken,
        answers,
      })

      if (passed && !hasPassedBefore) {
        // Mark section as complete
        const { data: existingProgress } = await supabase
          .from('user_section_progress')
          .select('*')
          .eq('user_id', userId)
          .eq('section_id', section.id)
          .single()

        if (existingProgress) {
          await supabase
            .from('user_section_progress')
            .update({
              is_completed: true,
              completed_at: new Date().toISOString(),
            })
            .eq('id', existingProgress.id)
        } else {
          // Get module and track info from section
          const { data: sectionData } = await supabase
            .from('sections')
            .select('module_id, module:modules(track_id)')
            .eq('id', section.id)
            .single()

          await supabase.from('user_section_progress').insert({
            user_id: userId,
            section_id: section.id,
            module_id: sectionData?.module_id,
            track_id: (sectionData?.module as any)?.track_id,
            is_completed: true,
            completed_at: new Date().toISOString(),
          })
        }

        // Update profile stats
        const { data: profile } = await supabase
          .from('profiles')
          .select('*')
          .eq('id', userId)
          .single()

        if (profile) {
          const today = new Date().toISOString().split('T')[0]
          const lastActive = profile.last_active_date
          let newStreak = profile.current_streak

          if (!lastActive || lastActive !== today) {
            const yesterday = new Date()
            yesterday.setDate(yesterday.getDate() - 1)
            const yesterdayStr = yesterday.toISOString().split('T')[0]

            if (lastActive === yesterdayStr) {
              newStreak = profile.current_streak + 1
            } else if (lastActive !== today) {
              newStreak = 1
            }
          }

          await supabase
            .from('profiles')
            .update({
              xp_total: profile.xp_total + xpEarned,
              total_quizzes_passed: profile.total_quizzes_passed + 1,
              total_sections_completed: profile.total_sections_completed + 1,
              perfect_quiz_count: isPerfect
                ? profile.perfect_quiz_count + 1
                : profile.perfect_quiz_count,
              current_streak: newStreak,
              longest_streak: Math.max(newStreak, profile.longest_streak),
              last_active_date: today,
            })
            .eq('id', userId)

          // Update module progress
          const { data: sectionData } = await supabase
            .from('sections')
            .select('module_id')
            .eq('id', section.id)
            .single()

          if (sectionData?.module_id) {
            const { data: allSections } = await supabase
              .from('sections')
              .select('id')
              .eq('module_id', sectionData.module_id)

            const { data: completedSections } = await supabase
              .from('user_section_progress')
              .select('section_id')
              .eq('user_id', userId)
              .eq('module_id', sectionData.module_id)
              .eq('is_completed', true)

            const sectionsCompleted = completedSections?.length || 0
            const totalSections = allSections?.length || 0
            const moduleCompleted = sectionsCompleted === totalSections

            const { data: moduleProgress } = await supabase
              .from('user_module_progress')
              .select('*')
              .eq('user_id', userId)
              .eq('module_id', sectionData.module_id)
              .single()

            if (moduleProgress) {
              await supabase
                .from('user_module_progress')
                .update({
                  sections_completed: sectionsCompleted,
                  is_completed: moduleCompleted,
                  completed_at: moduleCompleted ? new Date().toISOString() : null,
                })
                .eq('id', moduleProgress.id)
            } else {
              const { data: moduleData } = await supabase
                .from('modules')
                .select('track_id')
                .eq('id', sectionData.module_id)
                .single()

              await supabase.from('user_module_progress').insert({
                user_id: userId,
                module_id: sectionData.module_id,
                track_id: moduleData?.track_id,
                sections_completed: sectionsCompleted,
                total_sections: totalSections,
                is_completed: moduleCompleted,
                completed_at: moduleCompleted ? new Date().toISOString() : null,
              })
            }

            // Award module completion XP
            if (moduleCompleted) {
              const { data: moduleInfo } = await supabase
                .from('modules')
                .select('xp_reward')
                .eq('id', sectionData.module_id)
                .single()

              if (moduleInfo) {
                await supabase
                  .from('profiles')
                  .update({
                    xp_total: profile.xp_total + xpEarned + moduleInfo.xp_reward,
                    total_modules_completed: profile.total_modules_completed + 1,
                  })
                  .eq('id', userId)
              }
            }
          }
        }
      }

      setResult({
        passed,
        scorePercent,
        correctAnswers,
        totalQuestions: questions.length,
        xpEarned,
        isPerfect,
        questionResults,
      })
      setShowResults(true)
    } catch (error) {
      console.error('Error submitting quiz:', error)
    } finally {
      setIsSubmitting(false)
    }
  }

  const resetQuiz = () => {
    setAnswers({})
    setResult(null)
    setShowResults(false)
  }

  return (
    <div className="space-y-6">
      <Card className="border-border bg-card">
        <CardHeader>
          <div className="flex items-center justify-between">
            <div>
              <CardTitle className="text-lg">{quiz.title}</CardTitle>
              {quiz.description && (
                <p className="text-sm text-muted-foreground mt-1">{quiz.description}</p>
              )}
            </div>
            <Badge variant="outline">
              Pass: {quiz.passing_score}%
            </Badge>
          </div>
        </CardHeader>
        <CardContent className="space-y-8">
          {questions.map((question, qIndex) => (
            <div key={question.id} className="space-y-4">
              <div className="flex items-start gap-3">
                <span className="flex-shrink-0 w-8 h-8 rounded-full bg-primary/10 text-primary flex items-center justify-center text-sm font-medium">
                  {qIndex + 1}
                </span>
                <p className="font-medium pt-1">{question.question_text}</p>
              </div>

              <RadioGroup
                value={answers[question.id]?.toString()}
                onValueChange={(value) =>
                  setAnswers({ ...answers, [question.id]: parseInt(value) })
                }
                className="pl-11 space-y-2"
              >
                {(question.options as string[]).map((option, oIndex) => (
                  <div
                    key={oIndex}
                    className={cn(
                      'flex items-center space-x-3 p-3 rounded-lg border transition-colors',
                      answers[question.id] === oIndex
                        ? 'border-primary bg-primary/5'
                        : 'border-border hover:border-border-hover'
                    )}
                  >
                    <RadioGroupItem value={oIndex.toString()} id={`${question.id}-${oIndex}`} />
                    <Label
                      htmlFor={`${question.id}-${oIndex}`}
                      className="flex-1 cursor-pointer"
                    >
                      {option}
                    </Label>
                  </div>
                ))}
              </RadioGroup>
            </div>
          ))}

          <div className="pt-4">
            <Button
              onClick={handleSubmit}
              disabled={!allAnswered || isSubmitting}
              className="w-full"
              size="lg"
            >
              {isSubmitting ? (
                <>
                  <Loader2 className="mr-2 h-4 w-4 animate-spin" />
                  Submitting...
                </>
              ) : (
                'Submit Quiz'
              )}
            </Button>
            {!allAnswered && (
              <p className="text-sm text-muted-foreground text-center mt-2">
                Answer all questions to submit
              </p>
            )}
          </div>
        </CardContent>
      </Card>

      {/* Results Dialog */}
      <Dialog open={showResults} onOpenChange={setShowResults}>
        <DialogContent className="max-w-2xl max-h-[90vh] overflow-y-auto">
          <DialogHeader>
            <DialogTitle className="flex items-center gap-2">
              {result?.passed ? (
                <>
                  <CheckCircle className="h-6 w-6 text-success" />
                  Quiz Passed!
                </>
              ) : (
                <>
                  <XCircle className="h-6 w-6 text-destructive" />
                  Not Quite
                </>
              )}
            </DialogTitle>
            <DialogDescription>
              {result?.passed
                ? 'Great job! You can continue to the next section.'
                : 'Review the material and try again.'}
            </DialogDescription>
          </DialogHeader>

          {result && (
            <div className="space-y-6 py-4">
              {/* Score */}
              <div className="text-center p-6 rounded-lg bg-muted/50">
                <div
                  className={cn(
                    'text-5xl font-bold mb-2',
                    result.passed ? 'text-success' : 'text-destructive'
                  )}
                >
                  {result.scorePercent}%
                </div>
                <div className="text-sm text-muted-foreground">
                  {result.correctAnswers} of {result.totalQuestions} correct
                </div>
                {result.passed && result.xpEarned > 0 && (
                  <div className="flex items-center justify-center gap-2 mt-4 text-primary">
                    <Sparkles className="h-5 w-5" />
                    <span className="font-semibold">+{result.xpEarned} XP earned!</span>
                  </div>
                )}
                {result.isPerfect && (
                  <div className="flex items-center justify-center gap-2 mt-2 text-warning">
                    <Trophy className="h-5 w-5" />
                    <span className="font-semibold">Perfect Score!</span>
                  </div>
                )}
              </div>

              {/* Question Review */}
              <div className="space-y-4">
                <h4 className="font-semibold">Review Answers</h4>
                {result.questionResults.map((qr, index) => {
                  const question = questions.find((q) => q.id === qr.questionId)
                  if (!question) return null

                  return (
                    <div
                      key={qr.questionId}
                      className={cn(
                        'p-4 rounded-lg border',
                        qr.isCorrect ? 'border-success/30 bg-success/5' : 'border-destructive/30 bg-destructive/5'
                      )}
                    >
                      <div className="flex items-start gap-2 mb-2">
                        {qr.isCorrect ? (
                          <CheckCircle className="h-5 w-5 text-success flex-shrink-0 mt-0.5" />
                        ) : (
                          <XCircle className="h-5 w-5 text-destructive flex-shrink-0 mt-0.5" />
                        )}
                        <span className="font-medium">{question.question_text}</span>
                      </div>
                      <div className="pl-7 space-y-1 text-sm">
                        <p>
                          <span className="text-muted-foreground">Your answer: </span>
                          <span className={qr.isCorrect ? 'text-success' : 'text-destructive'}>
                            {(question.options as string[])[qr.selectedAnswer]}
                          </span>
                        </p>
                        {!qr.isCorrect && (
                          <p>
                            <span className="text-muted-foreground">Correct answer: </span>
                            <span className="text-success">
                              {(question.options as string[])[qr.correctAnswer]}
                            </span>
                          </p>
                        )}
                        {qr.explanation && (
                          <p className="text-muted-foreground mt-2 italic">
                            {qr.explanation}
                          </p>
                        )}
                      </div>
                    </div>
                  )
                })}
              </div>
            </div>
          )}

          <DialogFooter className="flex-col sm:flex-row gap-2">
            {result?.passed ? (
              nextSectionSlug ? (
                <Button onClick={() => router.push(`/sections/${nextSectionSlug}`)} className="gap-2">
                  Next Section
                  <ArrowRight className="h-4 w-4" />
                </Button>
              ) : (
                <Button onClick={() => router.back()} className="gap-2">
                  Back to Module
                  <ArrowRight className="h-4 w-4" />
                </Button>
              )
            ) : (
              <>
                <Button variant="outline" onClick={resetQuiz} className="gap-2">
                  <RotateCcw className="h-4 w-4" />
                  Retake Quiz
                </Button>
                <Button variant="outline" onClick={() => setShowResults(false)} className="gap-2">
                  <BookOpen className="h-4 w-4" />
                  Review Lesson
                </Button>
              </>
            )}
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  )
}
