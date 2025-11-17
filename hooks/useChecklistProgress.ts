import { useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';
import { useSupabase } from './useSupabase';

export interface ChecklistProgress {
  id: string;
  user_id: string;
  module_id: string;
  checklist_item_id: string;
  completed_at: string;
  xp_awarded: number;
}

export function useChecklistProgress(moduleId?: string) {
  const { user } = useSupabase();
  const [completed, setCompleted] = useState<Set<string>>(new Set());
  const [loading, setLoading] = useState(true);
  const [toggling, setToggling] = useState<Set<string>>(new Set()); // Prevent rapid-fire clicks
  const supabase = createClient();

  useEffect(() => {
    if (!user) {
      setCompleted(new Set());
      setLoading(false);
      return;
    }

    async function fetchProgress() {
      try {
        setLoading(true);
        let query = supabase
          .from('checklist_progress')
          .select('checklist_item_id')
          .eq('user_id', user!.id);

        if (moduleId) {
          query = query.eq('module_id', moduleId);
        }

        const { data, error } = await query;

        if (error) throw error;
        setCompleted(new Set(data?.map(d => d.checklist_item_id) || []));
      } catch (err) {
        console.error('Error fetching checklist progress:', err);
      } finally {
        setLoading(false);
      }
    }

    fetchProgress();

    // Subscribe to changes
    const subscription = supabase
      .channel(`checklist_progress:${user!.id}`)
      .on(
        'postgres_changes',
        {
          event: '*',
          schema: 'public',
          table: 'checklist_progress',
          filter: `user_id=eq.${user!.id}`,
        },
        () => {
          fetchProgress();
        }
      )
      .subscribe();

    return () => {
      subscription.unsubscribe();
    };
  }, [user, moduleId, supabase]);

  const toggleItem = async (moduleId: string, itemId: string) => {
    if (!user) return;

    // Prevent rapid-fire clicks on same item
    if (toggling.has(itemId)) {
      console.log('Already processing this item, please wait...');
      return;
    }

    const isCompleted = completed.has(itemId);

    // Mark as toggling
    setToggling(prev => new Set(prev).add(itemId));

    try {
      if (isCompleted) {
        // Uncomplete
        const { error } = await supabase
          .from('checklist_progress')
          .delete()
          .eq('user_id', user.id)
          .eq('module_id', moduleId)
          .eq('checklist_item_id', itemId);

        if (error) {
          console.error('Error uncompleting item:', error);
          return;
        }

        setCompleted(prev => {
          const next = new Set(prev);
          next.delete(itemId);
          return next;
        });
      } else {
        // Complete
        const { error } = await supabase.rpc('complete_checklist_item', {
          p_user_id: user.id,
          p_module_id: moduleId,
          p_checklist_item_id: itemId,
        });

        if (error) {
          console.error('Error completing item:', error);
          throw error;
        }

        setCompleted(prev => new Set(prev).add(itemId));
      }
    } catch (err) {
      console.error('Error toggling item:', err);
    } finally {
      // Remove from toggling set after a delay
      setTimeout(() => {
        setToggling(prev => {
          const next = new Set(prev);
          next.delete(itemId);
          return next;
        });
      }, 500);
    }
  };

  return {
    completed,
    loading,
    toggleItem,
    isCompleted: (itemId: string) => completed.has(itemId),
  };
}
