/**
 * src/app/api/laporan/[id]/dukungan/route.ts
 * Endpoint Upvote / Dukung Laporan Serupa
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { dapatkanKonteksAuth } from '@/lib/server/auth';
import { hashIP, periksaRateLimit } from '@/lib/server/rate-limit';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function POST(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const laporanId = params.id;
    const ip = req.headers.get('x-forwarded-for')?.split(',')[0] || '127.0.0.1';
    const auth = await dapatkanKonteksAuth();

    // Rate limit pemberian dukungan: maks 20 dukungan / jam per IP/user
    const identifier = auth.userId || hashIP(ip);
    const limitCheck = periksaRateLimit(identifier, 'dukung', 20, 3600);
    if (!limitCheck.allowed) {
      return apiError('RATE_LIMITED', 'Terlalu banyak memberikan dukungan dalam waktu singkat.');
    }

    const ipHash = hashIP(ip);

    // Cek apakah laporan valid
    const { data: laporan } = await supabaseAdmin
      .from('laporan')
      .select('id, status')
      .eq('id', laporanId)
      .single();

    if (!laporan) {
      return apiError('NOT_FOUND', 'Laporan yang ingin didukung tidak ditemukan');
    }

    // Insert dukungan
    const { error } = await supabaseAdmin.from('dukungan_laporan').insert({
      laporan_id: laporanId,
      user_id: auth.userId,
      ip_hash: auth.userId ? null : ipHash,
    });

    if (error) {
      if (error.code === '23505') {
        // Unique violation
        return apiError('CONFLICT', 'Anda sudah pernah memberikan dukungan pada laporan ini.');
      }
      return apiError('INTERNAL_ERROR', 'Gagal mencatat dukungan.');
    }

    return apiSukses({
      laporan_id: laporanId,
      pesan: 'Dukungan Anda berhasil dicatat. Terima kasih telah berpartisipasi!',
    });
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Terjadi kesalahan sistem saat memproses dukungan');
  }
}

