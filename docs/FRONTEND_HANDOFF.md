# Panduan Integrasi Frontend (FE Handoff) — RAMPUNG

Halo Syifa (Frontend Engineer)! Dokumen ini adalah panduan lengkap kontrak API, skema data, dan integrasi backend untuk membangun antarmuka web platform **RAMPUNG** tanpa perlu menebak-nebak.

---

## 1. Environment Variables untuk Frontend

Buat berkas `.env.local` di root proyek. **Hanya gunakan variabel berawalan `NEXT_PUBLIC_` di komponen FE**:

```env
NEXT_PUBLIC_APP_URL=http://localhost:3000

# Supabase Client SDK (Aman di Client-Side)
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here

# Cloudflare Turnstile (Opsional, untuk form anonim)
NEXT_PUBLIC_TURNSTILE_SITE_KEY=your-site-key
```

> [!CAUTION]
> **JANGAN PERNAH** memanggil atau mengimpor `SUPABASE_SERVICE_ROLE_KEY` di file antarmuka (komponen `'use client'`). Kunci tersebut khusus sisi server.

---

## 2. Format Standar Respons API

Semua endpoint backend RAMPUNG mengembalikan format respons seragam:

### Respons Sukses:
```json
{
  "data": { ... },
  "meta": {
    "cursor_berikutnya": "2026-10-15T08:30:00.000Z",
    "sumber": [
      {
        "provenance": "asli",
        "nama_sumber": "Data Terbuka Pemkot Surakarta",
        "waktu_pembaruan": "2026-11-10T12:00:00Z"
      }
    ],
    "waktu_query": "2026-11-10T15:00:00Z"
  }
}
```

### Respons Error:
```json
{
  "error": {
    "kode": "VALIDATION_ERROR",
    "pesan": "Judul laporan minimal 5 karakter",
    "detail": { ... }
  }
}
```

---

## 3. Peta Kode Error ke Pesan Tampilan Antarmuka (UI)

Gunakan mapping berikut untuk menampilkan toast/alert di sisi pengguna:

| Kode Error | HTTP Status | Rekomendasi Pesan UI (Toast / Banner) |
| :--- | :--- | :--- |
| `VALIDATION_ERROR` | 422 | Tampilkan pesan spesifik dari `error.pesan` di bawah input form terkait. |
| `UNAUTHORIZED` | 401 | *"Sesi Anda telah berakhir. Silakan masuk kembali."* |
| `FORBIDDEN` | 403 | *"Anda tidak memiliki hak akses untuk melakukan tindakan ini."* |
| `NOT_FOUND` | 404 | *"Data atau laporan yang dicari tidak ditemukan."* |
| `RATE_LIMITED` | 429 | *"Terlalu banyak permintaan. Mohon tunggu beberapa saat sebelum mencoba kembali."* |
| `INVALID_STATUS_TRANSITION` | 400 | Tampilkan pesan dari `error.pesan` (mis. penolakan wajib sertakan alasan). |
| `CONFLICT` | 409 | *"Anda sudah pernah memberikan dukungan pada laporan ini."* |
| `INTERNAL_ERROR` | 500 | *"Terjadi gangguan koneksi pada server. Silakan coba sesaat lagi."* |

---

## 4. Cara Menampilkan Label Provenance Data

Setiap data analitik dan item laporan menyertakan kolom `provenance` (`'asli'` \| `'agregat_resmi'` \| `'simulasi_terkalibrasi'` \| `'simulasi'`).
Gunakan badge visual sesuai panduan berikut:

| Nilai Provenance | Label Teks Badge UI | Warna Badge Rekomendasi | Tooltip Penjelasan |
| :--- | :--- | :--- | :--- |
| `asli` | **Resmi** | Hijau / Emerald (`bg-emerald-50 text-emerald-700`) | Data definitif resmi Pemerintah Kota Surakarta |
| `agregat_resmi` | **Agregat Resmi** | Biru (`bg-blue-50 text-blue-700`) | Statistik resmi Dispendukcapil / Satu Data Jateng |
| `simulasi_terkalibrasi` | **Data Simulasi** | Abu-abu / Netral (`bg-slate-100 text-slate-700`) | Titik mikro terkalibrasi dari pola aduan resmi ULAS |

---

## 5. Cara Berlangganan Pembaruan Real-Time (Supabase Realtime)

Gunakan helper Supabase bawaan pada halaman *Lacak Laporan* untuk memperbarui linimasa status tiket secara otomatis:

```typescript
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL!,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
);

// Dengarkan perubahan status laporan spesifik
export function subscribeStatusLaporan(laporanId: string, onUpdate: (data: any) => void) {
  const channel = supabase
    .channel(`laporan-${laporanId}`)
    .on(
      'postgres_changes',
      {
        event: 'UPDATE',
        schema: 'public',
        table: 'laporan',
        filter: `id=eq.${laporanId}`,
      },
      (payload) => {
        onUpdate(payload.new);
      }
    )
    .subscribe();

  return () => {
    supabase.removeChannel(channel);
  };
}
```

---

## 6. Daftar Endpoint Utama

| Method | Path | Auth | Keterangan |
| :--- | :--- | :--- | :--- |
| `POST` | `/api/laporan` | Publik | Buat laporan aduan baru |
| `GET` | `/api/laporan/publik` | Publik | Daftar laporan publik (cursor pagination: `?limit=20&cursor=...`) |
| `GET` | `/api/laporan/lacak/:kode` | Publik | Lacak status tiket via kode lacak (mis. `RPG-SIM00001`) |
| `GET` | `/api/laporan/serupa` | Publik | Cek laporan terdekat: `?kategori_id=...&latitude=...&longitude=...` |
| `POST` | `/api/laporan/:id/dukungan` | Publik | Upvote laporan serupa |
| `POST` | `/api/laporan/:id/konfirmasi` | Publik / Warga | Audit gotong-royong pelapor (puas, biasa, kurang_puas) |
| `GET` | `/api/petugas/antrean` | Petugas / Admin | Antrean verifikasi tugas per dinas |
| `PATCH` | `/api/petugas/laporan/:id/status`| Petugas / Admin | Pembaruan status (state machine) + upload foto sesudah |
| `GET` | `/api/dashboard/ringkasan` | Publik | KPI kartu angka beranda (Papan Tanggap) |
| `GET` | `/api/dashboard/tren` | Publik | Grafik tren masuk vs selesai bulanan |
| `GET` | `/api/dashboard/waktu-penanganan`| Publik | Median durasi penanganan per dinas & kategori |
| `GET` | `/api/dashboard/per-kapita` | Publik | Rasio laporan per 10.000 penduduk per kelurahan |
| `GET` | `/api/dashboard/konfirmasi` | Publik | Persentase kepuasan audit pelapor |
| `GET` | `/api/peta/laporan` | Publik | GeoJSON sebaran laporan untuk Leaflet |
| `GET` | `/api/referensi/kategori` | Publik | Master kategori, ikon, dan target SLA hari |
| `GET` | `/api/referensi/wilayah` | Publik | Master 5 kecamatan dan 54 kelurahan |
| `GET` | `/api/referensi/sumber-data` | Publik | Metadata "Dari Mana Data Ini?" |

---

## 7. Akun Demo untuk Pengujian Antarmuka

| Peran (Role) | Email Demo | Password Demo | Hak Akses |
| :--- | :--- | :--- | :--- |
| **Warga** | `warga.demo@rampung.id` | `WargaSolo2026!` | Melapor bernama, melihat riwayat laporannya, konfirmasi hasil |
| **Petugas DPUPR** | `petugas.dpupr@surakarta.go.id` | `PetugasDPUPR2026!` | Menangani aduan aspal, trotoar, dan drainase |
| **Petugas Dishub** | `petugas.dishub@surakarta.go.id` | `PetugasDishub2026!` | Menangani aduan lampu PJU, rambu, dan halte |
| **Petugas DLH** | `petugas.dlh@surakarta.go.id` | `PetugasDLH2026!` | Menangani sampah liar dan kebersihan lingkungan |
| **Admin** | `admin@rampung.surakarta.go.id` | `AdminSoloRampung2026!` | Pengawasan menyeluruh, audit log, kelola user |

---

## 8. Checklist yang Perlu FE Lakukan

- [ ] Pastikan form pelaporan memiliki validasi minimal sesuai skema Zod (judul min. 5 huruf, deskripsi min. 20 huruf).
- [ ] Koordinat form pelaporan dibatasi di dalam Kota Surakarta (Lon: 110.77-110.87, Lat: -7.60 s/d -7.52).
- [ ] Di halaman *Peta Laporan*, bedakan warna/bentuk marker status (Baru, Diproses, Selesai).
- [ ] Di modul *Perubahan Nyatanya*, tampilkan perbandingan foto sebelum dan sesudah secara *side-by-side* / *slider*.
- [ ] Gunakan data mock di folder `mocks/` jika ingin styling komponen secara instan tanpa menunggu database.

