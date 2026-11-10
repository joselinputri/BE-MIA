/**
 * src/app/api/laporan/[id]/konfirmasi/route.ts
 * Endpoint Konfirmasi Hasil Sebelum-Sesudah oleh Pelapor Warga
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { KonfirmasiInputSchema } from '@/lib/contracts/konfirmasi';
import { apiSukses, apiError } from '@/lib/server/response';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function POST(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const laporanId = params.id;
    const json = await req.json();

    const parsed = KonfirmasiInputSchema.safeParse(json);
    if (!parsed.success) {
      return apiError('VALIDATION_ERROR', parsed.error.errors[0]?.message || 'Input tidak valid');
    }

    const { jawaban, rating, komentar, minta_buka_ulang } = parsed.data;

    // Cek status laporan harus sudah selesai
    const { data: laporan, error: errLaporan } = await supabaseAdmin
      .from('laporan')
      .select('id, status, kode_lacak')
      .eq('id', laporanId)
      .single();

    if (errLaporan || !laporan) {
      return apiError('NOT_FOUND', 'Laporan tidak ditemukan');
    }

    if (laporan.status !== 'selesai' && laporan.status !== 'dibuka_ulang') {
      return apiError(
        'INVALID_STATUS_TRANSITION',
        'Konfirmasi hasil hanya dapat dilakukan pada laporan yang berstatus selesai'
      );
    }

    // Simpan konfirmasi
    const { error: errKonfirmasi } = await supabaseAdmin
      .from('konfirmasi_pelapor')
      .upsert({
        laporan_id: laporanId,
        jawaban,
        rating: rating || (jawaban === 'puas' ? 5 : jawaban === 'biasa' ? 3 : 1),
        komentar: komentar || null,
      });

    if (errKonfirmasi) {
      return apiError('INTERNAL_ERROR', 'Gagal menyimpan konfirmasi');
    }

    // Jika pelapor memilih minta buka ulang (belum beres)
    if (minta_buka_ulang || jawaban === 'kurang_puas') {
      await supabaseAdmin
        .from('laporan')
        .update({ status: 'dibuka_ulang', updated_at: new Date().toISOString() })
        .eq('id', laporanId);

      await supabaseAdmin.from('status_history').insert({
        laporan_id: laporanId,
        status_dari: 'selesai',
        status_ke: 'dibuka_ulang',
        catatan: komentar || 'Pelapor menyatakan hasil perbaikan belum tuntas.',
      });

      return apiSukses({
        status_terbaru: 'dibuka_ulang',
        pesan: 'Konfirmasi tersimpan. Laporan telah dibuka kembali untuk ditindaklanjuti oleh petugas.',
      });
    }

    return apiSukses({
      status_terbaru: 'selesai',
      pesan: 'Terima kasih atas konfirmasi Anda. Partisipasi Anda menjaga Surakarta tetap beres!',
    });
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Terjadi kesalahan sistem saat menyimpan konfirmasi');
  }
}

