/**
 * src/lib/server/auth.ts
 * Autentikasi & Otorisasi Server
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { getSupabaseServerClient } from './supabase-server';
import { supabaseAdmin } from './supabase-admin';
import { UserRole } from './state-machine';

export interface AuthContext {
  userId: string | null;
  role: UserRole;
  dinasId: string | null;
  isAuthenticated: boolean;
}

export async function dapatkanKonteksAuth(authHeader?: string): Promise<AuthContext> {
  try {
    const supabase = await getSupabaseServerClient(authHeader);

    const {
      data: { user },
      error: userError,
    } = await supabase.auth.getUser();

    if (userError || !user) {
      return {
        userId: null,
        role: 'warga',
        dinasId: null,
        isAuthenticated: false,
      };
    }

    // Ambil role definitif dari database profiles
    const { data: profile } = await supabaseAdmin
      .from('profiles')
      .select('role, dinas_id')
      .eq('id', user.id)
      .single();

    return {
      userId: user.id,
      role: (profile?.role as UserRole) || 'warga',
      dinasId: profile?.dinas_id || null,
      isAuthenticated: true,
    };
  } catch (err) {
    return {
      userId: null,
      role: 'warga',
      dinasId: null,
      isAuthenticated: false,
    };
  }
}

