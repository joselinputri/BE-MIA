/**
 * src/app/api/admin/laporan/[id]/route.ts
 * Endpoint Moderasi & Penghapusan Laporan Spam/Ilegal oleh Administrator
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { dapatkanKonteksAuth } from '@/lib/server/auth';
import { isSupabaseConfigured, supabaseAdmin } from '@/lib/server/supabase-admin';

export async function DELETE(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    if (!isSupabaseConfigured()) {
      return apiError('SERVICE_UNAVAILABLE', 'Layanan belum dikonfigurasi.');
    }

    const authHeader = req.headers.get('authorization') || undefined;
    const auth = await dapatkanKonteksAuth(authHeader);

    if (!auth.isAuthenticated || auth.role !== 'admin') {
      return apiError('FORBIDDEN', 'Hanya administrator yang berhak menghapus laporan aduan');
    }

    const { id: laporanId } = await params;

    // Ambil data laporan sebelum dihapus untuk pencatatan audit log
    const { data: laporan, error: errCari } = await supabaseAdmin
      .from('laporan')
      .select('id, kode_lacak, judul, penanda')
      .eq('id', laporanId)
      .single();

    if (errCari || !laporan) {
      return apiError('NOT_FOUND', 'Laporan tidak ditemukan atau sudah dihapus');
    }

    // Hapus data berelasi jika ada (konfirmasi, history, dukung)
    await supabaseAdmin.from('konfirmasi_pelapor').delete().eq('laporan_id', laporanId);
    await supabaseAdmin.from('status_history').delete().eq('laporan_id', laporanId);
    await supabaseAdmin.from('dukungan_laporan').delete().eq('laporan_id', laporanId);

    // Hapus laporan utama
    const { error: errHapus } = await supabaseAdmin
      .from('laporan')
      .delete()
      .eq('id', laporanId);

    if (errHapus) {
      return apiError('INTERNAL_ERROR', 'Gagal menghapus laporan dari basis data');
    }

    // Catat log moderasi
    try {
      await supabaseAdmin.from('audit_logs').insert({
        admin_id: auth.userId,
        aksi: 'hapus_laporan_spam',
        target: laporan.kode_lacak,
        detail: {
          judul: laporan.judul,
          penanda: laporan.penanda,
          alasan: 'Penghapusan laporan spam / tidak pantas oleh admin',
        },
      });
    } catch {
      // Abaikan jika tabel audit_logs belum siap
    }

    return apiSukses({
      pesan: `Laporan #${laporan.kode_lacak} berhasil dihapus permanen oleh Administrator.`,
    });
  } catch (err: any) {
    console.error('[admin/laporan/delete] Error:', err?.message || err);
    return apiError('INTERNAL_ERROR', 'Terjadi kesalahan sistem saat menghapus laporan');
  }
}

export async function PATCH(
  req: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    if (!isSupabaseConfigured()) {
      return apiError('SERVICE_UNAVAILABLE', 'Layanan belum dikonfigurasi.');
    }

    const authHeader = req.headers.get('authorization') || undefined;
    const auth = await dapatkanKonteksAuth(authHeader);

    if (!auth.isAuthenticated || auth.role !== 'admin') {
      return apiError('FORBIDDEN', 'Hanya administrator yang berhak memoderasi laporan');
    }

    const { id: laporanId } = await params;
    const body = await req.json().catch(() => ({}));
    const aksi = body.aksi; // 'verifikasi_sah' | 'tolak_spam'

    if (aksi === 'verifikasi_sah') {
      // Hapus penanda spam/verifikasi tambahan
      await supabaseAdmin
        .from('laporan')
        .update({
          penanda: [],
          updated_at: new Date().toISOString(),
        })
        .eq('id', laporanId);

      return apiSukses({ pesan: 'Laporan telah diverifikasi sah sebagai aduan publik.' });
    }

    if (aksi === 'tolak_spam') {
      await supabaseAdmin
        .from('laporan')
        .update({
          status: 'ditolak',
          updated_at: new Date().toISOString(),
        })
        .eq('id', laporanId);

      await supabaseAdmin.from('status_history').insert({
        laporan_id: laporanId,
        status_dari: 'masuk',
        status_ke: 'ditolak',
        catatan: body.alasan || 'Laporan ditolak oleh Admin: Bukan fasilitas publik / terindikasi spam.',
      });

      return apiSukses({ pesan: 'Laporan ditolak sebagai spam/komersial.' });
    }

    return apiError('VALIDATION_ERROR', 'Aksi moderasi tidak valid');
  } catch (err: any) {
    console.error('[admin/laporan/patch] Error:', err?.message || err);
    return apiError('INTERNAL_ERROR', 'Terjadi kesalahan saat memoderasi laporan');
  }
}
