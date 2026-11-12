'use client';

import { useEffect, useState } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { UserRound, Mail, ShieldCheck, Save, ClipboardList, LogOut, RefreshCw } from 'lucide-react';
import Reveal from '@/components/Reveal';
import { useAuth } from '@/lib/client/auth';
import { fetchAuthed } from '@/lib/client/supabase';
import { cn } from '@/lib/utils';

const LABEL_PERAN = {
  warga: 'Warga',
  petugas: 'Petugas Lapangan (DPUPR)',
  admin: 'Administrator',
} as const;

export default function ProfilPage() {
  const router = useRouter();
  const { pengguna, siap, perbaruiProfil, keluar } = useAuth();
  const [nama, setNama] = useState('');
  const [noTelepon, setNoTelepon] = useState('');
  const [pesan, setPesan] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);
  const [switchingRole, setSwitchingRole] = useState(false);

  useEffect(() => {
    if (siap && !pengguna) router.replace('/masuk');
  }, [pengguna, router, siap]);

  useEffect(() => {
    if (pengguna) {
      setNama(pengguna.nama);
      setNoTelepon(pengguna.no_telepon);
    }
  }, [pengguna]);

  async function handleSubmit(event: React.FormEvent) {
    event.preventDefault();
    setError(null);
    setPesan(null);
    setSaving(true);
    const result = await perbaruiProfil(nama, noTelepon);
    setSaving(false);
    if (result) setError(result);
    else setPesan('Profil berhasil diperbarui.');
  }

  async function handleSwitchRole(roleBaru: 'warga' | 'petugas' | 'admin', dinas = 'DPUPR') {
    setError(null);
    setPesan(null);
    setSwitchingRole(true);
    try {
      const res = await fetchAuthed('/api/auth/switch-role', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ role: roleBaru, dinas }),
      });
      const json = await res.json();
      if (!res.ok) throw new Error(json.error?.pesan || 'Gagal mengubah peran.');
      setPesan(`Peran akun berhasil diubah menjadi ${roleBaru.toUpperCase()}${roleBaru === 'petugas' ? ` (${dinas})` : ''}! Menyinkronkan...`);
      setTimeout(() => {
        window.location.reload();
      }, 800);
    } catch (err: any) {
      setError(err?.message || 'Gagal mengubah peran akun.');
    } finally {
      setSwitchingRole(false);
    }
  }

  async function handleKeluar() {
    await keluar();
    router.replace('/');
  }

  if (!siap || !pengguna) {
    return <main className="mx-auto max-w-3xl px-4 py-12 text-center text-white">Memuat profil…</main>;
  }

  return (
    <main className="mx-auto max-w-3xl space-y-6 px-4 py-10 sm:px-8">
      <Reveal>
        <header className="rounded-3xl border border-navy/10 bg-hero p-6 shadow-lg sm:p-8">
          <div className="flex items-center gap-4">
            <span className="grid size-14 place-items-center rounded-2xl bg-navy text-white">
              <UserRound className="size-7" />
            </span>
            <div>
              <p className="text-xs font-bold uppercase tracking-wider text-navy/60">Akun RAMPUNG</p>
              <h1 className="text-2xl font-extrabold text-navy">Profil Saya</h1>
              <p className="mt-1 text-sm text-navy/70">{LABEL_PERAN[pengguna.peran]}</p>
            </div>
          </div>
        </header>
      </Reveal>

      <Reveal delay={80}>
        <section className="space-y-5 rounded-3xl border border-navy/10 bg-panel p-6 shadow-sm sm:p-8">
          {error && <p role="alert" className="rounded-xl border border-rose-300 bg-rose-50 p-3 text-sm text-crimson">{error}</p>}
          {pesan && <p role="status" className="rounded-xl border border-emerald-300 bg-emerald-50 p-3 text-sm text-emerald-900">{pesan}</p>}

          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label htmlFor="nama" className="mb-1.5 block text-xs font-bold text-navy">Nama Lengkap</label>
              <div className="relative">
                <UserRound className="absolute left-3.5 top-1/2 size-4 -translate-y-1/2 text-navy/40" />
                <input
                  id="nama"
                  required
                  minLength={2}
                  maxLength={100}
                  value={nama}
                  onChange={(event) => setNama(event.target.value)}
                  className="w-full rounded-xl border border-navy/15 bg-white py-3 pl-10 pr-4 text-sm text-navy focus:outline-none focus:ring-2 focus:ring-crimson"
                />
              </div>
            </div>

            <div>
              <span className="mb-1.5 block text-xs font-bold text-navy">Alamat Email</span>
              <div className="flex items-center gap-3 rounded-xl border border-navy/10 bg-white/70 px-4 py-3 text-sm text-navy/70">
                <Mail className="size-4" />
                <span>{pengguna.email}</span>
              </div>
            </div>

            <div>
              <label htmlFor="telepon" className="mb-1.5 block text-xs font-bold text-navy">Nomor Telepon (opsional)</label>
              <input
                id="telepon"
                type="tel"
                maxLength={20}
                value={noTelepon}
                onChange={(event) => setNoTelepon(event.target.value)}
                className="w-full rounded-xl border border-navy/15 bg-white px-4 py-3 text-sm text-navy focus:outline-none focus:ring-2 focus:ring-crimson"
              />
            </div>

            <button type="submit" disabled={saving} className="inline-flex min-h-11 items-center gap-2 rounded-xl bg-crimson px-5 text-sm font-bold text-white hover:bg-[#8a002b] disabled:opacity-50">
              <Save className="size-4" />
              {saving ? 'Menyimpan…' : 'Simpan Perubahan'}
            </button>
          </form>

          {/* ── Peralihan Hak Akses Peran Akun ── */}
          <div className="rounded-2xl border border-navy/15 bg-white p-5 space-y-3 mt-6">
            <div className="flex flex-wrap items-center justify-between gap-2">
              <div>
                <h3 className="text-sm font-extrabold text-navy">Peralihan Hak Akses Peran Pengguna</h3>
                <p className="text-xs text-navy/70 mt-0.5">
                  Tentukan otoritas akun Anda dalam ekosistem RAMPUNG (Warga, Petugas Lapangan DPUPR, atau Administrator).
                </p>
              </div>
              <span className="text-xs font-mono font-bold bg-navy text-white px-2.5 py-1 rounded-md">
                Peran Aktif: {pengguna.peran.toUpperCase()}
              </span>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-3 gap-2.5 pt-2">
              <button
                type="button"
                disabled={switchingRole || pengguna.peran === 'warga'}
                onClick={() => handleSwitchRole('warga')}
                className={cn(
                  'p-3 rounded-xl border text-xs font-bold transition-all text-center',
                  pengguna.peran === 'warga'
                    ? 'border-crimson bg-crimson/10 text-crimson shadow-sm ring-1 ring-crimson'
                    : 'border-navy/15 bg-card hover:bg-navy/5 text-navy hover:border-navy/30'
                )}
              >
                👤 Warga Biasa
              </button>
              <button
                type="button"
                disabled={switchingRole || pengguna.peran === 'petugas'}
                onClick={() => handleSwitchRole('petugas', 'DPUPR')}
                className={cn(
                  'p-3 rounded-xl border text-xs font-bold transition-all text-center',
                  pengguna.peran === 'petugas'
                    ? 'border-emerald-600 bg-emerald-50 text-emerald-800 shadow-sm ring-1 ring-emerald-500'
                    : 'border-navy/15 bg-card hover:bg-navy/5 text-navy hover:border-navy/30'
                )}
              >
                👷 Petugas (DPUPR)
              </button>
              <button
                type="button"
                disabled={switchingRole || pengguna.peran === 'admin'}
                onClick={() => handleSwitchRole('admin')}
                className={cn(
                  'p-3 rounded-xl border text-xs font-bold transition-all text-center',
                  pengguna.peran === 'admin'
                    ? 'border-indigo-600 bg-indigo-50 text-indigo-800 shadow-sm ring-1 ring-indigo-500'
                    : 'border-navy/15 bg-card hover:bg-navy/5 text-navy hover:border-navy/30'
                )}
              >
                🛡️ Administrator
              </button>
            </div>
            {switchingRole && (
              <p className="text-xs font-semibold text-emerald-700 animate-pulse flex items-center gap-1.5 pt-1">
                <RefreshCw className="w-3.5 h-3.5 animate-spin" /> Memperbarui peran akun di Supabase...
              </p>
            )}
          </div>

          <div className="flex flex-wrap gap-3 border-t border-navy/10 pt-5">
            <Link href="/riwayat" className="inline-flex min-h-11 items-center gap-2 rounded-xl border border-navy/20 bg-white px-4 text-sm font-bold text-navy hover:bg-card">
              <ClipboardList className="size-4" /> Riwayat Laporan
            </Link>
            {pengguna.peran === 'admin' && (
              <Link href="/admin" className="inline-flex min-h-11 items-center gap-2 rounded-xl border border-navy/20 bg-white px-4 text-sm font-bold text-navy hover:bg-card">
                <ShieldCheck className="size-4" /> Panel Admin
              </Link>
            )}
            {pengguna.peran === 'petugas' && (
              <Link href="/papan-tanggap" className="inline-flex min-h-11 items-center gap-2 rounded-xl border border-navy/20 bg-white px-4 text-sm font-bold text-navy hover:bg-card">
                <ShieldCheck className="size-4" /> Papan Tanggap
              </Link>
            )}
            <button type="button" onClick={handleKeluar} className="inline-flex min-h-11 items-center gap-2 rounded-xl border border-rose-300 bg-rose-50 px-4 text-sm font-bold text-crimson hover:bg-rose-100">
              <LogOut className="size-4" /> Keluar
            </button>
          </div>
        </section>
      </Reveal>
    </main>
  );
}
