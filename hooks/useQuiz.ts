import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';
import { useSupabase } from './useSupabase';

export interface Quiz {
  id: string;
  module_id: string;
  title: string;
  description: string | null;
  passing_score: number;
  xp_reward: number;
  time_limit_minutes: number | null;
  is_active: boolean;
}

export interface QuizQuestion {
  id: string;
  quiz_id: string;
  question_text: string;
  question_type: 'multiple_choice' | 'true_false' | 'multi_select';
  explanation: string | null;
  points: number;
  order_index: number;
}

export interface QuizAnswer {
  id: string;
  question_id: string;
  answer_text: string;
  is_correct: boolean;
  order_index: number;
}

export interface QuizAttempt {
  id: string;
  user_id: string;
  quiz_id: string;
  started_at: string;
  completed_at: string | null;
  score: number | null;
  passed: boolean | null;
  time_taken_seconds: number | null;
  xp_awarded: number;
  answers_data: any;
}

export function useQuiz(moduleId?: string) {
  const { user } = useSupabase();
  const [quiz, setQuiz] = useState<Quiz | null>(null);
  const [questions, setQuestions] = useState<QuizQuestion[]>([]);
  const [answers, setAnswers] = useState<{ [questionId: string]: QuizAnswer[] }>({});
  const [attempts, setAttempts] = useState<QuizAttempt[]>([]);
  const [currentAttempt, setCurrentAttempt] = useState<QuizAttempt | null>(null);
  const [loading, setLoading] = useState(true);
  const supabase = createClient();

  useEffect(() => {
    if (!moduleId) {
      setLoading(false);
      return;
    }

    async function fetchQuiz() {
      try {
        setLoading(true);

        // Fetch quiz
        const { data: quizData } = await supabase
          .from('quizzes')
          .select('*')
          .eq('module_id', moduleId)
          .eq('is_active', true)
          .single();

        if (quizData) {
          setQuiz(quizData);

          // Fetch questions
          const { data: questionsData } = await supabase
            .from('quiz_questions')
            .select('*')
            .eq('quiz_id', quizData.id)
            .order('order_index');

          if (questionsData) {
            setQuestions(questionsData);

            // Fetch answers for all questions
            const { data: answersData } = await supabase
              .from('quiz_answers')
              .select('*')
              .in('question_id', questionsData.map(q => q.id))
              .order('order_index');

            if (answersData) {
              const answersByQuestion: { [key: string]: QuizAnswer[] } = {};
              answersData.forEach(answer => {
                if (!answersByQuestion[answer.question_id]) {
                  answersByQuestion[answer.question_id] = [];
                }
                answersByQuestion[answer.question_id].push(answer);
              });
              setAnswers(answersByQuestion);
            }
          }

          // Fetch user's attempts if logged in
          if (user) {
            const { data: attemptsData } = await supabase
              .from('quiz_attempts')
              .select('*')
              .eq('quiz_id', quizData.id)
              .eq('user_id', user.id)
              .order('started_at', { ascending: false });

            if (attemptsData) {
              setAttempts(attemptsData);
            }
          }
        }
      } catch (err) {
        console.error('Error fetching quiz:', err);
      } finally {
        setLoading(false);
      }
    }

    fetchQuiz();
  }, [moduleId, user, supabase]);

  const startAttempt = async () => {
    if (!user || !quiz) return null;

    try {
      const { data, error } = await supabase
        .from('quiz_attempts')
        .insert({
          user_id: user.id,
          quiz_id: quiz.id,
          started_at: new Date().toISOString(),
        })
        .select()
        .single();

      if (error) throw error;

      setCurrentAttempt(data);
      return data;
    } catch (err) {
      console.error('Error starting quiz attempt:', err);
      return null;
    }
  };

  const submitAttempt = async (attemptId: string, userAnswers: { [questionId: string]: string[] }) => {
    if (!user || !quiz) return null;

    try {
      // Calculate score
      let totalPoints = 0;
      let earnedPoints = 0;

      const answersData = questions.map(question => {
        const questionAnswers = answers[question.id] || [];
        const correctAnswerIds = questionAnswers
          .filter(a => a.is_correct)
          .map(a => a.id);

        const userAnswerIds = userAnswers[question.id] || [];
        const isCorrect = JSON.stringify(correctAnswerIds.sort()) === JSON.stringify(userAnswerIds.sort());

        totalPoints += question.points;
        if (isCorrect) {
          earnedPoints += question.points;
        }

        return {
          question_id: question.id,
          user_answers: userAnswerIds,
          correct_answers: correctAnswerIds,
          is_correct: isCorrect,
          points_earned: isCorrect ? question.points : 0,
        };
      });

      const score = Math.floor((earnedPoints / totalPoints) * 100);

      // Submit via database function
      const { error } = await supabase.rpc('complete_quiz', {
        p_attempt_id: attemptId,
        p_score: score,
        p_answers_data: answersData,
      });

      if (error) throw error;

      // Fetch updated attempt
      const { data: updatedAttempt } = await supabase
        .from('quiz_attempts')
        .select('*')
        .eq('id', attemptId)
        .single();

      if (updatedAttempt) {
        setAttempts(prev => [updatedAttempt, ...prev]);
        setCurrentAttempt(null);
        return updatedAttempt;
      }

      return null;
    } catch (err) {
      console.error('Error submitting quiz:', err);
      return null;
    }
  };

  const getBestScore = () => {
    const completedAttempts = attempts.filter(a => a.completed_at && a.score !== null);
    if (completedAttempts.length === 0) return null;
    return Math.max(...completedAttempts.map(a => a.score!));
  };

  const hasPassed = () => {
    return attempts.some(a => a.passed === true);
  };

  return {
    quiz,
    questions,
    answers,
    attempts,
    currentAttempt,
    loading,
    startAttempt,
    submitAttempt,
    getBestScore,
    hasPassed,
    attemptCount: attempts.length,
  };
}
