'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { ShieldCheck, UsersRound, ClipboardList } from 'lucide-react';
import Reveal from '@/components/Reveal';
import { useAuth } from '@/lib/client/auth';
import { fetchAuthed } from '@/lib/client/supabase';

interface AdminUser {
  id: string;
  nama: string | null;
  role: 'warga' | 'petugas' | 'admin';
  no_telepon: string | null;
  created_at: string;
  dinas?: { nama?: string; singkatan?: string } | null;
}

export default function AdminPage() {
  const router = useRouter();
  const { pengguna, siap } = useAuth();
  const [users, setUsers] = useState<AdminUser[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!siap) return;
    if (!pengguna) {
      router.replace('/masuk');
      return;
    }
    if (pengguna.peran !== 'admin') {
      router.replace('/profil');
      return;
    }

    let aktif = true;
    void fetchAuthed('/api/admin/users')
      .then(async (response) => {
        const payload = await response.json();
        if (!response.ok) throw new Error(payload.error?.pesan || 'Daftar akun gagal dimuat.');
        if (aktif) setUsers(Array.isArray(payload.data) ? payload.data : []);
      })
      .catch((cause: unknown) => {
        if (aktif) setError(cause instanceof Error ? cause.message : 'Daftar akun gagal dimuat.');
      })
      .finally(() => {
        if (aktif) setLoading(false);
      });

    return () => { aktif = false; };
  }, [pengguna, router, siap]);

  if (!siap || !pengguna || pengguna.peran !== 'admin') {
    return <main className="mx-auto max-w-5xl px-4 py-12 text-center text-white">Memeriksa akses…</main>;
  }

  return (
    <main className="mx-auto max-w-6xl space-y-6 px-4 py-10 sm:px-8">
      <Reveal>
        <header className="flex flex-wrap items-center justify-between gap-4 rounded-3xl border border-navy/10 bg-hero p-6 shadow-lg sm:p-8">
          <div className="flex items-center gap-4">
            <span className="grid size-14 place-items-center rounded-2xl bg-navy text-white"><ShieldCheck className="size-7" /></span>
            <div>
              <p className="text-xs font-bold uppercase tracking-wider text-navy/60">Administrasi RAMPUNG</p>
              <h1 className="text-2xl font-extrabold text-navy sm:text-3xl">Panel Admin</h1>
              <p className="mt-1 text-sm text-navy/70">Masuk sebagai {pengguna.nama}</p>
            </div>
          </div>
          <Link href="/profil" className="inline-flex min-h-11 items-center gap-2 rounded-xl bg-navy px-4 text-sm font-bold text-white hover:bg-slate">
            Profil Akun
          </Link>
        </header>
      </Reveal>

      <Reveal delay={80}>
        <section className="rounded-3xl border border-navy/10 bg-panel p-5 shadow-sm sm:p-7">
          <div className="mb-5 flex items-center justify-between gap-3">
            <div>
              <h2 className="flex items-center gap-2 text-lg font-extrabold text-navy"><UsersRound className="size-5" /> Akun Pengguna</h2>
              <p className="mt-1 text-xs text-navy/70">Daftar akun yang tersimpan di Supabase.</p>
            </div>
            <Link href="/papan-tanggap" className="inline-flex min-h-10 items-center gap-2 rounded-xl border border-navy/15 bg-white px-3 text-xs font-bold text-navy hover:bg-card">
              <ClipboardList className="size-4" /> Papan Tanggap
            </Link>
          </div>

          {error && <p role="alert" className="mb-4 rounded-xl border border-rose-300 bg-rose-50 p-3 text-sm text-crimson">{error}</p>}

          <div className="overflow-x-auto rounded-2xl border border-navy/10 bg-white">
            <table className="w-full min-w-[600px] text-left text-sm">
              <thead className="bg-card text-xs uppercase text-navy/70">
                <tr>
                  <th scope="col" className="px-4 py-3">Nama</th>
                  <th scope="col" className="px-4 py-3">Peran</th>
                  <th scope="col" className="px-4 py-3">Dinas</th>
                  <th scope="col" className="px-4 py-3">Terdaftar</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-navy/10">
                {loading ? (
                  <tr><td colSpan={4} className="px-4 py-8 text-center text-navy/60">Memuat akun…</td></tr>
                ) : error ? (
                  <tr><td colSpan={4} className="px-4 py-8 text-center text-navy/60">Akun tidak dapat dimuat.</td></tr>
                ) : users.length === 0 ? (
                  <tr><td colSpan={4} className="px-4 py-8 text-center text-navy/60">Belum ada akun.</td></tr>
                ) : users.map((user) => (
                  <tr key={user.id} className="text-navy">
                    <td className="px-4 py-3 font-semibold">{user.nama || '—'}</td>
                    <td className="px-4 py-3 capitalize">{user.role}</td>
                    <td className="px-4 py-3">{user.dinas?.nama || '—'}</td>
                    <td className="px-4 py-3">{new Date(user.created_at).toLocaleDateString('id-ID')}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </section>
      </Reveal>
    </main>
  );
}
