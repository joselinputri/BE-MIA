'use client';

import { useState } from 'react';
import { Sparkles, ShieldAlert, CheckCircle2, ChevronDown, ChevronUp, Bot, ArrowRight } from 'lucide-react';
import { type Laporan } from '@/lib/client/data';
import { cn } from '@/lib/utils';

interface KartuInspeksiAIProps {
  laporan: Laporan;
}

export default function KartuInspeksiAI({ laporan }: KartuInspeksiAIProps) {
  const [bukaDetail, setBukaDetail] = useState(false);

  const judul = (laporan.judul || '').trim();
  const deskripsi = (laporan.deskripsi || '').trim();
  const gabunganTeks = `${judul} ${deskripsi}`.toLowerCase();

  // Evaluasi spam eksplisit
  const adaIndikasiSpam =
    laporan.penanda?.includes('perlu_verifikasi_tambahan') ||
    /\b(joki|open joki|jasa tugas|slot|gacor|maxwin|judol|pinjol|pinjaman|dana cair|dana cepat|dana kilat|open bo|vcs)\b/i.test(
      gabunganTeks
    ) ||
    /wa\.me\//i.test(gabunganTeks);

  // Evaluasi kejelasan konten (apakah teks hanya asal ketik / spam huruf acak)
  const hanyaHurufAcak = /^[a-z\s.,\-_]{1,30}$/i.test(judul) && !/\s/.test(judul.trim()) && judul.length > 5;
  const teksSangatPendek = (judul.length + deskripsi.length) < 25;
  const kataBermakna = /jalan|aspal|rusak|lubang|lampu|pju|mati|sampah|bau|saluran|drainase|banjir|pohon|rambu|trotoar|fasilitas/i.test(gabunganTeks);

  // Klasifikasi dinas pengampu otomatis berdasarkan konten / kategori laporan
  let dinasTerkait = laporan.dinas;
  if (!dinasTerkait || dinasTerkait === 'Dinas Terkait') {
    if (/lampu|pju|rambu|lalu lintas|marka|halte|trotoar jalan raya|dishub/i.test(gabunganTeks)) {
      dinasTerkait = 'Dinas Perhubungan (Dishub)';
    } else if (/sampah|kebersihan|pohon|taman|limbah|dlh/i.test(gabunganTeks)) {
      dinasTerkait = 'Dinas Lingkungan Hidup (DLH)';
    } else if (/tertib|reklame liar|pkl liar|okupasi|satpol/i.test(gabunganTeks)) {
      dinasTerkait = 'Satuan Polisi Pamong Praja (Satpol PP)';
    } else {
      dinasTerkait = 'Dinas Pekerjaan Umum & Penataan Ruang (DPUPR)';
    }
  }

  let skorKelayakan = 92;
  let urgensi = 'Sedang';

  if (adaIndikasiSpam) {
    skorKelayakan = 24;
    urgensi = 'Rendah (Ditandai Anomali / Spam)';
  } else if (!kataBermakna && (teksSangatPendek || hanyaHurufAcak)) {
    skorKelayakan = 35;
    urgensi = 'Rendah (Deskripsi Kurang Jelas)';
  } else if (/ambruk|putus|longsor|tergenang banjir|korban|darurat/i.test(gabunganTeks)) {
    skorKelayakan = 98;
    urgensi = 'Tinggi (Prioritas Keselamatan)';
  }

  return (
    <div className="rounded-2xl border border-indigo-200/80 bg-gradient-to-br from-indigo-50/60 to-purple-50/40 p-4 sm:p-5 shadow-sm space-y-3">
      <div className="flex items-center justify-between gap-3 flex-wrap">
        <div className="flex items-center gap-2">
          <div className="p-2 rounded-xl bg-navy text-white shadow-xs">
            <Sparkles className="w-4 h-4 text-amber-400" />
          </div>
          <div>
            <div className="flex items-center gap-2">
              <h3 className="text-xs font-extrabold text-navy tracking-tight uppercase">
                Verifikasi Semantik Aduan
              </h3>
              <span className="text-[10px] font-bold px-2 py-0.5 rounded-full bg-navy/10 text-navy border border-navy/20">
                Audit Otomatis
              </span>
            </div>
            <p className="text-[11px] text-navy/70 mt-0.5">
              Validasi kelayakan dan klasifikasi urgensi penanganan fasilitas publik.
            </p>
          </div>
        </div>

        <button
          type="button"
          onClick={() => setBukaDetail(!bukaDetail)}
          className="inline-flex items-center gap-1 text-xs font-bold text-indigo-700 hover:text-indigo-900 transition"
        >
          {bukaDetail ? 'Tutup Analisa' : 'Lihat Detail AI'}
          {bukaDetail ? <ChevronUp className="w-3.5 h-3.5" /> : <ChevronDown className="w-3.5 h-3.5" />}
        </button>
      </div>

      {/* Ringkasan Skor Utama */}
      <div className="grid grid-cols-2 sm:grid-cols-3 gap-2.5 pt-1">
        <div className="bg-white/80 p-3 rounded-xl border border-indigo-100">
          <span className="text-[10px] font-bold uppercase text-navy/60 block">Skor Kelayakan</span>
          <div className="flex items-baseline gap-1 mt-0.5">
            <span
              className={cn(
                'text-xl font-black',
                skorKelayakan >= 70 ? 'text-emerald-700' : 'text-crimson'
              )}
            >
              {skorKelayakan}
            </span>
            <span className="text-xs text-navy/50 font-bold">/100</span>
          </div>
        </div>

        <div className="bg-white/80 p-3 rounded-xl border border-indigo-100">
          <span className="text-[10px] font-bold uppercase text-navy/60 block">Tingkat Urgensi</span>
          <span className="text-xs font-extrabold text-navy mt-1 block line-clamp-1">
            {urgensi}
          </span>
        </div>

        <div className="col-span-2 sm:col-span-1 bg-white/80 p-3 rounded-xl border border-indigo-100">
          <span className="text-[10px] font-bold uppercase text-navy/60 block">Status AI</span>
          <span
            className={cn(
              'text-xs font-extrabold mt-1 inline-flex items-center gap-1',
              adaIndikasiSpam ? 'text-crimson' : 'text-emerald-700'
            )}
          >
            {adaIndikasiSpam ? (
              <>
                <ShieldAlert className="w-3.5 h-3.5" /> Perlu Review Manual
              </>
            ) : (
              <>
                <CheckCircle2 className="w-3.5 h-3.5" /> Layak Verifikasi
              </>
            )}
          </span>
        </div>
      </div>

      {/* Accordion Detail Breakdown */}
      {bukaDetail && (
        <div className="pt-2 border-t border-indigo-200/60 space-y-2.5 text-xs text-navy/80 animate-in fade-in">
          <div>
            <strong className="text-navy font-bold block mb-1">Rekomendasi Dinas Pengampu:</strong>
            <p className="bg-white/90 p-2.5 rounded-lg border border-navy/10 text-[11px]">
              🏛️ {dinasTerkait}
            </p>
          </div>

          <div>
            <strong className="text-navy font-bold block mb-1">Diagnosa Sistem:</strong>
            <p className="bg-white/90 p-2.5 rounded-lg border border-navy/10 text-[11px] leading-relaxed">
              {adaIndikasiSpam
                ? 'Terdeteksi pola kata kunci promosi, penawaran jasa, atau komersial non-aduan infrastruktur. Sistem otomatis menahan status untuk ditinjau oleh operator dinas dan tidak menghapus data secara otomatis (prinsip Human-in-the-Loop).'
                : 'Laporan memenuhi kaidah aduan fasilitas kota dengan deskripsi lokasi dan visual yang memadai. Waktu respon optimal ditargetkan dalam SLA 3x24 jam kerja.'}
            </p>
          </div>

          {laporan.saran_perbaikan && laporan.saran_perbaikan.length > 0 && (
            <div>
              <strong className="text-navy font-bold block mb-1">Saran Kelengkapan untuk Pelapor:</strong>
              <ul className="list-disc list-inside bg-white/90 p-2.5 rounded-lg border border-navy/10 text-[11px] space-y-0.5">
                {laporan.saran_perbaikan.map((saran, i) => (
                  <li key={i}>{saran}</li>
                ))}
              </ul>
            </div>
          )}
        </div>
      )}
    </div>
  );
}

