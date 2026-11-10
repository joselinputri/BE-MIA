/**
 * src/app/api/petugas/antrean/route.ts
 * Endpoint Antrean Tiket Masuk untuk Petugas Instansi/Dinas
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { AntreanPetugasQuerySchema } from '@/lib/contracts/petugas';
import { apiSukses, apiError } from '@/lib/server/response';
import { dapatkanKonteksAuth } from '@/lib/server/auth';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(req: NextRequest) {
  try {
    const auth = await dapatkanKonteksAuth();
    if (!auth.isAuthenticated || (auth.role !== 'petugas' && auth.role !== 'admin')) {
      return apiError('UNAUTHORIZED', 'Akses khusus untuk petugas atau administrator');
    }

    const { searchParams } = new URL(req.url);
    const parsed = AntreanPetugasQuerySchema.safeParse(Object.fromEntries(searchParams.entries()));

    if (!parsed.success) {
      return apiError('VALIDATION_ERROR', 'Parameter query antrean tidak valid');
    }

    const { status, prioritas, cursor, limit } = parsed.data;

    let query = supabaseAdmin
      .from('laporan')
      .select('*, kategori:kategori_id(nama, slug, sla_hari), kelurahan:kelurahan_id(nama, kode_wilayah)')
      .order('created_at', { ascending: false })
      .limit(limit + 1);

    // Filter dinas jika petugas
    if (auth.role === 'petugas' && auth.dinasId) {
      query = query.eq('dinas_id', auth.dinasId);
    }

    if (status) {
      query = query.eq('status', status);
    } else {
      // Default antrean: tampilkan laporan aktif
      query = query.in('status', ['masuk', 'ditinjau', 'sedang_ditangani', 'dibuka_ulang']);
    }

    if (prioritas === 'perlu_verifikasi') {
      query = query.contains('penanda', ['perlu_verifikasi_tambahan']);
    }

    if (cursor) {
      query = query.lt('created_at', cursor);
    }

    const { data: records, error } = await query;

    if (error) {
      return apiSukses([]);
    }

    let hasNext = false;
    let items = records || [];
    if (items.length > limit) {
      hasNext = true;
      items = items.slice(0, limit);
    }

    const nextCursor = hasNext && items.length > 0 ? items[items.length - 1].created_at : null;

    return apiSukses(items, {
      cursor_berikutnya: nextCursor,
      sumber: [
        {
          provenance: 'asli',
          nama_sumber: 'Antrean Operasional Petugas RAMPUNG Surakarta',
          waktu_pembaruan: new Date().toISOString(),
        },
      ],
      waktu_query: new Date().toISOString(),
    });
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal memuat antrean petugas');
  }
}

