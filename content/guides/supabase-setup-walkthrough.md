# Supabase Setup Walkthrough

## Introduction

This comprehensive guide will walk you through setting up Supabase for your AI Operator projects. Supabase is your backend-as-a-service platform that provides:
- PostgreSQL database (with powerful extensions)
- Authentication system
- Real-time subscriptions
- File storage
- Edge functions
- Row-level security

By the end of this walkthrough, you'll have a production-ready Supabase project configured for AI workflows.

## Prerequisites

- A GitHub account (for Supabase sign-up)
- Basic understanding of databases (from Module 8: Data Layer)
- A project idea or use case in mind

## Part 1: Creating Your Supabase Project

### Step 1: Sign Up for Supabase

1. Go to [supabase.com](https://supabase.com)
2. Click "Start your project"
3. Sign up with GitHub (recommended) or email
4. Confirm your email address

### Step 2: Create a New Project

1. Click "New Project" in your dashboard
2. Fill in the project details:
   - **Name**: Choose a descriptive name (e.g., `ai-content-generator`)
   - **Database Password**: Generate a strong password (save it securely!)
   - **Region**: Choose closest to your users (e.g., US East, EU West)
   - **Pricing Plan**: Start with Free tier

3. Click "Create new project"
4. Wait 2-3 minutes for provisioning

### Step 3: Understanding the Dashboard

Once your project is ready, familiarize yourself with the main sections:

- **Table Editor**: Visual interface for managing database tables
- **SQL Editor**: Write custom SQL queries
- **Authentication**: Manage users and auth settings
- **Storage**: Handle file uploads
- **Database**: Access connection strings and manage extensions
- **API**: View your project's API documentation

## Part 2: Setting Up Your First Database Table

### Step 4: Enable Row Level Security

Before creating tables, understand Row Level Security (RLS):
- RLS ensures users can only access their own data
- It's enforced at the database level (more secure than application logic)
- Always enable it for production tables

### Step 5: Create a Table (Visual Method)

Let's create a `documents` table for an AI knowledge base:

1. Go to **Table Editor**
2. Click "Create a new table"
3. Configure the table:
   - **Name**: `documents`
   - **Description**: "User documents for AI processing"
   - **Enable Row Level Security (RLS)**: ✅ Checked

4. Add columns:

| Column Name | Type | Default Value | Options |
|-------------|------|---------------|---------|
| `id` | uuid | `gen_random_uuid()` | Primary, Unique |
| `created_at` | timestamptz | `now()` | Not null |
| `user_id` | uuid | - | Not null, Foreign Key to auth.users |
| `title` | text | - | Not null |
| `content` | text | - | Not null |
| `metadata` | jsonb | `'{}'::jsonb` | |
| `embedding` | vector(1536) | - | (for semantic search) |

5. Click "Save"

### Step 6: Set Up RLS Policies

After creating the table, set up security policies:

1. In Table Editor, click on the `documents` table
2. Click the "RLS" button at the top
3. Click "Add Policy"

**Policy 1: Users can view their own documents**
```sql
CREATE POLICY "Users can view own documents"
ON documents FOR SELECT
USING (auth.uid() = user_id);
```

**Policy 2: Users can insert their own documents**
```sql
CREATE POLICY "Users can insert own documents"
ON documents FOR INSERT
WITH CHECK (auth.uid() = user_id);
```

**Policy 3: Users can update their own documents**
```sql
CREATE POLICY "Users can update own documents"
ON documents FOR UPDATE
USING (auth.uid() = user_id);
```

**Policy 4: Users can delete their own documents**
```sql
CREATE POLICY "Users can delete own documents"
ON documents FOR DELETE
USING (auth.uid() = user_id);
```

4. Click "Create policy" for each

## Part 3: Enabling Vector Search (for RAG Systems)

### Step 7: Install pgvector Extension

To enable semantic search with embeddings:

1. Go to **Database** → **Extensions**
2. Search for `vector`
3. Enable the `pgvector` extension
4. Click "Enable"

### Step 8: Create a Vector Similarity Function

Go to **SQL Editor** and run:

```sql
-- Function to search similar documents by embedding
CREATE OR REPLACE FUNCTION match_documents(
  query_embedding vector(1536),
  match_threshold float,
  match_count int
)
RETURNS TABLE (
  id uuid,
  title text,
  content text,
  metadata jsonb,
  similarity float
)
LANGUAGE sql STABLE
AS $$
  SELECT
    documents.id,
    documents.title,
    documents.content,
    documents.metadata,
    1 - (documents.embedding <=> query_embedding) AS similarity
  FROM documents
  WHERE 1 - (documents.embedding <=> query_embedding) > match_threshold
  ORDER BY documents.embedding <=> query_embedding
  LIMIT match_count;
$$;
```

### Step 9: Create an Index for Fast Vector Search

```sql
-- Create an index for fast similarity search
CREATE INDEX ON documents
USING ivfflat (embedding vector_cosine_ops)
WITH (lists = 100);
```

## Part 4: Setting Up Authentication

### Step 10: Configure Auth Providers

1. Go to **Authentication** → **Providers**
2. Enable desired auth methods:
   - **Email**: Default, always available
   - **Google**: For social login
   - **GitHub**: Great for developer tools
   - **Magic Link**: Passwordless email login

For Google OAuth:
1. Go to [Google Cloud Console](https://console.cloud.google.com)
2. Create a project
3. Enable Google+ API
4. Create OAuth credentials
5. Copy Client ID and Client Secret to Supabase

### Step 11: Configure Email Templates

1. Go to **Authentication** → **Email Templates**
2. Customize templates for:
   - Confirm signup
   - Magic Link
   - Reset password
   - Change email address

Example customization:
```html
<h2>Welcome to AI Academy!</h2>
<p>Click the link below to confirm your email:</p>
<p><a href="{{ .ConfirmationURL }}">Confirm Email</a></p>
```

### Step 12: Set Up Auth Redirects

1. Go to **Authentication** → **URL Configuration**
2. Add your site URLs:
   - **Site URL**: `https://yourdomain.com`
   - **Redirect URLs**:
     - `http://localhost:3000/*` (development)
     - `https://yourdomain.com/*` (production)

## Part 5: Setting Up Storage

### Step 13: Create a Storage Bucket

For storing user uploads (images, documents, etc.):

1. Go to **Storage**
2. Click "Create a new bucket"
3. Configure:
   - **Name**: `user-uploads`
   - **Public**: Unchecked (private by default)
   - **File size limit**: 50 MB
   - **Allowed MIME types**: `image/*,application/pdf`

4. Click "Create bucket"

### Step 14: Set Up Storage Policies

```sql
-- Allow users to upload to their own folder
CREATE POLICY "Users can upload own files"
ON storage.objects FOR INSERT
WITH CHECK (
  bucket_id = 'user-uploads' AND
  auth.uid()::text = (storage.foldername(name))[1]
);

-- Allow users to view their own files
CREATE POLICY "Users can view own files"
ON storage.objects FOR SELECT
USING (
  bucket_id = 'user-uploads' AND
  auth.uid()::text = (storage.foldername(name))[1]
);

-- Allow users to delete their own files
CREATE POLICY "Users can delete own files"
ON storage.objects FOR DELETE
USING (
  bucket_id = 'user-uploads' AND
  auth.uid()::text = (storage.foldername(name))[1]
);
```

## Part 6: Getting Your API Credentials

### Step 15: Locate Your Project Credentials

1. Go to **Settings** → **API**
2. Copy these values (you'll need them in your code):

```env
# .env file
SUPABASE_URL=https://xxxxxxxxxxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**Important Security Notes:**
- ✅ Use `SUPABASE_ANON_KEY` in client-side code
- ⚠️ Use `SUPABASE_SERVICE_ROLE_KEY` **only** in server-side code
- ❌ Never commit service role key to Git
- ✅ Always use environment variables

## Part 7: Testing Your Setup

### Step 16: Test with Supabase Client

Install the Supabase client:

```bash
# JavaScript/TypeScript
npm install @supabase/supabase-js

# Python
pip install supabase
```

**JavaScript Example:**

```javascript
import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_ANON_KEY
)

// Test: Insert a document
async function testInsert() {
  const { data, error } = await supabase
    .from('documents')
    .insert({
      title: 'Test Document',
      content: 'This is a test',
      user_id: 'YOUR_USER_ID'
    })

  if (error) {
    console.error('Error:', error)
  } else {
    console.log('Success:', data)
  }
}

// Test: Query documents
async function testQuery() {
  const { data, error } = await supabase
    .from('documents')
    .select('*')
    .eq('user_id', 'YOUR_USER_ID')

  if (error) {
    console.error('Error:', error)
  } else {
    console.log('Documents:', data)
  }
}
```

**Python Example:**

```python
from supabase import create_client, Client
import os

url = os.environ.get("SUPABASE_URL")
key = os.environ.get("SUPABASE_ANON_KEY")
supabase: Client = create_client(url, key)

# Test: Insert a document
def test_insert():
    data = supabase.table('documents').insert({
        'title': 'Test Document',
        'content': 'This is a test',
        'user_id': 'YOUR_USER_ID'
    }).execute()
    print("Success:", data)

# Test: Query documents
def test_query():
    data = supabase.table('documents').select('*').eq('user_id', 'YOUR_USER_ID').execute()
    print("Documents:", data)
```

### Step 17: Test Authentication

```javascript
// Sign up a test user
async function testSignUp() {
  const { data, error } = await supabase.auth.signUp({
    email: 'test@example.com',
    password: 'securepassword123'
  })

  if (error) {
    console.error('Error:', error)
  } else {
    console.log('User created:', data.user)
  }
}

// Sign in
async function testSignIn() {
  const { data, error } = await supabase.auth.signInWithPassword({
    email: 'test@example.com',
    password: 'securepassword123'
  })

  if (error) {
    console.error('Error:', error)
  } else {
    console.log('Signed in:', data.user)
  }
}

// Get current session
async function getSession() {
  const { data: { session } } = await supabase.auth.getSession()
  console.log('Current session:', session)
}
```

### Step 18: Test Vector Search

```javascript
import { Configuration, OpenAIApi } from 'openai'

// Generate embedding with OpenAI
async function getEmbedding(text) {
  const openai = new OpenAIApi(new Configuration({
    apiKey: process.env.OPENAI_API_KEY
  }))

  const response = await openai.createEmbedding({
    model: 'text-embedding-ada-002',
    input: text
  })

  return response.data.data[0].embedding
}

// Store document with embedding
async function storeWithEmbedding(title, content, userId) {
  const embedding = await getEmbedding(content)

  const { data, error } = await supabase
    .from('documents')
    .insert({
      title,
      content,
      user_id: userId,
      embedding
    })

  return { data, error }
}

// Search similar documents
async function searchSimilar(query, userId) {
  const queryEmbedding = await getEmbedding(query)

  const { data, error } = await supabase.rpc('match_documents', {
    query_embedding: queryEmbedding,
    match_threshold: 0.7,
    match_count: 5
  })

  return { data, error }
}
```

## Part 8: Production Best Practices

### Step 19: Enable Database Backups

1. Go to **Settings** → **Database**
2. Under "Backups", configure:
   - **Point-in-Time Recovery (PITR)**: Enable for Pro plan
   - **Daily Backups**: Automatically enabled
   - **Retention**: 7 days (Free), 30 days (Pro)

### Step 20: Monitor Usage

1. Go to **Settings** → **Usage**
2. Monitor:
   - Database size
   - API requests
   - Storage usage
   - Bandwidth

Set up alerts:
1. Go to **Settings** → **Notifications**
2. Enable email alerts for:
   - 80% quota usage
   - Failed API requests
   - Database errors

### Step 21: Set Up Database Indexes

For better query performance:

```sql
-- Index for user_id lookups (most common query)
CREATE INDEX idx_documents_user_id ON documents(user_id);

-- Index for created_at (for sorting)
CREATE INDEX idx_documents_created_at ON documents(created_at DESC);

-- Composite index for common query patterns
CREATE INDEX idx_documents_user_created ON documents(user_id, created_at DESC);
```

### Step 22: Configure Connection Pooling

For production applications with many concurrent users:

1. Go to **Settings** → **Database**
2. Find "Connection pooling"
3. Use the pooled connection string for your application
4. Configure pool size based on your tier:
   - Free: 15 connections
   - Pro: 50 connections
   - Pay-as-you-go: 200+ connections

## Part 9: Advanced Configuration

### Step 23: Set Up Database Functions

Create reusable database functions for complex operations:

```sql
-- Function to get user document count
CREATE OR REPLACE FUNCTION get_user_document_count(user_uuid uuid)
RETURNS integer
LANGUAGE sql STABLE
AS $$
  SELECT COUNT(*)::integer
  FROM documents
  WHERE user_id = user_uuid;
$$;

-- Function to soft delete (mark as deleted without removing)
CREATE OR REPLACE FUNCTION soft_delete_document(doc_id uuid, user_uuid uuid)
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE documents
  SET metadata = metadata || '{"deleted": true}'::jsonb
  WHERE id = doc_id AND user_id = user_uuid;
END;
$$;
```

### Step 24: Set Up Database Triggers

Automate tasks with triggers:

```sql
-- Automatically update 'updated_at' timestamp
ALTER TABLE documents ADD COLUMN updated_at timestamptz;

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_documents_updated_at BEFORE UPDATE
ON documents FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();
```

### Step 25: Set Up Realtime Subscriptions

Enable realtime updates for collaborative features:

1. Go to **Database** → **Replication**
2. Enable replication for `documents` table
3. In your code:

```javascript
// Subscribe to changes
const subscription = supabase
  .channel('documents-changes')
  .on('postgres_changes', {
    event: '*',
    schema: 'public',
    table: 'documents',
    filter: `user_id=eq.${userId}`
  }, (payload) => {
    console.log('Change received!', payload)
  })
  .subscribe()

// Unsubscribe when done
subscription.unsubscribe()
```

## Part 10: Troubleshooting Common Issues

### Issue 1: "Permission denied for table"

**Cause**: RLS is enabled but no policies exist
**Solution**: Add appropriate RLS policies (see Step 6)

### Issue 2: "Function does not exist"

**Cause**: Function not created or wrong schema
**Solution**:
```sql
-- Check if function exists
SELECT routine_name
FROM information_schema.routines
WHERE routine_schema = 'public';
```

### Issue 3: Vector search is slow

**Cause**: Missing index on embedding column
**Solution**: Create IVFFlat index (see Step 9)

### Issue 4: "Auth session expired"

**Cause**: JWT token expired after 1 hour
**Solution**: Implement token refresh:
```javascript
supabase.auth.onAuthStateChange((event, session) => {
  if (event === 'TOKEN_REFRESHED') {
    console.log('Token refreshed')
  }
})
```

### Issue 5: CORS errors in browser

**Cause**: Domain not added to allowed URLs
**Solution**: Add domain to **Authentication** → **URL Configuration**

## Next Steps

Now that your Supabase project is set up, you can:

1. **Integrate with your application**: Use the code examples above
2. **Build a RAG system**: Module 11 (RAG Systems)
3. **Add AI agents**: Module 12 (AI Agents)
4. **Implement payments**: Module 13 (Payments & Auth)
5. **Add monitoring**: Module 14 (Monitoring & Logging)

## Additional Resources

- [Supabase Documentation](https://supabase.com/docs)
- [Supabase Discord Community](https://discord.supabase.com)
- [pgvector GitHub](https://github.com/pgvector/pgvector)
- [Row Level Security Guide](https://supabase.com/docs/guides/auth/row-level-security)
- [Supabase CLI](https://supabase.com/docs/guides/cli)

## Summary Checklist

- [ ] Created Supabase project
- [ ] Created `documents` table with RLS
- [ ] Set up RLS policies for CRUD operations
- [ ] Enabled pgvector extension
- [ ] Created vector similarity function
- [ ] Created vector index
- [ ] Configured authentication providers
- [ ] Set up storage bucket with policies
- [ ] Saved API credentials securely
- [ ] Tested basic operations
- [ ] Tested vector search
- [ ] Set up database indexes
- [ ] Configured connection pooling
- [ ] Enabled monitoring and alerts

**Congratulations!** You now have a production-ready Supabase setup for AI workflows.
