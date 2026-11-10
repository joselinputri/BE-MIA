/**
 * src/app/api/dashboard/ringkasan/route.ts
 * Endpoint Ringkasan Metrik Beranda (Papan Tanggap & KPI Utama)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { RingkasanLanding } from '@/lib/contracts/dashboard';

export async function GET(req: NextRequest) {
  try {
    const data: RingkasanLanding = {
      laporan_bulan_ini: 57,
      laporan_selesai: 49,
      persentase_selesai: 85.9,
      sedang_dikerjakan: 8,
      rata_rata_harian: 35,
      kinerja_dinas: [
        {
          singkatan: 'DPUPR',
          nama: 'Dinas Pekerjaan Umum & Penataan Ruang (DPUPR)',
          rata_hari: 1.1,
          persen_tuntas: 98.0,
        },
        {
          singkatan: 'Dishub',
          nama: 'Dinas Perhubungan (Dishub)',
          rata_hari: 1.3,
          persen_tuntas: 96.5,
        },
        {
          singkatan: 'DLH',
          nama: 'Dinas Lingkungan Hidup (DLH)',
          rata_hari: 1.6,
          persen_tuntas: 94.0,
        },
        {
          singkatan: 'Satpol PP',
          nama: 'Satuan Polisi Pamong Praja (Satpol PP)',
          rata_hari: 1.8,
          persen_tuntas: 89.2,
        },
      ],
    };

    return apiSukses(data, {
      sumber: [
        {
          provenance: 'simulasi_terkalibrasi',
          nama_sumber: 'Papan Tanggap RAMPUNG Surakarta 2026',
          waktu_pembaruan: new Date().toISOString(),
        },
      ],
      waktu_query: new Date().toISOString(),
    });
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal memuat ringkasan dashboard');
  }
}

