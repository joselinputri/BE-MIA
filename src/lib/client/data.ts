/**
 * Lapisan data FE RAMPUNG.
 * Terkoneksi ke endpoint API Backend (/api/laporan, /api/dashboard, dll)
 * dan mendukung sinkronisasi laporan yang baru ditambahkan pengguna.
 */
import dashboardMock from '../../../mocks/dashboard.json';
import laporanMock from '../../../mocks/laporan-publik.json';
import { fetchAuthed } from './supabase';

export const USE_MOCK =
  process.env.NEXT_PUBLIC_USE_MOCK === 'true' ||
  !process.env.NEXT_PUBLIC_SUPABASE_URL ||
  !process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ||
  process.env.NEXT_PUBLIC_SUPABASE_URL.includes('your-project') ||
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY.includes('your-anon-key');

/* ── Tipe Data ── */

export interface LinimasaItem {
  tahap?: number;
  status_ke: string;
  judul_tahap?: string;
  catatan: string;
  created_at: string;
}

export interface CatatanTeknis {
  regu_pelaksana?: string;
  mandor?: string;
  surat_tugas?: string;
  spesifikasi_material?: string;
  kondisi_cuaca?: string;
  waktu_respon_awal?: string;
  biaya_logistik?: string;
  sumber_dana?: string;
  indeks_kepuasan_wilayah?: number;
}

export interface Laporan {
  id: string;
  kode_lacak: string;
  judul: string;
  deskripsi: string;
  kategori: string;
  kategori_slug: string;
  kelurahan: string | null;
  kecamatan: string | null;
  latitude: number;
  longitude: number;
  status: string;
  penanda?: string[];
  saran_perbaikan?: string[];
  foto_sebelum_paths: string[];
  foto_sesudah_paths: string[];
  is_anonim?: boolean;
  is_demo?: boolean;
  provenance?: string;
  dinas?: string;
  dinas_singkatan?: string;
  jumlah_dukungan?: number;
  konfirmasi_jawaban?: string | null;
  catatan_teknis?: CatatanTeknis;
  linimasa?: LinimasaItem[];
  created_at: string;
  updated_at?: string;
}

export interface Dinas { singkatan: string; nama: string; rata_hari: number; persen_tuntas: number }
export interface Ringkasan {
  laporan_bulan_ini: number; laporan_selesai: number; persentase_selesai: number;
  sedang_dikerjakan: number; rata_rata_harian: number; kinerja_dinas: Dinas[];
}
export interface Tren { bulan: string; jumlah_masuk: number; jumlah_selesai: number }
export interface Konfirmasi {
  total_selesai: number; total_dikonfirmasi: number;
  persen_puas: number; persen_biasa: number; persen_kurang_puas: number;
  persen_dibuka_ulang: number; total_dibuka_ulang: number;
}
export interface Dashboard {
  ringkasan: Ringkasan; tren: Tren[]; konfirmasi: Konfirmasi; dariMock: boolean; error?: string;
}

/* ── Helper Penyimpanan Lokal ── */
const STORAGE_KEY = 'rampung_laporan_user';

export function dapatkanLaporanLokal(): Laporan[] {
  if (typeof window === 'undefined') return [];
  try {
    const raw = localStorage.getItem(STORAGE_KEY);
    return raw ? JSON.parse(raw) : [];
  } catch {
    return [];
  }
}

export function simpanLaporanLokal(laporanBaru: Laporan): boolean {
  if (typeof window === 'undefined') return false;
  try {
    const exist = dapatkanLaporanLokal();
    const updated = [laporanBaru, ...exist];
    localStorage.setItem(STORAGE_KEY, JSON.stringify(updated));
    return true;
  } catch {
    return false;
  }
}

const mockLaporanAwal = laporanMock as unknown as Laporan[];

/* ── API Dashboard ── */

export async function getDashboard(): Promise<Dashboard> {
  if (USE_MOCK) {
    return {
      ringkasan: dashboardMock.ringkasan as Ringkasan,
      tren: dashboardMock.tren as Tren[],
      konfirmasi: dashboardMock.konfirmasi as Konfirmasi,
      dariMock: true,
    };
  }

  try {
    const responses = await Promise.all([
      fetchAuthed('/api/dashboard/ringkasan'),
      fetchAuthed('/api/dashboard/tren'),
      fetchAuthed('/api/dashboard/konfirmasi'),
    ]);
    const payloads = await Promise.all(responses.map((response) => response.json()));
    const failed = responses.findIndex((response) => !response.ok);

    if (failed >= 0) {
      throw new Error(payloads[failed]?.error?.pesan || 'Data dashboard belum dapat dimuat.');
    }

    return {
      ringkasan: payloads[0].data as Ringkasan,
      tren: payloads[1].data as Tren[],
      konfirmasi: payloads[2].data as Konfirmasi,
      dariMock: false,
    };
  } catch (error) {
    return {
      ringkasan: {
        laporan_bulan_ini: 0,
        laporan_selesai: 0,
        persentase_selesai: 0,
        sedang_dikerjakan: 0,
        rata_rata_harian: 0,
        kinerja_dinas: [],
      },
      tren: [],
      konfirmasi: {
        total_selesai: 0,
        total_dikonfirmasi: 0,
        persen_puas: 0,
        persen_biasa: 0,
        persen_kurang_puas: 0,
        persen_dibuka_ulang: 0,
        total_dibuka_ulang: 0,
      },
      dariMock: false,
      error: error instanceof Error ? error.message : 'Data dashboard belum dapat dimuat.',
    };
  }
}

/* ── API Laporan Publik ── */

export async function getLaporanPublik(): Promise<Laporan[]> {
  if (USE_MOCK) {
    const mergedMap = new Map<string, Laporan>();
    dapatkanLaporanLokal().forEach((lap) => mergedMap.set(lap.kode_lacak, lap));
    mockLaporanAwal.forEach((lap) => {
      if (!mergedMap.has(lap.kode_lacak)) mergedMap.set(lap.kode_lacak, lap);
    });
    return Array.from(mergedMap.values());
  }

  const res = await fetchAuthed('/api/laporan/publik');
  const json = await res.json();
  if (!res.ok || !Array.isArray(json.data)) {
    throw new Error(json.error?.pesan || 'Daftar laporan publik gagal dimuat.');
  }
  return json.data;
}

export function bersihkanKode(kode: string) {
  return kode.trim().replace(/^#/, '').toUpperCase();
}

/* ── API Lacak Tiket ── */

export async function lacak(kode: string): Promise<Laporan | null> {
  const k = bersihkanKode(kode);

  if (USE_MOCK) {
    const foundUser = dapatkanLaporanLokal().find(
      (laporan) => laporan.kode_lacak.toUpperCase() === k || laporan.id === k
    );
    return (
      foundUser ||
      mockLaporanAwal.find((laporan) => laporan.kode_lacak.toUpperCase() === k || laporan.id === k) ||
      null
    );
  }

  try {
    const res = await fetchAuthed(`/api/laporan/lacak/${encodeURIComponent(k)}`);
    if (!res.ok) return null;
    const json = await res.json();
    if (!json.data?.laporan) return null;
    return {
      ...json.data.laporan,
      linimasa: json.data.linimasa || json.data.laporan.linimasa,
      catatan_teknis: json.data.catatan_teknis || json.data.laporan.catatan_teknis,
    };
  } catch {
    return null;
  }
}

function jarakMeter(a: [number, number], b: [number, number]) {
  const R = 6371000;
  const rad = (x: number) => (x * Math.PI) / 180;
  const dLat = rad(b[0] - a[0]);
  const dLon = rad(b[1] - a[1]);
  const h = Math.sin(dLat / 2) ** 2 + Math.cos(rad(a[0])) * Math.cos(rad(b[0])) * Math.sin(dLon / 2) ** 2;
  return 2 * R * Math.asin(Math.sqrt(h));
}

export async function cariSerupa(slug: string, lat: number, lon: number, radius = 500): Promise<(Laporan & { jarak: number })[]> {
  const all = await getLaporanPublik();
  return all
    .filter((l) => l.kategori_slug === slug || slug === '*')
    .map((l) => ({ ...l, jarak: jarakMeter([lat, lon], [l.latitude, l.longitude]) }))
    .filter((l) => l.jarak <= radius)
    .sort((a, b) => a.jarak - b.jarak);
}

/* ── API Buat Laporan Baru ── */

export interface BuatLaporanPayload {
  judul: string;
  deskripsi: string;
  kategori_id?: string;
  kategori_slug: string;
  latitude: number;
  longitude: number;
  kelurahan?: string;
  kecamatan?: string;
  foto_url?: string;
  is_anonim: boolean;
  email_pelapor?: string;
  telepon_pelapor?: string;
}

const KATEGORI_NAMA_MAP: Record<string, { nama: string; dinas: string; singkatan: string }> = {
  'penambalan-aspal': { nama: 'Penambalan Aspal', dinas: 'Dinas Pekerjaan Umum & Penataan Ruang', singkatan: 'DPUPR' },
  'lampu-pju': { nama: 'Lampu PJU', dinas: 'Dinas Perhubungan', singkatan: 'Dishub' },
  'drainase': { nama: 'Drainase & Saluran Air', dinas: 'Dinas Pekerjaan Umum & Penataan Ruang', singkatan: 'DPUPR' },
  'sampah-lingkungan': { nama: 'Sampah & Lingkungan', dinas: 'Dinas Lingkungan Hidup', singkatan: 'DLH' },
  'fasilitas-difabel': { nama: 'Fasilitas Difabel', dinas: 'Dinas Pekerjaan Umum & Penataan Ruang', singkatan: 'DPUPR' },
  'rambu-halte': { nama: 'Rambu & Halte', dinas: 'Dinas Perhubungan', singkatan: 'Dishub' },
};

export async function kirimLaporan(payload: BuatLaporanPayload): Promise<{
  ok: boolean;
  kode?: string;
  pesan: string;
  penanda?: string[];
  saran_perbaikan?: string[];
}> {
  const defaultPhoto =
    payload.foto_url ||
    'https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?w=800&auto=format&fit=crop';

  try {
    if (USE_MOCK) {
      const infoKat = KATEGORI_NAMA_MAP[payload.kategori_slug] || KATEGORI_NAMA_MAP['penambalan-aspal'];
      const now = new Date().toISOString();
      const kodeBaru = `RMP-${new Date().getFullYear()}-${Math.random().toString(36).slice(2, 6).toUpperCase()}`;
      const laporanDemo: Laporan = {
        id: `demo-${Date.now()}`,
        kode_lacak: kodeBaru,
        judul: payload.judul,
        deskripsi: payload.deskripsi,
        kategori: infoKat.nama,
        kategori_slug: payload.kategori_slug,
        kelurahan: payload.kelurahan || null,
        kecamatan: payload.kecamatan || null,
        latitude: payload.latitude,
        longitude: payload.longitude,
        status: 'masuk',
        penanda: [],
        saran_perbaikan: [],
        foto_sebelum_paths: payload.foto_url ? [payload.foto_url] : [],
        foto_sesudah_paths: [],
        is_anonim: payload.is_anonim,
        is_demo: true,
        provenance: 'simulasi',
        dinas: infoKat.dinas,
        dinas_singkatan: infoKat.singkatan,
        jumlah_dukungan: 0,
        konfirmasi_jawaban: null,
        linimasa: [
          {
            tahap: 1,
            status_ke: 'masuk',
            judul_tahap: 'Diterima',
            catatan: 'Tersimpan di browser untuk keperluan demo; belum dikirim ke Supabase.',
            created_at: now,
          },
        ],
        created_at: now,
        updated_at: now,
      };

      if (!simpanLaporanLokal(laporanDemo)) {
        return { ok: false, pesan: 'Laporan demo tidak dapat disimpan di browser ini.' };
      }

      return {
        ok: true,
        kode: kodeBaru,
        pesan: 'Laporan berhasil disimpan dan kode pelacakan siap digunakan.',
      };
    }

    if (
      !payload.foto_url ||
      payload.foto_url.startsWith('blob:') ||
      payload.foto_url.includes('images.unsplash.com')
    ) {
      return {
        ok: false,
        pesan: 'Unggah foto belum tersambung ke Supabase Storage. Laporan belum dikirim.',
      };
    }

    let kategoriId = payload.kategori_id;

    if (!kategoriId) {
      const kategoriRes = await fetchAuthed('/api/referensi/kategori');
      const kategoriJson = await kategoriRes.json();

      if (!kategoriRes.ok || kategoriJson.error) {
        return {
          ok: false,
          pesan: kategoriJson.error?.pesan || 'Gagal memuat daftar kategori.',
        };
      }

      const kategoriTerpilih = Array.isArray(kategoriJson.data)
        ? kategoriJson.data.find(
            (item: { id?: string; slug?: string }) => item.slug === payload.kategori_slug
          )
        : undefined;
      kategoriId = typeof kategoriTerpilih?.id === 'string' ? kategoriTerpilih.id : undefined;
    }

    if (!kategoriId) {
      return {
        ok: false,
        pesan: 'Kategori yang dipilih tidak tersedia. Muat ulang halaman dan pilih kategori kembali.',
      };
    }

    const requestBody = {
      judul: payload.judul.trim(),
      deskripsi: payload.deskripsi.trim(),
      kategori_id: kategoriId,
      latitude: payload.latitude || -7.5684,
      longitude: payload.longitude || 110.825,
      foto_sebelum_paths: [defaultPhoto],
      is_anonim: payload.is_anonim,
      email_pelapor: payload.email_pelapor,
      telepon_pelapor: payload.telepon_pelapor,
    };

    const res = await fetchAuthed('/api/laporan', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(requestBody),
    });

    const json = await res.json();

    if (!res.ok || json.error) {
      return {
        ok: false,
        pesan: json.error?.pesan || 'Gagal mengirim laporan ke server.',
      };
    }

    const data = json.data;
    return {
      ok: true,
      kode: data?.kode_lacak,
      pesan: 'Laporan berhasil dikirim dan tersimpan di Supabase.',
      penanda: data?.penanda,
      saran_perbaikan: data?.saran_perbaikan,
    };
  } catch (err: any) {
    return {
      ok: false,
      pesan: 'Terjadi gangguan jaringan saat menghubungi server backend.',
    };
  }
}

/* ── Dukungan & Konfirmasi ── */

export async function dukungLaporan(laporanId: string): Promise<{ ok: boolean; pesan: string }> {
  if (USE_MOCK) {
    return { ok: false, pesan: 'Dukungan belum disimpan. Hubungkan Supabase untuk mengaktifkan fitur ini.' };
  }

  try {
    const res = await fetchAuthed(`/api/laporan/${laporanId}/dukungan`, { method: 'POST' });
    const json = await res.json();
    if (res.ok && json.data) {
      return { ok: true, pesan: json.data.pesan || 'Dukungan berhasil ditambahkan!' };
    }
    return { ok: false, pesan: json.error?.pesan || 'Dukungan gagal disimpan.' };
  } catch {
    return { ok: false, pesan: 'Server tidak dapat dijangkau. Dukungan belum disimpan.' };
  }
}

export async function kirimKonfirmasiAudit(
  laporanId: string,
  jawaban: 'puas' | 'biasa' | 'kurang_puas',
  rating: number,
  mintaBukaUlang: boolean
): Promise<{ ok: boolean; pesan: string }> {
  if (USE_MOCK) {
    return { ok: false, pesan: 'Konfirmasi belum disimpan. Hubungkan Supabase untuk mengaktifkan fitur ini.' };
  }

  try {
    const res = await fetchAuthed(`/api/laporan/${laporanId}/konfirmasi`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ jawaban, rating, minta_buka_ulang: mintaBukaUlang }),
    });
    const json = await res.json();
    if (res.ok && json.data) {
      return { ok: true, pesan: json.data.pesan || 'Konfirmasi audit warga berhasil disimpan!' };
    }
    return { ok: false, pesan: json.error?.pesan || 'Konfirmasi audit gagal disimpan.' };
  } catch {
    return { ok: false, pesan: 'Server tidak dapat dijangkau. Konfirmasi belum disimpan.' };
  }
}
