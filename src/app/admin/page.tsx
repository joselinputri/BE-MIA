'use client';

import { useEffect, useState, useCallback } from 'react';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { ShieldCheck, UsersRound, ClipboardList, AlertTriangle, CheckCircle, Trash2, XCircle, FileText, Activity } from 'lucide-react';
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
  const [tabAktif, setTabAktif] = useState<'moderasi' | 'pengguna' | 'audit'>('moderasi');

  // State Pengguna
  const [users, setUsers] = useState<AdminUser[]>([]);
  const [loadingUsers, setLoadingUsers] = useState(true);
  const [errorUsers, setErrorUsers] = useState<string | null>(null);

  // State Audit Logs
  const [auditLogs, setAuditLogs] = useState<any[]>([]);
  const [loadingAudit, setLoadingAudit] = useState(false);

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

    // Muat Audit Logs
    setLoadingAudit(true);
    void fetchAuthed('/api/admin/audit-log')
      .then(async (res) => {
        const j = await res.json();
        if (aktif && j.data) setAuditLogs(j.data);
      })
      .catch(() => {})
      .finally(() => {
        if (aktif) setLoadingAudit(false);
      });

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
      let bodyData: any = { aksi };
      if (aksi === 'verifikasi_sah') {
        const regu = prompt('Masukkan nama Regu Pelaksana (contoh: Tim Reaksi Cepat DPUPR Surakarta):', 'Tim Reaksi Cepat DPUPR Surakarta');
        if (regu === null) {
          setSedangMemprosesId(null);
          return;
        }
        const mandor = prompt('Masukkan nama Mandor / Penanggung Jawab Lapangan:', 'Bambang Triyono, S.T.');
        const surat = prompt('Masukkan Nomor Surat Tugas:', 'ST-2026-DPUPR-SKA');
        bodyData.catatan_teknis = {
          regu_pelaksana: regu || 'Tim Reaksi Cepat Dinas Pengampu',
          mandor: mandor || 'Petugas Lapangan Berwenang',
          surat_tugas: surat || 'ST-2026-SURAKARTA',
          spesifikasi_material: 'Standar Teknis Lapangan SNI',
          waktu_penugasan: new Date().toLocaleString('id-ID'),
        };
      } else {
        bodyData.alasan = 'Ditolak oleh admin: Bukan fasilitas publik / spam';
      }

      const res = await fetchAuthed(`/api/admin/laporan/${id}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(bodyData),
      });
      const json = await res.json();
      if (!res.ok) throw new Error(json.error?.pesan || 'Gagal memoderasi laporan.');
      setPesanAksi(aksi === 'verifikasi_sah' ? 'Laporan berhasil diverifikasi sah & tim lapangan ditugaskan.' : 'Laporan ditolak.');
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
        <button
          type="button"
          onClick={() => setTabAktif('audit')}
          className={cn(
            'px-4 py-2 rounded-xl text-xs font-bold transition-all flex items-center gap-2',
            tabAktif === 'audit'
              ? 'bg-crimson text-white shadow-sm'
              : 'bg-white/80 text-navy hover:bg-white'
          )}
        >
          <FileText className="size-4" />
          <span>Log Audit Keamanan ({auditLogs.length})</span>
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
                            {lap.status === 'ditolak' ? (
                              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded bg-rose-100 text-crimson font-bold border border-rose-300">
                                Ditolak (Spam / Non-Fasilitas)
                              </span>
                            ) : lap.status === 'sedang_ditangani' ? (
                              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded bg-amber-100 text-amber-800 font-bold border border-amber-300">
                                Sedang Ditangani (Terverifikasi)
                              </span>
                            ) : lap.status === 'selesai' ? (
                              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded bg-emerald-100 text-emerald-800 font-bold border border-emerald-300">
                                Selesai
                              </span>
                            ) : isSpam ? (
                              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded bg-rose-100 text-rose-800 font-bold border border-rose-200">
                                Terindikasi Spam / Ilegal
                              </span>
                            ) : (
                              <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded bg-blue-100 text-blue-800 font-semibold border border-blue-200">
                                Baru Masuk (Perlu Verifikasi)
                              </span>
                            )}
                          </td>
                          <td className="px-4 py-3 text-right">
                            <div className="flex items-center justify-end gap-1.5">
                              {/* Hanya tampilkan tombol Verifikasi jika status masih MASUK dan bukan ditolak */}
                              {lap.status === 'masuk' && (
                                <button
                                  type="button"
                                  disabled={sedangMemprosesId === lap.id}
                                  onClick={() => handleModerasiStatus(lap.id, 'verifikasi_sah')}
                                  className="px-2.5 py-1.5 rounded-lg bg-emerald-600 hover:bg-emerald-700 text-white font-bold transition flex items-center gap-1 disabled:opacity-50"
                                  title="Verifikasi sah dan tugaskan regu/mandor"
                                >
                                  <CheckCircle className="size-3.5" />
                                  <span>Verifikasi & Tugaskan</span>
                                </button>
                              )}

                              {/* Tombol Tolak hanya jika belum ditolak dan belum selesai/diproses */}
                              {lap.status === 'masuk' && (
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

                              {/* Jika sudah diproses, beri indikator label */}
                              {lap.status === 'sedang_ditangani' && (
                                <span className="text-[11px] font-bold text-amber-700 bg-amber-50 px-2 py-1 rounded-lg border border-amber-200">
                                  Sedang Berjalan
                                </span>
                              )}

                              {/* Tombol Hapus selalu tersedia untuk admin membersihkan DB */}
                              <button
                                type="button"
                                disabled={sedangMemprosesId === lap.id}
                                onClick={() => handleHapusLaporan(lap.id, lap.kode_lacak)}
                                className="px-2.5 py-1.5 rounded-lg bg-crimson hover:bg-[#8a002b] text-white font-bold transition flex items-center gap-1 disabled:opacity-50"
                                title="Hapus laporan dari database"
                              >
                                <Trash2 className="size-3.5" />
                                <span>Hapus</span>
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

      {/* ── TAB 3: LOG AUDIT KEAMANAN (APPEND-ONLY) ── */}
      {tabAktif === 'audit' && (
        <Reveal delay={60}>
          <section className="rounded-3xl border border-navy/10 bg-panel p-5 shadow-sm sm:p-7 space-y-4">
            <div>
              <h2 className="text-lg font-extrabold text-navy">Log Audit Keamanan (Append-Only Trail)</h2>
              <p className="text-xs text-navy/70 mt-0.5">
                Pencatatan kriptografis seluruh aksi administratif sensitif, moderasi tiket, dan perubahan peran pengguna untuk audit transparansi.
              </p>
            </div>

            <div className="overflow-x-auto rounded-2xl border border-navy/10 bg-white">
              <table className="w-full min-w-[700px] text-left text-xs">
                <thead className="bg-card text-[11px] uppercase text-navy/70">
                  <tr>
                    <th className="px-4 py-3">Waktu Kejadian</th>
                    <th className="px-4 py-3">Aksi Administratif</th>
                    <th className="px-4 py-3">Target Entitas</th>
                    <th className="px-4 py-3">Pelaksana</th>
                    <th className="px-4 py-3">Alamat IP / Jejak</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-navy/10">
                  {loadingAudit ? (
                    <tr><td colSpan={5} className="px-4 py-8 text-center text-navy/60">Memuat catatan log audit…</td></tr>
                  ) : auditLogs.length === 0 ? (
                    <tr>
                      <td colSpan={5} className="px-4 py-8 text-center text-navy/60">
                        Belum ada aktivitas administratif sensitif yang tercatat pada sesi ini.
                      </td>
                    </tr>
                  ) : (
                    auditLogs.map((log, idx) => (
                      <tr key={log.id || idx} className="text-navy">
                        <td className="px-4 py-3 font-mono text-[11px]">
                          {log.created_at ? new Date(log.created_at).toLocaleString('id-ID') : '—'}
                        </td>
                        <td className="px-4 py-3 font-bold">
                          <span className="px-2 py-0.5 rounded bg-slate-100 text-navy font-mono">
                            {log.aksi || 'MODIFIKASI_DATA'}
                          </span>
                        </td>
                        <td className="px-4 py-3 font-medium">
                          {log.tabel_target || log.target || 'Laporan'}
                          {log.record_id ? ` #${log.record_id.slice(0, 8)}` : ''}
                        </td>
                        <td className="px-4 py-3 font-semibold">
                          {log.user?.nama || 'Administrator'}
                        </td>
                        <td className="px-4 py-3 font-mono text-[10px] text-navy/60">
                          {log.ip_address || '127.0.0.1'}
                        </td>
                      </tr>
                    ))
                  )}
                </tbody>
              </table>
            </div>
          </section>
        </Reveal>
      )}
    </main>
  );
}
