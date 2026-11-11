import type { ComponentProps, ReactNode } from 'react';
import { cn } from '@/lib/utils';

export function Panel({ className, ...p }: ComponentProps<'section'>) {
  return <section className={cn('rounded-3xl bg-[#BEBDCC] p-5 shadow-[0_8px_24px_rgba(40,38,75,.14)] sm:p-6', className)} {...p} />;
}

export function Kartu({ className, ...p }: ComponentProps<'div'>) {
  return <div className={cn('rounded-2xl bg-card', className)} {...p} />;
}

export function PageHero({ judul, deskripsi, children, id, className }: { judul: string; deskripsi: ReactNode; children?: ReactNode; id?: string; className?: string }) {
  return (
    <header className={cn('bg-hero flex flex-col gap-5 rounded-3xl p-6 shadow-[0_8px_24px_rgba(40,38,75,.14)] sm:p-8 md:flex-row md:items-center md:justify-between', className)}>
      <div className="max-w-2xl">
        <h1 id={id} className="text-3xl font-bold leading-tight text-navy sm:text-4xl">{judul}</h1>
        <p className="mt-2 text-sm leading-relaxed text-navy/80 sm:text-base">{deskripsi}</p>
      </div>
      {children}
    </header>
  );
}

export function Pil({ className, ...p }: ComponentProps<'span'>) {
  return <span className={cn('inline-flex items-center rounded-full px-2.5 py-0.5 text-[11px] font-bold', className)} {...p} />;
}

export const tombolDasar = 'inline-flex min-h-11 items-center justify-center gap-2 rounded-xl px-4 text-sm font-bold transition-colors disabled:opacity-50 focus-visible:ring-2';

