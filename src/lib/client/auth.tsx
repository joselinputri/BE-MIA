'use client';

import { createContext, useCallback, useContext, useEffect, useMemo, useState, type ReactNode } from 'react';
import { fetchAuthed, supabaseBrowser } from './supabase';

export interface Pengguna {
  id: string;
  nama: string;
  email: string;
  peran: 'warga' | 'petugas' | 'admin';
  no_telepon: string;
  created_at: string;
}

interface PendaftaranResult {
  error: string | null;
  perluKonfirmasiEmail: boolean;
}

interface AuthCtx {
  pengguna: Pengguna | null;
  siap: boolean;
  masuk: (email: string, sandi: string) => Promise<{ error: string | null; pengguna: Pengguna | null }>;
  daftarkan: (nama: string, email: string, sandi: string) => Promise<PendaftaranResult>;
  perbaruiProfil: (nama: string, noTelepon: string) => Promise<string | null>;
  keluar: () => Promise<void>;
}

const Ctx = createContext<AuthCtx>({
  pengguna: null,
  siap: false,
  masuk: async () => ({ error: 'Layanan akun belum tersedia.', pengguna: null }),
  daftarkan: async () => ({ error: 'Layanan akun belum tersedia.', perluKonfirmasiEmail: false }),
  perbaruiProfil: async () => 'Layanan akun belum tersedia.',
  keluar: async () => {},
});

async function ambilProfil(accessToken: string): Promise<Pengguna> {
  const response = await fetch('/api/auth/profile', {
    headers: { Authorization: `Bearer ${accessToken}` },
    cache: 'no-store',
  });
  const payload = await response.json();
  if (!response.ok || !payload.data) {
    throw new Error(payload.error?.pesan || 'Profil akun gagal dimuat.');
  }
  const profile = payload.data;
  return {
    id: profile.id,
    nama: profile.nama || profile.email,
    email: profile.email,
    peran: profile.role,
    no_telepon: profile.no_telepon || '',
    created_at: profile.created_at,
  };
}

export function AuthProvider({ children }: { children: ReactNode }) {
  const [pengguna, setPengguna] = useState<Pengguna | null>(null);
  const [siap, setSiap] = useState(false);

  useEffect(() => {
    if (!supabaseBrowser) {
      setSiap(true);
      return;
    }

    let aktif = true;
    const muatPengguna = async (accessToken: string | undefined) => {
      if (!accessToken) {
        if (aktif) {
          setPengguna(null);
          setSiap(true);
        }
        return;
      }

      try {
        const profile = await ambilProfil(accessToken);
        if (aktif) setPengguna(profile);
      } catch {
        if (aktif) setPengguna(null);
      } finally {
        if (aktif) setSiap(true);
      }
    };

    void supabaseBrowser.auth.getSession().then(({ data }) => {
      void muatPengguna(data.session?.access_token);
    });

    const { data: { subscription } } = supabaseBrowser.auth.onAuthStateChange((_event, session) => {
      setSiap(false);
      void muatPengguna(session?.access_token);
    });

    return () => {
      aktif = false;
      subscription.unsubscribe();
    };
  }, []);

  const masuk = useCallback(async (email: string, sandi: string) => {
    if (!supabaseBrowser) return { error: 'Layanan akun belum dikonfigurasi.', pengguna: null };
    const { data, error } = await supabaseBrowser.auth.signInWithPassword({
      email: email.trim(),
      password: sandi,
    });
    if (error || !data.session) {
      return { error: error?.message || 'Email atau kata sandi tidak valid.', pengguna: null };
    }

    try {
      const profile = await ambilProfil(data.session.access_token);
      setPengguna(profile);
      return { error: null, pengguna: profile };
    } catch (profileError) {
      await supabaseBrowser.auth.signOut();
      return {
        error: profileError instanceof Error ? profileError.message : 'Profil akun gagal dimuat.',
        pengguna: null,
      };
    }
  }, []);

  const daftarkan = useCallback(async (nama: string, email: string, sandi: string): Promise<PendaftaranResult> => {
    if (!supabaseBrowser) {
      return { error: 'Layanan pendaftaran belum dikonfigurasi.', perluKonfirmasiEmail: false };
    }

    const { data, error } = await supabaseBrowser.auth.signUp({
      email: email.trim(),
      password: sandi,
      options: { data: { full_name: nama.trim() } },
    });
    if (error) return { error: error.message, perluKonfirmasiEmail: false };

    if (data.session) {
      try {
        setPengguna(await ambilProfil(data.session.access_token));
      } catch (profileError) {
        return {
          error: profileError instanceof Error ? profileError.message : 'Profil akun gagal dimuat.',
          perluKonfirmasiEmail: false,
        };
      }
    }

    return { error: null, perluKonfirmasiEmail: !data.session };
  }, []);

  const perbaruiProfil = useCallback(async (nama: string, noTelepon: string) => {
    const response = await fetchAuthed('/api/auth/profile', {
      method: 'PUT',
      body: JSON.stringify({ nama, no_telepon: noTelepon }),
    });
    const payload = await response.json();
    if (!response.ok || !payload.data) {
      return payload.error?.pesan || 'Perubahan profil gagal disimpan.';
    }
    setPengguna((current) => current ? {
      ...current,
      nama: payload.data.nama,
      no_telepon: payload.data.no_telepon,
    } : current);
    return null;
  }, []);

  const keluar = useCallback(async () => {
    if (supabaseBrowser) await supabaseBrowser.auth.signOut();
    setPengguna(null);
  }, []);

  const nilai = useMemo(
    () => ({ pengguna, siap, masuk, daftarkan, perbaruiProfil, keluar }),
    [pengguna, siap, masuk, daftarkan, perbaruiProfil, keluar]
  );
  return <Ctx.Provider value={nilai}>{children}</Ctx.Provider>;
}

export const useAuth = () => useContext(Ctx);
