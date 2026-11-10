/**
 * src/lib/server/state-machine.ts
 * Validator Mesin State Transisi Status Laporan di Sisi Server
 * Platform RAMPUNG — Pelaporan Aduan Warga Kota Surakarta
 */

export type StatusLaporan =
  | 'masuk'
  | 'ditinjau'
  | 'sedang_ditangani'
  | 'selesai'
  | 'ditolak'
  | 'dibuka_ulang';

export type UserRole = 'warga' | 'petugas' | 'admin';

export interface ValidasiTransisiResult {
  valid: boolean;
  pesan: string;
}

export function validasiTransisiStatus(
  statusDari: StatusLaporan,
  statusKe: StatusLaporan,
  role: UserRole,
  catatan?: string,
  fotoSesudah?: string[]
): ValidasiTransisiResult {
  // Transisi ke status yang sama tidak diizinkan
  if (statusDari === statusKe) {
    return {
      valid: false,
      pesan: `Status laporan saat ini sudah "${statusDari}"`,
    };
  }

  // 1. Dari 'masuk'
  if (statusDari === 'masuk') {
    if (statusKe === 'ditinjau') {
      if (role !== 'petugas' && role !== 'admin') {
        return { valid: false, pesan: 'Hanya petugas atau admin yang berhak meninjau laporan' };
      }
      return { valid: true, pesan: 'OK' };
    }
    if (statusKe === 'ditolak') {
      if (role !== 'petugas' && role !== 'admin') {
        return { valid: false, pesan: 'Hanya petugas atau admin yang berhak menolak laporan' };
      }
      if (!catatan || catatan.trim().length < 10) {
        return { valid: false, pesan: 'Penolakan laporan wajib disertai alasan minimal 10 karakter' };
      }
      return { valid: true, pesan: 'OK' };
    }
  }

  // 2. Dari 'ditinjau'
  if (statusDari === 'ditinjau') {
    if (statusKe === 'sedang_ditangani') {
      if (role !== 'petugas' && role !== 'admin') {
        return { valid: false, pesan: 'Hanya petugas atau admin yang berhak memulai penanganan' };
      }
      return { valid: true, pesan: 'OK' };
    }
    if (statusKe === 'masuk') {
      if (role !== 'petugas' && role !== 'admin') {
        return { valid: false, pesan: 'Hanya petugas atau admin yang berhak mengembalikan status' };
      }
      return { valid: true, pesan: 'OK' };
    }
    if (statusKe === 'ditolak') {
      if (role !== 'petugas' && role !== 'admin') {
        return { valid: false, pesan: 'Hanya petugas atau admin yang berhak menolak laporan' };
      }
      if (!catatan || catatan.trim().length < 10) {
        return { valid: false, pesan: 'Penolakan laporan wajib disertai alasan minimal 10 karakter' };
      }
      return { valid: true, pesan: 'OK' };
    }
  }

  // 3. Dari 'sedang_ditangani'
  if (statusDari === 'sedang_ditangani') {
    if (statusKe === 'selesai') {
      if (role !== 'petugas' && role !== 'admin') {
        return { valid: false, pesan: 'Hanya petugas atau admin yang berhak menyelesaikan laporan' };
      }
      if (!fotoSesudah || fotoSesudah.length === 0) {
        return { valid: false, pesan: 'Penyelesaian laporan wajib menyertakan foto bukti pengerjaan sesudah' };
      }
      return { valid: true, pesan: 'OK' };
    }
  }

  // 4. Dari 'selesai'
  if (statusDari === 'selesai') {
    if (statusKe === 'dibuka_ulang') {
      // Warga pelapor atau admin boleh meminta buka ulang
      return { valid: true, pesan: 'OK' };
    }
  }

  // 5. Dari 'dibuka_ulang'
  if (statusDari === 'dibuka_ulang') {
    if (statusKe === 'sedang_ditangani') {
      if (role !== 'petugas' && role !== 'admin') {
        return { valid: false, pesan: 'Hanya petugas atau admin yang berhak menangani kembali laporan' };
      }
      return { valid: true, pesan: 'OK' };
    }
    if (statusKe === 'ditolak') {
      if (role !== 'petugas' && role !== 'admin') {
        return { valid: false, pesan: 'Hanya petugas atau admin yang berhak menolak laporan' };
      }
      if (!catatan || catatan.trim().length < 10) {
        return { valid: false, pesan: 'Penolakan laporan wajib disertai alasan minimal 10 karakter' };
      }
      return { valid: true, pesan: 'OK' };
    }
  }

  return {
    valid: false,
    pesan: `Transisi status tidak valid: dari "${statusDari}" ke "${statusKe}" untuk peran "${role}"`,
  };
}
