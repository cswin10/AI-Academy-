'use client';

import { useState } from 'react';
import { useQuiz } from '@/hooks/useQuiz';
import { useSupabase } from '@/hooks/useSupabase';
import { Play, Award, XCircle } from 'lucide-react';
import { Button } from '@/components/ui/Button';
import { Card } from '@/components/ui/Card';

interface QuizContainerProps {
  moduleId: string;
}

export function QuizContainer({ moduleId }: QuizContainerProps) {
  const { user } = useSupabase();
  const {
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
  } = useQuiz(moduleId);

  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [userAnswers, setUserAnswers] = useState<{ [questionId: string]: string[] }>({});
  const [showResults, setShowResults] = useState(false);
  const [results, setResults] = useState<any>(null);

  if (loading) {
    return <div className="text-center py-8">Loading quiz...</div>;
  }

  if (!quiz) {
    return <div className="text-center py-8 text-text-secondary">No quiz available for this module yet.</div>;
  }

  if (!user) {
    return (
      <Card className="p-8 text-center">
        <p className="text-text-secondary mb-4">Please log in to take quizzes and earn XP</p>
      </Card>
    );
  }

  const handleStart = async () => {
    const attempt = await startAttempt();
    if (attempt) {
      setCurrentQuestionIndex(0);
      setUserAnswers({});
      setShowResults(false);
    }
  };

  const handleAnswerSelect = (questionId: string, answerId: string) => {
    const question = questions.find(q => q.id === questionId);
    if (!question) return;

    if (question.question_type === 'multi_select') {
      setUserAnswers(prev => {
        const current = prev[questionId] || [];
        const updated = current.includes(answerId)
          ? current.filter(id => id !== answerId)
          : [...current, answerId];
        return { ...prev, [questionId]: updated };
      });
    } else {
      setUserAnswers(prev => ({ ...prev, [questionId]: [answerId] }));
    }
  };

  const handleNext = () => {
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(prev => prev + 1);
    }
  };

  const handlePrevious = () => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(prev => prev - 1);
    }
  };

  const handleSubmit = async () => {
    if (!currentAttempt) return;

    const result = await submitAttempt(currentAttempt.id, userAnswers);
    if (result) {
      setResults(result);
      setShowResults(true);
    }
  };

  // Intro screen
  if (!currentAttempt && !showResults) {
    const bestScore = getBestScore();
    const passed = hasPassed();

    return (
      <Card className="p-8">
        <div className="max-w-2xl mx-auto">
          <div className="text-center mb-8">
            <h2 className="text-3xl font-bold text-text-primary mb-4">{quiz.title}</h2>
            {quiz.description && (
              <p className="text-text-secondary">{quiz.description}</p>
            )}
          </div>

          <div className="grid md:grid-cols-3 gap-4 mb-8">
            <div className="bg-gray-800 p-4 rounded-lg text-center">
              <div className="text-2xl font-bold text-purple-primary">{questions.length}</div>
              <div className="text-sm text-text-secondary">Questions</div>
            </div>
            <div className="bg-gray-800 p-4 rounded-lg text-center">
              <div className="text-2xl font-bold text-green-500">{quiz.passing_score}%</div>
              <div className="text-sm text-text-secondary">Passing Score</div>
            </div>
            <div className="bg-gray-800 p-4 rounded-lg text-center">
              <div className="text-2xl font-bold text-yellow-500">+{quiz.xp_reward}</div>
              <div className="text-sm text-text-secondary">XP Reward</div>
            </div>
          </div>

          {bestScore !== null && (
            <div className="mb-6 p-4 rounded-lg bg-blue-500/20 border border-blue-500/30">
              <div className="flex items-center gap-2">
                {passed ? (
                  <Award className="w-5 h-5 text-green-500" />
                ) : (
                  <XCircle className="w-5 h-5 text-orange-500" />
                )}
                <span className="text-sm">
                  Your best score: <strong>{bestScore}%</strong>
                  {passed && ' (Passed!)'}
                </span>
              </div>
              <p className="text-xs text-text-secondary mt-1">
                Attempts: {attempts.length}
              </p>
            </div>
          )}

          <Button
            onClick={handleStart}
            variant="primary"
            size="lg"
            className="w-full"
            icon={<Play className="w-5 h-5" />}
          >
            {attempts.length > 0 ? 'Retake Quiz' : 'Start Quiz'}
          </Button>
        </div>
      </Card>
    );
  }

  // Results screen
  if (showResults && results) {
    const passed = results.passed;
    const correctCount = results.answers_data.filter((a: any) => a.is_correct).length;

    return (
      <Card className="p-8">
        <div className="max-w-2xl mx-auto">
          <div className="text-center mb-8">
            {passed ? (
              <div className="mb-4">
                <Award className="w-16 h-16 text-green-500 mx-auto mb-2" />
                <h2 className="text-3xl font-bold text-green-500 mb-2">Congratulations!</h2>
                <p className="text-text-secondary">You passed the quiz!</p>
              </div>
            ) : (
              <div className="mb-4">
                <XCircle className="w-16 h-16 text-orange-500 mx-auto mb-2" />
                <h2 className="text-3xl font-bold text-orange-500 mb-2">Keep Practicing!</h2>
                <p className="text-text-secondary">You can retake this quiz anytime</p>
              </div>
            )}

            <div className="text-6xl font-bold text-text-primary mb-2">{results.score}%</div>
            <p className="text-text-secondary">
              {correctCount} / {questions.length} correct
            </p>
          </div>

          {results.xp_awarded > 0 && (
            <div className="mb-6 p-4 rounded-lg bg-green-500/20 border border-green-500/30 text-center">
              <p className="text-green-500 font-bold">+{results.xp_awarded} XP Earned!</p>
            </div>
          )}

          <div className="space-y-4 mb-8">
            {questions.map((question, idx) => {
              const answerData = results.answers_data.find((a: any) => a.question_id === question.id);
              const questionAnswers = answers[question.id] || [];

              return (
                <div key={question.id} className="p-4 rounded-lg bg-gray-800 border border-gray-700">
                  <div className="flex items-start gap-2 mb-2">
                    <span className="font-bold text-text-primary">Q{idx + 1}.</span>
                    <p className="flex-1 text-text-primary">{question.question_text}</p>
                    {answerData.is_correct ? (
                      <span className="text-green-500 text-sm font-medium">✓ Correct</span>
                    ) : (
                      <span className="text-red-500 text-sm font-medium">✗ Wrong</span>
                    )}
                  </div>

                  <div className="ml-6 space-y-1 text-sm">
                    {questionAnswers.map(answer => {
                      const isCorrect = answer.is_correct;
                      const wasSelected = answerData.user_answers.includes(answer.id);

                      return (
                        <div
                          key={answer.id}
                          className={`p-2 rounded ${
                            isCorrect
                              ? 'bg-green-500/20 text-green-500'
                              : wasSelected
                              ? 'bg-red-500/20 text-red-500'
                              : 'text-text-secondary'
                          }`}
                        >
                          {answer.answer_text}
                          {isCorrect && ' ✓'}
                          {wasSelected && !isCorrect && ' (Your answer)'}
                        </div>
                      );
                    })}
                  </div>

                  {question.explanation && (
                    <div className="mt-2 ml-6 text-sm text-text-secondary italic">
                      💡 {question.explanation}
                    </div>
                  )}
                </div>
              );
            })}
          </div>

          <Button
            onClick={() => {
              setShowResults(false);
            }}
            variant="primary"
            className="w-full"
          >
            {passed ? 'Continue Learning' : 'Try Again'}
          </Button>
        </div>
      </Card>
    );
  }

  // Quiz questions
  const currentQuestion = questions[currentQuestionIndex];
  const questionAnswers = answers[currentQuestion?.id] || [];
  const selectedAnswers = userAnswers[currentQuestion?.id] || [];

  return (
    <Card className="p-8">
      <div className="max-w-2xl mx-auto">
        {/* Progress */}
        <div className="mb-6">
          <div className="flex items-center justify-between mb-2">
            <span className="text-sm font-medium text-text-secondary">
              Question {currentQuestionIndex + 1} of {questions.length}
            </span>
            <span className="text-sm text-text-secondary">
              {Math.round(((currentQuestionIndex + 1) / questions.length) * 100)}%
            </span>
          </div>
          <div className="h-2 bg-gray-700 rounded-full overflow-hidden">
            <div
              className="h-full bg-gradient-to-r from-purple-600 to-blue-600 transition-all"
              style={{ width: `${((currentQuestionIndex + 1) / questions.length) * 100}%` }}
            />
          </div>
        </div>

        {/* Question */}
        <div className="mb-8">
          <h3 className="text-xl font-bold text-text-primary mb-4">
            {currentQuestion.question_text}
          </h3>

          <div className="space-y-3">
            {questionAnswers.map(answer => {
              const isSelected = selectedAnswers.includes(answer.id);

              return (
                <button
                  key={answer.id}
                  onClick={() => handleAnswerSelect(currentQuestion.id, answer.id)}
                  className={`
                    w-full p-4 rounded-lg border-2 text-left transition-all
                    ${isSelected
                      ? 'border-purple-500 bg-purple-500/20'
                      : 'border-gray-700 bg-gray-800 hover:border-gray-600'
                    }
                  `}
                >
                  {answer.answer_text}
                </button>
              );
            })}
          </div>
        </div>

        {/* Navigation */}
        <div className="flex items-center justify-between">
          <Button
            onClick={handlePrevious}
            variant="secondary"
            disabled={currentQuestionIndex === 0}
          >
            Previous
          </Button>

          {currentQuestionIndex === questions.length - 1 ? (
            <Button
              onClick={handleSubmit}
              variant="primary"
              disabled={Object.keys(userAnswers).length !== questions.length}
            >
              Submit Quiz
            </Button>
          ) : (
            <Button
              onClick={handleNext}
              variant="primary"
            >
              Next
            </Button>
          )}
        </div>
      </div>
    </Card>
  );
}
