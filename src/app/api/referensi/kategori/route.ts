/**
 * src/app/api/referensi/kategori/route.ts
 * Endpoint Referensi Kategori Laporan & SLA Penanganan
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(req: NextRequest) {
  try {
    const { data, error } = await supabaseAdmin
      .from('kategori')
      .select('id, nama, slug, ikon, sla_hari, is_aktif, dinas:dinas_id(nama, singkatan)')
      .eq('is_aktif', true);

    const fallback = [
      { id: 'c1111111-0000-0000-0000-000000000001', nama: 'Penambalan Aspal', slug: 'penambalan-aspal', ikon: 'hammer', sla_hari: 7, dinas: { nama: 'Dinas Pekerjaan Umum dan Penataan Ruang', singkatan: 'DPUPR' } },
      { id: 'c2222222-0000-0000-0000-000000000002', nama: 'Lampu PJU', slug: 'lampu-pju', ikon: 'lightbulb', sla_hari: 5, dinas: { nama: 'Dinas Perhubungan', singkatan: 'Dishub' } },
      { id: 'c3333333-0000-0000-0000-000000000003', nama: 'Drainase & Saluran Air', slug: 'drainase', ikon: 'droplets', sla_hari: 14, dinas: { nama: 'Dinas Pekerjaan Umum dan Penataan Ruang', singkatan: 'DPUPR' } },
      { id: 'c4444444-0000-0000-0000-000000000004', nama: 'Sampah & Lingkungan', slug: 'sampah-lingkungan', ikon: 'trash-2', sla_hari: 3, dinas: { nama: 'Dinas Lingkungan Hidup', singkatan: 'DLH' } },
      { id: 'c5555555-0000-0000-0000-000000000005', nama: 'Fasilitas Difabel', slug: 'fasilitas-difabel', ikon: 'accessibility', sla_hari: 14, dinas: { nama: 'Dinas Pekerjaan Umum dan Penataan Ruang', singkatan: 'DPUPR' } },
      { id: 'c6666666-0000-0000-0000-000000000006', nama: 'Rambu & Halte', slug: 'rambu-halte', ikon: 'signpost', sla_hari: 7, dinas: { nama: 'Dinas Perhubungan', singkatan: 'Dishub' } },
    ];

    return apiSukses(data && data.length > 0 ? data : fallback);
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal memuat kategori aduan');
  }
}

