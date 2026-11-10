/**
 * src/app/api/notifikasi/[id]/baca/route.ts
 * Endpoint Menandai Notifikasi Sudah Dibaca
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { dapatkanKonteksAuth } from '@/lib/server/auth';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function PATCH(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const notifId = params.id;
    const auth = await dapatkanKonteksAuth();

    let query = supabaseAdmin
      .from('notifikasi')
      .update({ is_dibaca: true })
      .eq('id', notifId);

    if (auth.isAuthenticated && auth.userId) {
      query = query.eq('user_id', auth.userId);
    }

    const { error } = await query;

    if (error) {
      return apiError('INTERNAL_ERROR', 'Gagal memperbarui status notifikasi');
    }

    return apiSukses({ id: notifId, is_dibaca: true });
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Terjadi kesalahan sistem saat memperbarui notifikasi');
  }
}

