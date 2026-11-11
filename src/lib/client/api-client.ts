/**
 * src/lib/client/api-client.ts
 * SDK Client Terstandarisasi untuk Frontend Engineer
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

import { ApiResponse } from '../contracts/common';
import { BuatLaporanInput, LaporanPublikFilter, LaporanPublikItem } from '../contracts/laporan';
import { UbahStatusInput } from '../contracts/petugas';
import { KonfirmasiInput } from '../contracts/konfirmasi';
import { DashboardFilter, RingkasanLanding, TrenBulananItem, WaktuPenangananItem, PerKapitaItem, CivicInsight } from '../contracts/dashboard';
import { fetchAuthed } from './supabase';

async function fetcher<T>(url: string, init?: RequestInit): Promise<ApiResponse<T>> {
  const res = await fetchAuthed(url, {
    ...init,
    headers: {
      'Content-Type': 'application/json',
      ...init?.headers,
    },
  });
  return res.json();
}

export const rampungApi = {
  laporan: {
    buat: (payload: BuatLaporanInput) =>
      fetcher<{ id: string; kode_lacak: string; status: string; penanda: string[]; saran_perbaikan: string[] }>(
        '/api/laporan',
        { method: 'POST', body: JSON.stringify(payload) }
      ),

    lacak: (kode: string) =>
      fetcher<{ laporan: LaporanPublikItem; linimasa: any[]; sla: any }>(`/api/laporan/lacak/${encodeURIComponent(kode)}`),

    getPublik: (filter?: LaporanPublikFilter) => {
      const q = new URLSearchParams();
      if (filter) {
        Object.entries(filter).forEach(([k, v]) => {
          if (v !== undefined) q.append(k, String(v));
        });
      }
      return fetcher<LaporanPublikItem[]>(`/api/laporan/publik?${q.toString()}`);
    },

    getSerupa: (kategoriId: string, lat: number, lon: number, radius: number = 500) =>
      fetcher<any[]>(`/api/laporan/serupa?kategori_id=${kategoriId}&latitude=${lat}&longitude=${lon}&radius_meter=${radius}`),

    dukung: (laporanId: string) =>
      fetcher<{ laporan_id: string; pesan: string }>(`/api/laporan/${laporanId}/dukungan`, { method: 'POST' }),

    konfirmasi: (laporanId: string, payload: KonfirmasiInput) =>
      fetcher<{ status_terbaru: string; pesan: string }>(`/api/laporan/${laporanId}/konfirmasi`, {
        method: 'POST',
        body: JSON.stringify(payload),
      }),

    getLaporanSaya: (limit: number = 20, cursor?: string) => {
      const q = new URLSearchParams({ limit: String(limit) });
      if (cursor) q.append('cursor', cursor);
      return fetcher<any[]>(`/api/laporan/saya?${q.toString()}`);
    },

    getUploadUrl: (tipe: 'image/jpeg' | 'image/png' | 'image/webp') =>
      fetcher<{ upload_url: string; file_path: string; expires_in: number }>('/api/laporan/upload-foto', {
        method: 'POST',
        body: JSON.stringify({ tipe }),
      }),
  },

  petugas: {
    getAntrean: (status?: string, prioritas: string = 'semua') => {
      const q = new URLSearchParams({ prioritas });
      if (status) q.append('status', status);
      return fetcher<any[]>(`/api/petugas/antrean?${q.toString()}`);
    },

    ubahStatus: (laporanId: string, payload: UbahStatusInput) =>
      fetcher<{ id: string; status_baru: string; pesan: string }>(`/api/petugas/laporan/${laporanId}/status`, {
        method: 'PATCH',
        body: JSON.stringify(payload),
      }),
  },

  dashboard: {
    getRingkasan: () => fetcher<RingkasanLanding>('/api/dashboard/ringkasan'),

    getTren: (filter?: DashboardFilter) => {
      const q = new URLSearchParams();
      if (filter) Object.entries(filter).forEach(([k, v]) => v && q.append(k, v));
      return fetcher<TrenBulananItem[]>(`/api/dashboard/tren?${q.toString()}`);
    },

    getWaktuPenanganan: (filter?: DashboardFilter) => {
      const q = new URLSearchParams();
      if (filter) Object.entries(filter).forEach(([k, v]) => v && q.append(k, v));
      return fetcher<WaktuPenangananItem[]>(`/api/dashboard/waktu-penanganan?${q.toString()}`);
    },

    getPerKapita: (filter?: DashboardFilter) => {
      const q = new URLSearchParams();
      if (filter) Object.entries(filter).forEach(([k, v]) => v && q.append(k, v));
      return fetcher<PerKapitaItem[]>(`/api/dashboard/per-kapita?${q.toString()}`);
    },

    getKonfirmasi: (filter?: DashboardFilter) => {
      const q = new URLSearchParams();
      if (filter) Object.entries(filter).forEach(([k, v]) => v && q.append(k, v));
      return fetcher<any>(`/api/dashboard/konfirmasi?${q.toString()}`);
    },

    getUmurLaporan: (filter?: DashboardFilter) => {
      const q = new URLSearchParams();
      if (filter) Object.entries(filter).forEach(([k, v]) => v && q.append(k, v));
      return fetcher<any[]>(`/api/dashboard/umur-laporan?${q.toString()}`);
    },

    getInsight: (filter?: DashboardFilter) => {
      const q = new URLSearchParams();
      if (filter) Object.entries(filter).forEach(([k, v]) => v && q.append(k, v));
      return fetcher<CivicInsight[]>(`/api/dashboard/insight?${q.toString()}`);
    },
  },

  referensi: {
    getKategori: () => fetcher<any[]>('/api/referensi/kategori'),
    getWilayah: () => fetcher<any[]>('/api/referensi/wilayah'),
    getSumberData: () => fetcher<any[]>('/api/referensi/sumber-data'),
  },

  peta: {
    getGeoJson: (kategori?: string, status?: string) => {
      const q = new URLSearchParams();
      if (kategori) q.append('kategori', kategori);
      if (status) q.append('status', status);
      return fetcher<any>(`/api/peta/laporan?${q.toString()}`);
    },
  },
};
