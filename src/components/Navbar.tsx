'use client';
import * as Menu from '@radix-ui/react-dropdown-menu';
import { ChevronDown, LogIn, LogOut, Menu as Burger, UserPlus, X } from 'lucide-react';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { useState } from 'react';
import { useAuth } from '@/lib/client/auth';
import { cn } from '@/lib/utils';

const NAV = [
  { href: '/', label: 'Beranda' },
  { href: '/lapor', label: 'Laporan', anak: [{ href: '/lapor', label: 'Kirim Aduan' }, { href: '/riwayat', label: 'Riwayat & Lacak' }] },
  { href: '/peta', label: 'Peta Lapor' },
  { href: '/papan-tanggap', label: 'Papan Tanggap' },
];

export default function Navbar() {
  const path = usePathname();
  const { pengguna, keluar } = useAuth();
  const [buka, setBuka] = useState(false);

  const aktif = (n: (typeof NAV)[number]) =>
    n.anak ? n.anak.some((a) => path.startsWith(a.href)) : n.href === '/' ? path === '/' : path.startsWith(n.href);

  const linkClass = (a: boolean) =>
    cn('nav-link relative px-1 py-2 text-sm font-bold text-white transition-colors',
      a && 'text-crimson after:absolute after:inset-x-0 after:-bottom-0.5 after:h-[2px] after:rounded-full after:bg-crimson');

  return (
    <header className="bg-nav no-print sticky top-0 z-40 shadow-md">
      <div className="mx-auto flex h-16 max-w-7xl items-center justify-between gap-4 px-4 sm:px-8">
        {/* Brand */}
        <Link href="/" className="text-lg font-extrabold tracking-wide text-navy">RAMPUNG</Link>

        {/* Desktop nav */}
        <nav aria-label="Navigasi utama" className="hidden items-center gap-7 md:flex">
          {NAV.map((n) =>
            n.anak ? (
              <Menu.Root key={n.label}>
                <Menu.Trigger className={cn(linkClass(aktif(n)), 'inline-flex items-center gap-1')}>
                  {n.label} <ChevronDown size={14} aria-hidden="true" />
                </Menu.Trigger>
                <Menu.Portal>
                  <Menu.Content sideOffset={8} className="z-50 min-w-44 rounded-xl bg-white p-1.5 text-sm font-semibold text-navy shadow-xl animate-in fade-in slide-in-from-top-2">
                    {n.anak.map((a) => (
                      <Menu.Item key={a.href} asChild>
                        <Link href={a.href} className="block rounded-lg px-3 py-2.5 outline-none data-[highlighted]:bg-card">{a.label}</Link>
                      </Menu.Item>
                    ))}
                  </Menu.Content>
                </Menu.Portal>
              </Menu.Root>
            ) : (
              <Link key={n.href} href={n.href} aria-current={aktif(n) ? 'page' : undefined} className={linkClass(aktif(n))}>{n.label}</Link>
            ),
          )}
        </nav>

        {/* Actions */}
        <div className="flex items-center gap-2">
          {pengguna ? (
            <Menu.Root>
              <Menu.Trigger className="nav-link flex items-center gap-2 rounded-full py-1 pl-2 pr-1 text-sm font-bold text-white" aria-label="Menu akun">
                <span className="hidden sm:inline">Halo, {pengguna.nama.split(' ')[0]}</span>
                <span className="grid size-10 place-items-center rounded-full border-2 border-white bg-crimson text-sm font-bold text-white" aria-hidden="true">
                  {pengguna.nama.slice(0, 1).toUpperCase()}
                </span>
                <ChevronDown size={16} aria-hidden="true" />
              </Menu.Trigger>
              <Menu.Portal>
                <Menu.Content align="end" sideOffset={8} className="z-50 min-w-48 rounded-xl bg-white p-1.5 text-sm font-semibold text-navy shadow-xl animate-in fade-in slide-in-from-top-2">
                  <Menu.Item asChild><Link href="/profil" className="block rounded-lg px-3 py-2.5 outline-none data-[highlighted]:bg-card">Profil Akun</Link></Menu.Item>
                  <Menu.Item asChild><Link href="/riwayat" className="block rounded-lg px-3 py-2.5 outline-none data-[highlighted]:bg-card">Riwayat Laporan</Link></Menu.Item>
                  {pengguna.peran === 'admin' && <Menu.Item asChild><Link href="/admin" className="block rounded-lg px-3 py-2.5 outline-none data-[highlighted]:bg-card">Panel Admin</Link></Menu.Item>}
                  <Menu.Item onSelect={() => { void keluar(); }} className="flex cursor-pointer items-center gap-2 rounded-lg px-3 py-2.5 text-crimson outline-none data-[highlighted]:bg-card">
                    <LogOut size={16} aria-hidden="true" /> Keluar
                  </Menu.Item>
                </Menu.Content>
              </Menu.Portal>
            </Menu.Root>
          ) : (
            <>
              <Link href="/masuk" className="nav-link hidden min-h-10 items-center gap-2 rounded-lg border border-white/80 px-4 text-sm font-bold text-white hover:bg-white/10 sm:inline-flex">
                <LogIn size={16} aria-hidden="true" /> Masuk
              </Link>
              <Link href="/daftar" className="hidden min-h-10 items-center gap-2 rounded-lg bg-crimson px-4 text-sm font-bold text-white hover:bg-[#8a002b] sm:inline-flex">
                <UserPlus size={16} aria-hidden="true" /> Daftar
              </Link>
            </>
          )}
          <button type="button" className="nav-link grid size-11 place-items-center rounded-lg text-white md:hidden" aria-expanded={buka} aria-controls="menu-ponsel" aria-label={buka ? 'Tutup menu' : 'Buka menu'} onClick={() => setBuka(!buka)}>
            {buka ? <X /> : <Burger />}
          </button>
        </div>
      </div>

      {/* Mobile menu */}
      {buka && (
        <nav id="menu-ponsel" aria-label="Navigasi ponsel" className="bg-slate-card flex flex-col gap-1 px-4 pb-4 md:hidden">
          {[
            ...NAV.flatMap((n) => n.anak ?? [n]),
            ...(pengguna
              ? [
                  { href: '/profil', label: 'Profil Akun' },
                  ...(pengguna.peran === 'admin' ? [{ href: '/admin', label: 'Panel Admin' }] : []),
                ]
              : [{ href: '/masuk', label: 'Masuk' }, { href: '/daftar', label: 'Daftar' }]),
          ].map((n) => (
            <Link key={n.href + n.label} href={n.href} onClick={() => setBuka(false)} className="rounded-lg px-3 py-3 text-sm font-bold text-white hover:bg-white/10">{n.label}</Link>
          ))}
        </nav>
      )}
    </header>
  );
}
