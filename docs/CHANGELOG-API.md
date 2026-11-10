# CHANGELOG API — RAMPUNG

Dokumen ini mencatat setiap perubahan, penambahan, dan pembaruan kontrak antarmuka API antara Backend dan Frontend.

---

## [v1.0.0] - 2026-11-10
### Inisialisasi Kontrak Perdana (First Release)
- **Umum**:
  - Format respons seragam `{ data, meta?, error? }` untuk seluruh endpoint.
  - Kode error stabil (`VALIDATION_ERROR`, `UNAUTHORIZED`, `FORBIDDEN`, `NOT_FOUND`, `RATE_LIMITED`, `INVALID_STATUS_TRANSITION`, `CONFLICT`, `INTERNAL_ERROR`).
  - Label provenance wajib pada setiap record data (`asli`, `agregat_resmi`, `simulasi_terkalibrasi`, `simulasi`).
- **Modul Pelaporan (`/api/laporan`)**:
  - Endpoint `POST /api/laporan` (dukungan pelapor anonim maupun bernama).
  - Endpoint `GET /api/laporan/lacak/:kode` (pelacakan resi via kode lacak unik 12 karakter alfanumerik `RPG-XXXXXXXX`).
  - Endpoint `GET /api/laporan/serupa` (kueri radius PostGIS untuk deteksi laporan serupa).
  - Endpoint `POST /api/laporan/:id/dukungan` (upvote laporan dengan pencegahan vote ganda).
  - Endpoint `POST /api/laporan/:id/konfirmasi` (audit dua arah pelapor sebelum-sesudah).
- **Modul Petugas (`/api/petugas`)**:
  - Endpoint `GET /api/petugas/antrean` (antrean tugas per dinas berwenang).
  - Endpoint `PATCH /api/petugas/laporan/:id/status` (transisi status tervalidasi state machine).
- **Modul Dashboard (`/api/dashboard`)**:
  - Endpoint tren bulanan, waktu penanganan per OPD/kategori, normalisasi per 10.000 penduduk, statistik konfirmasi, dan umur laporan.
  - Endpoint insight deskriptif otomatis tanpa klaim kausal.

