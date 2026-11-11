'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { UserPlus, User, Mail, Key, ShieldAlert, Check } from 'lucide-react';
import Reveal from '@/components/Reveal';
import { useAuth } from '@/lib/client/auth';

export default function DaftarPage() {
  const router = useRouter();
  const { daftarkan, siap } = useAuth();
  const [nama, setNama] = useState('');
  const [email, setEmail] = useState('');
  const [sandi, setSandi] = useState('');
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [perluKonfirmasiEmail, setPerluKonfirmasiEmail] = useState(false);

  async function handleSubmit(event: React.FormEvent) {
    event.preventDefault();
    setErrorMsg(null);
    setIsLoading(true);
    const result = await daftarkan(nama, email, sandi);
    setIsLoading(false);

    if (result.error) {
      setErrorMsg(result.error);
      return;
    }

    if (result.perluKonfirmasiEmail) {
      setPerluKonfirmasiEmail(true);
      return;
    }
    router.push('/profil');
  }

  return (
    <main className="mx-auto max-w-lg px-4 py-12">
      <Reveal>
        <div className="space-y-6 rounded-3xl border border-navy/10 bg-panel p-6 shadow-[0_8px_24px_rgba(40,38,75,.14)] sm:p-8">
          <div className="space-y-1 text-center">
            <h1 className="text-2xl font-extrabold text-navy">Daftar Akun Warga</h1>
            <p className="text-xs text-navy/70">Buat akun untuk menyimpan dan memantau laporan Anda.</p>
          </div>

          {errorMsg && (
            <div role="alert" className="flex items-center gap-2 rounded-xl border border-rose-300 bg-rose-100 p-3 text-xs text-crimson">
              <ShieldAlert className="h-4 w-4 shrink-0" />
              <span>{errorMsg}</span>
            </div>
          )}

          {perluKonfirmasiEmail ? (
            <div role="status" className="space-y-2 rounded-2xl border border-emerald-300 bg-emerald-50 p-4 text-center">
              <Check className="mx-auto h-8 w-8 text-emerald-700" />
              <p className="text-sm font-extrabold text-emerald-900">Periksa email Anda</p>
              <p className="text-xs text-emerald-800">Konfirmasi alamat email untuk mengaktifkan akun, lalu masuk.</p>
              <Link href="/masuk" className="inline-block pt-2 text-xs font-bold text-crimson hover:underline">
                Ke halaman masuk
              </Link>
            </div>
          ) : (
            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label htmlFor="nama" className="mb-1.5 block text-xs font-bold text-navy">Nama Lengkap</label>
                <div className="relative">
                  <User className="absolute left-3.5 top-1/2 h-4 w-4 -translate-y-1/2 text-navy/40" />
                  <input
                    id="nama"
                    type="text"
                    required
                    minLength={2}
                    maxLength={100}
                    autoComplete="name"
                    value={nama}
                    onChange={(event) => setNama(event.target.value)}
                    placeholder="Nama lengkap"
                    className="w-full rounded-xl border border-navy/15 bg-white py-2.5 pl-10 pr-4 text-sm font-semibold text-navy focus:outline-none focus:ring-2 focus:ring-crimson"
                  />
                </div>
              </div>

              <div>
                <label htmlFor="email" className="mb-1.5 block text-xs font-bold text-navy">Alamat Email</label>
                <div className="relative">
                  <Mail className="absolute left-3.5 top-1/2 h-4 w-4 -translate-y-1/2 text-navy/40" />
                  <input
                    id="email"
                    type="email"
                    required
                    autoComplete="email"
                    value={email}
                    onChange={(event) => setEmail(event.target.value)}
                    placeholder="nama@email.com"
                    className="w-full rounded-xl border border-navy/15 bg-white py-2.5 pl-10 pr-4 text-sm font-semibold text-navy focus:outline-none focus:ring-2 focus:ring-crimson"
                  />
                </div>
              </div>

              <div>
                <label htmlFor="password" className="mb-1.5 block text-xs font-bold text-navy">Kata Sandi</label>
                <div className="relative">
                  <Key className="absolute left-3.5 top-1/2 h-4 w-4 -translate-y-1/2 text-navy/40" />
                  <input
                    id="password"
                    type="password"
                    required
                    minLength={8}
                    autoComplete="new-password"
                    value={sandi}
                    onChange={(event) => setSandi(event.target.value)}
                    placeholder="Minimal 8 karakter"
                    className="w-full rounded-xl border border-navy/15 bg-white py-2.5 pl-10 pr-4 text-sm font-semibold text-navy focus:outline-none focus:ring-2 focus:ring-crimson"
                  />
                </div>
              </div>

              <button
                type="submit"
                disabled={isLoading || !siap}
                className="flex w-full items-center justify-center gap-2 rounded-xl bg-crimson py-3 text-xs font-extrabold text-white shadow-md transition-all hover:bg-[#8a002b] disabled:opacity-50"
              >
                <UserPlus className="h-4 w-4" />
                <span>{isLoading ? 'Membuat akun…' : 'Daftar'}</span>
              </button>
            </form>
          )}

          <div className="pt-2 text-center text-xs text-navy/70">
            Sudah memiliki akun?{' '}
            <Link href="/masuk" className="font-bold text-crimson hover:underline">Masuk</Link>
          </div>
        </div>
      </Reveal>
    </main>
  );
}
