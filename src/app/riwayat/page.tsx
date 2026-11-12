'use client';

import { useState, useEffect, useRef, Suspense, useMemo } from 'react';
import Link from 'next/link';
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
  PhoneCall,
  UserCheck,
  Sparkles,
  Upload,
  Camera,
  CheckSquare,
  Loader2,
} from 'lucide-react';
import Reveal from '@/components/Reveal';
import KomparasiSlider from '@/components/KomparasiSlider';
import KartuInspeksiAI from '@/components/KartuInspeksiAI';
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
import { useAuth } from '@/lib/client/auth';
import { fetchAuthed } from '@/lib/client/supabase';
import { cn } from '@/lib/utils';

function cekIndikasiSpam(laporan?: Laporan | null): boolean {
  if (!laporan) return false;
  if (laporan.penanda?.includes('perlu_verifikasi_tambahan')) return true;
  const gabung = `${laporan.judul || ''} ${laporan.deskripsi || ''}`.toLowerCase();
  return /joki|open joki|jasa tugas|jasa skripsi|slot|gacor|maxwin|zeus|olympus|pragmatic|judi|judol|togel|casino|poker|taruhan|sbobet|pinjol|pinjaman|pinjam uang|dana cair|dana cepat|dana kilat|butuh dana|butuh uang|tanpa jaminan|tanpa agunan|bunga rendah|gestun|followers|top up|topup|dm ig|wa\.me|open bo|vcs|obat kuat/i.test(gabung);
}

function RiwayatContent() {
  const searchParams = useSearchParams();
  const kodeDariUrl = searchParams.get('kode');

  const { data: allLaporan } = useAsync(getLaporanPublik, []);
  const [activeKode, setActiveKode] = useState<string>(kodeDariUrl || '');
  const [activeTicket, setActiveTicket] = useState<Laporan | null>(null);
  const [searchInput, setSearchInput] = useState<string>('');
  const [filterWilayah, setFilterWilayah] = useState<string>('Semua');
  const [filterStatus, setFilterStatus] = useState<string>('Semua');
  const [rating, setRating] = useState<number>(5);
  const [komentarUlasan, setKomentarUlasan] = useState<string>('');
  const [modeEditUlasan, setModeEditUlasan] = useState<boolean>(false);
  const [konfirmasiStatus, setKonfirmasiStatus] = useState<'idle' | 'selesai' | 'revisi'>('idle');
  const [jumlahDukungan, setJumlahDukungan] = useState<number>(0);
  const [sudahDukung, setSudahDukung] = useState<boolean>(false);
  const [copyNotice, setCopyNotice] = useState<boolean>(false);
  const [aksiNotice, setAksiNotice] = useState<string | null>(null);
  const currentLap = activeTicket;
  const { pengguna } = useAuth();
  const isPetugasOrAdmin = pengguna?.peran === 'petugas' || pengguna?.peran === 'admin';
  const fileInputRef = useRef<HTMLInputElement | null>(null);

  // State khusus aksi petugas
  const [berkasFotoSesudah, setBerkasFotoSesudah] = useState<File | null>(null);
  const [previewFotoSesudah, setPreviewFotoSesudah] = useState<string | null>(null);
  const [catatanPetugas, setCatatanPetugas] = useState<string>(
    'Pekerjaan penanganan dan perbaikan fisik telah tuntas diselesaikan oleh Regu Reaksi Cepat di lokasi.'
  );
  const [sedangUploadPetugas, setSedangUploadPetugas] = useState<boolean>(false);
  const [pesanPetugas, setPesanPetugas] = useState<{ tipe: 'sukses' | 'error'; teks: string } | null>(null);

  const handlePilihFotoSesudah = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (!file) return;
    if (!file.type.startsWith('image/')) {
      setPesanPetugas({ tipe: 'error', teks: 'Format berkas wajib berupa gambar citra (JPEG/PNG/WebP).' });
      return;
    }
    if (file.size > 5 * 1024 * 1024) {
      setPesanPetugas({ tipe: 'error', teks: 'Ukuran foto maksimal 5 MB.' });
      return;
    }
    setBerkasFotoSesudah(file);
    setPreviewFotoSesudah(URL.createObjectURL(file));
    setPesanPetugas(null);
  };

  const handleSelesaikanAduan = async () => {
    if (!currentLap) return;
    if (!berkasFotoSesudah) {
      setPesanPetugas({ tipe: 'error', teks: 'Wajib memilih foto bukti sesudah perbaikan terlebih dahulu.' });
      return;
    }
    if (!catatanPetugas || catatanPetugas.trim().length < 10) {
      setPesanPetugas({ tipe: 'error', teks: 'Catatan penanganan wajib diisi minimal 10 karakter.' });
      return;
    }

    setSedangUploadPetugas(true);
    setPesanPetugas(null);
    try {
      // 1. Upload foto bukti sesudah ke bucket laporan-foto
      const formData = new FormData();
      formData.append('file', berkasFotoSesudah);

      const uploadRes = await fetchAuthed(`/api/petugas/laporan/${currentLap.id}/upload-sesudah`, {
        method: 'POST',
        body: formData,
      });

      const uploadJson = await uploadRes.json();
      if (!uploadRes.ok) {
        throw new Error(uploadJson.error?.pesan || 'Gagal mengunggah foto sesudah ke server storage.');
      }

      const filePath = uploadJson.data?.file_path;

      // 2. Perbarui status laporan menjadi 'selesai'
      const statusRes = await fetchAuthed(`/api/petugas/laporan/${currentLap.id}/status`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          status_ke: 'selesai',
          catatan: catatanPetugas,
          foto_sesudah_paths: [filePath],
        }),
      });

      const statusJson = await statusRes.json();
      if (!statusRes.ok) {
        throw new Error(statusJson.error?.pesan || 'Gagal memperbarui status laporan.');
      }

      setPesanPetugas({
        tipe: 'sukses',
        teks: 'Foto bukti berhasil disimpan dan status laporan telah resmi berubah menjadi SELESAI!',
      });
      setBerkasFotoSesudah(null);

      // Muat ulang data tiket
      const updated = await lacak(activeKode);
      if (updated) {
        setActiveTicket(updated);
      }
    } catch (err: any) {
      setPesanPetugas({ tipe: 'error', teks: err?.message || 'Gagal memproses penanganan laporan.' });
    } finally {
      setSedangUploadPetugas(false);
    }
  };

  const filteredLaporan = useMemo(() => {
    if (!allLaporan) return [];
    return allLaporan.filter((lap) => {
      // Filter wilayah
      if (filterWilayah !== 'Semua') {
        const wil = `${lap.kecamatan || ''} ${lap.kelurahan || ''}`.toLowerCase();
        if (!wil.includes(filterWilayah.toLowerCase())) return false;
      }
      // Filter status
      if (filterStatus !== 'Semua') {
        if (filterStatus === 'masuk' && lap.status !== 'masuk') return false;
        if (filterStatus === 'sedang_ditangani' && lap.status !== 'sedang_ditangani' && lap.status !== 'ditinjau' && lap.status !== 'diproses') return false;
        if (filterStatus === 'selesai' && lap.status !== 'selesai') return false;
      }
      // Filter search
      if (searchInput.trim()) {
        const q = searchInput.trim().toLowerCase();
        const cocokKode = lap.kode_lacak?.toLowerCase().includes(q);
        const cocokJudul = lap.judul?.toLowerCase().includes(q);
        const cocokWil = `${lap.kecamatan || ''} ${lap.kelurahan || ''}`.toLowerCase().includes(q);
        if (!cocokKode && !cocokJudul && !cocokWil) return false;
      }
      return true;
    });
  }, [allLaporan, filterWilayah, filterStatus, searchInput]);

  // Set initial active ticket from URL or first available report
  useEffect(() => {
    if (!allLaporan || allLaporan.length === 0) return;
    if (kodeDariUrl) {
      const matchUrl = allLaporan.find((l) => l.kode_lacak?.toLowerCase() === kodeDariUrl.toLowerCase());
      if (matchUrl) {
        setActiveKode(matchUrl.kode_lacak);
        return;
      }
    }
    if (!activeKode) {
      setActiveKode(allLaporan[0].kode_lacak);
    }
  }, [allLaporan, kodeDariUrl]);

  // Sync activeKode with filteredLaporan when filter changes
  useEffect(() => {
    if (filteredLaporan.length > 0) {
      const match = filteredLaporan.find((l) => l.kode_lacak === activeKode);
      if (!match) {
        setActiveKode(filteredLaporan[0].kode_lacak);
      }
    }
  }, [filteredLaporan]);

  useEffect(() => {
    if (!activeKode) return;
    let aktif = true;
    setActiveTicket(null);
    setAksiNotice(null);
    setPreviewFotoSesudah(null);
    setBerkasFotoSesudah(null);
    setPesanPetugas(null);
    lacak(activeKode).then((laporan) => {
      if (!aktif) return;
      setActiveTicket(laporan);
      setJumlahDukungan(laporan?.jumlah_dukungan || 0);
      setSudahDukung(false);
      setKonfirmasiStatus('idle');
      setModeEditUlasan(false);
      if (laporan?.konfirmasi_warga?.rating) {
        setRating(laporan.konfirmasi_warga.rating);
      }
      if (laporan?.konfirmasi_warga?.komentar) {
        setKomentarUlasan(laporan.konfirmasi_warga.komentar);
      } else {
        setKomentarUlasan('');
      }
    });
    return () => {
      aktif = false;
    };
  }, [activeKode]);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (!searchInput.trim()) return;
    const found = (allLaporan || []).find((l) =>
      l.kode_lacak?.toLowerCase().includes(searchInput.trim().toLowerCase())
    );
    if (found) {
      setActiveKode(found.kode_lacak);
      setFilterStatus('Semua');
      setFilterWilayah('Semua');
    }
  };

  const handleResetFilter = () => {
    setFilterWilayah('Semua');
    setFilterStatus('Semua');
    setSearchInput('');
    if (allLaporan && allLaporan.length > 0) {
      setActiveKode(allLaporan[0].kode_lacak);
    }
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
      status === 'revisi',
      komentarUlasan.trim() || undefined
    );
    if (result.ok) {
      setKonfirmasiStatus(status);
      setModeEditUlasan(false);
      const updated = await lacak(activeKode);
      if (updated) {
        setActiveTicket(updated);
      }
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
              <select
                value={filterWilayah}
                onChange={(e) => setFilterWilayah(e.target.value)}
                className="bg-white border border-navy/15 rounded-xl px-3 py-2.5 text-xs font-bold text-navy focus:outline-none focus:ring-2 focus:ring-crimson cursor-pointer"
              >
                <option value="Semua">Wilayah: Semua</option>
                <option value="Laweyan">Wilayah: Laweyan</option>
                <option value="Banjarsari">Wilayah: Banjarsari</option>
                <option value="Jebres">Wilayah: Jebres</option>
                <option value="Serengan">Wilayah: Serengan</option>
                <option value="Pasar Kliwon">Wilayah: Pasar Kliwon</option>
              </select>

              <select
                value={filterStatus}
                onChange={(e) => setFilterStatus(e.target.value)}
                className="bg-white border border-navy/15 rounded-xl px-3 py-2.5 text-xs font-bold text-navy focus:outline-none focus:ring-2 focus:ring-crimson cursor-pointer"
              >
                <option value="Semua">Semua Status</option>
                <option value="masuk">Baru</option>
                <option value="sedang_ditangani">Diproses</option>
                <option value="selesai">Selesai</option>
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
            {filteredLaporan.slice(0, 4).map((laporan) => (
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
            {filteredLaporan.length === 0 && (
              <button
                type="button"
                onClick={handleResetFilter}
                className="px-2.5 py-1 text-xs font-bold text-crimson hover:underline"
              >
                Reset Filter
              </button>
            )}
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
                  {filteredLaporan.length} Laporan
                </span>
              </div>

              {/* List Tiket Mini */}
              <div className="space-y-3">
                {filteredLaporan.map((laporan) => (
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
                      <div className="flex items-center gap-1">
                        {cekIndikasiSpam(laporan) && (
                          <span className="text-[9px] font-extrabold bg-rose-100 text-rose-800 px-1.5 py-0.5 rounded border border-rose-300">
                            Perlu Verifikasi
                          </span>
                        )}
                        <span className={cn(
                          'text-[10px] font-extrabold px-2 py-0.5 rounded text-white',
                          laporan.status === 'selesai' ? 'bg-emerald-700' : laporan.status === 'sedang_ditangani' ? 'bg-amber-600' : 'bg-navy'
                        )}>
                          {laporan.status.replace(/_/g, ' ')}
                        </span>
                      </div>
                    </div>
                    <h3 className="text-xs font-extrabold text-navy leading-snug line-clamp-1">{laporan.judul}</h3>
                    <p className="text-[11px] text-navy/70 mt-1 flex items-center gap-1">
                      <MapPin className="w-3 h-3 text-crimson shrink-0" />
                      {laporan.kelurahan || laporan.kecamatan || 'Surakarta'}
                    </p>
                  </button>
                ))}

                {filteredLaporan.length === 0 && (
                  <div className="rounded-2xl bg-white/80 p-5 text-center space-y-3 border border-navy/10">
                    <p className="text-xs text-navy/70 font-semibold leading-relaxed">
                      Tidak ada aduan berstatus &quot;{filterStatus}&quot; di wilayah &quot;{filterWilayah}&quot;.
                    </p>
                    <button
                      type="button"
                      onClick={handleResetFilter}
                      className="px-4 py-2 bg-crimson hover:bg-[#8a002b] text-white text-xs font-bold rounded-xl transition shadow-xs"
                    >
                      Reset Filter
                    </button>
                  </div>
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
                    {cekIndikasiSpam(currentLap) && (
                      <span className="text-xs font-bold bg-rose-100 text-rose-800 border border-rose-300 px-2.5 py-1 rounded-md flex items-center gap-1">
                        <AlertCircle className="w-3.5 h-3.5 text-rose-600" />
                        Perlu Verifikasi (Indikasi Spam)
                      </span>
                    )}
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
                  {currentLap?.judul || (filteredLaporan.length === 0 ? 'Tidak Ada Laporan Sesuai Filter' : 'Laporan tidak ditemukan')}
                </h2>
                <p className="text-xs sm:text-sm text-navy/80 leading-relaxed font-medium">
                  {currentLap?.deskripsi || (filteredLaporan.length === 0
                    ? `Tidak ada aduan berstatus "${filterStatus === 'masuk' ? 'Baru' : filterStatus === 'sedang_ditangani' ? 'Diproses' : filterStatus === 'selesai' ? 'Selesai' : filterStatus}" di wilayah "${filterWilayah}". Silakan ubah filter atau tekan tombol Reset Filter.`
                    : 'Periksa kembali kode lacak atau coba lagi setelah data berhasil dimuat.')}
                </p>

                {!currentLap && filteredLaporan.length === 0 && (
                  <div className="pt-2">
                    <button
                      type="button"
                      onClick={handleResetFilter}
                      className="px-4 py-2 bg-crimson hover:bg-[#8a002b] text-white text-xs font-bold rounded-xl transition shadow-xs"
                    >
                      Reset Filter & Tampilkan Semua
                    </button>
                  </div>
                )}

                {/* ── Transparansi / Kartu Inspeksi AI Gemini 3.5 ── */}
                {currentLap && <KartuInspeksiAI laporan={currentLap} />}

                {cekIndikasiSpam(currentLap) && (
                  <div className="rounded-2xl border border-rose-300 bg-rose-50 p-4 text-xs font-medium text-rose-900 flex items-start gap-3">
                    <AlertCircle className="w-5 h-5 text-rose-600 shrink-0 mt-0.5" />
                    <div>
                      <p className="font-bold text-rose-950">Laporan Ditandai oleh Sistem Keamanan AI</p>
                      <p className="mt-0.5 text-rose-800 leading-relaxed">
                        Laporan ini terdeteksi bukan aduan fasilitas publik (indikasi spam/komersial/joki) dan diberi penanda <strong>perlu_verifikasi_tambahan</strong> untuk ditinjau manual oleh Petugas sebelum didisposisikan.
                      </p>
                    </div>
                  </div>
                )}
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

                {/* ── Komparasi Slider Interaktif jika kedua foto tersedia ── */}
                {currentLap?.foto_sebelum_paths?.[0]?.startsWith('http') &&
                 currentLap?.foto_sesudah_paths?.[0]?.startsWith('http') && (
                  <div className="mb-4">
                    <KomparasiSlider
                      fotoSebelum={currentLap.foto_sebelum_paths[0]}
                      fotoSesudah={currentLap.foto_sesudah_paths[0]}
                      altSebelum="Kondisi Sebelum Penanganan"
                      altSesudah="Kondisi Tuntas (Hasil Perbaikan)"
                    />
                  </div>
                )}

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

              {/* ── Panel Petugas: Bukti Sesudah & Selesaikan Aduan ── */}
              {isPetugasOrAdmin && currentLap && currentLap.status !== 'selesai' && currentLap.status !== 'ditolak' && (
                <div className="bg-emerald-500/10 border-2 border-emerald-500/30 rounded-2xl p-5 sm:p-6 space-y-4">
                  <div className="flex items-center justify-between gap-3 flex-wrap">
                    <div className="flex items-center gap-2">
                      <div className="p-2 bg-emerald-500 text-white rounded-xl shadow-sm">
                        <CheckSquare className="w-5 h-5" />
                      </div>
                      <div>
                        <h3 className="text-sm font-extrabold text-navy">
                          Panel Tindak Lanjut Petugas Lapangan
                        </h3>
                        <p className="text-xs text-navy/70">
                          Unggah foto bukti sesudah perbaikan fisik untuk menuntaskan tiket aduan ini.
                        </p>
                      </div>
                    </div>
                    <span className="text-[11px] font-bold px-2.5 py-1 bg-emerald-600/15 text-emerald-800 rounded-lg border border-emerald-600/30">
                      Peran: {pengguna?.peran?.toUpperCase()}
                    </span>
                  </div>

                  {/* Area Pilih & Pratinjau Foto Bukti */}
                  <div className="space-y-3">
                    <label className="block text-xs font-bold text-navy">
                      1. Foto Bukti Fisik Sesudah Perbaikan (Wajib)
                    </label>
                    <input
                      type="file"
                      ref={fileInputRef}
                      onChange={handlePilihFotoSesudah}
                      accept="image/jpeg,image/png,image/webp"
                      className="hidden"
                    />

                    {previewFotoSesudah ? (
                      <div className="relative rounded-xl overflow-hidden border border-emerald-500/30 max-w-md bg-slate-900">
                        <img
                          src={previewFotoSesudah}
                          alt="Pratinjau Foto Sesudah"
                          className="w-full h-48 object-cover"
                        />
                        <button
                          type="button"
                          onClick={() => fileInputRef.current?.click()}
                          className="absolute bottom-2.5 right-2.5 bg-black/70 hover:bg-black text-white text-xs font-bold px-3 py-1.5 rounded-lg backdrop-blur transition flex items-center gap-1.5"
                        >
                          <Camera className="w-3.5 h-3.5" />
                          Ganti Foto
                        </button>
                      </div>
                    ) : (
                      <button
                        type="button"
                        onClick={() => fileInputRef.current?.click()}
                        className="w-full sm:w-auto flex items-center justify-center gap-2 px-4 py-3 border-2 border-dashed border-emerald-500/40 rounded-xl bg-white hover:bg-emerald-500/5 text-emerald-800 text-xs font-bold transition shadow-sm"
                      >
                        <Upload className="w-4 h-4 text-emerald-600" />
                        Pilih / Ambil Foto Bukti Sesudah
                      </button>
                    )}
                  </div>

                  {/* Catatan Tindakan */}
                  <div className="space-y-2">
                    <label className="block text-xs font-bold text-navy">
                      2. Catatan Penanganan & Berita Acara Singkat
                    </label>
                    <textarea
                      rows={3}
                      value={catatanPetugas}
                      onChange={(e) => setCatatanPetugas(e.target.value)}
                      placeholder="Uraikan tindakan perbaikan yang telah dilakukan di lapangan..."
                      className="w-full rounded-xl border border-navy/20 p-3 text-xs text-navy focus:outline-none focus:ring-2 focus:ring-emerald-500 bg-white"
                    />
                  </div>

                  {/* Pesan Notifikasi Sukses / Error */}
                  {pesanPetugas && (
                    <div
                      className={cn(
                        'p-3 rounded-xl text-xs font-medium border flex items-center gap-2',
                        pesanPetugas.tipe === 'sukses'
                          ? 'bg-emerald-50 border-emerald-200 text-emerald-800'
                          : 'bg-red-50 border-red-200 text-red-800'
                      )}
                    >
                      {pesanPetugas.tipe === 'sukses' ? (
                        <CheckCircle2 className="w-4 h-4 shrink-0 text-emerald-600" />
                      ) : (
                        <AlertCircle className="w-4 h-4 shrink-0 text-red-600" />
                      )}
                      <span>{pesanPetugas.teks}</span>
                    </div>
                  )}

                  {/* Tombol Eksekusi Penuntasan */}
                  <div className="pt-2 flex items-center gap-3 flex-wrap">
                    <button
                      type="button"
                      disabled={sedangUploadPetugas || !berkasFotoSesudah}
                      onClick={handleSelesaikanAduan}
                      className={cn(
                        'px-5 py-2.5 rounded-xl text-xs font-extrabold text-white flex items-center gap-2 shadow-sm transition',
                        sedangUploadPetugas || !berkasFotoSesudah
                          ? 'bg-emerald-600/50 cursor-not-allowed'
                          : 'bg-emerald-600 hover:bg-emerald-700 active:scale-95'
                      )}
                    >
                      {sedangUploadPetugas ? (
                        <>
                          <Loader2 className="w-4 h-4 animate-spin" />
                          Menyimpan Bukti & Menuntaskan...
                        </>
                      ) : (
                        <>
                          <CheckCircle2 className="w-4 h-4" />
                          Selesaikan Aduan & Unggah Bukti
                        </>
                      )}
                    </button>
                    <p className="text-[11px] text-navy/60">
                      Tindakan ini akan mengunggah berkas ke storage aman dan memvalidasi transisi status menjadi &apos;selesai&apos;.
                    </p>
                  </div>
                </div>
              )}

              {/* Informasi Alur Petugas Lapangan */}
              {!isPetugasOrAdmin && currentLap && currentLap.status !== 'selesai' && (
                <div className={cn(
                  'rounded-2xl p-4 flex items-center justify-between gap-4 flex-wrap border',
                  currentLap.status === 'masuk'
                    ? 'bg-blue-50/80 border-blue-200 text-blue-900'
                    : 'bg-amber-50 border-amber-200/80'
                )}>
                  <div className="flex items-center gap-3">
                    <div className={cn(
                      'p-2 rounded-xl',
                      currentLap.status === 'masuk' ? 'bg-blue-600/10 text-blue-700' : 'bg-amber-500/10 text-amber-700'
                    )}>
                      {currentLap.status === 'masuk' ? <Clock className="w-5 h-5" /> : <UserCheck className="w-5 h-5" />}
                    </div>
                    <div>
                      {currentLap.status === 'masuk' ? (
                        <p className="text-xs font-extrabold text-navy">
                          Mohon ditunggu verifikasi dari petugas
                        </p>
                      ) : (
                        <>
                          <p className="text-xs font-extrabold text-navy">
                            Penanganan Sedang Berjalan
                          </p>
                          <p className="text-[11px] text-navy/70">
                            Petugas lapangan berwenang yang ditugaskan akan mengunggah foto bukti sesudah perbaikan dan catatan teknis.
                          </p>
                        </>
                      )}
                    </div>
                  </div>
                </div>
              )}

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
                ) : currentLap?.linimasa && currentLap.linimasa.some(
                    (l) => l.status_ke === 'sedang_ditangani' && l.catatan && l.catatan !== 'Regu Reaksi Cepat melakukan tindakan fisik di lokasi'
                  ) ? (
                  <dl className="grid gap-2 text-xs text-navy/80">
                    {currentLap.linimasa
                      .filter((l) => l.status_ke === 'sedang_ditangani' && l.catatan && l.catatan !== 'Regu Reaksi Cepat melakukan tindakan fisik di lokasi')
                      .map((l, i) => (
                        <div key={i}>
                          <dt className="font-bold">Catatan Verifikasi Admin</dt>
                          <dd className="mt-0.5 text-navy/80 leading-relaxed">{l.catatan}</dd>
                          <dd className="text-[11px] text-navy/50 mt-0.5">{new Date(l.created_at).toLocaleString('id-ID')}</dd>
                        </div>
                      ))
                    }
                  </dl>
                ) : (
                  <p className="text-xs text-navy/70">Belum ada catatan penanganan yang tersimpan.</p>
                )}
              </div>

              {/* ── Kuesioner Audit Gotong Royong (Khusus Warga Pelapor saat status Selesai) ── */}
              {currentLap?.status === 'selesai' && !isPetugasOrAdmin && (!currentLap?.konfirmasi_warga || modeEditUlasan) && (
                <div className="bg-white p-5 rounded-2xl border-2 border-crimson/20 shadow-sm space-y-4">
                  <div className="flex items-start justify-between gap-3 flex-wrap">
                    <div className="flex items-start gap-3">
                      <div className="p-2 bg-crimson/10 text-crimson rounded-xl shrink-0 mt-0.5">
                        <AlertCircle className="w-5 h-5" />
                      </div>
                      <div>
                        <h3 className="text-sm font-extrabold text-navy">
                          {currentLap?.konfirmasi_warga ? 'Perbarui Ulasan & Penilaian Layanan' : 'Apakah laporan ini sudah benar-benar beres?'}
                        </h3>
                        <p className="text-xs text-navy/70 mt-0.5 leading-relaxed">
                          Sebagai warga pelapor, Anda berhak memverifikasi langsung hasil pengerjaan di lapangan dan memberikan suara ulasan.
                        </p>
                      </div>
                    </div>
                    {modeEditUlasan && (
                      <button
                        type="button"
                        onClick={() => setModeEditUlasan(false)}
                        className="text-xs font-bold text-navy/60 hover:text-navy underline"
                      >
                        Batal Edit
                      </button>
                    )}
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

                      <div className="space-y-1.5">
                        <label className="block text-[11px] font-bold text-navy">
                          Suara Warga / Testimoni Layanan & Catatan Evaluasi:
                        </label>
                        <textarea
                          rows={3}
                          value={komentarUlasan}
                          onChange={(e) => setKomentarUlasan(e.target.value)}
                          placeholder="Tuliskan ulasan langsung Anda mengenai hasil perbaikan di lokasi, kerapian pengerjaan, atau masukan untuk dinas pengampu..."
                          className="w-full rounded-xl border border-navy/15 p-3 text-xs text-navy focus:outline-none focus:ring-2 focus:ring-emerald-500 bg-white leading-relaxed resize-none"
                        />
                        <p className="text-[10px] text-navy/50">
                          Ulasan warga akan ditampilkan transparan pada Papan Tanggap dan evaluasi kinerja dinas.
                        </p>
                      </div>

                      <div className="flex flex-col sm:flex-row gap-3">
                        <button
                          type="button"
                          onClick={() => handleKonfirmasi('selesai')}
                          className="flex-1 py-3 bg-emerald-600 hover:bg-emerald-700 text-white font-extrabold text-xs rounded-xl flex items-center justify-center gap-2 transition-all shadow-md active:scale-95"
                        >
                          <Check className="w-4 h-4" />
                          Sudah Beres / Selesai Tuntas
                        </button>

                        <button
                          type="button"
                          onClick={() => handleKonfirmasi('revisi')}
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
                        Terima kasih telah memberikan penilaian terhadap penanganan fasilitas publik.
                      </p>
                    </div>
                  ) : (
                    <div className="p-4 bg-rose-50 border border-rose-300 rounded-xl text-center space-y-1 animate-in fade-in">
                      <p className="text-xs font-extrabold text-crimson">
                        Permintaan tindak lanjut berhasil dikirim ke petugas.
                      </p>
                      <p className="text-[11px] text-navy/70">
                        Status aduan diubah menjadi dibuka kembali agar petugas melakukan pengerjaan ulang.
                      </p>
                    </div>
                  )}
                </div>
              )}

              {/* Tampilan Konfirmasi yang Sudah Diberikan (Untuk Petugas / Admin atau Warga saat tidak dalam mode edit) */}
              {currentLap?.status === 'selesai' && !modeEditUlasan && (isPetugasOrAdmin || currentLap?.konfirmasi_warga) && (
                <div className="bg-emerald-50 border border-emerald-200/80 rounded-2xl p-4 sm:p-5 space-y-2">
                  <div className="flex items-center justify-between gap-3 flex-wrap">
                    <div className="flex items-center gap-2.5">
                      <CheckCircle2 className="w-5 h-5 text-emerald-600 shrink-0" />
                      <div>
                        <p className="text-xs font-bold text-emerald-950">
                          {currentLap?.konfirmasi_warga ? 'Ulasan & Konfirmasi Gotong Royong Warga' : 'Penanganan Telah Selesai'}
                        </p>
                        <p className="text-[11px] text-emerald-800">
                          {currentLap?.konfirmasi_warga
                            ? 'Pelapor telah memvalidasi hasil pekerjaan di lapangan secara langsung.'
                            : 'Penilaian kualitas layanan fasilitas publik dievaluasi langsung oleh warga pelapor.'}
                        </p>
                      </div>
                    </div>

                    <div className="flex items-center gap-2">
                      {currentLap?.konfirmasi_warga && (
                        <div className="flex items-center gap-1 bg-white/80 px-2.5 py-1 rounded-xl border border-emerald-200">
                          {[1, 2, 3, 4, 5].map((star) => (
                            <Star
                              key={star}
                              className={cn(
                                'w-3.5 h-3.5',
                                star <= (currentLap.konfirmasi_warga?.rating || 5)
                                  ? 'fill-amber-400 text-amber-400'
                                  : 'text-navy/20'
                              )}
                            />
                          ))}
                          <span className="text-[11px] font-extrabold text-navy ml-1">
                            {currentLap.konfirmasi_warga.rating}/5
                          </span>
                        </div>
                      )}

                      {!isPetugasOrAdmin && currentLap?.konfirmasi_warga && (
                        <button
                          type="button"
                          onClick={() => {
                            setRating(currentLap.konfirmasi_warga?.rating || 5);
                            setKomentarUlasan(currentLap.konfirmasi_warga?.komentar || '');
                            setModeEditUlasan(true);
                          }}
                          className="px-3 py-1 bg-white hover:bg-emerald-100 text-emerald-800 text-[11px] font-bold rounded-lg border border-emerald-300 transition"
                        >
                          {currentLap.konfirmasi_warga?.komentar ? 'Ubah Komentar' : '+ Tambah Komentar Warga'}
                        </button>
                      )}
                    </div>
                  </div>

                  {currentLap?.konfirmasi_warga?.komentar ? (
                    <div className="bg-white/90 p-3 rounded-xl border border-emerald-100 text-xs text-navy/90 mt-2">
                      <p className="text-[10px] font-bold text-emerald-800 uppercase tracking-wider mb-1">
                        Komentar / Ulasan Warga:
                      </p>
                      <p className="italic leading-relaxed">&ldquo;{currentLap.konfirmasi_warga.komentar}&rdquo;</p>
                    </div>
                  ) : !isPetugasOrAdmin ? (
                    <div className="bg-white/80 p-3 rounded-xl border border-dashed border-emerald-300 text-xs text-navy/70 mt-2 flex items-center justify-between gap-2">
                      <span className="italic text-[11px]">Belum ada catatan/komentar ulasan yang disertakan pada rating ini.</span>
                      <button
                        type="button"
                        onClick={() => {
                          setRating(currentLap.konfirmasi_warga?.rating || 5);
                          setKomentarUlasan('');
                          setModeEditUlasan(true);
                        }}
                        className="text-[11px] font-extrabold text-emerald-800 hover:underline shrink-0"
                      >
                        Tuliskan Komentar Sekarang &rarr;
                      </button>
                    </div>
                  ) : null}
                </div>
              )}

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
