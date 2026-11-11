import { clsx, type ClassValue } from 'clsx';
import { twMerge } from 'tailwind-merge';

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

export function hariSejak(iso: string, sampai: Date = new Date()) {
  const ms = sampai.getTime() - new Date(iso).getTime();
  return Math.max(0, Math.floor(ms / 86_400_000));
}

export function waktuRelatif(iso: string, sekarang: Date = new Date()) {
  const menit = Math.max(0, Math.round((sekarang.getTime() - new Date(iso).getTime()) / 60_000));
  if (menit < 60) return `${menit} menit lalu`;
  if (menit < 1440) return `${Math.round(menit / 60)} jam lalu`;
  return `${Math.round(menit / 1440)} hari lalu`;
}

export function tanggalPendek(iso: string) {
  return new Date(iso).toLocaleString('id-ID', {
    day: 'numeric', month: 'short', year: 'numeric',
    hour: '2-digit', minute: '2-digit', timeZone: 'Asia/Jakarta',
  });
}

export function angkaRingkas(n: number) {
  if (n >= 1_000_000) return (n / 1_000_000).toFixed(1).replace(/\.0$/, '') + ' jt';
  if (n >= 1_000) return (n / 1_000).toFixed(1).replace(/\.0$/, '') + ' rb';
  return n.toLocaleString('id-ID');
}

