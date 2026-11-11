import '@fontsource-variable/montserrat';
import type { Metadata } from 'next';
import AccessibilityFab from '@/components/AccessibilityFab';
import Footer from '@/components/Footer';
import Navbar from '@/components/Navbar';
import { AuthProvider } from '@/lib/client/auth';
import './globals.css';

export const metadata: Metadata = {
  title: 'RAMPUNG | Lapor Cepat, Surakarta Beres',
  description: 'Platform aduan warga Kota Surakarta dengan bukti foto sebelum dan sesudah yang dikonfirmasi pelapor.',
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="id">
      <body>
        <noscript><style>{'.reveal{opacity:1!important;transform:none!important}'}</style></noscript>
        <a href="#isi" className="sr-only focus:not-sr-only focus:fixed focus:left-3 focus:top-3 focus:z-[60] focus:rounded-lg focus:bg-white focus:px-4 focus:py-2 focus:font-bold">
          Lewati ke konten
        </a>
        <AuthProvider>
          <Navbar />
          <main id="isi">{children}</main>
          <Footer />
          <AccessibilityFab />
        </AuthProvider>
      </body>
    </html>
  );
}

