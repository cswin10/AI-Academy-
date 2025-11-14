import fs from 'fs';
import path from 'path';
import matter from 'gray-matter';
import { ModuleMetadata, ModuleContent, Section, ChecklistItem } from './types';

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

    return {
      metadata,
      content,
      sections,
      checklistItems,
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
