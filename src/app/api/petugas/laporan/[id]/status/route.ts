/**
 * src/app/api/petugas/laporan/[id]/status/route.ts
 * Endpoint Perubahan Status Laporan oleh Petugas Berwenang (State Machine)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { UbahStatusInputSchema } from '@/lib/contracts/petugas';
import { apiSukses, apiError } from '@/lib/server/response';
import { dapatkanKonteksAuth } from '@/lib/server/auth';
import { validasiTransisiStatus } from '@/lib/server/state-machine';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function PATCH(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { id: laporanId } = await params;
    const authHeader = req.headers.get('authorization') || undefined;
    const auth = await dapatkanKonteksAuth(authHeader);

    if (!auth.isAuthenticated || (auth.role !== 'petugas' && auth.role !== 'admin')) {
      return apiError('FORBIDDEN', 'Hanya petugas atau admin yang berhak mengubah status tiket');
    }

    const json = await req.json();
    const parsed = UbahStatusInputSchema.safeParse(json);
    if (!parsed.success) {
      return apiError('VALIDATION_ERROR', parsed.error.issues?.[0]?.message || 'Input tidak valid');
    }

    const { status_ke, catatan, foto_sesudah_paths } = parsed.data;

    // Ambil laporan saat ini
    const { data: laporan, error: errLaporan } = await supabaseAdmin
      .from('laporan')
      .select('id, status, dinas_id, kode_lacak')
      .eq('id', laporanId)
      .single();

    if (errLaporan || !laporan) {
      return apiError('NOT_FOUND', 'Laporan tidak ditemukan');
    }

    // Otorisasi dinas: Petugas hanya dapat menangani laporan dinasnya sendiri (jika laporan telah ditugaskan ke dinas)
    if (auth.role === 'petugas' && auth.dinasId && laporan.dinas_id && laporan.dinas_id !== auth.dinasId) {
      return apiError(
        'FORBIDDEN',
        'Anda tidak memiliki kewenangan mengubah status laporan di luar dinas Anda.'
      );
    }

    // Validasi State Machine di server
    const cekTransisi = validasiTransisiStatus(
      laporan.status,
      status_ke,
      auth.role,
      catatan,
      foto_sesudah_paths
    );

    if (!cekTransisi.valid) {
      return apiError('INVALID_STATUS_TRANSITION', cekTransisi.pesan);
    }

    // Lakukan pembaruan status laporan
    const updatePayload: Record<string, any> = {
      status: status_ke,
      updated_at: new Date().toISOString(),
    };
    if (foto_sesudah_paths && foto_sesudah_paths.length > 0) {
      updatePayload.foto_sesudah_paths = foto_sesudah_paths;
    }

    const { error: errUpdate } = await supabaseAdmin
      .from('laporan')
      .update(updatePayload)
      .eq('id', laporanId);

    if (errUpdate) {
      console.error('[petugas/status] errUpdate:', errUpdate.message, errUpdate.details);
      return apiError('INTERNAL_ERROR', `Gagal memperbarui status laporan: ${errUpdate.message}`);
    }

    // Catat ke status_history (non-blocking)
    try {
      await supabaseAdmin.from('status_history').insert({
        laporan_id: laporanId,
        status_dari: laporan.status,
        status_ke,
        catatan: catatan || null,
        diubah_oleh: auth.userId,
      });
    } catch (e: any) {
      console.warn('[petugas/status] Gagal mencatat status_history:', e?.message);
    }

    // Catat ke audit_log (non-blocking)
    try {
      await supabaseAdmin.from('audit_log').insert({
        user_id: auth.userId,
        aksi: 'ubah_status',
        tabel_target: 'laporan',
        record_id: laporanId,
        detail: {
          status_dari: laporan.status,
          status_ke,
          catatan,
          kode_lacak: laporan.kode_lacak,
        },
      });
    } catch (e: any) {
      console.warn('[petugas/status] Gagal mencatat audit_log:', e?.message);
    }

    return apiSukses({
      id: laporanId,
      status_sebelumnya: laporan.status,
      status_baru: status_ke,
      pesan: `Status laporan berhasil diperbarui menjadi "${status_ke}".`,
    });
  } catch (err: any) {
    console.error('[petugas/status] Error:', err?.message || err);
    return apiError('INTERNAL_ERROR', 'Terjadi kesalahan sistem saat memperbarui status');
  }
}

