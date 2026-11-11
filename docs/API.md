# Dokumentasi Endpoint API — RAMPUNG

Platform Pelaporan Aduan Warga Kota Surakarta Berbasis Transparansi Dua Arah.

---

## 1. POST /api/laporan
Membuat aduan baru (bisa dilakukan secara anonim atau terdaftar).

- **Otorisasi**: Publik
- **Rate Limit**: 5 laporan/jam (anonim), 10 laporan/jam (login)

### Request Body:
```json
{
  "judul": "Lubang aspal jalan di dekat halte",
  "deskripsi": "Aspal berlubang cukup dalam sekitar 40cm, sangat membahayakan pengendara motor terutama saat hujan.",
  "kategori_id": "a1111111-0000-4000-8000-000000000001",
  "kelurahan_id": "c1000000-0000-0000-0000-000000000001",
  "latitude": -7.5612,
  "longitude": 110.8034,
  "foto_sebelum_paths": ["sebelum/17628100-foto1.jpg"],
  "is_anonim": false,
  "email_pelapor": "warga@example.com",
  "telepon_pelapor": "08123456789"
}
```

### Response 201 Created:
```json
{
  "data": {
    "id": "e229e0b8-4c31-4899-8cfb-665e78398b11",
    "kode_lacak": "RPG-A7XK9MQ2",
    "status": "masuk",
    "penanda": [],
    "saran_perbaikan": [],
    "created_at": "2026-11-10T15:30:00.000Z"
  }
}
```

---

## 2. GET /api/laporan/lacak/:kode
Melacak perkembangan penanganan tiket berdasarkan kode lacak unik.

- **Otorisasi**: Publik
- **Rate Limit**: 30 request/menit per IP

### Response 200 OK:
```json
{
  "data": {
    "laporan": {
      "id": "s0000000-0000-0000-0000-000000000001",
      "kode_lacak": "RPG-SIM00001",
      "judul": "Aspal amblas di dekat persimpangan",
      "status": "selesai",
      "kategori": "Penambalan Aspal",
      "kelurahan": "Purwosari",
      "foto_sebelum_paths": ["https://images.unsplash.com/..."],
      "foto_sesudah_paths": ["https://images.unsplash.com/..."]
    },
    "linimasa": [
      {
        "status_ke": "masuk",
        "catatan": "Laporan baru diterima oleh sistem",
        "created_at": "2026-10-15T08:30:00Z"
      },
      {
        "status_ke": "sedang_ditangani",
        "catatan": "Tim UPT Jalan DPUPR menuju lokasi",
        "created_at": "2026-10-16T09:00:00Z"
      },
      {
        "status_ke": "selesai",
        "catatan": "Penambalan jalan selesai tuntas",
        "created_at": "2026-10-17T11:45:00Z"
      }
    ],
    "sla": {
      "hari_berjalan": 2,
      "status": "selesai"
    }
  }
}
```

---

## 3. GET /api/laporan/serupa
Mendeteksi apakah sudah ada laporan bertopik serupa di sekitar lokasi sebelum warga mengirim aduan ganda.

- **Query Parameters**:
  - `kategori_id` (UUID, required)
  - `latitude` (Float, required)
  - `longitude` (Float, required)
  - `radius_meter` (Int, default: 500, max: 2000)
  - `maks` (Int, default: 5)

### Response 200 OK:
```json
{
  "data": [
    {
      "id": "s0000000-0000-0000-0000-000000000001",
      "kode_lacak": "RPG-SIM00001",
      "judul": "Aspal amblas di dekat persimpangan",
      "kategori": "Penambalan Aspal",
      "kelurahan": "Purwosari",
      "status": "sedang_ditangani",
      "jarak_meter": 84.5,
      "jumlah_dukungan": 12,
      "created_at": "2026-10-15T08:30:00Z"
    }
  ]
}
```

---

## 4. POST /api/laporan/:id/konfirmasi
Pelapor memberikan konfirmasi hasil perbaikan setelah status tiket diselesaikan oleh petugas.

- **Request Body**:
```json
{
  "jawaban": "puas",
  "rating": 5,
  "komentar": "Terima kasih jalan sudah halus kembali dan aman dilewati.",
  "minta_buka_ulang": false
}
```

---

## 5. PATCH /api/petugas/laporan/:id/status
Memperbarui status tiket penanganan oleh petugas berwenang (State Machine Enforcement).

- **Otorisasi**: Petugas / Admin
- **Request Body (Contoh Penyelesaian)**:
```json
{
  "status_ke": "selesai",
  "catatan": "Pekerjaan penambalan lubang aspal telah tuntas dikerjakan oleh Tim Regu UPT Cepat 03.",
  "foto_sesudah_paths": ["sesudah/17628120-selesai.jpg"]
}
```

---

## 6. Modul Analitik Dashboard

- `GET /api/dashboard/ringkasan` — Kartu KPI utama Papan Tanggap
- `GET /api/dashboard/tren?periode_mulai=2026-01-01&periode_akhir=2026-12-31` — Grafik tren masuk vs selesai bulanan
- `GET /api/dashboard/waktu-penanganan` — Median hari penanganan per dinas
- `GET /api/dashboard/per-kapita` — Laporan per 10.000 penduduk per kelurahan
- `GET /api/dashboard/konfirmasi` — Rasio kepuasan audit pelapor & reopen rate
- `GET /api/dashboard/umur-laporan` — Distribusi umur laporan yang belum selesai
- `GET /api/dashboard/insight` — Kalimat wawasan deskriptif otomatis
- `GET /api/referensi/sumber-data` — Metadata "Dari Mana Data Ini?"
