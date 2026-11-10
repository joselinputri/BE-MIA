/**
 * src/app/api/referensi/sumber-data/route.ts
 * Endpoint Metadata Sumber Data & Provenance ("Dari Mana Data Ini?")
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(req: NextRequest) {
  try {
    const { data, error } = await supabaseAdmin
      .from('sumber_data')
      .select('*')
      .order('nama', { ascending: true });

    const fallback = [
      {
        nama: 'Dispendukcapil Kota Surakarta - Data Agregat Kependudukan',
        url: 'https://dispendukcapil.surakarta.go.id',
        tahun_data: 2023,
        lisensi: 'Data Terbuka Pemerintah Kota Surakarta',
        provenance: 'agregat_resmi',
        catatan_pengolahan: 'Data agregat resmi jumlah penduduk per kelurahan Semester 2 Tahun 2023',
      },
      {
        nama: 'Portal Data Jawa Tengah - Rekap Aduan ULAS',
        url: 'https://data.jatengprov.go.id',
        tahun_data: 2023,
        lisensi: 'Open Data Pemerintah Provinsi Jawa Tengah',
        provenance: 'agregat_resmi',
        catatan_pengolahan: 'Rekap volume dan proporsi aduan ULAS per OPD untuk kalibrasi simulasi',
      },
      {
        nama: 'BPS Kota Surakarta & Kemendagri - Batas Wilayah Administrasi',
        url: 'https://surakartakota.bps.go.id',
        tahun_data: 2023,
        lisensi: 'Publikasi Resmi BPS & Kemendagri',
        provenance: 'asli',
        catatan_pengolahan: 'Batas 5 kecamatan dan 54 kelurahan definitif di Kota Surakarta',
      },
    ];

    return apiSukses(data && data.length > 0 ? data : fallback);
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal memuat metadata sumber data');
  }
}

