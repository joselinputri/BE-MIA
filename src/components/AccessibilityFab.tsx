'use client';
import * as Popover from '@radix-ui/react-popover';
import { Accessibility } from 'lucide-react';
import { useCallback, useEffect, useState } from 'react';
import { cn } from '@/lib/utils';

const UKURAN = [1, 1.125, 1.25];

export default function AccessibilityFab() {
  const [ukuran, setUkuran] = useState(0);
  const [kontras, setKontras] = useState(false);
  const [membaca, setMembaca] = useState(false);

  useEffect(() => {
    try {
      setUkuran(Number(localStorage.getItem('rampung_ukuran') ?? 0));
      setKontras(localStorage.getItem('rampung_kontras') === '1');
    } catch {}
  }, []);

  useEffect(() => {
    document.documentElement.style.setProperty('--fs', String(UKURAN[ukuran]));
    document.documentElement.classList.toggle('hc', kontras);
    try {
      localStorage.setItem('rampung_ukuran', String(ukuran));
      localStorage.setItem('rampung_kontras', kontras ? '1' : '0');
    } catch {}
  }, [ukuran, kontras]);

  const baca = useCallback(() => {
    const s = window.speechSynthesis;
    if (!s) return;
    if (membaca) { s.cancel(); setMembaca(false); return; }
    const teks = (document.querySelector('main')?.textContent ?? '').replace(/\s+/g, ' ').trim().slice(0, 6000);
    const u = new SpeechSynthesisUtterance(teks);
    u.lang = 'id-ID';
    u.onend = () => setMembaca(false);
    s.speak(u);
    setMembaca(true);
  }, [membaca]);

  useEffect(() => () => window.speechSynthesis?.cancel(), []);

  const tombol = 'min-h-12 w-full rounded-xl border border-navy/15 bg-white px-4 text-sm font-bold text-navy shadow-sm hover:bg-card transition-colors';

  return (
    <div className="no-print fixed bottom-5 right-5 z-50">
      <Popover.Root>
        <Popover.Trigger
          aria-label="Pengaturan aksesibilitas"
          className="grid size-12 place-items-center rounded-xl bg-crimson text-white shadow-lg hover:bg-[#8a002b] transition-colors"
        >
          <Accessibility aria-hidden="true" />
        </Popover.Trigger>
        <Popover.Portal>
          <Popover.Content side="top" align="end" sideOffset={10} className="z-50 flex w-60 flex-col gap-3 rounded-2xl bg-mist p-3 shadow-2xl animate-in fade-in slide-in-from-bottom-2">
            <button type="button" className={tombol} onClick={() => setUkuran((ukuran + 1) % UKURAN.length)}>
              Perbesar Teks {ukuran > 0 && <span className="text-crimson"> ({Math.round(UKURAN[ukuran] * 100)}%)</span>}
            </button>
            <button type="button" className={cn(tombol, kontras && 'bg-navy text-white hover:bg-navy')} aria-pressed={kontras} onClick={() => setKontras(!kontras)}>
              Kontras Tinggi
            </button>
            <button type="button" className={cn(tombol, membaca && 'bg-navy text-white hover:bg-navy')} aria-pressed={membaca} onClick={baca}>
              {membaca ? 'Hentikan Pembacaan' : 'Dengarkan Halaman'}
            </button>
          </Popover.Content>
        </Popover.Portal>
      </Popover.Root>
    </div>
  );
}

