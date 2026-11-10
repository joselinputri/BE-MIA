/**
 * src/app/api/laporan/publik/[id]/route.ts
 * Endpoint Detail Laporan Publik Tunggal (Bebas PII)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(
  req: NextRequest,
  { params }: { params: { id: string } }
) {
  try {
    const id = params.id;

    const { data: laporan, error } = await supabaseAdmin
      .from('laporan_publik')
      .select('*')
      .eq('id', id)
      .single();

    if (error || !laporan) {
      return apiError('NOT_FOUND', 'Laporan tidak ditemukan');
    }

    // Ambil linimasa status publik
    const { data: history } = await supabaseAdmin
      .from('status_history')
      .select('status_dari, status_ke, catatan, created_at')
      .eq('laporan_id', id)
      .order('created_at', { ascending: true });

    return apiSukses({
      ...laporan,
      linimasa: history || [],
    });
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal memuat detail laporan');
  }
}

