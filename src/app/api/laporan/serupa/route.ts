/**
 * src/app/api/laporan/serupa/route.ts
 * Endpoint Deteksi Laporan Serupa di Sekitar Lokasi
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { LaporanSerupaQuerySchema } from '@/lib/contracts/laporan';
import { apiSukses, apiError } from '@/lib/server/response';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);
    const rawQuery = Object.fromEntries(searchParams.entries());

    const parsed = LaporanSerupaQuerySchema.safeParse(rawQuery);
    if (!parsed.success) {
      return apiError(
        'VALIDATION_ERROR',
        parsed.error.issues?.[0]?.message || 'Parameter query tidak valid'
      );
    }

    const { kategori_id, latitude, longitude, radius_meter, maks } = parsed.data;

    const { data, error } = await supabaseAdmin.rpc('fn_laporan_serupa', {
      p_kategori_id: kategori_id,
      p_latitude: latitude,
      p_longitude: longitude,
      p_radius_meter: radius_meter,
      p_maks: maks,
    });

    if (error) {
      return apiSukses([]);
    }

    return apiSukses(data || []);
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal mendeteksi laporan serupa di sekitar lokasi');
  }
}

