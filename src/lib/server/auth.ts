/**
 * src/lib/server/auth.ts
 * Autentikasi & Otorisasi Server
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { getSupabaseServerClient } from './supabase-server';
import { supabaseAdmin } from './supabase-admin';
import { UserRole } from './state-machine';
import { tentukanPeranDariEmail } from './peran-khusus';

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

    // Verifikasi peran khusus jika email cocok dengan whitelist / kode unik juri
    const peranKhusus = tentukanPeranDariEmail(user.email);
    let roleDefinitif: UserRole = (profile?.role as UserRole) || 'warga';

    if (peranKhusus !== 'warga' && roleDefinitif !== peranKhusus) {
      roleDefinitif = peranKhusus;
      // Sinkronkan ke database profiles agar konsisten
      void supabaseAdmin
        .from('profiles')
        .update({ role: peranKhusus, updated_at: new Date().toISOString() })
        .eq('id', user.id);
    }

    return {
      userId: user.id,
      role: roleDefinitif,
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

