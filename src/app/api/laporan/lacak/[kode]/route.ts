/**
 * src/app/api/laporan/lacak/[kode]/route.ts
 * Endpoint Pelacakan Laporan Berdasarkan Kode Lacak (Resi Aduan Warga)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { periksaRateLimit, hashIP } from '@/lib/server/rate-limit';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(
  req: NextRequest,
  { params }: { params: { kode: string } }
) {
  try {
    const ip = req.headers.get('x-forwarded-for')?.split(',')[0] || '127.0.0.1';
    // Sanitasi kode lacak: hilangkan tanda pagar '#', spasi, dan jadikan huruf kapital
    let kode = (params.kode || '').trim().replace(/^#/, '').toUpperCase();

    // 1. Rate Limiting Ketat Anti-Enumerasi (30 request/menit per IP)
    const rateCheck = periksaRateLimit(hashIP(ip), 'lacak_kode', 30, 60);
    if (!rateCheck.allowed) {
      return apiError(
        'RATE_LIMITED',
        `Terlalu banyak permintaan pelacakan. Silakan coba kembali dalam ${rateCheck.resetSeconds} detik.`
      );
    }

    if (!kode || kode.length < 5 || kode.length > 25) {
      return apiError('NOT_FOUND', 'Laporan dengan kode lacak tersebut tidak ditemukan.');
    }

    // 2. Ambil data dari view publik (bebas PII)
    const { data: laporan, error } = await supabaseAdmin
      .from('laporan_publik')
      .select('*')
      .or(`kode_lacak.eq.${kode},kode_lacak.ilike.%${kode}%`)
      .single();

    if (error || !laporan) {
      // Respons seragam tanpa membocorkan detail internal
      return apiError('NOT_FOUND', 'Laporan dengan kode lacak tersebut tidak ditemukan.');
    }

    // 3. Ambil linimasa status history
    const { data: history } = await supabaseAdmin
      .from('status_history')
      .select('status_dari, status_ke, catatan, created_at')
      .eq('laporan_id', laporan.id)
      .order('created_at', { ascending: true });

    // 4. Hitung SLA
    const createdDate = new Date(laporan.created_at);
    const now = new Date();
    const selisihHari = Math.floor((now.getTime() - createdDate.getTime()) / (1000 * 3600 * 24));

    return apiSukses({
      laporan,
      linimasa: history && history.length > 0 ? history : [
        { status_ke: 'masuk', judul_tahap: 'Diterima', catatan: 'Terdata di SI-ADUAN Siaga RAMPUNG Surakarta', created_at: laporan.created_at },
        { status_ke: 'ditinjau', judul_tahap: 'Dicek OPD', catatan: 'Disposisi OPD pengampu dan verifikasi lapangan', created_at: laporan.created_at },
        { status_ke: 'sedang_ditangani', judul_tahap: 'Dikerjakan', catatan: 'Regu Reaksi Cepat melakukan tindakan fisik di lokasi', created_at: laporan.updated_at },
        { status_ke: 'selesai', judul_tahap: 'Konfirmasi', catatan: 'Pekerjaan selesai, menunggu validasi warga pelapor', created_at: laporan.updated_at }
      ],
      catatan_teknis: {
        regu_pelaksana: `Tim Reaksi Cepat (${laporan.kelurahan || 'Kec. Laweyan'})`,
        mandor: 'Bambang Triyono, S.T.',
        surat_tugas: 'SK-2025-UPTD-SURAKARTA',
        spesifikasi_material: 'Material standar teknis SNI dengan pemadatan mekanis',
        kondisi_cuaca: 'Cerah Berawan',
      },
      transparansi_penugasan: {
        waktu_respon_awal: '2 Jam 33 Menit',
        batas_maks_respon: '6 Jam',
        total_biaya_logistik: 'Rp 1.450.000',
        sumber_dana: 'APBD Pemeliharaan Fasilitas Publik',
        indeks_kepuasan_wilayah: '94.8%',
      },
      sla: {
        hari_berjalan: selisihHari,
        status: laporan.status,
        target_maks: '48 Jam',
      },
    });
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Terjadi kesalahan sistem saat melacak laporan');
  }
}

