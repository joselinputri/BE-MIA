/**
 * src/lib/client/auth.ts
 * Auth Context & Hook untuk Komponen React Client
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 *
 * Menyediakan konteks autentikasi (pengguna yang sedang login)
 * untuk digunakan di semua halaman FE.
 */

'use client';

import { createContext, useContext, useEffect, useState, type ReactNode } from 'react';
import { supabase } from './supabase';

export interface Pengguna {
  id: string;
  email: string;
  nama: string;
  peran: 'warga' | 'petugas' | 'admin';
  no_telepon: string;
}

interface AuthContextType {
  pengguna: Pengguna | null;
  siap: boolean;
  keluar: () => Promise<void>;
}

const AuthContext = createContext<AuthContextType>({
  pengguna: null,
  siap: false,
  keluar: async () => {},
});

export function AuthProvider({ children }: { children: ReactNode }) {
  const [pengguna, setPengguna] = useState<Pengguna | null>(null);
  const [siap, setSiap] = useState(false);

  useEffect(() => {
    let aktif = true;

    async function muatProfil() {
      try {
        const {
          data: { session },
        } = await supabase.auth.getSession();

        if (!session) {
          if (aktif) setSiap(true);
          return;
        }

        const res = await fetch('/api/auth/profile', {
          headers: { Authorization: `Bearer ${session.access_token}` },
        });

        if (res.ok) {
          const payload = await res.json();
          if (aktif && payload.data) {
            setPengguna({
              id: payload.data.id,
              email: payload.data.email,
              nama: payload.data.nama,
              peran: payload.data.role,
              no_telepon: payload.data.no_telepon,
            });
          }
        }
      } catch {
        // Abaikan — pengguna belum login
      } finally {
        if (aktif) setSiap(true);
      }
    }

    void muatProfil();

    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!session) {
        setPengguna(null);
      } else {
        void muatProfil();
      }
    });

    return () => {
      aktif = false;
      subscription.unsubscribe();
    };
  }, []);

  async function keluar() {
    await supabase.auth.signOut();
    setPengguna(null);
  }

  return (
    <AuthContext.Provider value={{ pengguna, siap, keluar }}>
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  return useContext(AuthContext);
}

