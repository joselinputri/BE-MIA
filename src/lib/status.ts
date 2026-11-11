export type StatusKey = 'masuk' | 'ditinjau' | 'sedang_ditangani' | 'selesai' | 'ditolak' | 'dibuka_ulang';
export type Bentuk = 'circle' | 'triangle' | 'diamond' | 'square';

export const STATUS: Record<StatusKey, { label: string; warna: string; bentuk: Bentuk }> = {
  masuk:            { label: 'Baru',          warna: '#D97706', bentuk: 'circle' },
  ditinjau:         { label: 'Perlu Respon',  warna: '#A40033', bentuk: 'triangle' },
  sedang_ditangani: { label: 'Diproses',      warna: '#EA580C', bentuk: 'diamond' },
  selesai:          { label: 'Selesai',       warna: '#047857', bentuk: 'square' },
  ditolak:          { label: 'Ditolak',       warna: '#64748B', bentuk: 'circle' },
  dibuka_ulang:     { label: 'Dibuka Ulang',  warna: '#A40033', bentuk: 'triangle' },
};

export function statusDari(s: string) {
  return STATUS[(s as StatusKey)] ?? STATUS.masuk;
}

