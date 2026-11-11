/**
 * src/app/api/auth/switch-role/route.ts
 * Endpoint Mandiri Penggantian Peran (Warga / Petugas / Admin) untuk Evaluasi & Pengujian
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { getSupabaseServerClient } from '@/lib/server/supabase-server';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function POST(req: NextRequest) {
  try {
    const authHeader = req.headers.get('authorization') || undefined;
    const supabase = await getSupabaseServerClient(authHeader);
    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser();

    if (authError || !user) {
      return apiError('UNAUTHORIZED', 'Silakan masuk/login terlebih dahulu untuk beralih peran.');
    }

    const body = await req.json().catch(() => ({}));
    const roleBaru = body.role;
    const dinasSingkatan = body.dinas || 'DPUPR';

    if (!['warga', 'petugas', 'admin'].includes(roleBaru)) {
      return apiError('VALIDATION_ERROR', 'Pilihan peran tidak valid: warga, petugas, admin');
    }

    let dinasId: string | null = null;
    if (roleBaru === 'petugas') {
      const { data: dinas } = await supabaseAdmin
        .from('dinas')
        .select('id')
        .eq('singkatan', dinasSingkatan)
        .single();

      dinasId = dinas?.id || 'd1111111-0000-0000-0000-000000000001';
    }

    const { error: errUpdate } = await supabaseAdmin
      .from('profiles')
      .update({
        role: roleBaru,
        dinas_id: dinasId,
        updated_at: new Date().toISOString(),
      })
      .eq('id', user.id);

    if (errUpdate) {
      console.error('[switch-role] Update error:', errUpdate.message);
      return apiError('INTERNAL_ERROR', `Gagal mengubah peran: ${errUpdate.message}`);
    }

    return apiSukses({
      role: roleBaru,
      dinas_id: dinasId,
      pesan: `Peran berhasil diubah menjadi ${roleBaru.toUpperCase()}${roleBaru === 'petugas' ? ` (${dinasSingkatan})` : ''}`,
    });
  } catch (err: any) {
    console.error('[switch-role] Error:', err);
    return apiError('INTERNAL_ERROR', 'Gagal memproses pergantian peran');
  }
}

