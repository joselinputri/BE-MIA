/**
 * src/lib/client/supabase.ts
 * Supabase Client-Side Helper (Browser)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 *
 * Digunakan oleh komponen FE untuk inisialisasi Supabase client di browser
 * dan helper fetch dengan token otomatis.
 */

import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || '';
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || '';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

/**
 * Fetch ke API internal dengan menyertakan Authorization header dari sesi Supabase.
 */
export async function fetchAuthed(url: string, options?: RequestInit): Promise<Response> {
  const {
    data: { session },
  } = await supabase.auth.getSession();

  const headers = new Headers(options?.headers);
  if (session?.access_token) {
    headers.set('Authorization', `Bearer ${session.access_token}`);
  }

  return fetch(url, { ...options, headers });
}

