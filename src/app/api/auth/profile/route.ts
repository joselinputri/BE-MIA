/**
 * src/app/api/auth/profile/route.ts
 * Endpoint Profil Pengguna (GET & PUT)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { NextRequest } from 'next/server';
import { z } from 'zod';
import { apiError, apiSukses } from '@/lib/server/response';
import { getSupabaseServerClient } from '@/lib/server/supabase-server';
import { isSupabaseConfigured, supabaseAdmin } from '@/lib/server/supabase-admin';

const UpdateProfileSchema = z.object({
  nama: z.string().trim().min(2).max(100),
  no_telepon: z.string().trim().max(20).optional().nullable(),
});

async function getProfile() {
  if (!isSupabaseConfigured()) {
    return { error: apiError('SERVICE_UNAVAILABLE', 'Layanan akun belum dikonfigurasi.') };
  }

  const supabase = getSupabaseServerClient();
  const { data: { user }, error: authError } = await supabase.auth.getUser();
  if (authError || !user) {
    return { error: apiError('UNAUTHORIZED', 'Silakan masuk untuk melihat profil.') };
  }

  const { data: profile, error } = await supabaseAdmin
    .from('profiles')
    .select('id, role, nama, no_telepon, created_at')
    .eq('id', user.id)
    .single();

  if (error || !profile) {
    return { error: apiError('INTERNAL_ERROR', 'Profil akun belum tersedia. Hubungi administrator.') };
  }

  return {
    user,
    profile,
  };
}

export async function GET() {
  try {
    const result = await getProfile();
    if ('error' in result) return result.error;
    return apiSukses({
      id: result.profile.id,
      email: result.user.email || '',
      nama: result.profile.nama || '',
      role: result.profile.role,
      no_telepon: result.profile.no_telepon || '',
      created_at: result.profile.created_at,
    });
  } catch {
    return apiError('INTERNAL_ERROR', 'Gagal memuat profil akun.');
  }
}

export async function PUT(req: NextRequest) {
  try {
    const result = await getProfile();
    if ('error' in result) return result.error;

    const parsed = UpdateProfileSchema.safeParse(await req.json());
    if (!parsed.success) {
      return apiError('VALIDATION_ERROR', parsed.error.issues[0]?.message || 'Data profil tidak valid.');
    }

    const { data: profile, error } = await supabaseAdmin
      .from('profiles')
      .update({
        nama: parsed.data.nama,
        no_telepon: parsed.data.no_telepon || null,
        updated_at: new Date().toISOString(),
      })
      .eq('id', result.user.id)
      .select('id, role, nama, no_telepon, created_at')
      .single();

    if (error || !profile) {
      return apiError('INTERNAL_ERROR', 'Perubahan profil gagal disimpan.');
    }

    return apiSukses({
      id: profile.id,
      email: result.user.email || '',
      nama: profile.nama || '',
      role: profile.role,
      no_telepon: profile.no_telepon || '',
      created_at: profile.created_at,
    });
  } catch {
    return apiError('INTERNAL_ERROR', 'Gagal menyimpan perubahan profil.');
  }
}

