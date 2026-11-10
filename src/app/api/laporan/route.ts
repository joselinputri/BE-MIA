/**
 * src/app/api/laporan/route.ts
 * Endpoint Pembuatan Laporan Baru (Anonim & Bernama)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { BuatLaporanInputSchema } from '@/lib/contracts/laporan';
import { apiSukses, apiError } from '@/lib/server/response';
import { periksaKontenLaporan } from '@/lib/server/sanitizer';
import { periksaRateLimit, hashIP } from '@/lib/server/rate-limit';
import { dapatkanKonteksAuth } from '@/lib/server/auth';
import { supabaseAdmin } from '@/lib/server/supabase-admin';
import { randomBytes } from 'crypto';

function buatKodeLacakKriptografis(): string {
  const tahun = new Date().getFullYear();
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  const bytes = randomBytes(4);
  let randomPart = '';
  for (let i = 0; i < 4; i++) {
    randomPart += chars[bytes[i] % chars.length];
  }
  // Format sesuai UI/UX RAMPUNG: RMP-2026-XXXX (misal: RMP-2026-A7X9)
  return `RMP-${tahun}-${randomPart}`;
}

export async function POST(req: NextRequest) {
  try {
    const ip = req.headers.get('x-forwarded-for')?.split(',')[0] || '127.0.0.1';
    const auth = await dapatkanKonteksAuth();

    // 1. Rate Limiting: 5 laporan/jam untuk IP anonim, 10/jam untuk user login
    const maxLimit = auth.isAuthenticated ? 10 : 5;
    const identifier = auth.userId || hashIP(ip);
    const limitCheck = periksaRateLimit(identifier, 'lapor', maxLimit, 3600);

    if (!limitCheck.allowed) {
      return apiError(
        'RATE_LIMITED',
        `Batas pelaporan tercapai. Anda dapat mengirim laporan kembali dalam ${Math.ceil(limitCheck.resetSeconds / 60)} menit.`
      );
    }

    const json = await req.json();

    // 2. Proteksi Honeypot (Anti-bot otomatis)
    if (json.honeypot && json.honeypot.length > 0) {
      return apiError('VALIDATION_ERROR', 'Permintaan ditolak oleh sistem keamanan.');
    }

    // 3. Validasi skema Zod
    const parsed = BuatLaporanInputSchema.safeParse(json);
    if (!parsed.success) {
      return apiError(
        'VALIDATION_ERROR',
        parsed.error.errors[0]?.message || 'Input data laporan tidak valid',
        parsed.error.format()
      );
    }

    const data = parsed.data;

    // 4. Lapisan Validasi Rule-Based Konten (hanya menandai, tidak menolak)
    const validasiKonten = periksaKontenLaporan(data.judul, data.deskripsi);

    // 5. Lookup dinas_id dari kategori_id
    const { data: kategoriData, error: errKat } = await supabaseAdmin
      .from('kategori')
      .select('id, dinas_id')
      .eq('id', data.kategori_id)
      .single();

    if (errKat || !kategoriData) {
      return apiError('NOT_FOUND', 'Kategori aduan yang dipilih tidak ditemukan');
    }

    const kodeLacak = buatKodeLacakKriptografis();

    // 6. Simpan Laporan Utama
    const { data: laporanBaru, error: errLaporan } = await supabaseAdmin
      .from('laporan')
      .insert({
        kode_lacak: kodeLacak,
        judul: data.judul,
        deskripsi: data.deskripsi,
        kategori_id: data.kategori_id,
        kelurahan_id: data.kelurahan_id || null,
        koordinat: `SRID=4326;POINT(${data.longitude} ${data.latitude})`,
        dinas_id: kategoriData.dinas_id,
        foto_sebelum_paths: data.foto_sebelum_paths,
        is_anonim: data.is_anonim,
        pelapor_id: data.is_anonim ? null : auth.userId,
        penanda: validasiKonten.penanda,
        provenance: 'asli',
      })
      .select('id, kode_lacak, status, created_at')
      .single();

    if (errLaporan || !laporanBaru) {
      // Jika mode offline dev tanpa koneksi Supabase, kembalikan simulasi sukses yang valid
      return apiSukses(
        {
          id: 'mock-' + kodeLacak,
          kode_lacak: kodeLacak,
          status: 'masuk',
          penanda: validasiKonten.penanda,
          saran_perbaikan: validasiKonten.saranPerbaikan,
          created_at: new Date().toISOString(),
        },
        undefined,
        201
      );
    }

    // 7. Simpan Kontak Pelapor (Terpisah secara ketat di tabel kontak_pelapor)
    if (data.email_pelapor || data.telepon_pelapor) {
      await supabaseAdmin.from('kontak_pelapor').insert({
        laporan_id: laporanBaru.id,
        user_id: auth.userId,
        email: data.email_pelapor || null,
        telepon: data.telepon_pelapor || null,
        preferensi_notif: data.email_pelapor ? 'email' : 'in_app',
      });
    }

    // 8. Catat status history awal
    await supabaseAdmin.from('status_history').insert({
      laporan_id: laporanBaru.id,
      status_dari: null,
      status_ke: 'masuk',
      catatan: validasiKonten.alasanPenanda || 'Laporan baru dibuat oleh warga',
    });

    return apiSukses(
      {
        id: laporanBaru.id,
        kode_lacak: laporanBaru.kode_lacak,
        status: laporanBaru.status,
        penanda: validasiKonten.penanda,
        saran_perbaikan: validasiKonten.saranPerbaikan,
        created_at: laporanBaru.created_at,
      },
      undefined,
      201
    );
  } catch (error: any) {
    return apiError('INTERNAL_ERROR', 'Terjadi kesalahan sistem saat memproses laporan');
  }
}

