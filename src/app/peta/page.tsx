'use client';

import { useState, useEffect } from 'react';
import dynamic from 'next/dynamic';
import Link from 'next/link';
import {
  MapPin,
  Layers,
  ArrowUpRight,
} from 'lucide-react';
import Reveal from '@/components/Reveal';
import { Panel, Kartu } from '@/components/ui';
import { getLaporanPublik, type Laporan } from '@/lib/client/data';
import { useAsync } from '@/lib/client/hooks';
import { cn } from '@/lib/utils';

// Dynamic import Leaflet agar tidak error di server-side rendering
const PetaLeaflet = dynamic(() => import('@/components/PetaLeaflet'), {
  ssr: false,
  loading: () => (
    <div className="w-full h-[520px] bg-[#1d1b38] rounded-2xl flex flex-col items-center justify-center text-white/60">
      <MapPin className="w-10 h-10 animate-bounce text-crimson mb-2" />
      <p className="text-sm font-semibold">Memuat peta geospasial Surakarta...</p>
    </div>
  ),
});

export default function PetaPage() {
  const { data: laporanList, loading, error } = useAsync(getLaporanPublik, []);
  const [selectedKecamatan, setSelectedKecamatan] = useState<string>('semua');
  const [selectedStatus, setSelectedStatus] = useState<string>('semua');
  const [selectedTicket, setSelectedTicket] = useState<Laporan | null>(null);
  const laporan = laporanList || [];
  const totalTitik = laporan.length;
  const jumlahTanpaKecamatan = laporan.filter((item) => !item.kecamatan).length;
  const jumlahDiproses = laporan.filter((item) => item.status === 'sedang_ditangani').length;
  const jumlahStatus = (status: string) => laporan.filter((item) => item.status === status).length;
  const jumlahWilayah = (wilayah: string) =>
    laporan.filter((item) => item.kecamatan?.toLowerCase() === wilayah.toLowerCase()).length;
  const laporanDiproses = laporan.filter((item) => item.status === 'sedang_ditangani').slice(0, 4);
  const daftarWilayah = ['Banjarsari', 'Jebres', 'Laweyan', 'Pasar Kliwon', 'Serengan'].map((nama, index) => {
    const jumlah = jumlahWilayah(nama);
    return {
      nama,
      jumlah,
      baru: laporan.filter(
        (item) => item.status === 'masuk' && item.kecamatan?.toLowerCase() === nama.toLowerCase()
      ).length,
      persentase: totalTitik ? Math.round((jumlah / totalTitik) * 100) : 0,
      warna: ['bg-crimson', 'bg-navy', 'bg-slate', 'bg-peri', 'bg-emerald-600'][index],
    };
  });

  useEffect(() => {
    if (laporanList && laporanList.length > 0 && !selectedTicket) {
      setSelectedTicket(laporanList[0]);
    }
  }, [laporanList, selectedTicket]);

  return (
    <main className="mx-auto max-w-7xl px-4 py-6 sm:px-8 space-y-6">
      {error && (
        <div role="alert" className="rounded-2xl border border-rose-300 bg-rose-50 p-4 text-sm font-semibold text-crimson">
          Data peta gagal dimuat: {error.message}
        </div>
      )}
      {!loading && jumlahTanpaKecamatan > 0 && (
        <div role="status" className="rounded-2xl border border-amber-300 bg-amber-50 p-4 text-sm font-semibold text-amber-950">
          {jumlahTanpaKecamatan} laporan belum memiliki kecamatan. Lokasinya tetap terlihat pada filter “Belum dipetakan”; batas wilayah Supabase perlu dilengkapi agar laporan dapat dikelompokkan per kecamatan.
        </div>
      )}
      {/* ── 1. Page Hero ── */}
      <Reveal>
        <header className="bg-hero relative overflow-hidden rounded-3xl p-6 sm:p-8 shadow-[0_8px_24px_rgba(40,38,75,.14)] flex flex-col lg:flex-row lg:items-center lg:justify-between gap-6">
          <div className="max-w-2xl relative z-10">
            <h1 className="text-3xl font-extrabold tracking-tight text-navy sm:text-4xl leading-tight">
              Peta Lapor & Pantau Petugas Lapangan
            </h1>
            <p className="mt-2.5 text-sm sm:text-base text-navy/80 leading-relaxed font-medium">
              Pantau sebaran laporan yang tercatat di lima kecamatan Surakarta.
            </p>
          </div>

          <div className="flex flex-wrap items-center gap-3 relative z-10">
            <div className="bg-navy/90 text-white px-4 py-3 rounded-2xl flex items-center gap-3 shadow-md border border-white/10">
              <Layers className="w-5 h-5 text-peri" />
              <div>
                <p className="text-[10px] text-white/60 font-semibold tracking-wide uppercase">Total Titik Aduan</p>
                <p className="text-base font-extrabold">{loading ? '…' : `${totalTitik} Titik`}</p>
              </div>
            </div>

            <div className="bg-navy/90 text-white px-4 py-3 rounded-2xl flex items-center gap-3 shadow-md border border-white/10">
              <Layers className="w-5 h-5 text-emerald-400" />
              <div>
                <p className="text-[10px] text-white/60 font-semibold tracking-wide uppercase">Sedang Ditangani</p>
                <p className="text-base font-extrabold">{loading ? '…' : `${jumlahDiproses} Laporan`}</p>
              </div>
            </div>
          </div>
        </header>
      </Reveal>

      {/* ── 2. Filter Bar Horizontal ── */}
      <Reveal delay={80}>
        <div className="bg-panel p-3.5 sm:p-4 rounded-2xl shadow-sm flex flex-col md:flex-row md:items-center justify-between gap-4">
          {/* Kecamatan Pills */}
          <div className="flex items-center gap-1.5 overflow-x-auto pb-1 md:pb-0 scrollbar-none">
            <span className="text-[11px] font-extrabold uppercase text-navy/70 mr-1 shrink-0">Kecamatan:</span>
            {[
              { id: 'semua', label: `Semua (${loading ? '…' : totalTitik})` },
              ...['Banjarsari', 'Jebres', 'Laweyan', 'Pasar Kliwon', 'Serengan'].map((nama) => ({
                id: nama.toLowerCase(),
                label: `${nama} (${loading ? '…' : jumlahWilayah(nama)})`,
              })),
              ...(jumlahTanpaKecamatan > 0
                ? [{
                    id: 'tanpa-kecamatan',
                    label: `Belum dipetakan (${loading ? '…' : jumlahTanpaKecamatan})`,
                  }]
                : []),
            ].map((k) => (
              <button
                key={k.id}
                type="button"
                onClick={() => setSelectedKecamatan(k.id)}
                className={cn(
                  'px-3 py-1.5 rounded-xl text-xs font-bold transition-all shrink-0',
                  selectedKecamatan === k.id
                    ? 'bg-navy text-white shadow-sm'
                    : 'bg-white/80 text-navy hover:bg-white'
                )}
              >
                {k.label}
              </button>
            ))}
          </div>

          {/* Status Pills */}
          <div className="flex items-center gap-1.5 overflow-x-auto pb-1 md:pb-0 scrollbar-none">
            {[
              { id: 'semua', label: 'Semua Status' },
              { id: 'masuk', label: `Baru (${loading ? '…' : jumlahStatus('masuk')})` },
              { id: 'sedang_ditangani', label: `Diproses (${loading ? '…' : jumlahStatus('sedang_ditangani')})` },
              { id: 'selesai', label: `Selesai (${loading ? '…' : jumlahStatus('selesai')})` },
            ].map((s) => (
              <button
                key={s.id}
                type="button"
                onClick={() => setSelectedStatus(s.id)}
                className={cn(
                  'px-3 py-1.5 rounded-xl text-xs font-bold transition-all shrink-0',
                  selectedStatus === s.id
                    ? 'bg-crimson text-white shadow-sm'
                    : 'bg-white/80 text-navy hover:bg-white'
                )}
              >
                {s.label}
              </button>
            ))}
          </div>
        </div>
      </Reveal>

      {/* ── 3. Konten Utama: Peta Radar & Panel Dispatch ── */}
      <div className="grid grid-cols-1 lg:grid-cols-12 gap-6">
        {/* Kolom Kiri: Peta Geospasial Interaktif (lg:col-span-8) */}
        <Reveal delay={120} className="lg:col-span-8">
          <div className="bg-panel p-4 sm:p-5 rounded-3xl text-navy shadow-[0_8px_24px_rgba(40,38,75,.14)] border border-navy/10 space-y-4">
            <div className="flex items-center justify-between flex-wrap gap-2">
              <div className="flex items-center gap-2">
                <h2 className="text-lg font-bold text-navy tracking-wide">Peta Vektor Radar Surakarta</h2>
                <span className="text-[10px] font-extrabold uppercase bg-card text-navy/80 px-2 py-0.5 rounded-md">
                  Skala Kecamatan
                </span>
              </div>
              <div className="flex items-center gap-1.5 text-xs">
                <span className="inline-flex items-center gap-1 px-2.5 py-1 rounded-lg bg-emerald-500/20 text-emerald-800 font-semibold text-[11px] border border-emerald-500/30">
                  <span className="w-1.5 h-1.5 rounded-full bg-emerald-600 animate-ping" />
                  Peta Laporan
                </span>
              </div>
            </div>

            {/* Komponen Peta Leaflet */}
            <PetaLeaflet
              laporan={laporanList || []}
              selectedId={selectedTicket?.id}
              onSelect={(lap) => setSelectedTicket(lap)}
              kecamatanFilter={selectedKecamatan}
              statusFilter={selectedStatus}
            />

            {/* Legenda Titik Peta */}
            <div className="pt-2 flex flex-wrap items-center justify-between gap-3 text-xs border-t border-navy/10 text-navy/80">
              <div className="flex flex-wrap items-center gap-4">
                <span className="flex items-center gap-1.5">
                  <span className="w-3 h-3 rounded-full" style={{ backgroundColor: '#A40033' }} />
                  <span>Perlu Respon</span>
                </span>
                <span className="flex items-center gap-1.5">
                  <span className="w-3 h-3 rounded-full" style={{ backgroundColor: '#EA580C' }} />
                  <span>Diproses Tim</span>
                </span>
                <span className="flex items-center gap-1.5">
                  <span className="w-3 h-3 rounded-full" style={{ backgroundColor: '#047857' }} />
                  <span>Selesai Tuntas</span>
                </span>
                <span className="flex items-center gap-1.5">
                  <span className="w-3 h-3 rounded-full" style={{ backgroundColor: '#D97706' }} />
                  <span>Aduan Baru</span>
                </span>
              </div>
              <span className="text-[11px] text-navy/60">54 Kelurahan Terhubung</span>
            </div>

            {/* Kartu Detail Titik Terpilih */}
            {selectedTicket && (
              <div className="bg-card rounded-2xl p-4 border border-navy/10 flex flex-col sm:flex-row sm:items-center justify-between gap-4 animate-in fade-in">
                <div className="flex items-start gap-3">
                  <div className="p-2.5 rounded-xl bg-crimson text-white shrink-0 mt-0.5">
                    <MapPin className="w-5 h-5" />
                  </div>
                  <div>
                    <div className="flex items-center gap-2">
                      <span className="text-xs font-mono font-bold bg-navy text-white px-2 py-0.5 rounded">
                        #{selectedTicket.kode_lacak}
                      </span>
                      <span className="text-xs font-semibold text-navy/80">
                        {selectedTicket.kelurahan}, {selectedTicket.kecamatan}
                      </span>
                    </div>
                    <h3 className="text-sm font-bold text-navy mt-1 leading-snug line-clamp-1">
                      {selectedTicket.judul}
                    </h3>
                  </div>
                </div>

                <div className="flex items-center gap-2 shrink-0">
                  <Link
                    href={`/riwayat?kode=${selectedTicket.kode_lacak}`}
                    className="px-4 py-2 bg-crimson hover:bg-[#8a002b] text-white text-xs font-bold rounded-xl transition-colors shadow"
                  >
                    Detail Tiket
                  </Link>
                </div>
              </div>
            )}
          </div>
        </Reveal>

        {/* Kolom Kanan: Laporan yang sedang ditangani */}
        <Reveal delay={160} className="lg:col-span-4 space-y-4">
          <div className="bg-panel p-5 rounded-3xl shadow-[0_8px_24px_rgba(40,38,75,.14)] space-y-4">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <Layers className="w-5 h-5 text-navy" />
                <h2 className="text-base font-bold text-navy">Laporan Sedang Ditangani</h2>
              </div>
              <span className="text-[11px] font-bold text-navy/70">
                {jumlahDiproses} laporan
              </span>
            </div>

            {laporanDiproses.map((item) => (
              <div key={item.id} className="bg-card p-4 rounded-2xl border border-navy/10 space-y-2">
                <h3 className="text-xs font-extrabold text-navy">{item.judul}</h3>
                <p className="text-[11px] text-navy/70">
                  {item.kategori} · {item.kelurahan || item.kecamatan || 'Surakarta'}
                </p>
                <Link
                  href={`/riwayat?kode=${item.kode_lacak}`}
                  className="inline-flex items-center gap-1 text-xs font-bold text-crimson"
                >
                  Lihat laporan <ArrowUpRight className="h-3.5 w-3.5" />
                </Link>
              </div>
            ))}
            {laporanDiproses.length === 0 && (
              <p className="rounded-2xl bg-card p-4 text-sm text-navy/70">
                Belum ada laporan berstatus sedang ditangani.
              </p>
            )}

            <Link
              href="/papan-tanggap"
              className="w-full py-2.5 bg-slate-card text-white text-xs font-bold rounded-xl flex items-center justify-center gap-2 hover:opacity-95 transition-all text-center"
            >
              Buka Papan Tanggap
            </Link>
          </div>
        </Reveal>
      </div>

      {/* ── 4. Beban Aduan Per Wilayah Kecamatan ── */}
      <Reveal delay={200}>
        <div className="bg-panel p-6 rounded-3xl shadow-[0_8px_24px_rgba(40,38,75,.14)] space-y-4">
          <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2">
            <div>
              <h2 className="text-lg font-extrabold text-navy">Beban Aduan Per Wilayah Kecamatan</h2>
              <p className="text-xs text-navy/70 mt-0.5">
                Sebaran berdasarkan laporan yang saat ini tercatat.
              </p>
            </div>
            <span className="text-[11px] font-semibold text-navy/60 bg-white/80 px-3 py-1 rounded-full shrink-0 border border-navy/10">
              {loading ? 'Memuat…' : `${totalTitik} laporan`}
            </span>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-4 pt-2">
            {daftarWilayah.map((k, index) => (
              <div key={k.nama} className="bg-card p-4 rounded-2xl border border-navy/10 space-y-2">
                <div className="flex items-center justify-between">
                  <span className="text-xs font-extrabold text-navy">{index + 1}. {k.nama}</span>
                  <span className="text-xs font-bold text-crimson">{k.persentase}%</span>
                </div>
                <p className="text-2xl font-extrabold text-navy">{k.jumlah} <span className="text-xs font-semibold text-navy/60">Laporan</span></p>
                <div className="w-full bg-navy/10 h-2 rounded-full overflow-hidden">
                  <div className={cn('h-full rounded-full', k.warna)} style={{ width: `${k.persentase}%` }} />
                </div>
                <p className="text-[11px] font-medium text-navy/70 pt-1 border-t border-navy/5">
                  {k.baru} laporan baru di wilayah ini
                </p>
              </div>
            ))}
          </div>
        </div>
      </Reveal>
    </main>
  );
}
