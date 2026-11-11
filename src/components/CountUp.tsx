'use client';
import { useEffect, useRef, useState } from 'react';

export default function CountUp({ to, desimal = 0, durasi = 900, sufiks = '' }: { to: number; desimal?: number; durasi?: number; sufiks?: string }) {
  const ref = useRef<HTMLSpanElement>(null);
  const [nilai, setNilai] = useState(0);
  useEffect(() => {
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches || !ref.current) { setNilai(to); return; }
    let raf = 0;
    const io = new IntersectionObserver(([e]) => {
      if (!e.isIntersecting) return;
      io.disconnect();
      const mulai = performance.now();
      const langkah = (t: number) => {
        const p = Math.min(1, (t - mulai) / durasi);
        setNilai(to * (1 - Math.pow(1 - p, 3)));
        if (p < 1) raf = requestAnimationFrame(langkah);
      };
      raf = requestAnimationFrame(langkah);
    });
    io.observe(ref.current);
    return () => { io.disconnect(); cancelAnimationFrame(raf); };
  }, [to, durasi]);
  return <span ref={ref}>{nilai.toLocaleString('id-ID', { minimumFractionDigits: desimal, maximumFractionDigits: desimal })}{sufiks}</span>;
}

