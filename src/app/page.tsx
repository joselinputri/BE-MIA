'use client';

import { useMemo, useRef, useState } from 'react';
import dynamic from 'next/dynamic';
import Link from 'next/link';
import Image from 'next/image';
import { useRouter } from 'next/navigation';
import { Search, Mic, SlidersHorizontal, ArrowRight, MapPin, Activity } from 'lucide-react';
import Reveal from '@/components/Reveal';
import CountUp from '@/components/CountUp';
import { GearHero } from '@/components/GearDecor';
import { Panel, Kartu, Pil, tombolDasar } from '@/components/ui';
import { getDashboard, getLaporanPublik, type Dashboard, type Laporan } from '@/lib/client/data';
import { useAsync } from '@/lib/client/hooks';
import { cn } from '@/lib/utils';
import { KATEGORI } from '@/lib/kategori';

// Dynamic import Three.js agar tidak dievaluasi di Node.js server (SSR: false)
const ThreeGears = dynamic(() => import('@/components/ThreeGears'), {
  ssr: false,
  loading: () => (
    <div className="w-full h-52 flex items-center justify-center text-white/40 text-xs font-semibold">
    Memuat visualisasi 3D...
    </div>
  ),
});

interface SpeechRecognitionResultItem { transcript: string }
interface SpeechRecognitionInstance {
  lang: string;
  interimResults: boolean;
  maxAlternatives: number;
  onresult: ((event: { results: ArrayLike<ArrayLike<SpeechRecognitionResultItem>> }) => void) | null;
  onerror: ((event: { error?: string }) => void) | null;
  onend: (() => void) | null;
  start: () => void;
  stop: () => void;
}

declare global {
  interface Window {
    SpeechRecognition?: new () => SpeechRecognitionInstance;
    webkitSpeechRecognition?: new () => SpeechRecognitionInstance;
  }
}

const PetaLeaflet = dynamic(() => import('@/components/PetaLeaflet'), {
  ssr: false,
  loading: () => <div className="grid h-[300px] place-items-center rounded-2xl bg-navy text-sm font-semibold text-white/70">Memuat peta laporan…</div>,
});

export default function Beranda() {
  const router = useRouter();
  const [kode, setKode] = useState('');
  const [filterKec, setFilterKec] = useState('Semua');
  const [filterStatus, setFilterStatus] = useState('semua');
  const [filterKategori, setFilterKategori] = useState('semua');
  const [filterTerbuka, setFilterTerbuka] = useState(false);
  const [mendengarkan, setMendengarkan] = useState(false);
  const [voiceMessage, setVoiceMessage] = useState<string | null>(null);
  const recognitionRef = useRef<SpeechRecognitionInstance | null>(null);

  const { data: dash } = useAsync<Dashboard>(() => getDashboard(), []);
  const { data: laporanList, error: laporanError, loading: laporanLoading } =
    useAsync<Laporan[]>(() => getLaporanPublik(), []);

  const r = dash?.ringkasan;
  const laporanTersaring = useMemo(() => (laporanList || []).filter((laporan) => {
    const cocokKecamatan = filterKec === 'Semua' || laporan.kecamatan?.toLowerCase() === filterKec.toLowerCase();
    const cocokStatus = filterStatus === 'semua' || laporan.status === filterStatus;
    const cocokKategori = filterKategori === 'semua' || laporan.kategori_slug === filterKategori;
    return cocokKecamatan && cocokStatus && cocokKategori;
  }), [filterKec, filterKategori, filterStatus, laporanList]);
  const firstLaporan = laporanList?.[0];
  const laporanTerkini = laporanTersaring
    .slice(0, 3);
  const trenTerbaru = dash?.tren.slice(-4) || [];
  const nilaiTrenMaks = Math.max(1, ...trenTerbaru.map((item) => item.jumlah_masuk));

  function handleLacak() {
    if (!kode.trim()) return;
    router.push(`/riwayat?kode=${encodeURIComponent(kode.trim())}`);
  }

  function handleVoiceSearch() {
    const Recognition = window.SpeechRecognition || window.webkitSpeechRecognition;
    if (!Recognition) {
      setVoiceMessage('Pencarian suara tidak didukung browser ini. Ketik kode tiket untuk melacak laporan.');
      return;
    }

    setVoiceMessage(null);
    if (mendengarkan) {
      recognitionRef.current?.stop();
      return;
    }

    const recognition = new Recognition();
    recognition.lang = 'id-ID';
    recognition.interimResults = false;
    recognition.maxAlternatives = 1;
    recognition.onresult = (event) => {
      const transcript = event.results[0]?.[0]?.transcript?.trim();
      if (transcript) setKode(transcript);
    };
    recognition.onerror = (event) => {
      setVoiceMessage(event.error === 'not-allowed'
        ? 'Izinkan akses mikrofon di browser untuk menggunakan pencarian suara.'
        : 'Suara tidak dapat dikenali. Silakan coba lagi atau ketik kode tiket.');
      setMendengarkan(false);
    };
    recognition.onend = () => setMendengarkan(false);
    recognitionRef.current = recognition;
    setMendengarkan(true);
    recognition.start();
  }

  return (
    <main className="mx-auto max-w-7xl space-y-8 px-4 pb-16 pt-4">
      {dash?.error && (
        <div role="alert" className="rounded-xl border border-amber-300 bg-amber-50 px-4 py-3 text-sm font-medium text-amber-950">
          Data dashboard belum dapat dimuat dari Supabase. {dash.error}
        </div>
      )}
      {laporanError && (
        <div role="alert" className="rounded-xl border border-amber-300 bg-amber-50 px-4 py-3 text-sm font-medium text-amber-950">
          Update laporan belum dapat dimuat. {laporanError.message}
        </div>
      )}

      {/* ════════════════════════════════════════════
          1) HERO
         ════════════════════════════════════════════ */}
      <Reveal>
        <section
          aria-label="Hero"
          className="bg-hero text-navy relative overflow-hidden rounded-3xl px-6 py-12 shadow-lg sm:px-10 sm:py-16 md:py-20"
        >
          <GearHero />
          <div className="relative z-10 flex flex-col md:flex-row md:items-center justify-between gap-8">
            <div className="max-w-xl">
              <h1 className="text-4xl font-extrabold leading-tight sm:text-5xl md:text-6xl">
                Lapor Cepat.<br />
                <span className="text-crimson">Surakarta Beres.</span>
              </h1>
              <p className="mt-4 text-sm sm:text-base text-navy/80 leading-relaxed font-medium">
                Pantau penanganan nyata dari jalan berlubang hingga fasilitas difabel. Divalidasi langsung oleh warga dengan bukti komparasi sebelum-sesudah.
              </p>
              <Link
                href="/lapor"
                className={cn(tombolDasar, 'bg-cta mt-6 rounded-xl px-7 py-3 text-base text-white shadow-md hover:opacity-90 inline-flex items-center gap-2')}
                aria-label="Buat laporan baru"
              >
                Lapor Sekarang
                <ArrowRight className="h-4 w-4" />
              </Link>
            </div>

            {/* Three.js Roda Gigi Interaktif yang Inklusif */}
            <div className="w-full md:w-80 h-64 shrink-0 rounded-2xl bg-navy text-white border border-white/10 p-2 overflow-hidden shadow-inner">
              <div className="text-[10px] font-extrabold uppercase tracking-wider text-white/60 px-3 pt-1">
                Alur Layanan RAMPUNG
              </div>
              <ThreeGears className="w-full h-52" />
            </div>
          </div>
        </section>
      </Reveal>

      {/* ════════════════════════════════════════════
          2) CARI LAPORAN
         ════════════════════════════════════════════ */}
      <Reveal delay={80}>
        <Panel aria-label="Cari laporan">
          <div className="flex flex-col gap-3 sm:flex-row">
            <div className="relative flex-1">
              <Search className="pointer-events-none absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate" aria-hidden="true" />
              <input
                type="search"
                value={kode}
                onChange={(e) => setKode(e.target.value)}
                onKeyDown={(e) => e.key === 'Enter' && handleLacak()}
                placeholder="Ketik ID Tiket (contoh: JLN-1313)"
                className="min-h-11 w-full rounded-xl border border-lilac/60 bg-white pl-10 pr-4 text-sm text-navy placeholder:text-slate/60 focus-visible:ring-2 focus-visible:ring-crimson"
                aria-label="Masukkan kode tiket laporan"
              />
            </div>
            <button
              onClick={handleLacak}
              className={cn(tombolDasar, 'bg-navy text-white hover:bg-slate')}
              aria-label="Lacak laporan"
            >
              Lacak Laporan
            </button>
            <button type="button" onClick={handleVoiceSearch} className={cn(tombolDasar, 'border border-lilac bg-white text-navy hover:bg-card')} aria-label="Cari kode tiket dengan suara" aria-pressed={mendengarkan}>
              <Mic className="h-4 w-4" /> {mendengarkan ? 'Mendengarkan…' : 'Suara'}
            </button>
            <button type="button" onClick={() => setFilterTerbuka((value) => !value)} className={cn(tombolDasar, 'border border-lilac bg-white text-navy hover:bg-card')} aria-label="Atur filter laporan" aria-expanded={filterTerbuka}>
              <SlidersHorizontal className="h-4 w-4" /> Filter
            </button>
          </div>

          {voiceMessage && <p role="status" className="mt-3 text-xs font-semibold text-crimson">{voiceMessage}</p>}

          {filterTerbuka && (
            <div className="mt-4 grid gap-3 rounded-2xl border border-navy/10 bg-white/70 p-4 sm:grid-cols-3">
              <label className="text-xs font-bold text-navy">
                Kecamatan
                <select value={filterKec} onChange={(event) => setFilterKec(event.target.value)} className="mt-1.5 block min-h-11 w-full rounded-xl border border-navy/15 bg-white px-3 text-sm font-medium">
                  <option value="Semua">Semua kecamatan</option>
                  {['Banjarsari', 'Jebres', 'Laweyan', 'Pasar Kliwon', 'Serengan'].map((nama) => <option key={nama}>{nama}</option>)}
                </select>
              </label>
              <label className="text-xs font-bold text-navy">
                Status
                <select value={filterStatus} onChange={(event) => setFilterStatus(event.target.value)} className="mt-1.5 block min-h-11 w-full rounded-xl border border-navy/15 bg-white px-3 text-sm font-medium">
                  <option value="semua">Semua status</option>
                  <option value="masuk">Masuk</option>
                  <option value="ditinjau">Ditinjau</option>
                  <option value="sedang_ditangani">Sedang ditangani</option>
                  <option value="selesai">Selesai</option>
                  <option value="ditolak">Ditolak</option>
                </select>
              </label>
              <label className="text-xs font-bold text-navy">
                Kategori
                <select value={filterKategori} onChange={(event) => setFilterKategori(event.target.value)} className="mt-1.5 block min-h-11 w-full rounded-xl border border-navy/15 bg-white px-3 text-sm font-medium">
                  <option value="semua">Semua kategori</option>
                  {KATEGORI.map((item) => <option key={item.slug} value={item.slug}>{item.nama}</option>)}
                </select>
              </label>
              <p className="text-xs text-navy/70 sm:col-span-3">{laporanTersaring.length} laporan sesuai filter.</p>
            </div>
          )}
        </Panel>
      </Reveal>

      {/* ════════════════════════════════════════════
          3) STATS CARDS
         ════════════════════════════════════════════ */}
      <Reveal delay={160}>
        <div className="grid grid-cols-2 gap-4 md:grid-cols-4" aria-label="Statistik laporan">
          {/* Card: Laporan Bulan Ini */}
          <Kartu className="flex flex-col gap-2 border border-crimson/20 !bg-white p-5 shadow-sm">
            <span className="text-[10px] font-bold uppercase tracking-wider text-slate">Laporan Bulan Ini</span>
            <span className="text-3xl font-bold text-navy">
              <CountUp to={r?.laporan_bulan_ini ?? 0} />
            </span>
            <div className="flex items-end gap-1" aria-hidden="true">
              {trenTerbaru.map((item, i) => (
                <div key={item.bulan} className="bar-grow w-3 rounded-t bg-peri/70" style={{ height: `${(item.jumlah_masuk / nilaiTrenMaks) * 32}px`, animationDelay: `${i * 120}ms` }} />
              ))}
            </div>
            <span className="text-[10px] text-slate font-semibold">Berdasarkan laporan yang tercatat</span>
          </Kartu>

          {/* Card: Rampung */}
          <Kartu className="flex flex-col gap-2 border border-emerald-700/20 !bg-emerald-50 p-5 shadow-sm">
            <span className="text-[10px] font-bold uppercase tracking-wider text-slate">Rampung</span>
            <span className="text-3xl font-bold text-navy">
              <CountUp to={r?.laporan_selesai ?? 0} />
            </span>
            {/* Circular progress */}
            <div className="flex items-center gap-2">
              <svg width="36" height="36" viewBox="0 0 36 36" aria-hidden="true" className="shrink-0">
                <circle cx="18" cy="18" r="15" fill="none" stroke="#C5C2D1" strokeWidth="3" />
                <circle
                  cx="18" cy="18" r="15" fill="none" stroke="#A40033" strokeWidth="3"
                  strokeDasharray={`${(r?.persentase_selesai ?? 0) * 0.9424} 94.24`}
                  strokeLinecap="round" transform="rotate(-90 18 18)"
                  className="bar-grow"
                />
              </svg>
              <span className="text-xs font-bold text-crimson"><CountUp to={r?.persentase_selesai ?? 0} desimal={0} sufiks="%" /></span>
            </div>
          </Kartu>

          {/* Card: Sedang Dikerjakan */}
          <Kartu className="flex flex-col gap-2 border border-amber-700/20 !bg-amber-50 p-5 shadow-sm">
            <span className="text-[10px] font-bold uppercase tracking-wider text-slate">Sedang Dikerjakan</span>
            <span className="text-3xl font-bold text-navy">
              <CountUp to={r?.sedang_dikerjakan ?? 0} />
            </span>
            <Activity className="h-6 w-6 text-amber-500" aria-hidden="true" />
          </Kartu>

          {/* Card: Rata-rata Harian */}
          <Kartu className="flex flex-col gap-2 border border-indigo-700/20 !bg-[#e9e8f4] p-5 shadow-sm">
            <span className="text-[10px] font-bold uppercase tracking-wider text-slate">Rata-rata Laporan Harian</span>
            <span className="text-3xl font-bold text-navy">
              <CountUp to={r?.rata_rata_harian ?? 0} />
            </span>
            {/* Sparkline decoration */}
            <svg viewBox="0 0 80 24" className="h-6 w-full" aria-hidden="true">
              <polyline
              points={trenTerbaru.map((item, i) => {
                const x = trenTerbaru.length > 1 ? (i / (trenTerbaru.length - 1)) * 80 : 40;
                const y = 22 - (item.jumlah_masuk / nilaiTrenMaks) * 18;
                return `${x},${y}`;
              }).join(' ')}
                fill="none" stroke="#959EC9" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"
              />
            </svg>
          </Kartu>
        </div>
      </Reveal>

      {/* ════════════════════════════════════════════
          4) PETA LAPOR + UPDATE LAYANAN
         ════════════════════════════════════════════ */}
      <Reveal delay={240}>
        <section aria-label="Peta laporan" className="grid gap-6 lg:grid-cols-5">
          {/* Left: Interactive map */}
          <div className="lg:col-span-3">
            <Panel className="!bg-[#BEBDCC] !p-0 overflow-hidden">
              {/* Kecamatan filter pills */}
              <div className="flex flex-wrap gap-2 p-4 pb-2">
                {['Semua', 'Banjarsari', 'Jebres', 'Laweyan', 'Pasar Kliwon', 'Serengan'].map((k) => (
                  <button
                    key={k}
                    type="button"
                    onClick={() => setFilterKec(k)}
                    className={cn(
                      'rounded-full px-3 py-1 text-[11px] font-bold transition-colors',
                      filterKec === k ? 'bg-crimson text-white' : 'bg-white/80 text-navy hover:bg-card'
                    )}
                  >
                    {k}
                  </button>
                ))}
              </div>
              <div className="mx-4 mb-4 overflow-hidden rounded-2xl">
                <PetaLeaflet
                  laporan={laporanList || []}
                  kecamatanFilter={filterKec === 'Semua' ? 'semua' : filterKec}
                  statusFilter={filterStatus}
                  kategoriFilter={filterKategori}
                />
              </div>

              {/* Category legend */}
              <div className="flex flex-wrap gap-x-4 gap-y-1 border-t border-navy/10 px-4 py-3">
                {KATEGORI.slice(0, 5).map((k) => (
                  <span key={k.slug} className="flex items-center gap-1.5 text-[10px] font-semibold text-navy">
                    <span className="h-2 w-2 rounded-full" style={{ backgroundColor: k.warna }} aria-hidden="true" />
                    {k.nama}
                  </span>
                ))}
              </div>
            </Panel>
          </div>

          {/* Right: Update Layanan */}
          <div className="flex flex-col gap-4 lg:col-span-2">
            <h2 className="text-lg font-bold text-white">Update Layanan</h2>
            {laporanTerkini.map((laporan, i) => {
              const statusSelesai = laporan.status === 'selesai';
              const statusBerjalan = laporan.status === 'sedang_ditangani';
                const status = statusSelesai ? 'Selesai'
                  : statusBerjalan ? 'Sedang ditangani'
                    : laporan.status === 'ditinjau' ? 'Ditinjau'
                      : laporan.status === 'ditolak' ? 'Ditolak'
                        : laporan.status === 'dibuka_ulang' ? 'Dibuka ulang'
                          : 'Menunggu tindak lanjut';
                const statusWarna = statusSelesai ? 'bg-emerald-700'
                  : statusBerjalan ? 'bg-amber-700'
                    : laporan.status === 'ditolak' ? 'bg-crimson'
                      : 'bg-navy';

              return (
                <Reveal key={laporan.id} delay={300 + i * 80}>
                  <Kartu className="flex flex-col gap-2 border border-navy/10 !bg-white p-4 shadow-sm">
                    <div className="flex items-center justify-between gap-2">
                      <Pil className="bg-crimson text-white">
                        {laporan.dinas_singkatan || laporan.kategori}
                      </Pil>
                      <span className="text-[10px] font-bold text-navy/70">
                        {new Date(laporan.created_at).toLocaleDateString('id-ID')}
                      </span>
                    </div>
                    <p className="text-sm font-bold leading-snug text-navy">{laporan.judul}</p>
                    <div className="flex items-center justify-between">
                      <span className="text-[10px] font-medium text-navy/70">{laporan.kelurahan || laporan.kecamatan || 'Surakarta'}</span>
                      <Pil className={cn('text-white', statusWarna)}>{status}</Pil>
                    </div>
                  </Kartu>
                </Reveal>
              );
            })}
            {laporanTerkini.length === 0 && (
              <Kartu className="border border-navy/10 !bg-[#e9e8f4] p-4 text-sm font-medium text-navy/80">
                {laporanLoading ? 'Memuat laporan…' : laporanError ? 'Laporan belum dapat dimuat.' : 'Belum ada laporan yang tercatat untuk filter ini.'}
              </Kartu>
            )}
            <Link
              href="/lapor"
              className={cn(tombolDasar, 'bg-crimson mt-auto w-full justify-center text-white hover:bg-crimson/90')}
              aria-label="Tambah titik aduan baru"
            >
              <MapPin className="h-4 w-4" />
              Tambah Titik Aduan Baru
            </Link>
          </div>
        </section>
      </Reveal>

      {/* ════════════════════════════════════════════
          5) PERUBAHAN NYATANYA
         ════════════════════════════════════════════ */}
      <Reveal delay={320}>
        <section aria-label="Perubahan nyata" className="rounded-3xl border border-navy/10 bg-white px-6 py-10 text-navy shadow-lg sm:px-10 sm:py-14">
          <Pil className="bg-crimson text-white mb-3">LIHAT HASILNYA</Pil>
          <h2 className="text-2xl font-bold sm:text-3xl">Perubahan Nyatanya</h2>

          {firstLaporan && (
            <>
              <div className="mt-8 grid gap-4 sm:grid-cols-2">
                {/* Sebelum */}
                <div>
                  <span className="mb-2 block text-[10px] font-bold uppercase tracking-wider text-navy/70">Sebelum Perbaikan</span>
                  <div className="relative aspect-video overflow-hidden rounded-2xl bg-lilac/30">
                    {firstLaporan.foto_sebelum_paths[0] && (
                      <Image
                        src={firstLaporan.foto_sebelum_paths[0]}
                        alt="Kondisi sebelum perbaikan"
                        fill
                        className="object-cover"
                        sizes="(max-width:640px) 100vw, 50vw"
                      />
                    )}
                  </div>
                </div>

                {/* Sesudah */}
                <div>
                  <span className="mb-2 block text-[10px] font-bold uppercase tracking-wider text-emerald-700">
                    {firstLaporan.status === 'selesai' ? 'Sesudah (Tuntas)' : 'Foto Pembaruan'}
                  </span>
                  <div className="relative aspect-video overflow-hidden rounded-2xl bg-lilac/30">
                    {firstLaporan.foto_sesudah_paths[0] && (
                      <Image
                        src={firstLaporan.foto_sesudah_paths[0]}
                        alt="Kondisi sesudah perbaikan"
                        fill
                        className="object-cover"
                        sizes="(max-width:640px) 100vw, 50vw"
                      />
                    )}
                    {!firstLaporan.foto_sesudah_paths[0] && (
                      <span className="absolute inset-0 grid place-items-center px-4 text-center text-xs text-navy/70">
                        Belum ada foto pembaruan yang tercatat.
                      </span>
                    )}
                  </div>
                </div>
              </div>

              <div className="mt-8 text-center text-sm font-semibold text-navy/80">
                Dukungan warga: {firstLaporan.jumlah_dukungan ?? 0}
              </div>
            </>
          )}
        </section>
      </Reveal>

      {/* ════════════════════════════════════════════
          6) PAPAN TANGGAP
         ════════════════════════════════════════════ */}
      <Reveal delay={400}>
        <section aria-label="Papan tanggap" className="grid gap-6 lg:grid-cols-2">
          {/* Left: Performa Dinas */}
          <Panel>
            <h2 className="text-sm font-bold uppercase tracking-wider text-navy/70 mb-5">
              Performa Organisasi Perangkat Daerah Surakarta
            </h2>

            <div className="space-y-5">
              {(r?.kinerja_dinas ?? []).slice(0, 3).map((d, i) => (
                <Reveal key={d.singkatan} delay={440 + i * 80}>
                  <div className="space-y-1.5">
                    <div className="flex items-center justify-between">
                      <span className="text-sm font-bold text-navy">{d.singkatan}</span>
                      <span className="text-xs text-slate">
                        <CountUp to={d.rata_hari} desimal={1} /> Hari &middot; <CountUp to={d.persen_tuntas} desimal={0} sufiks="% Selesai" />
                      </span>
                    </div>
                    <div className="h-2.5 w-full overflow-hidden rounded-full bg-lilac/40">
                      <div
                        className="bar-grow h-full rounded-full"
                        style={{
                          width: `${d.persen_tuntas}%`,
                          backgroundColor: i === 0 ? '#A40033' : i === 1 ? '#D97706' : '#047857',
                          animationDelay: `${i * 200}ms`,
                        }}
                      />
                    </div>
                  </div>
                </Reveal>
              ))}
              {(r?.kinerja_dinas ?? []).length === 0 && (
                <p className="text-sm text-slate">
                  Belum ada cukup data laporan untuk menampilkan kinerja per dinas.
                </p>
              )}
            </div>

            <p className="mt-6 text-[10px] leading-relaxed text-slate/70">
              Standar pelayanan publik dinilai langsung oleh warga pelapor
            </p>
          </Panel>

          {/* Right: Ketersediaan data pembanding */}
          <Kartu className="bg-dark-card flex flex-col gap-5 p-6 text-white">
            <h2 className="text-sm font-bold uppercase tracking-wider text-white/70">Perbandingan Layanan</h2>
            <p className="text-sm leading-relaxed text-white/80">
              Statistik pembanding antarwilayah belum tersedia. Angka perbandingan hanya akan ditampilkan setelah sumber data resmi terhubung.
            </p>
          </Kartu>
        </section>
      </Reveal>
    </main>
  );
}
