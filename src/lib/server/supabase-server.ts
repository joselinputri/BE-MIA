/**
 * src/lib/server/supabase-server.ts
 * Supabase Client Konteks Request Server (Menghormati RLS Pengguna)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { createClient } from '@supabase/supabase-js';
import { headers } from 'next/headers';

export function getSupabaseServerClient() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || 'https://mock.supabase.co';
  const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || 'mock-anon-key';

  const reqHeaders = headers();
  const authHeader = reqHeaders.get('authorization') || '';

  return createClient(supabaseUrl, supabaseAnonKey, {
    auth: {
      persistSession: false,
      autoRefreshToken: false,
    },
    global: {
      headers: authHeader ? { Authorization: authHeader } : {},
    },
  });
}

