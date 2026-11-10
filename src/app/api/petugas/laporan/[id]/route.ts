/**
 * src/app/api/petugas/laporan/[id]/route.ts
 * Endpoint Detail Laporan Lengkap untuk Petugas (Termasuk Kontak & Koordinat Asli)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { dapatkanKonteksAuth } from '@/lib/server/auth';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const id = params.id;
    const auth = await dapatkanKonteksAuth();

    if (!auth.isAuthenticated || (auth.role !== 'petugas' && auth.role !== 'admin')) {
      return apiError('FORBIDDEN', 'Akses dibatasi khusus untuk petugas dan admin');
    }

    const { data: laporan, error } = await supabaseAdmin
      .from('laporan')
      .select('*, kategori:kategori_id(*), kelurahan:kelurahan_id(*), dinas:dinas_id(*)')
      .eq('id', id)
      .single();

    if (error || !laporan) {
      return apiError('NOT_FOUND', 'Laporan tidak ditemukan');
    }

    // Petugas hanya boleh melihat detail kontak untuk laporan dinasnya
    if (auth.role === 'petugas' && auth.dinasId && laporan.dinas_id !== auth.dinasId) {
      return apiError('FORBIDDEN', 'Anda tidak berwenang mengakses laporan milik dinas lain');
    }

    // Ambil kontak pelapor
    const { data: kontak } = await supabaseAdmin
      .from('kontak_pelapor')
      .select('email, telepon, preferensi_notif')
      .eq('laporan_id', id)
      .single();

    // Catat ke audit_log bahwa petugas mengakses kontak pelapor
    await supabaseAdmin.from('audit_log').insert({
      user_id: auth.userId,
      aksi: 'akses_kontak',
      tabel_target: 'kontak_pelapor',
      record_id: id,
      detail: { laporan_id: id, dinas_id: laporan.dinas_id },
    });

    // Ambil status history
    const { data: history } = await supabaseAdmin
      .from('status_history')
      .select('*')
      .eq('laporan_id', id)
      .order('created_at', { ascending: true });

    return apiSukses({
      ...laporan,
      kontak_pelapor: kontak || null,
      linimasa: history || [],
    });
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal memuat detail laporan petugas');
  }
}

