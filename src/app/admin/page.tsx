'use client';

import { useEffect, useState, useCallback } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { ShieldCheck, UsersRound, ClipboardList, AlertTriangle, CheckCircle, Trash2, XCircle } from 'lucide-react';
import Reveal from '@/components/Reveal';
import { useAuth } from '@/lib/client/auth';
import { fetchAuthed } from '@/lib/client/supabase';
import { getLaporanPublik, type Laporan } from '@/lib/client/data';
import { cn } from '@/lib/utils';

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
  const [tabAktif, setTabAktif] = useState<'moderasi' | 'pengguna'>('moderasi');

  // State Pengguna
  const [users, setUsers] = useState<AdminUser[]>([]);
  const [loadingUsers, setLoadingUsers] = useState(true);
  const [errorUsers, setErrorUsers] = useState<string | null>(null);

  // State Moderasi Laporan
  const [daftarLaporan, setDaftarLaporan] = useState<Laporan[]>([]);
  const [loadingLaporan, setLoadingLaporan] = useState(true);
  const [errorLaporan, setErrorLaporan] = useState<string | null>(null);
  const [pesanAksi, setPesanAksi] = useState<string | null>(null);
  const [sedangMemprosesId, setSedangMemprosesId] = useState<string | null>(null);

  const muatDataLaporan = useCallback(async () => {
    setLoadingLaporan(true);
    try {
      const data = await getLaporanPublik();
      setDaftarLaporan(data);
    } catch {
      setErrorLaporan('Gagal memuat daftar laporan untuk moderasi.');
    } finally {
      setLoadingLaporan(false);
    }
  }, []);

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
        if (aktif) setErrorUsers(cause instanceof Error ? cause.message : 'Daftar akun gagal dimuat.');
      })
      .finally(() => {
        if (aktif) setLoadingUsers(false);
      });

    void muatDataLaporan();

    return () => { aktif = false; };
  }, [muatDataLaporan, pengguna, router, siap]);

  const handleHapusLaporan = async (id: string, kodeLacak: string) => {
    if (!window.confirm(`Konfirmasi: Hapus permanen laporan #${kodeLacak}? Tindakan ini tidak dapat dibatalkan.`)) {
      return;
    }

    setSedangMemprosesId(id);
    setPesanAksi(null);
    try {
      const res = await fetchAuthed(`/api/admin/laporan/${id}`, {
        method: 'DELETE',
      });
      const json = await res.json();
      if (!res.ok) throw new Error(json.error?.pesan || 'Gagal menghapus laporan.');
      setPesanAksi(`Laporan #${kodeLacak} berhasil dihapus.`);
      setDaftarLaporan((prev) => prev.filter((item) => item.id !== id));
    } catch (err: any) {
      alert(err?.message || 'Gagal menghapus laporan.');
    } finally {
      setSedangMemprosesId(null);
    }
  };

  const handleModerasiStatus = async (id: string, aksi: 'verifikasi_sah' | 'tolak_spam') => {
    setSedangMemprosesId(id);
    setPesanAksi(null);
    try {
      const res = await fetchAuthed(`/api/admin/laporan/${id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          aksi,
          alasan: aksi === 'tolak_spam' ? 'Ditolak oleh admin: Bukan fasilitas publik / spam' : undefined,
        }),
      });
      const json = await res.json();
      if (!res.ok) throw new Error(json.error?.pesan || 'Gagal memoderasi laporan.');
      setPesanAksi(aksi === 'verifikasi_sah' ? 'Laporan berhasil diverifikasi sah.' : 'Laporan ditolak.');
      await muatDataLaporan();
    } catch (err: any) {
      alert(err?.message || 'Gagal memproses moderasi laporan.');
    } finally {
      setSedangMemprosesId(null);
    }
  };

  if (!siap || !pengguna || pengguna.peran !== 'admin') {
    return <main className="mx-auto max-w-5xl px-4 py-12 text-center text-white">Memeriksa hak akses administrator…</main>;
  }

  // Filter laporan yang butuh moderasi (indikasi spam atau bertanda verifikasi tambahan)
  const laporanPerluPerhatian = daftarLaporan.filter(
    (item) => item.penanda?.includes('perlu_verifikasi_tambahan') || item.status === 'masuk'
  );

  return (
    <main className="mx-auto max-w-6xl space-y-6 px-4 py-10 sm:px-8">
      <Reveal>
        <header className="flex flex-wrap items-center justify-between gap-4 rounded-3xl border border-navy/10 bg-hero p-6 shadow-lg sm:p-8">
          <div className="flex items-center gap-4">
            <span className="grid size-14 place-items-center rounded-2xl bg-navy text-white"><ShieldCheck className="size-7" /></span>
            <div>
              <p className="text-xs font-bold uppercase tracking-wider text-navy/60">Administrasi & Moderasi RAMPUNG</p>
              <h1 className="text-2xl font-extrabold text-navy sm:text-3xl">Panel Administrator</h1>
              <p className="mt-1 text-sm text-navy/70">Otoritas kendali sistem — Masuk sebagai {pengguna.nama}</p>
            </div>
          </div>
          <div className="flex items-center gap-2">
            <Link href="/papan-tanggap" className="inline-flex min-h-11 items-center gap-2 rounded-xl border border-navy/20 bg-white px-4 text-xs font-bold text-navy hover:bg-card">
              <ClipboardList className="size-4" /> Papan Tanggap
            </Link>
            <Link href="/profil" className="inline-flex min-h-11 items-center gap-2 rounded-xl bg-navy px-4 text-xs font-bold text-white hover:bg-slate">
              Profil Akun
            </Link>
          </div>
        </header>
      </Reveal>

      {/* ── Tab Navigasi Admin ── */}
      <div className="flex items-center gap-2 border-b border-navy/10 pb-2">
        <button
          type="button"
          onClick={() => setTabAktif('moderasi')}
          className={cn(
            'px-4 py-2 rounded-xl text-xs font-bold transition-all flex items-center gap-2',
            tabAktif === 'moderasi'
              ? 'bg-crimson text-white shadow-sm'
              : 'bg-white/80 text-navy hover:bg-white'
          )}
        >
          <AlertTriangle className="size-4" />
          <span>Moderasi Laporan & Anti-Spam ({laporanPerluPerhatian.length})</span>
        </button>
        <button
          type="button"
          onClick={() => setTabAktif('pengguna')}
          className={cn(
            'px-4 py-2 rounded-xl text-xs font-bold transition-all flex items-center gap-2',
            tabAktif === 'pengguna'
              ? 'bg-crimson text-white shadow-sm'
              : 'bg-white/80 text-navy hover:bg-white'
          )}
        >
          <UsersRound className="size-4" />
          <span>Kelola Pengguna ({users.length})</span>
        </button>
      </div>

      {pesanAksi && (
        <div className="rounded-xl border border-emerald-300 bg-emerald-50 p-3 text-xs font-bold text-emerald-900 flex items-center gap-2">
          <CheckCircle className="size-4 text-emerald-600" />
          <span>{pesanAksi}</span>
        </div>
      )}

      {/* ── TAB 1: MODERASI LAPORAN ── */}
      {tabAktif === 'moderasi' && (
        <Reveal delay={60}>
          <section className="rounded-3xl border border-navy/10 bg-panel p-5 shadow-sm sm:p-7 space-y-4">
            <div>
              <h2 className="text-lg font-extrabold text-navy">Antrean Moderasi Laporan</h2>
              <p className="text-xs text-navy/70 mt-0.5">
                Admin berwenang menghapus laporan terindikasi spam (judi online/joki/komersial) serta memverifikasi aduan publik sah.
              </p>
            </div>

            {errorLaporan && <p className="p-3 bg-rose-50 text-crimson text-xs rounded-xl">{errorLaporan}</p>}

            <div className="overflow-x-auto rounded-2xl border border-navy/10 bg-white">
              <table className="w-full min-w-[700px] text-left text-xs">
                <thead className="bg-card text-[11px] uppercase text-navy/70">
                  <tr>
                    <th className="px-4 py-3">Kode Lacak</th>
                    <th className="px-4 py-3">Aduan Warga</th>
                    <th className="px-4 py-3">Kecamatan</th>
                    <th className="px-4 py-3">Indikasi Keamanan</th>
                    <th className="px-4 py-3 text-right">Tindakan Admin</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-navy/10">
                  {loadingLaporan ? (
                    <tr><td colSpan={5} className="px-4 py-8 text-center text-navy/60">Memuat laporan…</td></tr>
                  ) : daftarLaporan.length === 0 ? (
                    <tr><td colSpan={5} className="px-4 py-8 text-center text-navy/60">Tidak ada laporan yang tersimpan.</td></tr>
                  ) : (
                    daftarLaporan.slice(0, 30).map((lap) => {
                      const isSpam = lap.penanda?.includes('perlu_verifikasi_tambahan');
                      return (
                        <tr key={lap.id} className={cn('text-navy transition', isSpam && 'bg-rose-50/50')}>
                          <td className="px-4 py-3 font-mono font-bold">
                            <Link href={`/riwayat?kode=${lap.kode_lacak}`} className="text-crimson hover:underline">
                              #{lap.kode_lacak}
                            </Link>
                          </td>
                          <td className="px-4 py-3 max-w-xs">
                            <p className="font-bold truncate">{lap.judul}</p>
                            <p className="text-[11px] text-navy/60 truncate">{lap.deskripsi}</p>
                          </td>
                          <td className="px-4 py-3 font-medium">{lap.kecamatan || '—'}</td>
                          <td className="px-4 py-3">
                            {isSpam ? (
                              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded bg-rose-100 text-rose-800 font-bold border border-rose-200">
                                Terindikasi Spam / Ilegal
                              </span>
                            ) : (
                              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded bg-slate-100 text-navy/70 font-semibold">
                                Normal ({lap.status})
                              </span>
                            )}
                          </td>
                          <td className="px-4 py-3 text-right">
                            <div className="flex items-center justify-end gap-1.5">
                              {isSpam && (
                                <button
                                  type="button"
                                  disabled={sedangMemprosesId === lap.id}
                                  onClick={() => handleModerasiStatus(lap.id, 'verifikasi_sah')}
                                  className="px-2.5 py-1.5 rounded-lg bg-emerald-600 hover:bg-emerald-700 text-white font-bold transition flex items-center gap-1 disabled:opacity-50"
                                  title="Verifikasi sebagai laporan sah"
                                >
                                  <CheckCircle className="size-3.5" />
                                  <span>Verifikasi Sah</span>
                                </button>
                              )}
                              {lap.status !== 'ditolak' && (
                                <button
                                  type="button"
                                  disabled={sedangMemprosesId === lap.id}
                                  onClick={() => handleModerasiStatus(lap.id, 'tolak_spam')}
                                  className="px-2.5 py-1.5 rounded-lg border border-navy/20 bg-white hover:bg-slate-100 text-navy font-bold transition flex items-center gap-1 disabled:opacity-50"
                                  title="Tolak laporan sebagai bukan fasilitas publik"
                                >
                                  <XCircle className="size-3.5 text-navy/60" />
                                  <span>Tolak</span>
                                </button>
                              )}
                              <button
                                type="button"
                                disabled={sedangMemprosesId === lap.id}
                                onClick={() => handleHapusLaporan(lap.id, lap.kode_lacak)}
                                className="px-2.5 py-1.5 rounded-lg bg-crimson hover:bg-[#8a002b] text-white font-bold transition flex items-center gap-1 disabled:opacity-50"
                                title="Hapus laporan dari database"
                              >
                                <Trash2 className="size-3.5" />
                                <span>Hapus Laporan</span>
                              </button>
                            </div>
                          </td>
                        </tr>
                      );
                    })
                  )}
                </tbody>
              </table>
            </div>
          </section>
        </Reveal>
      )}

      {/* ── TAB 2: KELOLA PENGGUNA ── */}
      {tabAktif === 'pengguna' && (
        <Reveal delay={60}>
          <section className="rounded-3xl border border-navy/10 bg-panel p-5 shadow-sm sm:p-7 space-y-4">
            <div>
              <h2 className="text-lg font-extrabold text-navy">Akun Pengguna Terdaftar</h2>
              <p className="text-xs text-navy/70 mt-0.5">Daftar akun warga, petugas, dan administrator sistem.</p>
            </div>

            {errorUsers && <p role="alert" className="mb-4 rounded-xl border border-rose-300 bg-rose-50 p-3 text-sm text-crimson">{errorUsers}</p>}

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
                  {loadingUsers ? (
                    <tr><td colSpan={4} className="px-4 py-8 text-center text-navy/60">Memuat akun…</td></tr>
                  ) : errorUsers ? (
                    <tr><td colSpan={4} className="px-4 py-8 text-center text-navy/60">Akun tidak dapat dimuat.</td></tr>
                  ) : users.length === 0 ? (
                    <tr><td colSpan={4} className="px-4 py-8 text-center text-navy/60">Belum ada akun.</td></tr>
                  ) : users.map((user) => (
                    <tr key={user.id} className="text-navy">
                      <td className="px-4 py-3 font-semibold">{user.nama || '—'}</td>
                      <td className="px-4 py-3 capitalize font-bold">
                        <span className={cn(
                          'px-2 py-0.5 rounded text-xs',
                          user.role === 'admin' ? 'bg-indigo-100 text-indigo-800' :
                          user.role === 'petugas' ? 'bg-emerald-100 text-emerald-800' : 'bg-slate-100 text-navy'
                        )}>
                          {user.role}
                        </span>
                      </td>
                      <td className="px-4 py-3">{user.dinas?.nama || '—'}</td>
                      <td className="px-4 py-3">{new Date(user.created_at).toLocaleDateString('id-ID')}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </section>
        </Reveal>
      )}
    </main>
  );
}
