/**
 * src/app/api/peta/laporan/route.ts
 * Endpoint Titik Sebaran Peta Interaktif (Format GeoJSON FeatureCollection untuk Leaflet)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);
    const kategori = searchParams.get('kategori');
    const kecamatan = searchParams.get('kecamatan');
    const status = searchParams.get('status');

    let query = supabaseAdmin
      .from('laporan_publik')
      .select('id, kode_lacak, judul, kategori, kategori_slug, kelurahan, kecamatan, latitude, longitude, status, provenance, is_simulasi, created_at')
      .limit(300);

    if (kategori) query = query.eq('kategori_slug', kategori);
    if (kecamatan) query = query.eq('kecamatan_kode', kecamatan);
    if (status) query = query.eq('status', status);

    const { data: records, error } = await query;

    const items = records || [];

    // Konversi ke GeoJSON FeatureCollection
    const featureCollection = {
      type: 'FeatureCollection',
      features: items.map((item: any) => ({
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [item.longitude, item.latitude],
        },
        properties: {
          id: item.id,
          kode_lacak: item.kode_lacak,
          judul: item.judul,
          kategori: item.kategori,
          kategori_slug: item.kategori_slug,
          kelurahan: item.kelurahan,
          kecamatan: item.kecamatan,
          status: item.status,
          is_simulasi: item.is_simulasi,
          provenance: item.provenance,
          created_at: item.created_at,
        },
      })),
    };

    return apiSukses(featureCollection, {
      sumber: [
        {
          provenance: 'simulasi_terkalibrasi',
          nama_sumber: 'Peta Geospasial PostGIS RAMPUNG Surakarta',
          waktu_pembaruan: new Date().toISOString(),
        },
      ],
      waktu_query: new Date().toISOString(),
    });
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal memuat data sebaran peta');
  }
}

