/**
 * src/app/api/referensi/wilayah/route.ts
 * Endpoint Referensi 5 Kecamatan & 54 Kelurahan Kota Surakarta
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(req: NextRequest) {
  try {
    const { data: kecamatanList, error } = await supabaseAdmin
      .from('kecamatan')
      .select('id, nama, kode_wilayah, jumlah_penduduk, kelurahan:kelurahan(id, nama, kode_wilayah, jumlah_penduduk)')
      .order('kode_wilayah', { ascending: true });

    if (error || !kecamatanList || kecamatanList.length === 0) {
      // Fallback ringkas 5 kecamatan
      const fallback = [
        { kode_wilayah: '33.72.01', nama: 'Laweyan', jumlah_penduduk: 104523, kelurahan_count: 11 },
        { kode_wilayah: '33.72.02', nama: 'Serengan', jumlah_penduduk: 52310, kelurahan_count: 7 },
        { kode_wilayah: '33.72.03', nama: 'Pasar Kliwon', jumlah_penduduk: 88470, kelurahan_count: 10 },
        { kode_wilayah: '33.72.04', nama: 'Jebres', jumlah_penduduk: 151240, kelurahan_count: 11 },
        { kode_wilayah: '33.72.05', nama: 'Banjarsari', jumlah_penduduk: 191103, kelurahan_count: 15 },
      ];
      return apiSukses(fallback);
    }

    return apiSukses(kecamatanList);
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal memuat referensi wilayah Surakarta');
  }
}

