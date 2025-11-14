-- =============================================
-- SEED SAMPLE QUIZZES
-- =============================================

-- Quiz for Module 1: Foundations
DO $$
DECLARE
  v_quiz_id UUID;
  v_q1_id UUID;
  v_q2_id UUID;
  v_q3_id UUID;
  v_q4_id UUID;
  v_q5_id UUID;
BEGIN
  -- Create quiz
  INSERT INTO public.quizzes (module_id, title, description, passing_score, xp_reward, time_limit_minutes)
  VALUES ('01-foundations', 'Foundations Quiz', 'Test your understanding of AI Operator fundamentals', 70, 100, 15)
  RETURNING id INTO v_quiz_id;

  -- Question 1
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'What is the primary role of an AI Operator?', 'multiple_choice', 'AI Operators build and maintain AI systems, bridging the gap between AI tools and business outcomes.', 20, 1)
  RETURNING id INTO v_q1_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q1_id, 'Writing machine learning algorithms from scratch', false, 1),
  (v_q1_id, 'Building and integrating AI systems using existing tools and APIs', true, 2),
  (v_q1_id, 'Only using ChatGPT for content generation', false, 3),
  (v_q1_id, 'Managing AI hardware infrastructure', false, 4);

  -- Question 2
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'Which of these is NOT a core skill for AI Operators?', 'multiple_choice', 'AI Operators focus on integration and workflows, not building models from scratch.', 20, 2)
  RETURNING id INTO v_q2_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q2_id, 'Prompt engineering', false, 1),
  (v_q2_id, 'Training large language models from scratch', true, 2),
  (v_q2_id, 'API integration', false, 3),
  (v_q2_id, 'Workflow automation', false, 4);

  -- Question 3
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'What does RAG stand for in AI systems?', 'multiple_choice', 'RAG (Retrieval-Augmented Generation) enhances AI responses with relevant data from knowledge bases.', 20, 3)
  RETURNING id INTO v_q3_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q3_id, 'Random AI Generation', false, 1),
  (v_q3_id, 'Retrieval-Augmented Generation', true, 2),
  (v_q3_id, 'Rapid Automated Growth', false, 3),
  (v_q3_id, 'Reinforced Agent Guidance', false, 4);

  -- Question 4
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'Which tool is commonly used for workflow automation?', 'multiple_choice', 'n8n, Zapier, and Make are popular workflow automation tools that AI Operators use.', 20, 4)
  RETURNING id INTO v_q4_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q4_id, 'n8n or Zapier', true, 1),
  (v_q4_id, 'Microsoft Word', false, 2),
  (v_q4_id, 'Adobe Photoshop', false, 3),
  (v_q4_id, 'TensorFlow', false, 4);

  -- Question 5
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'Why is understanding prompt engineering important for AI Operators?', 'multiple_choice', 'Prompt engineering is crucial for getting reliable, consistent results from AI models.', 20, 5)
  RETURNING id INTO v_q5_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q5_id, 'It''s not important', false, 1),
  (v_q5_id, 'To get better and more consistent results from AI models', true, 2),
  (v_q5_id, 'To impress clients with technical jargon', false, 3),
  (v_q5_id, 'It''s only useful for researchers', false, 4);
END $$;

-- Quiz for Module 6: Tool Primer
DO $$
DECLARE
  v_quiz_id UUID;
  v_q1_id UUID;
  v_q2_id UUID;
  v_q3_id UUID;
  v_q4_id UUID;
  v_q5_id UUID;
BEGIN
  INSERT INTO public.quizzes (module_id, title, description, passing_score, xp_reward, time_limit_minutes)
  VALUES ('16-tool-primer', 'Tool Primer Quiz', 'Test your knowledge of AI Operator tools', 70, 100, 15)
  RETURNING id INTO v_quiz_id;

  -- Question 1
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'What is Supabase primarily used for?', 'multiple_choice', 'Supabase is a backend-as-a-service platform providing database, authentication, and storage.', 20, 1)
  RETURNING id INTO v_q1_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q1_id, 'Video editing', false, 1),
  (v_q1_id, 'Backend-as-a-service (database, auth, storage)', true, 2),
  (v_q1_id, 'Email marketing', false, 3),
  (v_q1_id, 'Image generation', false, 4);

  -- Question 2
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'Which service would you use to send SMS messages programmatically?', 'multiple_choice', 'Twilio is the industry standard for sending SMS and making voice calls programmatically.', 20, 2)
  RETURNING id INTO v_q2_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q2_id, 'Stripe', false, 1),
  (v_q2_id, 'Twilio', true, 2),
  (v_q2_id, 'Airtable', false, 3),
  (v_q2_id, 'Pinecone', false, 4);

  -- Question 3
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'What is a vector database used for in AI systems?', 'multiple_choice', 'Vector databases store embeddings for semantic search, enabling RAG systems.', 20, 3)
  RETURNING id INTO v_q3_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q3_id, 'Storing images and videos', false, 1),
  (v_q3_id, 'Semantic search with embeddings (RAG systems)', true, 2),
  (v_q3_id, 'Processing payments', false, 3),
  (v_q3_id, 'Sending emails', false, 4);

  -- Question 4
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'Why would you use Cloudflare R2 over AWS S3?', 'multiple_choice', 'R2 has no egress fees, making it much cheaper when users frequently download files.', 20, 4)
  RETURNING id INTO v_q4_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q4_id, 'It''s faster', false, 1),
  (v_q4_id, 'Free egress (no download fees)', true, 2),
  (v_q4_id, 'Better security', false, 3),
  (v_q4_id, 'Easier to set up', false, 4);

  -- Question 5
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'What is the main benefit of Supabase Row Level Security (RLS)?', 'multiple_choice', 'RLS ensures users can only access their own data at the database level, which is more secure than application logic.', 20, 5)
  RETURNING id INTO v_q5_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q5_id, 'Faster queries', false, 1),
  (v_q5_id, 'Database-level security ensuring users only see their own data', true, 2),
  (v_q5_id, 'Better UI', false, 3),
  (v_q5_id, 'Automatic backups', false, 4);
END $$;

-- Quiz for Module 11: RAG Systems
DO $$
DECLARE
  v_quiz_id UUID;
  v_q1_id UUID;
  v_q2_id UUID;
  v_q3_id UUID;
  v_q4_id UUID;
BEGIN
  INSERT INTO public.quizzes (module_id, title, description, passing_score, xp_reward, time_limit_minutes)
  VALUES ('10-rag-systems', 'RAG Systems Quiz', 'Test your understanding of production RAG implementations', 70, 150, 20)
  RETURNING id INTO v_quiz_id;

  -- Question 1
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'What is the main advantage of production RAG over basic RAG?', 'multiple_choice', 'Production RAG uses query enhancement, hybrid search, and reranking to achieve 95% accuracy vs 70% for basic RAG.', 25, 1)
  RETURNING id INTO v_q1_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q1_id, 'It''s faster', false, 1),
  (v_q1_id, 'Higher accuracy (95% vs 70%) through query enhancement, hybrid search, and reranking', true, 2),
  (v_q1_id, 'It costs less', false, 3),
  (v_q1_id, 'It''s easier to implement', false, 4);

  -- Question 2
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'What is the ideal chunk size for RAG systems?', 'multiple_choice', '300-500 tokens with semantic boundaries and overlap provides the best balance.', 25, 2)
  RETURNING id INTO v_q2_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q2_id, 'One sentence per chunk', false, 1),
  (v_q2_id, '300-500 tokens with semantic boundaries', true, 2),
  (v_q2_id, 'Entire documents', false, 3),
  (v_q2_id, 'Exactly 100 characters', false, 4);

  -- Question 3
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'What is reranking in the context of RAG?', 'multiple_choice', 'Reranking uses AI to score retrieved documents for relevance to improve result quality.', 25, 3)
  RETURNING id INTO v_q3_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q3_id, 'Sorting results alphabetically', false, 1),
  (v_q3_id, 'Using AI to score retrieved documents by relevance', true, 2),
  (v_q3_id, 'Randomizing search results', false, 3),
  (v_q3_id, 'Removing duplicate results', false, 4);

  -- Question 4
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'What is hybrid search?', 'multiple_choice', 'Hybrid search combines vector (semantic) search with keyword search for better retrieval.', 25, 4)
  RETURNING id INTO v_q4_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q4_id, 'Searching multiple databases at once', false, 1),
  (v_q4_id, 'Combining vector (semantic) and keyword search', true, 2),
  (v_q4_id, 'Using two different AI models', false, 3),
  (v_q4_id, 'Searching in parallel threads', false, 4);
END $$;

-- Quiz for Module 12: AI Agents
DO $$
DECLARE
  v_quiz_id UUID;
  v_q1_id UUID;
  v_q2_id UUID;
  v_q3_id UUID;
  v_q4_id UUID;
BEGIN
  INSERT INTO public.quizzes (module_id, title, description, passing_score, xp_reward, time_limit_minutes)
  VALUES ('11-ai-agents', 'AI Agents Quiz', 'Test your knowledge of autonomous AI agents', 70, 150, 20)
  RETURNING id INTO v_quiz_id;

  -- Question 1
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'What does ReAct stand for in the context of AI agents?', 'multiple_choice', 'ReAct combines Reasoning (thinking) and Acting (tool use) in a loop.', 25, 1)
  RETURNING id INTO v_q1_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q1_id, 'Rapid Action', false, 1),
  (v_q1_id, 'Reasoning + Acting', true, 2),
  (v_q1_id, 'Real-time Action', false, 3),
  (v_q1_id, 'Reactive Agent Control', false, 4);

  -- Question 2
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'Why are guardrails important in AI agents?', 'multiple_choice', 'Guardrails prevent infinite loops, timeouts, and runaway costs.', 25, 2)
  RETURNING id INTO v_q2_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q2_id, 'They make agents faster', false, 1),
  (v_q2_id, 'To prevent infinite loops, timeouts, and excessive costs', true, 2),
  (v_q2_id, 'They improve accuracy', false, 3),
  (v_q2_id, 'To add more features', false, 4);

  -- Question 3
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'What is the purpose of agent memory systems?', 'multiple_choice', 'Memory allows agents to maintain context across conversations and learn from past interactions.', 25, 3)
  RETURNING id INTO v_q3_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q3_id, 'To save API costs', false, 1),
  (v_q3_id, 'To maintain context across conversations and learn from past interactions', true, 2),
  (v_q3_id, 'To speed up processing', false, 3),
  (v_q3_id, 'To store passwords', false, 4);

  -- Question 4
  INSERT INTO public.quiz_questions (quiz_id, question_text, question_type, explanation, points, order_index)
  VALUES (v_quiz_id, 'What is the benefit of progressive disclosure in agent tool selection?', 'multiple_choice', 'Limiting tools helps agents make better decisions by reducing complexity.', 25, 4)
  RETURNING id INTO v_q4_id;

  INSERT INTO public.quiz_answers (question_id, answer_text, is_correct, order_index) VALUES
  (v_q4_id, 'It hides features from users', false, 1),
  (v_q4_id, 'Fewer tools lead to better decision-making by reducing complexity', true, 2),
  (v_q4_id, 'It makes the UI prettier', false, 3),
  (v_q4_id, 'It saves database space', false, 4);
END $$;
