/**
 * src/app/api/admin/users/[id]/role/route.ts
 * Endpoint Perubahan Role Pengguna oleh Administrator
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
    const targetUserId = params.id;
    const auth = await dapatkanKonteksAuth();

    if (!auth.isAuthenticated || auth.role !== 'admin') {
      return apiError('FORBIDDEN', 'Hanya administrator yang berhak mengubah role pengguna');
    }

    const json = await req.json();
    const roleBaru = json.role;
    const dinasId = json.dinas_id || null;

    if (!['warga', 'petugas', 'admin'].includes(roleBaru)) {
      return apiError('VALIDATION_ERROR', 'Role tidak valid. Pilihan: warga, petugas, admin');
    }

    if (roleBaru === 'petugas' && !dinasId) {
      return apiError('VALIDATION_ERROR', 'Penetapan role petugas wajib memilih dinas yang terkait');
    }

    // Ambil profil lama
    const { data: userLama, error: errCari } = await supabaseAdmin
      .from('profiles')
      .select('role, dinas_id')
      .eq('id', targetUserId)
      .single();

    if (errCari || !userLama) {
      return apiError('NOT_FOUND', 'Pengguna tidak ditemukan');
    }

    // Update profil
    const { error: errUpdate } = await supabaseAdmin
      .from('profiles')
      .update({
        role: roleBaru,
        dinas_id: roleBaru === 'petugas' ? dinasId : null,
        updated_at: new Date().toISOString(),
      })
      .eq('id', targetUserId);

    if (errUpdate) {
      return apiError('INTERNAL_ERROR', 'Gagal memperbarui role pengguna');
    }

    // Catat ke audit_log
    await supabaseAdmin.from('audit_log').insert({
      user_id: auth.userId,
      aksi: 'ubah_role',
      tabel_target: 'profiles',
      record_id: targetUserId,
      detail: {
        role_lama: userLama.role,
        role_baru: roleBaru,
        dinas_id: dinasId,
      },
    });

    return apiSukses({
      id: targetUserId,
      role: roleBaru,
      pesan: `Role pengguna berhasil diubah menjadi "${roleBaru}"`,
    });
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Terjadi kesalahan sistem saat memperbarui role pengguna');
  }
}

