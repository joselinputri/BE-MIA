/**
 * src/app/api/laporan/publik/route.ts
 * Endpoint Daftar Laporan Publik (Cursor Pagination + Filter + Ringkas/Lengkap)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { LaporanPublikFilterSchema } from '@/lib/contracts/laporan';
import { apiSukses, apiError } from '@/lib/server/response';
import { supabaseAdmin } from '@/lib/server/supabase-admin';
import { formatBanyakUrlFoto, dapatkanThumbnailUrl } from '@/lib/server/upload';

export async function GET(req: NextRequest) {
  try {
    const { searchParams } = new URL(req.url);
    const rawQuery = Object.fromEntries(searchParams.entries());

    const parsed = LaporanPublikFilterSchema.safeParse(rawQuery);
    if (!parsed.success) {
      return apiError(
        'VALIDATION_ERROR',
        parsed.error.issues?.[0]?.message || 'Parameter query filter tidak valid'
      );
    }

    const {
      kategori,
      kecamatan,
      kelurahan,
      status,
      sumber,
      pencarian,
      cursor,
      limit,
      fields,
    } = parsed.data;

    let query = supabaseAdmin
      .from('laporan_publik')
      .select('*')
      .order('created_at', { ascending: false })
      .limit(limit + 1);

    if (kategori) {
      query = query.eq('kategori_slug', kategori);
    }
    if (kecamatan) {
      query = query.eq('kecamatan_kode', kecamatan);
    }
    if (kelurahan) {
      query = query.eq('kelurahan_kode', kelurahan);
    }
    if (status) {
      query = query.eq('status', status);
    }
    if (sumber === 'asli') {
      query = query.eq('is_simulasi', false);
    } else if (sumber === 'simulasi') {
      query = query.eq('is_simulasi', true);
    }
    if (pencarian) {
      query = query.ilike('judul', `%${pencarian}%`);
    }
    if (cursor) {
      query = query.lt('created_at', cursor);
    }

    const { data: records, error } = await query;

    if (error) {
      console.error('[laporan/publik] DB error:', error.message, error.details, error.hint);
      return apiError('INTERNAL_ERROR', 'Gagal membaca data laporan publik dari database.');
    }

    let hasNextPage = false;
    let items = records || [];
    if (items.length > limit) {
      hasNextPage = true;
      items = items.slice(0, limit);
    }

    const nextCursor = hasNextPage && items.length > 0 ? items[items.length - 1].created_at : null;

    // Field selection & resolusi URL foto publik
    const sanitizedItems = items.map((item: any) => {
      const fotoSebelumUrls = formatBanyakUrlFoto(item.foto_sebelum_paths || []);
      const fotoSesudahUrls = formatBanyakUrlFoto(item.foto_sesudah_paths || []);
      const thumbUrl = fotoSebelumUrls.length > 0 ? dapatkanThumbnailUrl(item.foto_sebelum_paths[0]) : null;

      if (fields === 'ringkas') {
        return {
          id: item.id,
          kode_lacak: item.kode_lacak,
          judul: item.judul,
          kategori: item.kategori,
          kelurahan: item.kelurahan,
          status: item.status,
          thumbnail: thumbUrl,
          jumlah_dukungan: item.jumlah_dukungan,
          created_at: item.created_at,
          is_simulasi: item.is_simulasi,
          provenance: item.provenance,
        };
      }
      return {
        ...item,
        foto_sebelum_paths: fotoSebelumUrls,
        foto_sesudah_paths: fotoSesudahUrls,
        thumbnail: thumbUrl,
      };
    });

    return apiSukses(sanitizedItems, {
      cursor_berikutnya: nextCursor,
      sumber: [
        {
          provenance: sumber === 'asli' ? 'asli' : 'simulasi_terkalibrasi',
          nama_sumber: 'Data Publik RAMPUNG Kota Surakarta',
          waktu_pembaruan: new Date().toISOString(),
        },
      ],
      waktu_query: new Date().toISOString(),
    });
  } catch (err: any) {
    console.error('[laporan/publik] Error:', err?.message || err);
    return apiError('INTERNAL_ERROR', 'Gagal memuat daftar laporan publik');
  }
}

