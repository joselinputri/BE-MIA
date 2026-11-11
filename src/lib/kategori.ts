import { Accessibility, Droplet, Hammer, Lightbulb, Signpost, Trash2, type LucideIcon } from 'lucide-react';

export interface KategoriUI {
  slug: string;
  nama: string;
  ket: string;
  icon: LucideIcon;
  warna: string;
}

export const KATEGORI: KategoriUI[] = [
  { slug: 'penambalan-aspal', nama: 'Jalan & Aspal', ket: 'Lubang, amblas, trotoar patah', icon: Hammer, warna: '#A40033' },
  { slug: 'lampu-pju', nama: 'Lampu PJU', ket: 'Padam, redup, tiang roboh', icon: Lightbulb, warna: '#D97706' },
  { slug: 'drainase', nama: 'Saluran & Drainase', ket: 'Tersumbat, gorong-gorong jebol', icon: Droplet, warna: '#0E7490' },
  { slug: 'sampah-lingkungan', nama: 'Sampah & Lingkungan', ket: 'TPS liar, limbah, pohon tumbang', icon: Trash2, warna: '#047857' },
  { slug: 'fasilitas-difabel', nama: 'Fasilitas Difabel', ket: 'Guiding block rusak, ram terhalang', icon: Accessibility, warna: '#2563EB' },
  { slug: 'rambu-halte', nama: 'Rambu & Halte', ket: 'Rambu hilang, traffic light mati', icon: Signpost, warna: '#7C3AED' },
];

export function kategoriDari(teks: string): KategoriUI {
  const t = teks.toLowerCase();
  if (/pju|lampu/.test(t)) return KATEGORI[1];
  if (/drainase|saluran|genang/.test(t)) return KATEGORI[2];
  if (/sampah|lingkungan|pohon/.test(t)) return KATEGORI[3];
  if (/difabel|disabil|guiding/.test(t)) return KATEGORI[4];
  if (/rambu|halte|traffic/.test(t)) return KATEGORI[5];
  return KATEGORI[0];
}
