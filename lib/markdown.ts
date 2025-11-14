import fs from 'fs';
import path from 'path';
import matter from 'gray-matter';
import { ModuleMetadata, ModuleContent, Section, ChecklistItem, ModuleSection, Task, SectionQuiz, QuizQuestion } from './types';

const CONTENT_DIR = path.join(process.cwd(), 'content/modules');

// Get all module IDs
export const getAllModuleIds = (): string[] => {
  try {
    const files = fs.readdirSync(CONTENT_DIR);
    return files
      .filter((file) => file.endsWith('.md'))
      .map((file) => file.replace('.md', ''));
  } catch {
    return [];
  }
};

// Get module content by ID
export const getModuleContent = (moduleId: string): ModuleContent | null => {
  try {
    const fullPath = path.join(CONTENT_DIR, `${moduleId}.md`);
    const fileContents = fs.readFileSync(fullPath, 'utf8');
    const { data, content } = matter(fileContents);

    // Extract metadata
    const metadata: ModuleMetadata = {
      id: moduleId,
      number: data.number || 0,
      title: data.title || 'Untitled Module',
      description: data.description || '',
      estimatedTime: data.estimatedTime || 'TBD',
      difficulty: data.difficulty || 'Beginner',
      skillLevel: data.skillLevel || undefined,
      prerequisites: data.prerequisites || [],
      category: data.category || 'Foundation',
    };

    // Extract sections from content
    const sections = extractSections(content);

    // Extract checklist items
    const checklistItems = extractChecklistItems(content, moduleId);

    // Extract structured sections (new format)
    const structuredSections = extractStructuredSections(content, moduleId);

    return {
      metadata,
      content,
      sections,
      checklistItems,
      structuredSections,
    };
  } catch (error) {
    console.error(`Error loading module ${moduleId}:`, error);
    return null;
  }
};

// Get all modules metadata
export const getAllModules = (): ModuleMetadata[] => {
  const moduleIds = getAllModuleIds();
  return moduleIds
    .map((id) => {
      const module = getModuleContent(id);
      return module?.metadata;
    })
    .filter((m): m is ModuleMetadata => m !== null)
    .sort((a, b) => a.number - b.number);
};

// Extract sections (headings) from markdown
export const extractSections = (content: string): Section[] => {
  const sections: Section[] = [];
  const lines = content.split('\n');

  lines.forEach((line, index) => {
    const match = line.match(/^(#{1,6})\s+(.+)$/);
    if (match) {
      const level = match[1].length;
      const title = match[2].trim();
      const slug = slugify(title);

      sections.push({
        id: `section-${index}`,
        title,
        level,
        slug,
      });
    }
  });

  return sections;
};

// Extract checklist items from markdown
export const extractChecklistItems = (content: string, moduleId: string): ChecklistItem[] => {
  const items: ChecklistItem[] = [];
  const lines = content.split('\n');
  let inChecklistSection = false;
  let currentSection: string | undefined;

  lines.forEach((line, index) => {
    // Check if we're in a completion checklist section
    if (line.includes('Completion Checklist') || line.includes('Learning Objectives')) {
      inChecklistSection = true;
      currentSection = line.trim();
      return;
    }

    // Exit checklist section on next heading
    if (inChecklistSection && line.match(/^#{1,6}\s+/)) {
      inChecklistSection = false;
      currentSection = undefined;
    }

    // Extract checkbox items
    if (inChecklistSection) {
      const match = line.match(/^-\s+\[\s*\]\s+(.+)$/);
      if (match) {
        const text = match[1].trim();
        items.push({
          id: `${moduleId}-item-${index}`,
          text,
          moduleId,
          sectionId: currentSection,
        });
      }
    }
  });

  return items;
};

// Convert title to URL-friendly slug
export const slugify = (text: string): string => {
  return text
    .toLowerCase()
    .replace(/[^\w\s-]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .trim();
};

// Generate table of contents from sections
export const generateTableOfContents = (sections: Section[]) => {
  const toc: any[] = [];
  const stack: any[] = [];

  sections.forEach((section) => {
    const item = {
      id: section.id,
      title: section.title,
      level: section.level,
      slug: section.slug,
      children: [],
    };

    while (stack.length > 0 && stack[stack.length - 1].level >= section.level) {
      stack.pop();
    }

    if (stack.length === 0) {
      toc.push(item);
    } else {
      stack[stack.length - 1].children.push(item);
    }

    stack.push(item);
  });

  return toc;
};

// Extract structured sections with tasks and quizzes
export const extractStructuredSections = (content: string, moduleId: string): ModuleSection[] => {
  const sections: ModuleSection[] = [];
  const lines = content.split('\n');

  let currentSection: ModuleSection | null = null;
  let sectionNumber = 0;
  let currentContent: string[] = [];
  let inCodeBlock = false;
  let inTaskBlock = false;
  let inQuizBlock = false;
  let taskLines: string[] = [];
  let quizLines: string[] = [];
  let introContent: string[] = [];
  let beforeFirstSection = true;

  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];

    // Track code blocks to avoid parsing inside them
    if (line.trim().startsWith('```')) {
      if (!inCodeBlock) {
        // Starting a code block
        const blockType = line.trim().substring(3).trim();
        if (blockType === 'task') {
          inTaskBlock = true;
          taskLines = [];
          continue;
        } else if (blockType === 'quiz') {
          inQuizBlock = true;
          quizLines = [];
          continue;
        }
        inCodeBlock = true;
      } else {
        // Ending a code block
        if (inTaskBlock) {
          // Parse and add task to current section
          const task = parseTask(taskLines.join('\n'), moduleId, currentSection?.id || `${moduleId}-section-${sectionNumber}`);
          if (task && currentSection) {
            if (!currentSection.tasks) currentSection.tasks = [];
            currentSection.tasks.push(task);
          }
          inTaskBlock = false;
          taskLines = [];
          inCodeBlock = false;
          continue;
        } else if (inQuizBlock) {
          // Parse and add quiz to current section
          const quiz = parseQuiz(quizLines.join('\n'), currentSection?.id || `${moduleId}-section-${sectionNumber}`);
          if (quiz && currentSection) {
            currentSection.quiz = quiz;
          }
          inQuizBlock = false;
          quizLines = [];
          inCodeBlock = false;
          continue;
        }
        inCodeBlock = false;
      }
    }

    // Capture task block content
    if (inTaskBlock) {
      taskLines.push(line);
      continue;
    }

    // Capture quiz block content
    if (inQuizBlock) {
      quizLines.push(line);
      continue;
    }

    // Check for main section headings (## heading)
    const sectionMatch = line.match(/^##\s+(.+)$/);
    if (sectionMatch && !inCodeBlock) {
      // If this is the first section and we have intro content, create Introduction section
      if (beforeFirstSection && introContent.length > 0) {
        const introText = introContent.join('\n').trim();
        if (introText) {
          sectionNumber++;
          sections.push({
            id: `${moduleId}-section-${sectionNumber}`,
            title: 'Introduction',
            content: introText,
            sectionNumber,
          });
        }
        introContent = [];
        beforeFirstSection = false;
      }

      // Save previous section
      if (currentSection) {
        currentSection.content = currentContent.join('\n').trim();
        sections.push(currentSection);
      }

      // Start new section
      beforeFirstSection = false;
      sectionNumber++;
      const title = sectionMatch[1].trim();
      currentSection = {
        id: `${moduleId}-section-${sectionNumber}`,
        title,
        content: '',
        sectionNumber,
      };
      currentContent = [];
      continue;
    }

    // Skip the main H1 title
    if (line.match(/^#\s+(.+)$/)) {
      continue;
    }

    // Capture content before first section as intro
    if (beforeFirstSection && !inCodeBlock && line.trim()) {
      introContent.push(line);
    }

    // Add content to current section
    if (currentSection && !inCodeBlock) {
      currentContent.push(line);
    }
  }

  // Save last section
  if (currentSection) {
    currentSection.content = currentContent.join('\n').trim();
    sections.push(currentSection);
  }

  return sections;
};

// Parse task from task block
const parseTask = (taskContent: string, moduleId: string, sectionId: string): Task | null => {
  try {
    const lines = taskContent.split('\n');
    let title = '';
    let description = '';
    let xpReward = 10;

    lines.forEach(line => {
      const trimmed = line.trim();
      if (trimmed.startsWith('title:')) {
        title = trimmed.substring(6).trim();
      } else if (trimmed.startsWith('description:')) {
        description = trimmed.substring(12).trim();
      } else if (trimmed.startsWith('xp:')) {
        xpReward = parseInt(trimmed.substring(3).trim()) || 10;
      }
    });

    if (!title) return null;

    // Create deterministic ID from title (so it persists across page loads)
    const taskSlug = slugify(title);

    return {
      id: `${sectionId}-task-${taskSlug}`,
      title,
      description,
      xpReward,
    };
  } catch (error) {
    console.error('Error parsing task:', error);
    return null;
  }
};

// Parse quiz from quiz block
const parseQuiz = (quizContent: string, sectionId: string): SectionQuiz | null => {
  try {
    const lines = quizContent.split('\n');
    let title = 'Section Quiz';
    const questions: QuizQuestion[] = [];
    let currentQuestion: Partial<QuizQuestion> | null = null;
    let inQuestions = false;

    lines.forEach(line => {
      const trimmed = line.trim();

      if (trimmed.startsWith('title:')) {
        title = trimmed.substring(6).trim();
      } else if (trimmed === 'questions:') {
        inQuestions = true;
      } else if (inQuestions && trimmed.startsWith('- question:')) {
        // Save previous question
        if (currentQuestion && currentQuestion.question && currentQuestion.options) {
          questions.push({
            id: `${sectionId}-q${questions.length + 1}`,
            question: currentQuestion.question,
            options: currentQuestion.options,
            correctAnswer: currentQuestion.correctAnswer || 0,
            explanation: currentQuestion.explanation,
          });
        }
        // Start new question
        currentQuestion = {
          question: trimmed.substring(11).trim(),
          options: [],
          correctAnswer: 0,
        };
      } else if (currentQuestion && trimmed.startsWith('options:')) {
        const optionsStr = trimmed.substring(8).trim();
        // Parse array format: [A, B, C, D]
        const match = optionsStr.match(/\[(.*)\]/);
        if (match) {
          currentQuestion.options = match[1].split(',').map(o => o.trim());
        }
      } else if (currentQuestion && trimmed.startsWith('correct:')) {
        currentQuestion.correctAnswer = parseInt(trimmed.substring(8).trim()) || 0;
      } else if (currentQuestion && trimmed.startsWith('explanation:')) {
        currentQuestion.explanation = trimmed.substring(12).trim();
      }
    });

    // Save last question
    if (currentQuestion && currentQuestion.question && currentQuestion.options) {
      questions.push({
        id: `${sectionId}-q${questions.length + 1}`,
        question: currentQuestion.question,
        options: currentQuestion.options,
        correctAnswer: currentQuestion.correctAnswer || 0,
        explanation: currentQuestion.explanation,
      });
    }

    if (questions.length === 0) return null;

    return {
      id: `${sectionId}-quiz`,
      sectionId,
      title,
      questions,
    };
  } catch (error) {
    console.error('Error parsing quiz:', error);
    return null;
  }
};
