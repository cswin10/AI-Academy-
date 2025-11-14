'use client';

import React, { useState } from 'react';
import { CheckCircle2, XCircle, HelpCircle } from 'lucide-react';
import { Card } from '../ui/Card';
import { Button } from '../ui/Button';
import type { SectionQuiz } from '@/lib/types';

interface SectionQuizComponentProps {
  quiz: SectionQuiz;
  onComplete?: () => void;
}

export function SectionQuizComponent({ quiz, onComplete }: SectionQuizComponentProps) {
  const [selectedAnswers, setSelectedAnswers] = useState<Record<string, number>>({});
  const [submitted, setSubmitted] = useState(false);
  const [showExplanations, setShowExplanations] = useState(false);

  const handleAnswerSelect = (questionId: string, answerIndex: number) => {
    if (submitted) return;
    setSelectedAnswers(prev => ({
      ...prev,
      [questionId]: answerIndex,
    }));
  };

  const handleSubmit = () => {
    setSubmitted(true);
    setShowExplanations(true);

    // Check if all answers are correct
    const allCorrect = quiz.questions.every(q => selectedAnswers[q.id] === q.correctAnswer);
    if (allCorrect && onComplete) {
      onComplete();
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
            <p className="text-sm text-success mt-1">Perfect! You've mastered this section! 🎉</p>
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
