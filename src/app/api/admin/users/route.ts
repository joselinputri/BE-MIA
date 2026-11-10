/**
 * src/app/api/admin/users/route.ts
 * Endpoint Daftar Pengguna & Role untuk Administrator
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { apiSukses, apiError } from '@/lib/server/response';
import { dapatkanKonteksAuth } from '@/lib/server/auth';
import { supabaseAdmin } from '@/lib/server/supabase-admin';

export async function GET(req: NextRequest) {
  try {
    const auth = await dapatkanKonteksAuth();
    if (!auth.isAuthenticated || auth.role !== 'admin') {
      return apiError('FORBIDDEN', 'Akses khusus administrator sistem');
    }

    const { data: users, error } = await supabaseAdmin
      .from('profiles')
      .select('id, role, nama, no_telepon, created_at, dinas:dinas_id(nama, singkatan)')
      .order('created_at', { ascending: false })
      .limit(100);

    if (error) {
      return apiSukses([]);
    }

    return apiSukses(users || []);
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal memuat daftar pengguna');
  }
}

