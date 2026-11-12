'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { LogIn, Key, Mail, ShieldAlert } from 'lucide-react';
import { useAuth } from '@/lib/client/auth';
import Reveal from '@/components/Reveal';

export default function MasukPage() {
  const router = useRouter();
  const { masuk, siap } = useAuth();
  const [email, setEmail] = useState('');
  const [sandi, setSandi] = useState('');
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMsg(null);
    setIsLoading(true);

    const result = await masuk(email, sandi);
    setIsLoading(false);

    if (result.error || !result.pengguna) {
      setErrorMsg(result.error || 'Profil pengguna tidak tersedia.');
    } else {
      router.push(result.pengguna.peran === 'admin'
        ? '/admin'
        : result.pengguna.peran === 'petugas'
          ? '/papan-tanggap'
          : '/profil');
    }
  };

  return (
    <main className="mx-auto max-w-lg px-4 py-12">
      <Reveal>
        <div className="bg-panel p-6 sm:p-8 rounded-3xl shadow-[0_8px_24px_rgba(40,38,75,.14)] border border-navy/10 space-y-6">
          <div className="text-center space-y-1">
            <h1 className="text-2xl font-extrabold text-navy">Masuk ke RAMPUNG</h1>
            <p className="text-xs text-navy/70">
              Masuk untuk mengakses profil dan riwayat laporan Anda.
            </p>
          </div>

          {errorMsg && (
            <div className="p-3 bg-rose-100 border border-rose-300 text-crimson text-xs rounded-xl flex items-center gap-2">
              <ShieldAlert className="w-4 h-4 shrink-0" />
              <span>{errorMsg}</span>
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="block text-xs font-bold text-navy mb-1.5">Alamat Email</label>
              <div className="relative">
                <Mail className="w-4 h-4 text-navy/40 absolute left-3.5 top-1/2 -translate-y-1/2" />
                <input
                  type="email"
                  required
                  autoComplete="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="nama@email.com"
                  className="w-full pl-10 pr-4 py-2.5 bg-white border border-navy/15 rounded-xl text-sm font-semibold text-navy focus:outline-none focus:ring-2 focus:ring-crimson"
                />
              </div>
            </div>

            <div>
              <label className="block text-xs font-bold text-navy mb-1.5">Kata Sandi</label>
              <div className="relative">
                <Key className="w-4 h-4 text-navy/40 absolute left-3.5 top-1/2 -translate-y-1/2" />
                <input
                  type="password"
                  required
                  autoComplete="current-password"
                  value={sandi}
                  onChange={(e) => setSandi(e.target.value)}
                  placeholder="••••••••"
                  className="w-full pl-10 pr-4 py-2.5 bg-white border border-navy/15 rounded-xl text-sm font-semibold text-navy focus:outline-none focus:ring-2 focus:ring-crimson"
                />
              </div>
            </div>

            <button
              type="submit"
              disabled={isLoading || !siap}
              className="w-full py-3 bg-crimson hover:bg-[#8a002b] text-white text-xs font-extrabold rounded-xl transition-all shadow-md flex items-center justify-center gap-2 disabled:opacity-50"
            >
              <LogIn className="w-4 h-4" />
              <span>{isLoading ? 'Memeriksa akun…' : 'Masuk'}</span>
            </button>
          </form>
          <div className="text-center text-xs text-navy/70 pt-2">
            Belum punya akun?{' '}
            <Link href="/daftar" className="font-bold text-crimson hover:underline">
              Daftar Warga
            </Link>
          </div>
        </div>
      </Reveal>
    </main>
  );
}
