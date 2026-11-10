/**
 * src/app/api/admin/audit-log/route.ts
 * Endpoint Log Audit Aksi Sensitif (Append-Only)
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

    const { searchParams } = new URL(req.url);
    const cursor = searchParams.get('cursor');
    const limit = Math.min(Math.max(Number(searchParams.get('limit')) || 20, 1), 50);

    let query = supabaseAdmin
      .from('audit_log')
      .select('id, user_id, aksi, tabel_target, record_id, detail, ip_address, created_at, user:user_id(nama, role)')
      .order('created_at', { ascending: false })
      .limit(limit + 1);

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
          nama_sumber: 'Audit Log Append-Only RAMPUNG',
          waktu_pembaruan: new Date().toISOString(),
        },
      ],
      waktu_query: new Date().toISOString(),
    });
  } catch (err: any) {
    return apiError('INTERNAL_ERROR', 'Gagal memuat log audit');
  }
}

