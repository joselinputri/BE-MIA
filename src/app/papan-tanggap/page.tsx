'use client';

import Reveal from '@/components/Reveal';
import { getDashboard } from '@/lib/client/data';
import { useAsync } from '@/lib/client/hooks';

function formatAngka(value: number) {
  return new Intl.NumberFormat('id-ID', { maximumFractionDigits: 1 }).format(value);
}

export default function PapanTanggapPage() {
  const { data: dashboard, loading } = useAsync(getDashboard, []);
  const ringkasan = dashboard?.ringkasan;
  const tren = dashboard?.tren || [];
  const nilaiTrenMaks = Math.max(1, ...tren.map((item) => item.jumlah_masuk));

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
                <div className="col-span-2 rounded-2xl bg-white/80 p-4">
                  <dt className="text-xs font-bold text-navy/60">Penilaian puas</dt>
                  <dd className="mt-1 text-2xl font-extrabold text-navy">
                    {formatAngka(dashboard.konfirmasi.persen_puas)}%
                  </dd>
                </div>
              </dl>
            )}
          </div>
        </section>
      </Reveal>

      {!loading && !dashboard?.error && (ringkasan?.kinerja_dinas.length ?? 0) === 0 && (
        <p className="rounded-2xl border border-navy/10 bg-white/70 p-4 text-sm text-navy/70">
          Data kinerja per dinas belum disediakan backend, jadi peringkat dan angka dinas tidak ditampilkan.
        </p>
      )}
    </main>
  );
}
