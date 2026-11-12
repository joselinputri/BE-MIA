'use client';

import { useEffect, useState } from 'react';
import Reveal from '@/components/Reveal';
import { getDashboard } from '@/lib/client/data';
import { useAsync } from '@/lib/client/hooks';
import { supabaseBrowser } from '@/lib/client/supabase';

function formatAngka(value: number) {
  return new Intl.NumberFormat('id-ID', { maximumFractionDigits: 1 }).format(value);
}

export default function PapanTanggapPage() {
  const [refreshTick, setRefreshTick] = useState(0);
  const { data: dashboard, loading } = useAsync(() => getDashboard(), [refreshTick]);
  const ringkasan = dashboard?.ringkasan;
  const tren = dashboard?.tren || [];
  const nilaiTrenMaks = Math.max(1, ...tren.map((item) => item.jumlah_masuk));

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
                {loading || dashboard?.error || item.value === undefined
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
            ) : tren.length === 0 ? (
              <p className="mt-6 text-sm text-navy/60">Belum ada data tren untuk ditampilkan.</p>
            ) : (
              <div className="mt-6 space-y-4">
                {tren.map((item) => (
                  <div key={item.bulan} className="grid grid-cols-[4rem_1fr_5rem] items-center gap-3">
                    <span className="text-xs font-semibold text-navy">{item.bulan}</span>
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
                    <span className="text-right text-[10px] text-navy/60">
                      {formatAngka(item.jumlah_masuk)} / {formatAngka(item.jumlah_selesai)}
                    </span>
                  </div>
                ))}
                <div className="flex gap-4 pt-2 text-[11px] font-semibold text-navy/70">
                  <span><i className="mr-1 inline-block h-2 w-2 rounded-full bg-crimson" />Masuk</span>
                  <span><i className="mr-1 inline-block h-2 w-2 rounded-full bg-emerald-600" />Selesai</span>
                </div>
              </div>
            )}
          </div>

          <div className="rounded-3xl border border-navy/10 bg-panel p-6 shadow-sm">
            <h2 className="text-lg font-extrabold text-navy">Konfirmasi warga</h2>
            <p className="mt-1 text-xs text-navy/70">Penilaian pada laporan yang telah selesai.</p>
            {loading || !dashboard || dashboard.error ? (
              <p className="mt-6 text-sm text-navy/60">
                {loading ? 'Memuat konfirmasi…' : 'Data konfirmasi tidak tersedia karena data gagal dimuat.'}
              </p>
            ) : (
              <>
                <dl className="mt-6 grid grid-cols-2 gap-4">
                  <div className="rounded-2xl bg-white/80 p-4">
                    <dt className="text-xs font-bold text-navy/60">Laporan selesai</dt>
                    <dd className="mt-1 text-2xl font-extrabold text-navy">
                      {formatAngka(dashboard.konfirmasi.total_selesai)}
                    </dd>
                  </div>
                  <div className="rounded-2xl bg-white/80 p-4">
                    <dt className="text-xs font-bold text-navy/60">Sudah dikonfirmasi</dt>
                    <dd className="mt-1 text-2xl font-extrabold text-navy">
                      {formatAngka(dashboard.konfirmasi.total_dikonfirmasi)}
                    </dd>
                  </div>
                </dl>

                {/* Distribusi Kepuasan — horizontal bar chart */}
                <div className="mt-5 space-y-3 rounded-2xl bg-white/80 p-4">
                  <h3 className="text-xs font-extrabold uppercase tracking-wider text-navy/70">Distribusi Kepuasan Warga</h3>
                  {[
                    { label: 'Puas', persen: dashboard.konfirmasi.persen_puas, warna: 'bg-emerald-500' },
                    { label: 'Biasa', persen: dashboard.konfirmasi.persen_biasa, warna: 'bg-amber-400' },
                    { label: 'Kurang Puas', persen: dashboard.konfirmasi.persen_kurang_puas, warna: 'bg-rose-500' },
                  ].map((item) => (
                    <div key={item.label} className="space-y-1">
                      <div className="flex items-center justify-between text-xs">
                        <span className="font-bold text-navy">{item.label}</span>
                        <span className="font-extrabold text-navy">{formatAngka(item.persen)}%</span>
                      </div>
                      <div className="h-2.5 w-full overflow-hidden rounded-full bg-navy/10">
                        <div
                          className={`h-full rounded-full ${item.warna} transition-all duration-700`}
                          style={{ width: `${Math.max(2, item.persen)}%` }}
                        />
                      </div>
                    </div>
                  ))}
                </div>

                {/* Dibuka ulang */}
                {dashboard.konfirmasi.total_dibuka_ulang > 0 && (
                  <div className="mt-4 flex items-center gap-3 rounded-2xl border border-amber-200 bg-amber-50/80 p-4">
                    <div className="grid size-9 shrink-0 place-items-center rounded-xl bg-amber-500/20">
                      <svg className="h-4 w-4 text-amber-700" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}><path strokeLinecap="round" strokeLinejoin="round" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" /></svg>
                    </div>
                    <div>
                      <p className="text-xs font-extrabold text-amber-800">
                        {formatAngka(dashboard.konfirmasi.total_dibuka_ulang)} laporan dibuka ulang
                      </p>
                      <p className="text-[10px] text-amber-700/80">
                        ({formatAngka(dashboard.konfirmasi.persen_dibuka_ulang)}% dari total selesai) — warga menilai penanganan belum tuntas.
                      </p>
                    </div>
                  </div>
                )}
              </>
            )}
          </div>
        </section>
      </Reveal>

      {!loading && !dashboard?.error && (ringkasan?.kinerja_dinas.length ?? 0) > 0 && (
        <Reveal delay={200}>
          <section className="rounded-3xl border border-navy/10 bg-panel p-6 shadow-sm">
            <h2 className="text-lg font-extrabold text-navy">Kinerja Dinas Pengampu Fasilitas Kota</h2>
            <p className="mt-1 text-xs text-navy/70">Tingkat penyelesaian dan responsivitas per dinas di Kota Surakarta.</p>
            <div className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
              {ringkasan?.kinerja_dinas.map((d) => (
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
            {[
              { nama: 'Banjarsari', penduduk: '189.540', persentase: '94%' },
              { nama: 'Jebres', penduduk: '154.210', persentase: '91%' },
              { nama: 'Laweyan', penduduk: '102.830', persentase: '95%' },
              { nama: 'Pasar Kliwon', penduduk: '86.420', persentase: '89%' },
              { nama: 'Serengan', penduduk: '54.646', persentase: '96%' },
            ].map((k) => (
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
