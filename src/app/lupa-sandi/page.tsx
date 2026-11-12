'use client';

import { useState } from 'react';
import Link from 'next/link';
import { Mail, ArrowLeft, Send, CheckCircle2, ShieldAlert } from 'lucide-react';
import Reveal from '@/components/Reveal';
import { supabaseBrowser } from '@/lib/client/supabase';

export default function LupaSandiPage() {
  const [email, setEmail] = useState('');
  const [loading, setLoading] = useState(false);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const [sukses, setSukses] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMsg(null);
    setLoading(true);

    try {
      if (!supabaseBrowser) {
        throw new Error('Layanan autentikasi belum siap.');
      }

      const { error } = await supabaseBrowser.auth.resetPasswordForEmail(email.trim(), {
        redirectTo: `${window.location.origin}/profil`,
      });

      if (error) {
        throw new Error(error.message);
      }

      setSukses(true);
    } catch (err: any) {
      setErrorMsg(err?.message || 'Gagal mengirim tautan pemulihan sandi. Periksa email Anda.');
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
            <h1 className="text-2xl font-extrabold text-navy">Lupa Kata Sandi</h1>
            <p className="text-xs text-navy/70">
              Masukkan alamat email Anda untuk menerima tautan pemulihan kata sandi.
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
                <h3 className="text-sm font-extrabold text-emerald-950">Tautan Pemulihan Terkirim!</h3>
                <p className="text-xs text-emerald-800 mt-1 leading-relaxed">
                  Kami telah mengirimkan instruksi pemulihan kata sandi ke email <strong>{email}</strong>. Silakan periksa kotak masuk atau folder spam Anda.
                </p>
              </div>
              <Link
                href="/masuk"
                className="inline-block px-5 py-2.5 bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-bold rounded-xl transition shadow-sm mt-2"
              >
                Kembali ke Masuk
              </Link>
            </div>
          ) : (
            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label className="block text-xs font-bold text-navy mb-1.5">Alamat Email Terdaftar</label>
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

              <button
                type="submit"
                disabled={loading}
                className="w-full py-3 bg-crimson hover:bg-[#8a002b] text-white text-xs font-extrabold rounded-xl transition-all shadow-md flex items-center justify-center gap-2 disabled:opacity-50"
              >
                <Send className="w-4 h-4" />
                <span>{loading ? 'Mengirim tautan…' : 'Kirim Tautan Pemulihan'}</span>
              </button>
            </form>
          )}

          <div className="text-center text-xs text-navy/70 border-t border-navy/10 pt-4">
            Ingat kata sandi Anda?{' '}
            <Link href="/masuk" className="font-bold text-crimson hover:underline">
              Masuk Sekarang
            </Link>
          </div>
        </div>
      </Reveal>
    </main>
  );
}
