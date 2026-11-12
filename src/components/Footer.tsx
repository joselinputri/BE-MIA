import Link from 'next/link';

export default function Footer() {
  return (
    <footer className="bg-foot no-print mt-16">
      <div className="mx-auto grid max-w-7xl gap-6 px-4 py-8 text-xs text-navy sm:px-8 md:grid-cols-3 md:items-center">
        <div>
          <p className="text-sm font-extrabold">RAMPUNG</p>
          <p className="mt-2 text-navy/80">Pemerintah Kota Surakarta &middot; Kolaborasi Guyub Rukun Tanggap Fasilitas Publik</p>
        </div>
        <nav aria-label="Navigasi footer" className="flex flex-wrap gap-x-4 gap-y-1 font-semibold md:justify-center">
          <Link href="/">Beranda</Link>
          <Link href="/lapor">Laporan</Link>
          <Link href="/peta">Peta Lapor</Link>
          <Link href="/papan-tanggap">Papan Tanggap</Link>
          <a href="tel:112" className="font-extrabold text-crimson">Call Center 112 Surakarta</a>
        </nav>
        <p className="md:text-right">&copy; 2025 RAMPUNG Surakarta.</p>
      </div>
    </footer>
  );
}
