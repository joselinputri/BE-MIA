'use client';

import { useEffect, useState, useRef, type ChangeEvent } from 'react';
import dynamic from 'next/dynamic';
import Script from 'next/script';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import {
  Camera,
  ChevronRight,
  MapPin,
  Phone,
  Play,
  ShieldCheck,
  TriangleAlert,
  Navigation,
  Check,
  Sparkles,
  ArrowRight,
  RotateCw,
} from 'lucide-react';
import Reveal from '@/components/Reveal';
import { PageHero, Pil, tombolDasar } from '@/components/ui';
import { KATEGORI, type KategoriUI } from '@/lib/kategori';
import { kirimLaporan } from '@/lib/client/data';
import { cn } from '@/lib/utils';

/* ────────────────── constants ────────────────── */
const DESC_MAX = 500;
const DESC_MIN = 20;
const PUSAT_SURAKARTA: [number, number] = [-7.5684, 110.8122];
const TURNSTILE_SITE_KEY = process.env.NEXT_PUBLIC_TURNSTILE_SITE_KEY;

declare global {
  interface Window {
    turnstile?: {
      render: (
        container: HTMLElement,
        options: {
          sitekey: string;
          callback: (token: string) => void;
          'expired-callback': () => void;
          'error-callback': () => void;
        }
      ) => string;
      remove: (widgetId: string) => void;
    };
  }
}

const LokasiMapPicker = dynamic(() => import('@/components/LokasiMapPicker'), {
  ssr: false,
  loading: () => <div className="h-56 animate-pulse rounded-2xl bg-lilac/50" />,
});

const SLA_STEPS = [
  'Verifikasi laporan',
  'Pemeriksaan lapangan',
  'Tindak lanjut dan bukti penyelesaian',
] as const;

/* ══════════════════════ PAGE ══════════════════════ */
export default function LaporPage() {
  const router = useRouter();

  /* ── form state ── */
  const [kategori, setKategori] = useState<string | null>('penambalan-aspal');
  const [judul, setJudul] = useState<string>('');
  const [foto, setFoto] = useState<string | null>(null);
  const [fotoFile, setFotoFile] = useState<File | null>(null);
  const [fotoName, setFotoName] = useState<string>('');
  const [latitude, setLatitude] = useState(PUSAT_SURAKARTA[0]);
  const [longitude, setLongitude] = useState(PUSAT_SURAKARTA[1]);
  const [locationNotice, setLocationNotice] = useState<string | null>(null);
  const [deskripsi, setDeskripsi] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [errorNotice, setErrorNotice] = useState<string | null>(null);
  const [turnstileReady, setTurnstileReady] = useState(false);
  const [turnstileToken, setTurnstileToken] = useState<string | null>(null);
  const [suksesModal, setSuksesModal] = useState<{
    kode: string;
    pesan: string;
    penanda?: string[];
    saran?: string[];
  } | null>(null);

  const fileRef = useRef<HTMLInputElement>(null);
  const errorRef = useRef<HTMLDivElement>(null);
  const turnstileContainerRef = useRef<HTMLDivElement>(null);
  const turnstileWidgetIdRef = useRef<string | null>(null);

  useEffect(() => {
    if (!foto?.startsWith('blob:')) return;
    return () => URL.revokeObjectURL(foto);
  }, [foto]);

  useEffect(() => {
    if (!errorNotice) return;
    const frame = window.requestAnimationFrame(() => {
      errorRef.current?.scrollIntoView({ behavior: 'instant', block: 'center' });
    });
    return () => window.cancelAnimationFrame(frame);
  }, [errorNotice]);

  useEffect(() => {
    if (!TURNSTILE_SITE_KEY || !turnstileReady || !turnstileContainerRef.current || !window.turnstile) return;

    turnstileWidgetIdRef.current = window.turnstile.render(turnstileContainerRef.current, {
      sitekey: TURNSTILE_SITE_KEY,
      callback: (token) => setTurnstileToken(token),
      'expired-callback': () => {
        setTurnstileToken(null);
        setErrorNotice('Verifikasi keamanan kedaluwarsa. Selesaikan verifikasi kembali.');
      },
      'error-callback': () => {
        setTurnstileToken(null);
        setErrorNotice('Verifikasi keamanan gagal dimuat. Coba muat ulang halaman.');
      },
    });

    return () => {
      if (turnstileWidgetIdRef.current) {
        window.turnstile?.remove(turnstileWidgetIdRef.current);
        turnstileWidgetIdRef.current = null;
      }
    };
  }, [turnstileReady]);

  /* ── handlers ── */
  function handleFoto(e: ChangeEvent<HTMLInputElement>) {
    const file = e.target.files?.[0];
    if (!file) return;
    if (!['image/jpeg', 'image/png', 'image/webp'].includes(file.type)) {
      setErrorNotice('Format foto harus JPG, PNG, atau WebP.');
      e.target.value = '';
      return;
    }
    if (file.size > 5 * 1024 * 1024) {
      setErrorNotice('Ukuran foto maksimal 5 MB.');
      e.target.value = '';
      return;
    }
    setErrorNotice(null);
    setFotoName(file.name);
    const url = URL.createObjectURL(file);
    setFoto(url);
    setFotoFile(file);
  }

  function handleLokasiSaya() {
    setLocationNotice(null);
    if (!navigator.geolocation) {
      setLocationNotice('Peramban ini tidak mendukung akses lokasi.');
      return;
    }

    navigator.geolocation.getCurrentPosition(
      ({ coords }) => {
        if (
          coords.latitude < -7.6 ||
          coords.latitude > -7.52 ||
          coords.longitude < 110.77 ||
          coords.longitude > 110.87
        ) {
          setLocationNotice('Lokasi perangkat berada di luar Kota Surakarta. Pilih titik di peta.');
          return;
        }
        setLatitude(coords.latitude);
        setLongitude(coords.longitude);
      },
      () => setLocationNotice('Lokasi tidak dapat diakses. Izinkan lokasi atau pilih titik di peta.'),
      { enableHighAccuracy: true, timeout: 10000 }
    );
  }

  async function handleSubmit() {
    setErrorNotice(null);

    if (!kategori) {
      setErrorNotice('Pilih salah satu jenis masalah fasilitas kota terlebih dahulu.');
      return;
    }
    if (judul.trim().length < 5) {
      setErrorNotice('Judul laporan minimal 5 karakter agar dapat diidentifikasi petugas.');
      return;
    }
    if (deskripsi.trim().length < DESC_MIN) {
      setErrorNotice(`Deskripsi laporan minimal ${DESC_MIN} karakter agar jelas kronologi lapangannya.`);
      return;
    }
    if (!fotoFile) {
      setErrorNotice('Unggah foto bukti kondisi sebelum perbaikan terlebih dahulu.');
      return;
    }
    if (TURNSTILE_SITE_KEY && !turnstileToken) {
      setErrorNotice('Selesaikan verifikasi keamanan sebelum mengirim laporan.');
      return;
    }

    setIsSubmitting(true);

    const res = await kirimLaporan({
      judul: judul.trim(),
      deskripsi: deskripsi.trim(),
      kategori_slug: kategori,
      latitude,
      longitude,
      foto_url: foto || undefined,
      foto_file: fotoFile,
      is_anonim: true,
      turnstile_token: turnstileToken || undefined,
    });

    setIsSubmitting(false);

    if (res.ok && res.kode) {
      setSuksesModal({
        kode: res.kode,
        pesan: res.pesan,
        penanda: res.penanda,
        saran: res.saran_perbaikan,
      });
    } else {
      setErrorNotice(res.pesan || 'Gagal mengirim aduan. Coba beberapa saat lagi.');
    }
  }

  return (
    <main className="min-h-screen bg-mist pb-20">
      {/* ── Hero ── */}
      <section className="mx-auto max-w-6xl px-4 pt-6">
        <Reveal>
          <PageHero
            judul="Kirim Aduan Fasilitas Kota"
            deskripsi="Ungkap kendala fasilitas kota Surakarta secara langsung tanpa birokrasi berbelit. Terhubung ke 5 kecamatan dengan kepastian SLA tanggap cepat."
          />
        </Reveal>
      </section>

      {/* ── Main Content — two columns ── */}
      <section className="mx-auto mt-8 max-w-6xl px-4">
        <div className="grid gap-8 md:grid-cols-[1fr_340px]">
          {/* ════════ LEFT COLUMN — Form Steps ════════ */}
          <div className="space-y-10">
            {/* ── Step 1: Pilih Jenis Masalah ── */}
            <Reveal delay={80}>
              <div className="bg-panel p-6 rounded-3xl shadow-[0_8px_24px_rgba(40,38,75,.14)] border border-navy/10">
                <StepHeader num={1} title="Pilih Jenis Masalah" />
                <p className="mt-1 text-xs font-bold text-crimson">*WAJIB DIPILIH</p>

                <div className="mt-4 grid grid-cols-2 gap-3 sm:grid-cols-3" role="radiogroup" aria-label="Kategori masalah">
                  {KATEGORI.map((k) => (
                    <KategoriCard
                      key={k.slug}
                      kat={k}
                      selected={kategori === k.slug}
                      onSelect={() => setKategori(k.slug)}
                    />
                  ))}
                </div>
              </div>
            </Reveal>

            {/* ── Step 2: Bukti Foto & Lokasi Otomatis ── */}
            <Reveal delay={160}>
              <div className="bg-panel p-6 rounded-3xl shadow-[0_8px_24px_rgba(40,38,75,.14)] border border-navy/10 space-y-5">
                <div className="flex items-center justify-between">
                  <StepHeader num={2} title="Bukti Foto & Lokasi Otomatis" />
                  <Pil className="bg-emerald-600/20 text-emerald-800 border border-emerald-500/30 font-bold">
                    <span className="mr-1.5 inline-block h-2 w-2 rounded-full bg-emerald-500 animate-pulse" />
                    GPS Aktif
                  </Pil>
                </div>

                {/* Photo upload */}
                <button
                  type="button"
                  onClick={() => fileRef.current?.click()}
                  aria-label="Unggah foto bukti"
                  className={cn(
                    'flex w-full flex-col items-center justify-center gap-2 rounded-2xl border-2 border-dashed border-slate/40 bg-white/80 px-4 py-8 text-sm text-slate transition hover:border-crimson hover:bg-white focus-visible:ring-2 shadow-sm',
                    foto && 'border-crimson/50'
                  )}
                >
                  {foto ? (
                    // eslint-disable-next-line @next/next/no-img-element
                    <div className="relative">
                      <img src={foto} alt="Preview foto kondisi lapangan" className="h-44 w-auto rounded-xl object-cover shadow" />
                      <span className="absolute bottom-2 left-2 bg-navy/90 text-white text-[10px] font-bold px-2 py-0.5 rounded">
                        Klik untuk Ganti Foto
                      </span>
                    </div>
                  ) : (
                    <>
                      <Camera className="h-9 w-9 text-slate/70" />
                      <span className="font-bold text-navy">Ambil Foto / Unggah File</span>
                      <span className="text-xs text-slate/70">JPG, PNG, atau WebP hingga 5MB</span>
                    </>
                  )}
                  {fotoName && <span className="mt-2 text-xs font-mono font-bold text-navy/70">{fotoName}</span>}
                </button>
                <input ref={fileRef} type="file" accept="image/jpeg,image/png,image/webp" className="hidden" onChange={handleFoto} aria-hidden />

                {/* Lokasi laporan */}
                <div className="flex items-start justify-between gap-3 rounded-2xl bg-white p-4 border border-navy/10 shadow-sm">
                  <div className="flex items-start gap-2.5">
                    <MapPin className="mt-0.5 h-5 w-5 shrink-0 text-crimson" />
                    <div>
                      <p className="text-xs font-bold text-navy/60 uppercase">Titik Lokasi Laporan</p>
                      <p className="text-sm font-extrabold text-navy">Surakarta, Jawa Tengah</p>
                      <p className="text-[11px] text-navy/60">
                        {latitude.toFixed(5)}, {longitude.toFixed(5)}
                      </p>
                    </div>
                  </div>
                  <button
                    type="button"
                    onClick={handleLokasiSaya}
                    className="shrink-0 rounded-lg bg-card px-2.5 py-1 text-xs font-bold text-navy hover:bg-peri/40"
                  >
                    Lokasi Saya
                  </button>
                </div>

                {/* Judul Laporan */}
                <div>
                  <label htmlFor="judul" className="text-xs font-extrabold text-navy uppercase tracking-wider block mb-1.5">
                    Judul Ringkas Aduan
                  </label>
                  <input
                    id="judul"
                    type="text"
                    value={judul}
                    onChange={(e) => setJudul(e.target.value)}
                    placeholder="Contoh: Aspal Amblas Berlubang Parah di Dekat Halte"
                    className="w-full rounded-xl bg-white px-4 py-2.5 text-sm font-semibold text-navy border border-navy/15 focus:outline-none focus:ring-2 focus:ring-crimson"
                  />
                </div>

                {/* Description textarea */}
                <div>
                  <label htmlFor="deskripsi" className="text-xs font-extrabold text-navy uppercase tracking-wider block mb-1.5">
                    Rincian Deskripsi Masalah
                  </label>
                  <div className="rounded-2xl bg-white border border-navy/15 p-2 shadow-sm">
                    <textarea
                      id="deskripsi"
                      rows={4}
                      maxLength={DESC_MAX}
                      value={deskripsi}
                      onChange={(e) => setDeskripsi(e.target.value)}
                      placeholder="Jelaskan kondisi kerusakan yang Anda temui secara spesifik..."
                      className="w-full resize-none bg-transparent px-3 py-2 text-sm font-medium text-navy placeholder:text-slate/50 focus:outline-none"
                    />
                    <div className="flex items-center justify-between px-3 pt-2 border-t border-navy/5 text-xs text-slate/70">
                      <span>Minimal {DESC_MIN} karakter untuk verifikasi sistem</span>
                      <span className="font-mono font-bold">{deskripsi.length} / {DESC_MAX}</span>
                    </div>
                  </div>
                </div>
              </div>
            </Reveal>

            {/* ── Step 3: Privasi Pelapor ── */}
            <Reveal delay={240}>
              <div className="bg-panel p-6 rounded-3xl shadow-[0_8px_24px_rgba(40,38,75,.14)] border border-navy/10 space-y-4">
                <StepHeader num={3} title="Privasi Pelapor" />
                <p className="text-xs text-navy/70">
                  Laporan dikirim tanpa menampilkan identitas pribadi pada halaman publik.
                </p>
                {TURNSTILE_SITE_KEY && (
                  <>
                    <Script
                      src="https://challenges.cloudflare.com/turnstile/v0/api.js?render=explicit"
                      strategy="afterInteractive"
                      onReady={() => setTurnstileReady(true)}
                      onError={() => setErrorNotice('Skrip verifikasi keamanan gagal dimuat. Coba muat ulang halaman.')}
                    />
                    <div className="space-y-2">
                      <p className="text-xs font-semibold text-navy">Verifikasi keamanan</p>
                      <div ref={turnstileContainerRef} />
                    </div>
                  </>
                )}
              </div>
            </Reveal>

            {errorNotice && (
              <div
                ref={errorRef}
                role="alert"
                aria-live="assertive"
                className="flex scroll-mt-24 items-center gap-2 rounded-2xl border border-rose-300 bg-rose-100 p-4 text-xs font-bold text-crimson animate-in fade-in"
              >
                <TriangleAlert className="h-5 w-5 shrink-0" />
                <span>{errorNotice}</span>
              </div>
            )}
            {/* ── Bottom actions ── */}
            <Reveal delay={300}>
              <div className="flex flex-wrap items-center gap-3 pt-2">
                <button
                  type="button"
                  onClick={handleSubmit}
                  disabled={isSubmitting}
                  className={cn(
                    tombolDasar,
                    'bg-crimson px-7 text-white shadow-lg shadow-crimson/20 hover:bg-[#8a002b] disabled:opacity-50'
                  )}
                >
                  {isSubmitting ? (
                    <>
                      <RotateCw className="h-4 w-4 animate-spin" />
                      <span>Memproses Laporan...</span>
                    </>
                  ) : (
                    <>
                      <Play className="h-4 w-4" fill="white" />
                      <span>Kirim Laporan Sekarang</span>
                    </>
                  )}
                </button>
              </div>
            </Reveal>
          </div>

          {/* ════════ RIGHT COLUMN — Sidebar ════════ */}
          <aside className="space-y-6">
            {/* Peta Radar Sekitar */}
            <Reveal delay={120}>
              <div className="rounded-3xl bg-panel p-4 shadow-md">
                <div className="mb-3 flex items-center justify-between gap-2">
                  <div>
                    <p className="text-xs font-extrabold text-navy">Pilih Titik di Peta</p>
                    <p className="text-[11px] text-navy/70">Geser peta, klik lokasi, atau tarik pin.</p>
                  </div>
                  <Navigation className="h-5 w-5 shrink-0 text-crimson" />
                </div>
                <LokasiMapPicker
                  latitude={latitude}
                  longitude={longitude}
                  onChange={(lat, lng) => {
                    setLatitude(lat);
                    setLongitude(lng);
                    setLocationNotice(null);
                  }}
                />
                {locationNotice && <p role="status" className="mt-2 text-xs font-semibold text-crimson">{locationNotice}</p>}
              </div>
            </Reveal>

            {/* SLA Card */}
            <Reveal delay={200}>
              <div className="rounded-3xl bg-panel p-5 shadow-[0_8px_24px_rgba(40,38,75,.14)] border border-navy/10">
                <div className="flex items-center gap-2">
                  <ShieldCheck className="h-5 w-5 text-crimson" />
                  <h3 className="text-sm font-extrabold text-navy">Alur Penanganan Laporan</h3>
                </div>
                <ol className="mt-4 space-y-4">
                  {SLA_STEPS.map((s, i) => (
                    <li key={i} className="flex items-start gap-3">
                      <span className="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-crimson text-white text-xs font-bold shadow-sm">
                        {i + 1}
                      </span>
                      <div>
                        <p className="text-xs font-bold text-navy">{s}</p>
                      </div>
                    </li>
                  ))}
                </ol>
              </div>
            </Reveal>

            {/* Emergency Card */}
            <Reveal delay={280}>
              <div className="rounded-3xl bg-panel p-5 shadow-[0_8px_24px_rgba(40,38,75,.14)] border border-crimson/30">
                <div className="flex items-center gap-2">
                  <TriangleAlert className="h-5 w-5 text-crimson" />
                  <h3 className="text-xs font-extrabold text-crimson">Butuh Bantuan Mendesak / Mengancam Nyawa?</h3>
                </div>
                <div className="mt-4 space-y-2.5">
                  <a
                    href="tel:112"
                    className="flex items-center gap-3 p-3 bg-white rounded-2xl border border-navy/10 hover:border-crimson transition-colors"
                  >
                    <span className="flex h-9 w-9 items-center justify-center rounded-xl bg-crimson text-white shrink-0">
                      <Phone className="h-4 w-4" />
                    </span>
                    <div>
                      <p className="text-sm font-extrabold text-navy">112</p>
                      <p className="text-[10px] text-navy/60">Bebas Pulsa 24 Jam Siaga Solo</p>
                    </div>
                  </a>
                  <a
                    href="tel:0271714000"
                    className="flex items-center gap-3 p-3 bg-white rounded-2xl border border-navy/10 hover:border-crimson transition-colors"
                  >
                    <span className="flex h-9 w-9 items-center justify-center rounded-xl bg-navy text-white shrink-0">
                      <Phone className="h-4 w-4" />
                    </span>
                    <div>
                      <p className="text-sm font-extrabold text-navy">0271-714000</p>
                      <p className="text-[10px] text-navy/60">PUSDALOPS BPBD Surakarta</p>
                    </div>
                  </a>
                </div>
              </div>
            </Reveal>
          </aside>
        </div>
      </section>

      {/* ── Modal Dialog Sukses Buat Laporan ── */}
      {suksesModal && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-navy/70 backdrop-blur-sm animate-in fade-in">
          <div className="bg-white rounded-3xl p-6 sm:p-8 max-w-lg w-full shadow-2xl border-2 border-emerald-500 space-y-5 animate-in zoom-in-95">
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 rounded-2xl bg-emerald-100 text-emerald-700 flex items-center justify-center shrink-0">
                <Check className="w-7 h-7 stroke-[3]" />
              </div>
              <div>
                <h3 className="text-lg font-extrabold text-navy">Laporan Tersimpan</h3>
                <p className="text-xs text-navy/70">{suksesModal.pesan}</p>
              </div>
            </div>

            <div className="bg-card p-4 rounded-2xl border border-navy/10 space-y-2 text-center">
              <p className="text-[10px] font-bold text-navy/60 uppercase">Kode Lacak</p>
              <p className="text-2xl font-mono font-extrabold text-crimson tracking-wider">
                #{suksesModal.kode}
              </p>
              <p className="text-[11px] text-navy/70">Simpan kode ini untuk memantau perubahan status laporan.</p>
            </div>

            {suksesModal.saran && suksesModal.saran.length > 0 && (
              <div className="p-3 bg-amber-50 rounded-xl border border-amber-200 text-xs text-amber-900 space-y-1">
                <p className="font-bold flex items-center gap-1">
                  <Sparkles className="w-3.5 h-3.5 text-amber-600" />
                  Saran Sistem:
                </p>
                <ul className="list-disc list-inside text-[11px] space-y-0.5">
                  {suksesModal.saran.map((s, idx) => (
                    <li key={idx}>{s}</li>
                  ))}
                </ul>
              </div>
            )}

            <div className="flex flex-col sm:flex-row gap-3 pt-2">
              <Link
                href={`/riwayat?kode=${suksesModal.kode}`}
                className="flex-1 py-3 bg-crimson hover:bg-[#8a002b] text-white text-xs font-extrabold rounded-xl flex items-center justify-center gap-2 transition-all shadow-md"
              >
                <span>Lacak Laporan Sekarang</span>
                <ArrowRight className="w-4 h-4" />
              </Link>
              <button
                type="button"
                onClick={() => {
                  setSuksesModal(null);
                  setDeskripsi('');
                  setJudul('');
                  setFoto(null);
                }}
                className="py-3 px-4 bg-navy/10 hover:bg-navy/20 text-navy text-xs font-bold rounded-xl transition-colors"
              >
                Kirim Laporan Lain
              </button>
            </div>
          </div>
        </div>
      )}
    </main>
  );
}

/* ── sub-components ── */
function StepHeader({ num, title }: { num: number; title: string }) {
  return (
    <div className="flex items-center gap-3">
      <span className="flex h-7 w-7 items-center justify-center rounded-full bg-navy text-xs font-bold text-white shadow-sm">
        {num}
      </span>
      <h2 className="text-base font-extrabold text-navy">{title}</h2>
    </div>
  );
}

function KategoriCard({
  kat,
  selected,
  onSelect,
}: {
  kat: KategoriUI;
  selected: boolean;
  onSelect: () => void;
}) {
  const Icon = kat.icon;
  return (
    <button
      type="button"
      role="radio"
      aria-checked={selected}
      onClick={onSelect}
      className={cn(
        'flex flex-col items-start gap-2 rounded-2xl p-4 text-left transition-all',
        'bg-dark-card text-white',
        selected
          ? 'ring-2 ring-crimson shadow-lg shadow-crimson/20 scale-[1.02]'
          : 'ring-0 hover:ring-1 hover:ring-white/20'
      )}
    >
      <Icon className="h-6 w-6 opacity-90 text-peri" />
      <span className="text-xs font-extrabold leading-tight">{kat.nama}</span>
      <span className="text-[10px] leading-snug text-white/70">{kat.ket}</span>
    </button>
  );
}
