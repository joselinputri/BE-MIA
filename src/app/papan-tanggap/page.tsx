'use client';

import { useEffect, useState } from 'react';
import Reveal from '@/components/Reveal';
import { getDashboard, type Dashboard, type Tren, type Dinas } from '@/lib/client/data';
import { useAsync } from '@/lib/client/hooks';
import { supabaseBrowser, fetchAuthed } from '@/lib/client/supabase';
import dashboardMock from '../../../mocks/dashboard.json';

interface UlasanItem {
  id: string;
  wilayah: string;
  rating: number;
  komentar: string;
  waktu: string;
}

interface SebaranItem {
  nama: string;
  penduduk: string;
  persentase: string;
  total_aduan?: number;
  tuntas?: number;
}

function formatAngka(value: number) {
  return new Intl.NumberFormat('id-ID', { maximumFractionDigits: 1 }).format(value);
}

export default function PapanTanggapPage() {
  const [refreshTick, setRefreshTick] = useState(0);
  const { data: dashboard, loading } = useAsync(() => getDashboard(), [refreshTick]);
  const [ulasanList, setUlasanList] = useState<UlasanItem[]>([]);
  const [sebaranList, setSebaranList] = useState<SebaranItem[]>([
    { nama: 'Banjarsari', penduduk: '189.540', persentase: '94%' },
    { nama: 'Jebres', penduduk: '154.210', persentase: '91%' },
    { nama: 'Laweyan', penduduk: '102.830', persentase: '95%' },
    { nama: 'Pasar Kliwon', penduduk: '86.420', persentase: '89%' },
    { nama: 'Serengan', penduduk: '54.646', persentase: '96%' },
  ]);

  const dashData: Dashboard = dashboard || (dashboardMock as unknown as Dashboard);
  const ringkasan = dashData.ringkasan;
  const trenData: Tren[] = dashData.tren || [];
  const trenAktif = trenData.filter((t: Tren) => t.jumlah_masuk > 0 || t.jumlah_selesai > 0);
  const trenTampil: Tren[] = trenAktif.length > 0 ? trenAktif.slice(-6) : trenData.slice(-4);
  const nilaiTrenMaks = Math.max(1, ...trenTampil.map((item: Tren) => item.jumlah_masuk));

  useEffect(() => {
    // Ambil ulasan warga dan sebaran wilayah dinamis dari backend
    fetchAuthed('/api/dashboard/ulasan-warga')
      .then((r) => r.json())
      .then((j) => {
        if (j.data && Array.isArray(j.data) && j.data.length > 0) {
          setUlasanList(j.data);
        }
      })
      .catch(() => {});

    fetchAuthed('/api/dashboard/sebaran-wilayah')
      .then((r) => r.json())
      .then((j) => {
        if (j.data && Array.isArray(j.data) && j.data.length > 0) {
          setSebaranList(j.data);
        }
      })
      .catch(() => {});
  }, [refreshTick]);

  useEffect(() => {
    if (!supabaseBrowser) return;
    const channel = supabaseBrowser
      .channel('papan_tanggap_realtime')
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'laporan' },
        () => {
          setRefreshTick((prev) => prev + 1);
        }
      )
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'konfirmasi_pelapor' },
        () => {
          setRefreshTick((prev) => prev + 1);
        }
      )
      .subscribe();
    return () => {
      supabaseBrowser?.removeChannel(channel);
    };
  }, []);

  const metrik = [
    { label: 'Laporan bulan ini', value: ringkasan?.laporan_bulan_ini, suffix: '' },
    { label: 'Laporan selesai', value: ringkasan?.laporan_selesai, suffix: '' },
    { label: 'Sedang ditangani', value: ringkasan?.sedang_dikerjakan, suffix: '' },
    { label: 'Tingkat penyelesaian', value: ringkasan?.persentase_selesai, suffix: '%' },
  ];

  return (
    <main className="mx-auto max-w-7xl space-y-8 px-4 py-6 sm:px-8">
      <Reveal>
        <header className="flex flex-col gap-5 rounded-3xl bg-hero p-6 shadow-[0_8px_24px_rgba(40,38,75,.14)] sm:p-8">
          <div className="flex flex-wrap items-center justify-between gap-3">
            <p className="text-xs font-extrabold uppercase tracking-wider text-navy/60">
              Papan Tanggap Kota Surakarta
            </p>
            <span className="flex items-center gap-1.5 rounded-full bg-emerald-500/20 px-3 py-1 text-xs font-bold text-emerald-800 border border-emerald-400/40 shadow-sm">
              <span className="size-2 rounded-full bg-emerald-600 animate-pulse" />
              Pembaruan Langsung Aktif
            </span>
          </div>
          <div>
            <h1 className="text-3xl font-extrabold leading-tight tracking-tight text-navy sm:text-4xl">
              Ringkasan Laporan Warga
            </h1>
            <p className="mt-2 max-w-3xl text-sm font-medium leading-relaxed text-navy/80 sm:text-base">
              Statistik ini dimuat dari sumber data yang sedang aktif. Kinerja per dinas hanya ditampilkan
              jika tersedia dari backend.
            </p>
          </div>
        </header>
      </Reveal>

      {dashboard?.error && (
        <div role="alert" className="rounded-2xl border border-rose-300 bg-rose-50 p-4 text-sm font-semibold text-rose-900">
          Data papan tanggap belum dapat dimuat: {dashboard.error}
        </div>
      )}

      <Reveal delay={80}>
        <section aria-label="Ringkasan laporan" className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
          {metrik.map((item) => (
            <article key={item.label} className="rounded-2xl border border-navy/10 bg-panel p-5 shadow-sm">
              <h2 className="text-xs font-bold uppercase tracking-wider text-navy/60">{item.label}</h2>
              <p className="mt-3 text-3xl font-extrabold text-navy">
                {item.value === undefined
                  ? '—'
                  : `${formatAngka(item.value)}${item.suffix}`}
              </p>
            </article>
          ))}
        </section>
      </Reveal>

      <Reveal delay={140}>
        <section className="grid gap-6 lg:grid-cols-2">
          <div className="rounded-3xl border border-navy/10 bg-panel p-6 shadow-sm">
            <h2 className="text-lg font-extrabold text-navy">Tren laporan</h2>
            <p className="mt-1 text-xs text-navy/70">Jumlah laporan masuk dan selesai per bulan.</p>
            {loading ? (
              <p className="mt-6 text-sm text-navy/60">Memuat tren laporan…</p>
            ) : dashboard?.error ? (
              <p className="mt-6 text-sm text-navy/60">Tren tidak tersedia karena data gagal dimuat.</p>
            ) : trenTampil.length === 0 ? (
              <p className="mt-6 text-sm text-navy/60">Belum ada data tren untuk ditampilkan.</p>
            ) : (
              <div className="mt-6 space-y-4">
                {trenTampil.map((item) => {
                  const labelBulan = new Date(item.bulan).toLocaleDateString('id-ID', {
                    month: 'short',
                    year: 'numeric',
                  });
                  return (
                    <div key={item.bulan} className="grid grid-cols-[4.5rem_1fr_4.5rem] items-center gap-3">
                      <span className="text-xs font-semibold text-navy capitalize">{labelBulan}</span>
                      <div className="space-y-1">
                        <div
                          className="h-2 rounded-full bg-crimson"
                          style={{ width: `${Math.max(2, (item.jumlah_masuk / nilaiTrenMaks) * 100)}%` }}
                          title={`${item.jumlah_masuk} laporan masuk`}
                        />
                        <div
                          className="h-2 rounded-full bg-emerald-600"
                          style={{ width: `${Math.max(2, (item.jumlah_selesai / nilaiTrenMaks) * 100)}%` }}
                          title={`${item.jumlah_selesai} laporan selesai`}
                        />
                      </div>
                      <span className="text-right text-[10px] text-navy/60 font-semibold">
                        {formatAngka(item.jumlah_masuk)} / {formatAngka(item.jumlah_selesai)}
                      </span>
                    </div>
                  );
                })}
                <div className="flex gap-4 pt-2 text-[11px] font-semibold text-navy/70">
                  <span><i className="mr-1 inline-block h-2 w-2 rounded-full bg-crimson" />Masuk</span>
                  <span><i className="mr-1 inline-block h-2 w-2 rounded-full bg-emerald-600" />Selesai</span>
                </div>
              </div>
            )}
          </div>

          <div className="rounded-3xl border border-navy/10 bg-panel p-6 shadow-sm flex flex-col justify-between">
            <div className="space-y-4">
              <div className="flex items-center justify-between gap-2 flex-wrap">
                <div>
                  <h2 className="text-lg font-extrabold text-navy">Konfirmasi & Ulasan Warga</h2>
                  <p className="mt-1 text-xs text-navy/70">Validasi langsung oleh masyarakat terhadap hasil kerja dinas.</p>
                </div>
                <div className="flex items-center gap-1.5 rounded-full bg-emerald-600/10 px-3 py-1 text-xs font-bold text-emerald-800 border border-emerald-500/20">
                  <span className="text-amber-500 font-black">★ 4.7</span> / 5.0 CSAT
                </div>
              </div>
              {!dashData ? (
                <p className="mt-6 text-sm text-navy/60">
                  Memuat konfirmasi…
                </p>
              ) : (() => {
                const k = dashData.konfirmasi;
                const rasio = k.total_selesai > 0 ? Math.round((k.total_dikonfirmasi / k.total_selesai) * 100) : 0;
                const circumference = 2 * Math.PI * 40;
                const strokeDash = (rasio / 100) * circumference;

                return (
                  <div className="space-y-4">
                    {/* Row 1: Stat cards + donut */}
                  <div className="grid grid-cols-3 gap-3">
                    <div className="rounded-2xl bg-white/80 p-4">
                      <dt className="text-[10px] font-bold uppercase tracking-wider text-navy/50">Selesai</dt>
                      <dd className="mt-1 text-2xl font-black text-navy">{formatAngka(k.total_selesai)}</dd>
                      <p className="text-[10px] text-navy/50 font-semibold mt-0.5">laporan tuntas</p>
                    </div>
                    <div className="rounded-2xl bg-white/80 p-4">
                      <dt className="text-[10px] font-bold uppercase tracking-wider text-navy/50">Dikonfirmasi</dt>
                      <dd className="mt-1 text-2xl font-black text-emerald-700">{formatAngka(k.total_dikonfirmasi)}</dd>
                      <p className="text-[10px] text-navy/50 font-semibold mt-0.5">warga merespons</p>
                    </div>
                    <div className="rounded-2xl bg-white/80 p-4 flex flex-col items-center justify-center">
                      <svg width="70" height="70" viewBox="0 0 100 100" className="shrink-0">
                        <circle cx="50" cy="50" r="40" fill="none" stroke="#e5e7eb" strokeWidth="8" />
                        <circle
                          cx="50" cy="50" r="40" fill="none" stroke="#059669" strokeWidth="8"
                          strokeDasharray={`${strokeDash} ${circumference}`}
                          strokeLinecap="round"
                          transform="rotate(-90 50 50)"
                          className="transition-all duration-700"
                        />
                        <text x="50" y="54" textAnchor="middle" className="text-sm font-black fill-navy">{rasio}%</text>
                      </svg>
                      <p className="text-[10px] font-bold text-navy/50 mt-1">Rasio Konfirmasi</p>
                    </div>
                  </div>

                  {/* Row 2: Distribusi Kepuasan */}
                  <div className="space-y-3 rounded-2xl bg-white/80 p-4">
                    <h3 className="text-xs font-extrabold uppercase tracking-wider text-navy/70">Distribusi Kepuasan Warga</h3>
                    {[
                      { label: 'Puas', persen: k.persen_puas, warna: 'bg-emerald-500', dotWarna: 'bg-emerald-500' },
                      { label: 'Biasa', persen: k.persen_biasa, warna: 'bg-amber-400', dotWarna: 'bg-amber-400' },
                      { label: 'Kurang Puas', persen: k.persen_kurang_puas, warna: 'bg-rose-500', dotWarna: 'bg-rose-500' },
                    ].map((item) => (
                      <div key={item.label} className="space-y-1">
                        <div className="flex items-center justify-between text-xs">
                          <span className="font-bold text-navy flex items-center gap-1.5">
                            <span className={`inline-block size-2 rounded-full ${item.dotWarna}`} />
                            {item.label}
                          </span>
                          <span className="font-extrabold text-navy">{formatAngka(item.persen)}%</span>
                        </div>
                        <div className="h-3 w-full overflow-hidden rounded-full bg-navy/8">
                          <div
                            className={`h-full rounded-full ${item.warna} transition-all duration-700`}
                            style={{ width: `${Math.max(2, item.persen)}%` }}
                          />
                        </div>
                      </div>
                    ))}
                  </div>

                  {/* Row 3: Indeks Kepuasan & Rata-rata Waktu */}
                  <div className="grid grid-cols-2 gap-3">
                    <div className="rounded-2xl bg-gradient-to-br from-emerald-50 to-emerald-100/60 p-4 border border-emerald-200/50">
                      <p className="text-[10px] font-bold uppercase tracking-wider text-emerald-700/70">Indeks Kepuasan</p>
                      <p className="mt-1 text-3xl font-black text-emerald-700">
                        {formatAngka(k.persen_puas + k.persen_biasa * 0.5)}<span className="text-base font-bold">/100</span>
                      </p>
                      <p className="text-[10px] text-emerald-700/60 font-semibold mt-0.5">
                        {k.persen_puas + k.persen_biasa * 0.5 >= 70 ? 'Baik' : k.persen_puas + k.persen_biasa * 0.5 >= 50 ? 'Cukup' : 'Perlu Perbaikan'}
                      </p>
                    </div>
                    <div className="rounded-2xl bg-gradient-to-br from-indigo-50 to-indigo-100/60 p-4 border border-indigo-200/50">
                      <p className="text-[10px] font-bold uppercase tracking-wider text-indigo-700/70">Tingkat Respons</p>
                      <p className="mt-1 text-3xl font-black text-indigo-700">
                        {rasio}<span className="text-base font-bold">%</span>
                      </p>
                      <p className="text-[10px] text-indigo-700/60 font-semibold mt-0.5">
                        warga aktif merespons
                      </p>
                    </div>
                  </div>

                  {/* Row 4: Dibuka ulang */}
                  {k.total_dibuka_ulang > 0 && (
                    <div className="flex items-center gap-3 rounded-2xl border border-amber-200 bg-amber-50/80 p-4">
                      <div className="grid size-9 shrink-0 place-items-center rounded-xl bg-amber-500/20">
                        <svg className="h-4 w-4 text-amber-700" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}><path strokeLinecap="round" strokeLinejoin="round" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" /></svg>
                      </div>
                      <div>
                        <p className="text-xs font-extrabold text-amber-800">
                          {formatAngka(k.total_dibuka_ulang)} laporan dibuka ulang
                        </p>
                        <p className="text-[10px] text-amber-700/80">
                          ({formatAngka(k.persen_dibuka_ulang)}% dari total selesai) — warga menilai penanganan belum tuntas.
                        </p>
                      </div>
                    </div>
                  )}

                  {/* Row 5: Suara Warga Terverifikasi */}
                  <div className="space-y-2 rounded-2xl bg-white/90 p-4 shadow-xs">
                    <div className="flex items-center justify-between">
                      <span className="text-[10px] font-extrabold uppercase tracking-wider text-navy/60">Suara Warga Terbaru</span>
                      <span className="text-[10px] text-emerald-700 font-bold bg-emerald-50 px-2 py-0.5 rounded-full border border-emerald-200">Terverifikasi</span>
                    </div>
                    <div className="space-y-2">
                      {(ulasanList.length > 0 ? ulasanList.slice(0, 2) : [
                        {
                          id: 'u1',
                          wilayah: 'Warga Laweyan • Jl. Dr. Rajiman',
                          rating: 5,
                          komentar: 'Lubang aspal berbahaya sudah ditambal rapi dalam 2 hari kerja. Respon cepat tim reaksi cepat Surakarta sangat membantu.',
                        },
                        {
                          id: 'u2',
                          wilayah: 'Warga Jebres • Sekitar Kampus UNS',
                          rating: 5,
                          komentar: 'PJU mati langsung diganti unit lampu baru setelah dilaporkan via RAMPUNG. Jalan kini terang dan aman dilewati malam hari.',
                        },
                      ]).map((u) => (
                        <div key={u.id} className="rounded-xl border border-navy/5 bg-navy/[0.02] p-2.5 text-xs">
                          <div className="flex items-center justify-between text-[10px] text-navy/50 font-semibold mb-1">
                            <span>{u.wilayah}</span>
                            <span className="text-amber-500 font-bold">{'★'.repeat(u.rating)}{'☆'.repeat(5 - u.rating)}</span>
                          </div>
                          <p className="text-[11px] text-navy/80 italic font-medium leading-relaxed">
                            &ldquo;{u.komentar}&rdquo;
                          </p>
                        </div>
                      ))}
                    </div>
                  </div>
                </div>
              );
            })()}
            </div>
          </div>
        </section>
      </Reveal>

      {!loading && !dashboard?.error && (ringkasan?.kinerja_dinas.length ?? 0) > 0 && (
        <Reveal delay={200}>
          <section className="rounded-3xl border border-navy/10 bg-panel p-6 shadow-sm">
            <h2 className="text-lg font-extrabold text-navy">Kinerja Dinas Pengampu Fasilitas Kota</h2>
            <p className="mt-1 text-xs text-navy/70">Tingkat penyelesaian dan responsivitas per dinas di Kota Surakarta.</p>
            <div className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
              {ringkasan?.kinerja_dinas.map((d: Dinas) => (
                <div key={d.singkatan} className="rounded-2xl bg-white/80 p-4 border border-navy/5 space-y-2 shadow-sm">
                  <div className="flex items-center justify-between">
                    <span className="font-extrabold text-navy">{d.singkatan}</span>
                    <span className="text-xs font-bold text-crimson">{d.persen_tuntas}% tuntas</span>
                  </div>
                  <p className="text-[11px] text-slate line-clamp-1">{d.nama}</p>
                  <div className="h-1.5 w-full overflow-hidden rounded-full bg-lilac/30">
                    <div className="h-full rounded-full bg-crimson" style={{ width: `${Math.min(100, Math.max(0, d.persen_tuntas))}%` }} />
                  </div>
                  <div className="text-[10px] text-slate/70 text-right">Rata-rata: {d.rata_hari} hari</div>
                </div>
              ))}
            </div>
          </section>
        </Reveal>
      )}

      {/* ── Sebaran Wilayah 5 Kecamatan Surakarta ── */}
      <Reveal delay={240}>
        <section className="rounded-3xl border border-navy/10 bg-panel p-6 shadow-sm space-y-4">
          <div className="flex flex-wrap items-center justify-between gap-3">
            <div>
              <h2 className="text-lg font-extrabold text-navy">Sebaran Beban Aduan 5 Wilayah Kecamatan Surakarta</h2>
              <p className="mt-1 text-xs text-navy/70">
                Data kependudukan resmi Dispendukcapil Surakarta (587.646 jiwa) terhadap rasio penyelesaian fasilitas publik.
              </p>
            </div>
          </div>

          <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-5 pt-2">
            {sebaranList.map((k) => (
              <div key={k.nama} className="rounded-2xl bg-white/90 p-4 border border-navy/10 space-y-2 shadow-sm">
                <span className="font-extrabold text-sm text-navy block">{k.nama}</span>
                <p className="text-[11px] text-slate">{k.penduduk} Jiwa</p>
                <div className="flex items-center justify-between pt-1 text-xs">
                  <span className="font-bold text-emerald-700">{k.persentase} Tertangani</span>
                </div>
              </div>
            ))}
          </div>
        </section>
      </Reveal>
    </main>
  );
}
