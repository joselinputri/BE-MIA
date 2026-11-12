'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { Lock, ArrowLeft, CheckCircle2, ShieldAlert, Eye, EyeOff } from 'lucide-react';
import Reveal from '@/components/Reveal';
import { supabaseBrowser } from '@/lib/client/supabase';

export default function PerbaruiSandiPage() {
  const router = useRouter();
  const [passwordBaru, setPasswordBaru] = useState('');
  const [konfirmasiPassword, setKonfirmasiPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const [sukses, setSukses] = useState(false);
  const [sessionReady, setSessionReady] = useState(false);

  useEffect(() => {
    if (!supabaseBrowser) return;

    // Supabase otomatis mengurai hash URL (#access_token=...&type=recovery)
    const { data: authListener } = supabaseBrowser.auth.onAuthStateChange(async (event) => {
      if (event === 'PASSWORD_RECOVERY') {
        setSessionReady(true);
      }
    });

    // Cek apakah sudah ada sesi aktif dari recovery token
    supabaseBrowser.auth.getSession().then(({ data }) => {
      if (data?.session) {
        setSessionReady(true);
      }
    });

    return () => {
      authListener.subscription.unsubscribe();
    };
  }, []);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMsg(null);

    if (passwordBaru.length < 6) {
      setErrorMsg('Kata sandi baru minimal harus 6 karakter.');
      return;
    }

    if (passwordBaru !== konfirmasiPassword) {
      setErrorMsg('Konfirmasi kata sandi tidak cocok.');
      return;
    }

    setLoading(true);

    try {
      if (!supabaseBrowser) {
        throw new Error('Layanan autentikasi belum siap.');
      }

      const { error } = await supabaseBrowser.auth.updateUser({
        password: passwordBaru,
      });

      if (error) {
        throw new Error(error.message);
      }

      setSukses(true);
      setTimeout(() => {
        router.push('/masuk');
      }, 2500);
    } catch (err: any) {
      setErrorMsg(err?.message || 'Gagal memperbarui kata sandi. Tautan mungkin telah kedaluwarsa.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <main className="mx-auto max-w-lg px-4 py-12">
      <Reveal>
        <div className="bg-panel p-6 sm:p-8 rounded-3xl shadow-[0_8px_24px_rgba(40,38,75,.14)] border border-navy/10 space-y-6">
          <div className="space-y-1">
            <Link
              href="/masuk"
              className="inline-flex items-center gap-1.5 text-xs font-bold text-navy/70 hover:text-crimson transition mb-2"
            >
              <ArrowLeft className="w-3.5 h-3.5" />
              <span>Kembali ke Halaman Masuk</span>
            </Link>
            <h1 className="text-2xl font-extrabold text-navy">Buat Kata Sandi Baru</h1>
            <p className="text-xs text-navy/70">
              Silakan masukkan kata sandi baru Anda untuk mengamankan akun RAMPUNG.
            </p>
          </div>

          {errorMsg && (
            <div className="p-3 bg-rose-100 border border-rose-300 text-crimson text-xs rounded-xl flex items-center gap-2">
              <ShieldAlert className="w-4 h-4 shrink-0" />
              <span>{errorMsg}</span>
            </div>
          )}

          {sukses ? (
            <div className="p-5 bg-emerald-50 border border-emerald-300 rounded-2xl space-y-3 text-center animate-in fade-in">
              <CheckCircle2 className="w-10 h-10 text-emerald-600 mx-auto" />
              <div>
                <h3 className="text-sm font-extrabold text-emerald-950">Kata Sandi Berhasil Diperbarui!</h3>
                <p className="text-xs text-emerald-800 mt-1">
                  Mengarahkan Anda ke halaman masuk dalam beberapa detik...
                </p>
              </div>
              <Link
                href="/masuk"
                className="inline-block mt-2 px-4 py-2 bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-bold rounded-xl transition"
              >
                Masuk Sekarang
              </Link>
            </div>
          ) : (
            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="space-y-1.5">
                <label className="text-xs font-bold text-navy">Kata Sandi Baru</label>
                <div className="relative">
                  <input
                    type={showPassword ? 'text' : 'password'}
                    value={passwordBaru}
                    onChange={(e) => setPasswordBaru(e.target.value)}
                    required
                    minLength={6}
                    placeholder="Minimal 6 karakter"
                    className="w-full bg-white border border-navy/15 rounded-xl px-4 py-2.5 pl-10 pr-10 text-xs font-medium text-navy placeholder:text-navy/40 focus:outline-none focus:ring-2 focus:ring-crimson/20 focus:border-crimson transition"
                  />
                  <Lock className="w-4 h-4 text-navy/40 absolute left-3.5 top-3" />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    className="absolute right-3.5 top-3 text-navy/40 hover:text-navy transition"
                  >
                    {showPassword ? <EyeOff className="w-4 h-4" /> : <Eye className="w-4 h-4" />}
                  </button>
                </div>
              </div>

              <div className="space-y-1.5">
                <label className="text-xs font-bold text-navy">Konfirmasi Kata Sandi Baru</label>
                <div className="relative">
                  <input
                    type={showPassword ? 'text' : 'password'}
                    value={konfirmasiPassword}
                    onChange={(e) => setKonfirmasiPassword(e.target.value)}
                    required
                    minLength={6}
                    placeholder="Ulangi kata sandi baru"
                    className="w-full bg-white border border-navy/15 rounded-xl px-4 py-2.5 pl-10 pr-10 text-xs font-medium text-navy placeholder:text-navy/40 focus:outline-none focus:ring-2 focus:ring-crimson/20 focus:border-crimson transition"
                  />
                  <Lock className="w-4 h-4 text-navy/40 absolute left-3.5 top-3" />
                </div>
              </div>

              <button
                type="submit"
                disabled={loading}
                className="w-full py-3 bg-crimson hover:bg-[#8a002b] disabled:opacity-60 text-white text-xs font-bold rounded-xl transition shadow-sm flex items-center justify-center gap-2 cursor-pointer"
              >
                {loading ? 'Menyimpan Sandi...' : 'Simpan Kata Sandi Baru'}
              </button>
            </form>
          )}
        </div>
      </Reveal>
    </main>
  );
}
