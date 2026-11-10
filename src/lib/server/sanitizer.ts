/**
 * src/lib/server/sanitizer.ts
 * Lapisan Validasi Konten Hybrid (Rule-Based + AI Generatif Fallback)
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 * 
 * Prinsip:
 * 1. Hanya memberi penanda 'perlu_verifikasi_tambahan' dan saran perbaikan.
 * 2. TIDAK PERNAH menghapus atau menolak laporan secara otomatis (wewenang di Petugas).
 * 3. Layer 1: Deterministic Rule-Based (0ms, 0 cost, bebas ReDoS).
 * 4. Layer 2: Optional Generative AI (Google Gemini 1.5 Flash via REST API) jika GEMINI_API_KEY disetel.
 * 5. Graceful degradation: jika AI timeout atau tanpa API key, sistem tetap berjalan normal 100%.
 */

export type PenandaLaporan = 'perlu_verifikasi_tambahan';

// Daftar kata kunci terlarang (spam, promosi komersial, judi, pinjol)
const KATA_KUNCI_SPAM: string[] = [
  'slot',
  'gacor',
  'judi',
  'togel',
  'casino',
  'poker',
  'pinjol',
  'dana cair',
  'tanpa jaminan',
  'bunga rendah',
  'promo diskon',
  'wa.me/',
  'bit.ly/',
  't.me/',
];

export interface HasilValidasiKonten {
  perluVerifikasiTambahan: boolean;
  penanda: PenandaLaporan[];
  alasanPenanda?: string;
  saranPerbaikan: string[];
  skorValiditas?: number; // 0 - 100
  urgensi?: 'rendah' | 'sedang' | 'tinggi';
  aiDigunakan?: boolean;
}

/**
 * Validasi Konten Sinkron (Rule-Based Murni)
 * Digunakan untuk pemrosesan instan, unit test, dan baseline security.
 */
export function periksaKontenLaporan(
  judul: string,
  deskripsi: string
): HasilValidasiKonten {
  const gabunganTeks = `${judul} ${deskripsi}`.toLowerCase();
  const penanda: PenandaLaporan[] = [];
  const saranPerbaikan: string[] = [];
  let perluVerifikasiTambahan = false;
  let alasanPenanda: string | undefined;

  // 1. Cek kata kunci spam / judi / pinjol
  for (const keyword of KATA_KUNCI_SPAM) {
    if (gabunganTeks.includes(keyword)) {
      perluVerifikasiTambahan = true;
      penanda.push('perlu_verifikasi_tambahan');
      alasanPenanda = `Terdeteksi indikasi kata kunci komersial/spam: "${keyword}"`;
      break;
    }
  }

  // 2. Evaluasi kelengkapan teks untuk saran perbaikan kepada pelapor
  if (deskripsi.trim().length < 50) {
    saranPerbaikan.push('Deskripsi cukup singkat. Anda dapat menambahkan patokan bangunan terdekat atau kronologi kejadian agar memudahkan petugas.');
  }

  // Cek apakah ada penyebutan petunjuk arah atau patokan
  const adaPetunjuk = ['depan', 'sebelah', 'dekat', 'gang', 'rt', 'rw', 'samping', 'seberang', 'jalan', 'jl'].some((w) =>
    gabunganTeks.includes(w)
  );
  if (!adaPetunjuk) {
    saranPerbaikan.push('Disarankan menambahkan patokan lokasi (mis. "depan toko X" atau "sebelah gapura RT 02") agar petugas cepat menemukan titik kerusakan.');
  }

  return {
    perluVerifikasiTambahan,
    penanda,
    alasanPenanda,
    saranPerbaikan,
    skorValiditas: perluVerifikasiTambahan ? 20 : 85,
    urgensi: 'sedang',
    aiDigunakan: false,
  };
}

/**
 * Validasi Konten Asinkron Hybrid (Rule-Based + Google Gemini AI)
 * Jika GEMINI_API_KEY tersedia di .env.local, memanggil Gemini 1.5 Flash untuk analisis cerdas.
 * Jika tidak ada API key atau error jaringan, otomatis fallback ke Rule-Based tanpa error.
 */
export async function evaluasiLaporanCerdas(
  judul: string,
  deskripsi: string,
  kategoriNama: string = 'Infrastruktur'
): Promise<HasilValidasiKonten> {
  // Jalankan rule-based terlebih dahulu
  const hasilDasar = periksaKontenLaporan(judul, deskripsi);

  // Jika sudah terbukti spam judi/pinjol secara rule-based, tidak perlu buang kuota LLM
  if (hasilDasar.perluVerifikasiTambahan) {
    return hasilDasar;
  }

  const apiKey = process.env.GEMINI_API_KEY;
  if (!apiKey) {
    // Mode offline / default tanpa API Key
    return hasilDasar;
  }

  try {
    const controller = new AbortController();
    const timeoutId = setTimeout(() => controller.abort(), 2500); // Batas 2.5 detik agar respon tetap cepat

    const promptText = `Anda adalah asisten AI resmi verifikasi kelayakan laporan aduan warga Kota Surakarta (Platform RAMPUNG).
Tugas Anda:
1. Evaluasi apakah laporan ini nyata, wajar, dan bukan hoax/lelucon/prank/ujaran kebencian.
2. Tentukan tingkat urgensi (rendah/sedang/tinggi).
3. Berikan skor kelayakan (0 sampai 100).
4. Berikan saran singkat dan ramah jika pelapor perlu melengkapi detail lokasi/kondisi.
5. Jika ada indikasi anomali/palsu, beri tahu alasannya.

Data Laporan:
- Kategori: ${kategoriNama}
- Judul: ${judul}
- Deskripsi: ${deskripsi}

Format respons WAJIB berupa JSON murni tanpa markdown/backticks:
{
  "layak": true,
  "indikasi_anomali": false,
  "skor_validitas": 88,
  "urgensi": "sedang",
  "alasan_anomali": "",
  "saran_pelapor": "Saran singkat..."
}`;

    const res = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=${apiKey}`,
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          contents: [{ parts: [{ text: promptText }] }],
          generationConfig: {
            temperature: 0.2,
            maxOutputTokens: 256,
            responseMimeType: 'application/json',
          },
        }),
        signal: controller.signal,
      }
    );

    clearTimeout(timeoutId);

    if (!res.ok) {
      return hasilDasar;
    }

    const aiRes = await res.json();
    const rawContent = aiRes.candidates?.[0]?.content?.parts?.[0]?.text;
    if (!rawContent) return hasilDasar;

    const parsed = JSON.parse(rawContent.trim());

    const penanda: PenandaLaporan[] = [];
    let perluVerifikasiTambahan = false;
    let alasanPenanda = hasilDasar.alasanPenanda;

    if (parsed.indikasi_anomali || (parsed.skor_validitas !== undefined && parsed.skor_validitas < 50)) {
      perluVerifikasiTambahan = true;
      penanda.push('perlu_verifikasi_tambahan');
      alasanPenanda = `Analisis AI: ${parsed.alasan_anomali || 'Laporan terindikasi memerlukan peninjauan langsung'}`;
    }

    const saran: string[] = [...hasilDasar.saranPerbaikan];
    if (parsed.saran_pelapor && typeof parsed.saran_pelapor === 'string' && parsed.saran_pelapor.length > 5) {
      saran.unshift(`[Saran AI] ${parsed.saran_pelapor}`);
    }

    return {
      perluVerifikasiTambahan,
      penanda,
      alasanPenanda,
      saranPerbaikan: saran,
      skorValiditas: parsed.skor_validitas ?? hasilDasar.skorValiditas,
      urgensi: parsed.urgensi || hasilDasar.urgensi,
      aiDigunakan: true,
    };
  } catch (err) {
    // Fallback otomatis jika timeout / koneksi bermasalah
    return hasilDasar;
  }
}
