'use client';

import { useState, useEffect, Suspense } from 'react';
import { useSearchParams } from 'next/navigation';
import {
  Search,
  CheckCircle2,
  Clock,
  MapPin,
  Share2,
  ThumbsUp,
  AlertCircle,
  FileText,
  Star,
  Check,
  RotateCcw,
  ShieldCheck,
  PhoneCall,
  UserCheck,
  Sparkles,
} from 'lucide-react';
import Reveal from '@/components/Reveal';
import { PageHero, Panel, Kartu, Pil, tombolDasar } from '@/components/ui';
import {
  getLaporanPublik,
  lacak,
  dukungLaporan,
  kirimKonfirmasiAudit,
  USE_MOCK,
  type Laporan,
} from '@/lib/client/data';
import { useAsync } from '@/lib/client/hooks';
import { cn } from '@/lib/utils';

function RiwayatContent() {
  const searchParams = useSearchParams();
  const initialKode = searchParams.get('kode') || 'RMP-2025-088';

  const { data: allLaporan } = useAsync(getLaporanPublik, []);
  const [activeKode, setActiveKode] = useState<string>(initialKode);
  const [activeTicket, setActiveTicket] = useState<Laporan | null>(null);
  const [searchInput, setSearchInput] = useState<string>('');
  const [rating, setRating] = useState<number>(5);
  const [konfirmasiStatus, setKonfirmasiStatus] = useState<'idle' | 'selesai' | 'revisi'>('idle');
  const [jumlahDukungan, setJumlahDukungan] = useState<number>(0);
  const [sudahDukung, setSudahDukung] = useState<boolean>(false);
  const [copyNotice, setCopyNotice] = useState<boolean>(false);
  const [aksiNotice, setAksiNotice] = useState<string | null>(null);
  const currentLap = activeTicket;

  useEffect(() => {
    let aktif = true;
    setActiveTicket(null);
    setAksiNotice(null);
    lacak(activeKode).then((laporan) => {
      if (!aktif) return;
      setActiveTicket(laporan);
      setJumlahDukungan(laporan?.jumlah_dukungan || 0);
      setSudahDukung(false);
      setKonfirmasiStatus('idle');
    });
    return () => {
      aktif = false;
    };
  }, [activeKode]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (!searchInput.trim()) return;
    setActiveKode(searchInput.trim().toUpperCase());
  };

  const handleDukung = async () => {
    if (!currentLap || sudahDukung) return;
    setAksiNotice(null);
    const result = await dukungLaporan(currentLap.id);
    if (result.ok) {
      setJumlahDukungan((prev) => prev + 1);
      setSudahDukung(true);
    } else {
      setAksiNotice(result.pesan);
    }
  };

  async function handleKonfirmasi(status: 'selesai' | 'revisi') {
    if (!currentLap) return;
    setAksiNotice(null);
    const result = await kirimKonfirmasiAudit(
      currentLap.id,
      status === 'selesai' ? 'puas' : 'kurang_puas',
      rating,
      status === 'revisi'
    );
    if (result.ok) {
      setKonfirmasiStatus(status);
    } else {
      setAksiNotice(result.pesan);
    }
  }

  const handleShare = () => {
    if (typeof window !== 'undefined') {
      navigator.clipboard?.writeText(window.location.href);
      setCopyNotice(true);
      setTimeout(() => setCopyNotice(false), 3000);
    }
  };

  return (
    <main className="mx-auto max-w-7xl px-4 py-6 sm:px-8 space-y-6">
      {/* ── 1. Page Hero ── */}
      <Reveal>
        <header className="bg-hero rounded-3xl p-6 sm:p-8 shadow-[0_8px_24px_rgba(40,38,75,.14)] flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6">
          <div className="max-w-2xl">
            <h1 className="text-3xl font-extrabold tracking-tight text-navy sm:text-4xl leading-tight">
              Riwayat & Lacak Aduan
            </h1>
            <p className="mt-2.5 text-sm sm:text-base text-navy/80 leading-relaxed font-medium">
              Pantau perkembangan intervensi teknis OPD Surakarta, tinjau komparasi foto bukti lapangan, dan validasi ketuntasan fasilitas publik Anda.
            </p>
          </div>

          <div className="bg-white/90 backdrop-blur-sm px-4 py-3 rounded-2xl border border-navy/10 shadow-sm flex items-center gap-3">
            <div className="w-8 h-8 rounded-xl bg-emerald-100 text-emerald-700 flex items-center justify-center font-bold">
              <ShieldCheck className="w-5 h-5" />
            </div>
            <div>
              <p className="text-[10px] font-bold uppercase tracking-wider text-navy/60">Sumber Data</p>
              <p className="text-xs font-extrabold text-navy">{USE_MOCK ? 'Data Demo' : 'Supabase'}</p>
            </div>
          </div>
        </header>
      </Reveal>

      {/* ── 2. Pencarian & Filter Bar ── */}
      <Reveal delay={80}>
        <div className="bg-panel p-4 sm:p-5 rounded-3xl shadow-[0_8px_24px_rgba(40,38,75,.14)] space-y-3">
          <form onSubmit={handleSearch} className="flex flex-col md:flex-row gap-3">
            <div className="relative flex-1">
              <Search className="w-4 h-4 text-navy/50 absolute left-3.5 top-1/2 -translate-y-1/2" />
              <input
                type="text"
                placeholder="Ketik ID Tiket (contoh: #RMP-2025-088)"
                value={searchInput}
                onChange={(e) => setSearchInput(e.target.value)}
                className="w-full pl-10 pr-4 py-2.5 bg-white rounded-xl text-sm font-semibold text-navy border border-navy/15 focus:outline-none focus:ring-2 focus:ring-crimson placeholder:text-navy/40"
              />
            </div>

            <div className="flex gap-2">
              <select className="bg-white border border-navy/15 rounded-xl px-3 py-2.5 text-xs font-bold text-navy focus:outline-none focus:ring-2 focus:ring-crimson">
                <option>Wilayah: Semua</option>
                <option>Wilayah: Laweyan</option>
                <option>Wilayah: Banjarsari</option>
                <option>Wilayah: Jebres</option>
                <option>Wilayah: Serengan</option>
                <option>Wilayah: Pasar Kliwon</option>
              </select>

              <select className="bg-white border border-navy/15 rounded-xl px-3 py-2.5 text-xs font-bold text-navy focus:outline-none focus:ring-2 focus:ring-crimson">
                <option>Semua Status</option>
                <option>Baru</option>
                <option>Diproses</option>
                <option>Selesai</option>
              </select>

              <button
                type="submit"
                className="px-5 py-2.5 bg-crimson hover:bg-[#8a002b] text-white text-xs font-bold rounded-xl transition-all shadow-sm shrink-0"
              >
                Cari Tiket
              </button>
            </div>
          </form>

          {/* Pintas Laporan */}
          <div className="flex items-center gap-2 overflow-x-auto text-xs pt-1 pb-0.5 scrollbar-none">
            <span className="text-[11px] font-bold text-navy/60 uppercase shrink-0">Pintas Laporan:</span>
            {(allLaporan || []).slice(0, 3).map((laporan) => (
              <button
                key={laporan.id}
                type="button"
                onClick={() => setActiveKode(laporan.kode_lacak)}
                className={cn(
                  'px-3 py-1 rounded-lg font-bold transition-all shrink-0',
                  activeKode === laporan.kode_lacak
                    ? 'bg-crimson text-white shadow-sm'
                    : 'bg-white/80 text-navy hover:bg-white'
                )}
              >
                #{laporan.kode_lacak} &bull; {laporan.judul}
              </button>
            ))}
          </div>
        </div>
      </Reveal>

      {/* ── 3. Layout Grid 2 Kolom ── */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Kolom Kiri: Sidebar Tiket & Dukungan Warga (lg:col-span-4) */}
        <div className="lg:col-span-4 space-y-6">
          {/* Panel Tiket Pengawasan */}
          <Reveal delay={120}>
            <div className="bg-panel p-5 rounded-3xl shadow-[0_8px_24px_rgba(40,38,75,.14)] space-y-4">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2">
                  <FileText className="w-5 h-5 text-navy" />
                  <h2 className="text-base font-extrabold text-navy">Tiket Pengawasan</h2>
                </div>
                <span className="text-[11px] font-bold bg-crimson text-white px-2.5 py-0.5 rounded-full">
                  {allLaporan?.length || 0} Laporan
                </span>
              </div>

              {/* List Tiket Mini */}
              <div className="space-y-3">
                {USE_MOCK && (
                  <>
                {/* Tiket 1 */}
                <button
                  type="button"
                  onClick={() => setActiveKode('RMP-2025-088')}
                  className={cn(
                    'w-full text-left p-3.5 rounded-2xl border transition-all',
                    activeKode === 'RMP-2025-088'
                      ? 'bg-card border-crimson/50 shadow-md ring-2 ring-crimson/20'
                      : 'bg-white/80 border-navy/10 hover:bg-white'
                  )}
                >
                  <div className="flex items-center justify-between mb-1.5">
                    <span className="text-xs font-mono font-bold text-navy">#RMP-2025-088</span>
                    <span className="text-[10px] font-extrabold bg-crimson text-white px-2 py-0.5 rounded">
                      Menunggu Anda
                    </span>
                  </div>
                  <h3 className="text-xs font-extrabold text-navy leading-snug line-clamp-1">
                    Jalan Berlubang Aspal Ambles (Kedalaman 12cm)
                  </h3>
                  <p className="text-[11px] text-navy/70 mt-1 flex items-center gap-1">
                    <MapPin className="w-3 h-3 text-crimson shrink-0" />
                    Jl. Dr. Radjiman No. 410, Laweyan
                  </p>
                  <div className="flex items-center justify-between pt-2 mt-2 border-t border-navy/10 text-[10px] text-navy/60 font-semibold">
                    <span>DPUPR Kota Surakarta</span>
                    <span className="text-crimson font-bold">Tahap 4 dari 5</span>
                  </div>
                </button>

                {/* Tiket 2 */}
                <button
                  type="button"
                  onClick={() => setActiveKode('RMP-2025-094')}
                  className={cn(
                    'w-full text-left p-3.5 rounded-2xl border transition-all',
                    activeKode === 'RMP-2025-094'
                      ? 'bg-card border-crimson/50 shadow-md ring-2 ring-crimson/20'
                      : 'bg-white/80 border-navy/10 hover:bg-white'
                  )}
                >
                  <div className="flex items-center justify-between mb-1.5">
                    <span className="text-xs font-mono font-bold text-navy">#RMP-2025-094</span>
                    <span className="text-[10px] font-extrabold bg-amber-500 text-white px-2 py-0.5 rounded">
                      Sedang Dikerjakan
                    </span>
                  </div>
                  <h3 className="text-xs font-extrabold text-navy leading-snug line-clamp-1">
                    Lampu PJU Padam 4 Titik
                  </h3>
                  <p className="text-[11px] text-navy/70 mt-1 flex items-center gap-1">
                    <MapPin className="w-3 h-3 text-amber-600 shrink-0" />
                    Jl. Kolonel Sutarto, Jebres
                  </p>
                  <div className="flex items-center justify-between pt-2 mt-2 border-t border-navy/10 text-[10px] text-navy/60 font-semibold">
                    <span>Dishub Surakarta</span>
                    <span className="text-navy font-bold">Tahap 3 dari 5</span>
                  </div>
                </button>

                {/* Tiket 3 */}
                <button
                  type="button"
                  onClick={() => setActiveKode('RMP-2025-102')}
                  className={cn(
                    'w-full text-left p-3.5 rounded-2xl border transition-all',
                    activeKode === 'RMP-2025-102'
                      ? 'bg-card border-crimson/50 shadow-md ring-2 ring-crimson/20'
                      : 'bg-white/80 border-navy/10 hover:bg-white'
                  )}
                >
                  <div className="flex items-center justify-between mb-1.5">
                    <span className="text-xs font-mono font-bold text-navy">#RMP-2025-102</span>
                    <span className="text-[10px] font-extrabold bg-peri text-white px-2 py-0.5 rounded">
                      Verifikasi Lapangan
                    </span>
                  </div>
                  <h3 className="text-xs font-extrabold text-navy leading-snug line-clamp-1">
                    Sedimen Drainase Meluap
                  </h3>
                  <p className="text-[11px] text-navy/70 mt-1 flex items-center gap-1">
                    <MapPin className="w-3 h-3 text-slate shrink-0" />
                    Simpang Pasar Kembang, Serengan
                  </p>
                  <div className="flex items-center justify-between pt-2 mt-2 border-t border-navy/10 text-[10px] text-navy/60 font-semibold">
                    <span>DPUPR & DLH</span>
                    <span className="text-navy font-bold">Tahap 2 dari 5</span>
                  </div>
                </button>
                  </>
                )}
                {!USE_MOCK && (allLaporan || []).map((laporan) => (
                  <button
                    key={laporan.id}
                    type="button"
                    onClick={() => setActiveKode(laporan.kode_lacak)}
                    className={cn(
                      'w-full text-left p-3.5 rounded-2xl border transition-all',
                      activeKode === laporan.kode_lacak
                        ? 'bg-card border-crimson/50 shadow-md ring-2 ring-crimson/20'
                        : 'bg-white/80 border-navy/10 hover:bg-white'
                    )}
                  >
                    <div className="flex items-center justify-between mb-1.5">
                      <span className="text-xs font-mono font-bold text-navy">#{laporan.kode_lacak}</span>
                      <span className="text-[10px] font-extrabold bg-slate text-white px-2 py-0.5 rounded">
                        {laporan.status.replace(/_/g, ' ')}
                      </span>
                    </div>
                    <h3 className="text-xs font-extrabold text-navy leading-snug line-clamp-1">{laporan.judul}</h3>
                    <p className="text-[11px] text-navy/70 mt-1 flex items-center gap-1">
                      <MapPin className="w-3 h-3 text-crimson shrink-0" />
                      {laporan.kelurahan || laporan.kecamatan || 'Surakarta'}
                    </p>
                  </button>
                ))}
                {!USE_MOCK && (allLaporan || []).length === 0 && (
                  <p className="rounded-2xl bg-white/80 p-4 text-sm text-navy/70">
                    Belum ada laporan tersimpan.
                  </p>
                )}
              </div>
            </div>
          </Reveal>

          {/* Panel Dukungan Guyub Warga */}
          <Reveal delay={160}>
            <div className="bg-panel p-5 rounded-3xl shadow-[0_8px_24px_rgba(40,38,75,.14)] space-y-4">
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2">
                  <ThumbsUp className="w-4 h-4 text-crimson" />
                  <h3 className="text-sm font-extrabold text-navy">Dukungan Guyub Warga</h3>
                </div>
                <span className="text-[10px] font-bold bg-amber-100 text-amber-900 px-2 py-0.5 rounded">
                  {jumlahDukungan} dukungan
                </span>
              </div>
              <p className="text-xs text-navy/80 leading-relaxed font-medium">
                Jumlah dukungan yang tercatat untuk laporan ini.
              </p>
              <div className="flex items-center justify-between pt-1">
                <button
                  type="button"
                  onClick={handleDukung}
                  disabled={!currentLap || sudahDukung}
                  className={cn(
                    'px-4 py-2 rounded-xl text-xs font-bold transition-all flex items-center gap-1.5 shadow-sm',
                    sudahDukung
                      ? 'bg-emerald-600 text-white cursor-default'
                      : 'bg-crimson hover:bg-[#8a002b] text-white active:scale-95'
                  )}
                >
                  <ThumbsUp className="w-3.5 h-3.5" />
                  <span>{sudahDukung ? 'Terdukung!' : 'Dukung Keluhan'}</span>
                </button>
              </div>
              {aksiNotice && (
                <p role="status" className="text-xs font-semibold text-crimson">{aksiNotice}</p>
              )}
            </div>
          </Reveal>
        </div>

        {/* Kolom Kanan: Detail Laporan Utama & Linimasa Interaktif (lg:col-span-8) */}
        <div className="lg:col-span-8 space-y-6">
          <Reveal delay={140}>
            <div className="bg-panel p-6 sm:p-7 rounded-3xl shadow-[0_8px_24px_rgba(40,38,75,.14)] space-y-6">
              {/* Header Tiket */}
              <div className="space-y-3">
                <div className="flex flex-wrap items-center justify-between gap-2">
                  <div className="flex flex-wrap items-center gap-2">
                    <span className="text-xs font-mono font-bold bg-navy text-white px-2.5 py-1 rounded-md">
                      #{currentLap?.kode_lacak || '—'}
                    </span>
                    <span className="text-xs font-bold bg-white text-navy px-2.5 py-1 rounded-md border border-navy/10">
                      Kecamatan {currentLap?.kecamatan || '—'}
                    </span>
                    <span className="text-xs font-bold bg-emerald-100 text-emerald-800 px-2.5 py-1 rounded-md">
                      {currentLap
                        ? `Status: ${currentLap.status.replace(/_/g, ' ')}`
                        : 'Status belum tersedia'}
                    </span>
                  </div>

                  <button
                    type="button"
                    onClick={handleShare}
                    className="text-xs font-bold text-navy/70 hover:text-crimson flex items-center gap-1 transition-colors"
                  >
                    <Share2 className="w-3.5 h-3.5" />
                    <span>{copyNotice ? 'Tautan Disalin!' : 'Bagikan Progres'}</span>
                  </button>
                </div>

                <h2 className="text-2xl sm:text-3xl font-extrabold text-navy tracking-tight leading-tight">
                  {currentLap?.judul || 'Laporan tidak ditemukan'}
                </h2>
                <p className="text-xs sm:text-sm text-navy/80 leading-relaxed font-medium">
                  {currentLap?.deskripsi || 'Periksa kembali kode lacak atau coba lagi setelah data berhasil dimuat.'}
                </p>
              </div>

              {/* ── Linimasa status laporan ── */}
              <div className="bg-card p-5 rounded-2xl border border-navy/10 space-y-4">
                <h3 className="text-xs font-extrabold uppercase tracking-wider text-navy flex items-center gap-1.5">
                    <Sparkles className="w-3.5 h-3.5 text-crimson" />
                    Riwayat Status
                </h3>
                {currentLap?.linimasa?.length ? (
                  <ol className="space-y-3 pt-1">
                    {currentLap.linimasa.map((item, index) => (
                      <li key={`${item.created_at}-${index}`} className="flex gap-3 border-l-2 border-crimson/30 pl-3">
                        <div>
                          <p className="text-xs font-bold text-navy">
                            {item.judul_tahap || item.status_ke.replace(/_/g, ' ')}
                          </p>
                          <p className="text-[11px] text-navy/70">{item.catatan}</p>
                          <time className="text-[10px] text-navy/50">
                            {new Date(item.created_at).toLocaleString('id-ID')}
                          </time>
                        </div>
                      </li>
                    ))}
                  </ol>
                ) : (
                  <p className="text-xs text-navy/70">Belum ada riwayat status yang tersedia.</p>
                )}
              </div>

              {/* ── Komparasi Foto Sebelum vs Sesudah (Side by Side) ── */}
              <div className="space-y-3">
                <div className="flex items-center justify-between">
                  <h3 className="text-sm font-extrabold text-navy">
                    Komparasi Foto: Sebelum vs Sesudah Perbaikan
                  </h3>
                  <span className="text-[11px] font-medium text-navy/60">
                    {currentLap?.latitude != null && currentLap.longitude != null
                      ? `Lokasi: ${currentLap.latitude.toFixed(5)}, ${currentLap.longitude.toFixed(5)}`
                      : 'Lokasi belum tercatat'}
                  </span>
                </div>

                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div className="bg-card rounded-2xl overflow-hidden border border-navy/10 space-y-3 p-3">
                    <div className="relative h-48 w-full rounded-xl overflow-hidden bg-slate-900">
                      {currentLap?.foto_sebelum_paths?.[0]?.startsWith('http') ? (
                        <img src={currentLap?.foto_sebelum_paths?.[0]} alt="Kondisi sebelum penanganan" className="h-full w-full object-cover" />
                      ) : (
                        <span className="grid h-full place-items-center px-4 text-center text-xs text-white/70">
                          Foto sebelum belum tersedia.
                        </span>
                      )}
                      <span className="absolute top-2.5 left-2.5 bg-crimson text-white text-[10px] font-extrabold uppercase px-2 py-0.5 rounded shadow">
                        Foto Sebelum
                      </span>
                    </div>
                    <p className="text-[11px] text-navy/60">
                      {currentLap?.created_at ? new Date(currentLap.created_at).toLocaleString('id-ID') : 'Waktu belum tercatat'}
                    </p>
                  </div>

                  <div className="bg-card rounded-2xl overflow-hidden border border-navy/10 space-y-3 p-3">
                    <div className="relative h-48 w-full rounded-xl overflow-hidden bg-slate-900">
                      {currentLap?.foto_sesudah_paths?.[0]?.startsWith('http') ? (
                        <img src={currentLap?.foto_sesudah_paths?.[0]} alt="Kondisi sesudah penanganan" className="h-full w-full object-cover" />
                      ) : (
                        <span className="grid h-full place-items-center px-4 text-center text-xs text-white/70">
                          Foto sesudah belum tersedia.
                        </span>
                      )}
                      <span className="absolute top-2.5 left-2.5 bg-emerald-600 text-white text-[10px] font-extrabold uppercase px-2 py-0.5 rounded shadow">
                        Foto Sesudah
                      </span>
                    </div>
                    <p className="text-[11px] text-navy/60">
                      {currentLap?.updated_at ? new Date(currentLap.updated_at).toLocaleString('id-ID') : 'Waktu belum tercatat'}
                    </p>
                  </div>
                </div>
              </div>

              {/* ── Catatan teknis yang tersimpan ── */}
              <div className="bg-card p-4 sm:p-5 rounded-2xl border border-navy/10 space-y-3">
                <h3 className="text-xs font-extrabold text-navy uppercase tracking-wider">
                  Catatan Penanganan
                </h3>
                {currentLap?.catatan_teknis ? (
                  <dl className="grid gap-2 text-xs text-navy/80 sm:grid-cols-2">
                    {Object.entries(currentLap.catatan_teknis).map(([label, value]) => value != null && (
                      <div key={label}>
                        <dt className="font-bold capitalize">{label.replace(/_/g, ' ')}</dt>
                        <dd>{String(value)}</dd>
                      </div>
                    ))}
                  </dl>
                ) : (
                  <p className="text-xs text-navy/70">Belum ada catatan penanganan yang tersimpan.</p>
                )}
              </div>

              {/* ── Kuesioner Audit Gotong Royong ── */}
              <div className="bg-white p-5 rounded-2xl border-2 border-crimson/20 shadow-sm space-y-4">
                <div className="flex items-start gap-3">
                  <div className="p-2 bg-crimson/10 text-crimson rounded-xl shrink-0 mt-0.5">
                    <AlertCircle className="w-5 h-5" />
                  </div>
                  <div>
                    <h3 className="text-sm font-extrabold text-navy">
                      Apakah laporan ini sudah benar-benar beres?
                    </h3>
                    <p className="text-xs text-navy/70 mt-0.5 leading-relaxed">
                      Konfirmasi hanya dapat dikirim setelah laporan berstatus selesai.
                    </p>
                  </div>
                </div>

                {konfirmasiStatus === 'idle' ? (
                  <div className="space-y-4 pt-1">
                    <div className="flex items-center gap-2">
                      <span className="text-xs font-bold text-navy">Beri Penilaian Layanan:</span>
                      <div className="flex items-center gap-1">
                        {[1, 2, 3, 4, 5].map((star) => (
                          <button
                            key={star}
                            type="button"
                            onClick={() => setRating(star)}
                            className="p-1 hover:scale-110 transition-transform"
                          >
                            <Star
                              className={cn(
                                'w-5 h-5',
                                star <= rating ? 'fill-amber-400 text-amber-400' : 'text-navy/20'
                              )}
                            />
                          </button>
                        ))}
                      </div>
                      <span className="text-xs font-semibold text-navy/60 ml-1">
                        ({rating}/5 {rating >= 4 ? 'Sangat Puas' : 'Cukup'})
                      </span>
                    </div>

                    <div className="flex flex-col sm:flex-row gap-3">
                      <button
                        type="button"
                        onClick={() => handleKonfirmasi('selesai')}
                        disabled={!currentLap || currentLap.status !== 'selesai'}
                        className="flex-1 py-3 bg-emerald-600 hover:bg-emerald-700 text-white font-extrabold text-xs rounded-xl flex items-center justify-center gap-2 transition-all shadow-md active:scale-95"
                      >
                        <Check className="w-4 h-4" />
                        Sudah Beres / Selesai Tuntas
                      </button>

                      <button
                        type="button"
                        onClick={() => handleKonfirmasi('revisi')}
                        disabled={!currentLap || currentLap.status !== 'selesai'}
                        className="flex-1 py-3 bg-white hover:bg-rose-50 text-crimson border-2 border-crimson/40 font-extrabold text-xs rounded-xl flex items-center justify-center gap-2 transition-all active:scale-95"
                      >
                        <RotateCcw className="w-4 h-4" />
                        Belum Sesuai / Butuh Tindak Lanjut
                      </button>
                    </div>
                  </div>
                ) : konfirmasiStatus === 'selesai' ? (
                  <div className="p-4 bg-emerald-50 border border-emerald-300 rounded-xl text-center space-y-1 animate-in fade-in">
                    <p className="text-xs font-extrabold text-emerald-800">
                      Konfirmasi hasil berhasil disimpan.
                    </p>
                    <p className="text-[11px] text-emerald-700">
                      Terima kasih telah memberikan penilaian.
                    </p>
                  </div>
                ) : (
                  <div className="p-4 bg-rose-50 border border-rose-300 rounded-xl text-center space-y-1 animate-in fade-in">
                    <p className="text-xs font-extrabold text-crimson">
                      Permintaan tindak lanjut berhasil disimpan.
                    </p>
                    <p className="text-[11px] text-navy/70">
                      Petugas dapat meninjau permintaan ini melalui antrean laporan.
                    </p>
                  </div>
                )}
              </div>

              {/* Bantuan Langsung */}
              <div className="bg-panel p-4 rounded-2xl border border-navy/10 flex flex-col sm:flex-row sm:items-center justify-between gap-3">
                <div>
                  <h3 className="text-xs font-extrabold text-navy">Butuh Bantuan Langsung Petugas Lapangan?</h3>
                  <p className="text-[11px] text-navy/70">
                    Pusat Panggilan Siaga Terpadu 112 Kota Surakarta melayani tanggap darurat 24 jam gratis.
                  </p>
                </div>
                <a
                  href="tel:112"
                  className="px-4 py-2 bg-crimson hover:bg-[#8a002b] text-white text-xs font-bold rounded-xl flex items-center justify-center gap-1.5 transition-colors shrink-0"
                >
                  <PhoneCall className="w-3.5 h-3.5" />
                  Hubungi Call Center 112
                </a>
              </div>
            </div>
          </Reveal>
        </div>
      </div>
    </main>
  );
}

export default function RiwayatPage() {
  return (
    <Suspense
      fallback={
        <div className="mx-auto max-w-7xl px-4 py-16 text-center text-sm font-semibold text-navy/60">
          Memuat riwayat dan tiket pengawasan Kota Surakarta...
        </div>
      }
    >
      <RiwayatContent />
    </Suspense>
  );
}
