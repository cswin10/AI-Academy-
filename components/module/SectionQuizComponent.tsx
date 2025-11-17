'use client';

import React, { useState } from 'react';
import { CheckCircle2, XCircle, HelpCircle, Sparkles } from 'lucide-react';
import { Card } from '../ui/Card';
import { Button } from '../ui/Button';
import type { SectionQuiz } from '@/lib/types';
import { useAuth } from '@/contexts/AuthContext';
import { awardXP, XP_REWARDS } from '@/lib/gamification';
import { createClient } from '@/lib/supabase/client';

interface SectionQuizComponentProps {
  quiz: SectionQuiz;
  moduleId: string;
  onComplete?: () => void;
}

export function SectionQuizComponent({ quiz, moduleId, onComplete }: SectionQuizComponentProps) {
  const { user } = useAuth();
  const [selectedAnswers, setSelectedAnswers] = useState<Record<string, number>>({});
  const [submitted, setSubmitted] = useState(false);
  const [showExplanations, setShowExplanations] = useState(false);
  const [xpAwarded, setXpAwarded] = useState(false);
  const [isAwarding, setIsAwarding] = useState(false);

  const handleAnswerSelect = (questionId: string, answerIndex: number) => {
    if (submitted) return;
    setSelectedAnswers(prev => ({
      ...prev,
      [questionId]: answerIndex,
    }));
  };

  const handleSubmit = async () => {
    setSubmitted(true);
    setShowExplanations(true);

    // Check if all answers are correct
    const allCorrect = quiz.questions.every(q => selectedAnswers[q.id] === q.correctAnswer);

    if (allCorrect) {
      // Award XP if user is logged in and hasn't been awarded yet
      if (user && !xpAwarded) {
        setIsAwarding(true);
        try {
          // Check if this quiz was already completed
          const supabase = createClient();
          const { data: existing } = await supabase
            .from('checklist_progress')
            .select('id')
            .eq('user_id', user.id)
            .eq('module_id', moduleId)
            .eq('checklist_item_id', quiz.id)
            .single();

          if (!existing) {
            // Award XP for completing the quiz
            const result = await awardXP(
              user.id,
              XP_REWARDS.COMPLETE_SECTION,
              `Completed quiz: ${quiz.title}`,
              moduleId
            );

            if (result.success) {
              // Track quiz completion in database
              await supabase.from('checklist_progress').insert({
                user_id: user.id,
                module_id: moduleId,
                checklist_item_id: quiz.id,
                xp_awarded: XP_REWARDS.COMPLETE_SECTION,
              });

              setXpAwarded(true);
            }
          }
        } catch (error) {
          console.error('Error awarding XP:', error);
        } finally {
          setIsAwarding(false);
        }
      }

      if (onComplete) {
        onComplete();
      }
    }
  };

  const handleReset = () => {
    setSelectedAnswers({});
    setSubmitted(false);
    setShowExplanations(false);
  };

  const getScore = () => {
    let correct = 0;
    quiz.questions.forEach(q => {
      if (selectedAnswers[q.id] === q.correctAnswer) {
        correct++;
      }
    });
    return { correct, total: quiz.questions.length };
  };

  const score = submitted ? getScore() : { correct: 0, total: quiz.questions.length };
  const allQuestionsAnswered = quiz.questions.every(q => selectedAnswers[q.id] !== undefined);

  return (
    <Card className="p-6 mb-6 bg-purple-primary/5 border-2 border-purple-primary/20">
      <div className="flex items-center gap-3 mb-6">
        <HelpCircle className="w-6 h-6 text-purple-primary" />
        <h3 className="text-xl font-bold text-text-primary">{quiz.title}</h3>
      </div>

      {submitted && (
        <div className={`mb-6 p-4 rounded-lg ${
          score.correct === score.total
            ? 'bg-success/10 border border-success/30'
            : 'bg-warning/10 border border-warning/30'
        }`}>
          <p className="text-sm font-semibold">
            Score: {score.correct} / {score.total} ({Math.round((score.correct / score.total) * 100)}%)
          </p>
          {score.correct === score.total && (
            <>
              <p className="text-sm text-success mt-1">Perfect! You've mastered this section! 🎉</p>
              {user && xpAwarded && (
                <div className="flex items-center gap-2 mt-2 text-sm font-semibold text-purple-primary">
                  <Sparkles className="w-4 h-4" />
                  <span>+{XP_REWARDS.COMPLETE_SECTION} XP earned!</span>
                </div>
              )}
              {user && isAwarding && (
                <p className="text-sm text-text-secondary mt-2">Awarding XP...</p>
              )}
              {!user && (
                <p className="text-sm text-text-secondary mt-2">Sign in to earn XP and track progress!</p>
              )}
            </>
          )}
          {score.correct < score.total && (
            <p className="text-sm text-warning mt-1">Review the explanations below and try again.</p>
          )}
        </div>
      )}

      <div className="space-y-6">
        {quiz.questions.map((question, qIndex) => {
          const selectedAnswer = selectedAnswers[question.id];
          const isCorrect = submitted && selectedAnswer === question.correctAnswer;
          const isIncorrect = submitted && selectedAnswer !== question.correctAnswer && selectedAnswer !== undefined;

          return (
            <div key={question.id} className="space-y-3">
              <p className="font-medium text-text-primary">
                {qIndex + 1}. {question.question}
              </p>

              <div className="space-y-2">
                {question.options.map((option, optIndex) => {
                  const isSelected = selectedAnswer === optIndex;
                  const isCorrectAnswer = optIndex === question.correctAnswer;
                  const showAsCorrect = submitted && isCorrectAnswer;
                  const showAsIncorrect = submitted && isSelected && !isCorrect;

                  return (
                    <button
                      key={optIndex}
                      onClick={() => handleAnswerSelect(question.id, optIndex)}
                      disabled={submitted}
                      className={`
                        w-full p-3 rounded-lg text-left transition-all
                        ${isSelected && !submitted ? 'bg-purple-primary/20 border-2 border-purple-primary' : 'border-2 border-gray-700'}
                        ${showAsCorrect ? 'bg-success/20 border-2 border-success' : ''}
                        ${showAsIncorrect ? 'bg-error/20 border-2 border-error' : ''}
                        ${!submitted ? 'hover:bg-gray-800/50 cursor-pointer' : 'cursor-default'}
                      `}
                    >
                      <div className="flex items-center justify-between">
                        <span className="text-sm text-text-secondary">{option}</span>
                        {showAsCorrect && <CheckCircle2 className="w-5 h-5 text-success flex-shrink-0" />}
                        {showAsIncorrect && <XCircle className="w-5 h-5 text-error flex-shrink-0" />}
                      </div>
                    </button>
                  );
                })}
              </div>

              {submitted && showExplanations && question.explanation && (
                <div className="mt-3 p-3 bg-surface/50 rounded-lg border border-gray-700">
                  <p className="text-sm text-text-secondary">
                    <span className="font-semibold text-text-primary">Explanation: </span>
                    {question.explanation}
                  </p>
                </div>
              )}
            </div>
          );
        })}
      </div>

      <div className="mt-6 flex items-center gap-3">
        {!submitted ? (
          <Button
            onClick={handleSubmit}
            variant="primary"
            disabled={!allQuestionsAnswered}
            className="min-w-[150px]"
          >
            Submit Answers
          </Button>
        ) : (
          <Button
            onClick={handleReset}
            variant="secondary"
            className="min-w-[150px]"
          >
            Try Again
          </Button>
        )}

        {!allQuestionsAnswered && !submitted && (
          <span className="text-sm text-text-secondary">
            Answer all questions to submit
          </span>
        )}
      </div>
    </Card>
  );
}
