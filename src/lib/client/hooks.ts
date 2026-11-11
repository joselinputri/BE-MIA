'use client';
import { useEffect, useRef, useState } from 'react';

export function useAsync<T>(fn: () => Promise<T>, deps: unknown[] = []) {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);
  useEffect(() => {
    let aktif = true;
    setLoading(true);
    setError(null);
    fn()
      .then((d) => { if (aktif) setData(d); })
      .catch((cause: unknown) => {
        if (aktif) setError(cause instanceof Error ? cause : new Error('Data gagal dimuat.'));
      })
      .finally(() => { if (aktif) setLoading(false); });
    return () => { aktif = false; };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, deps);
  return { data, loading, error };
}

export function useReducedMotion() {
  const [reduce, setReduce] = useState(false);
  useEffect(() => {
    const q = window.matchMedia('(prefers-reduced-motion: reduce)');
    setReduce(q.matches);
    const f = () => setReduce(q.matches);
    q.addEventListener('change', f);
    return () => q.removeEventListener('change', f);
  }, []);
  return reduce;
}

export function useRevealAll(selector = '.reveal') {
  useEffect(() => {
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
      document.querySelectorAll(selector).forEach((el) => el.classList.add('in'));
      return;
    }
    const io = new IntersectionObserver((entries) => {
      entries.forEach((e) => { if (e.isIntersecting) { e.target.classList.add('in'); io.unobserve(e.target); } });
    }, { threshold: 0.1 });
    document.querySelectorAll(selector).forEach((el) => io.observe(el));
    return () => io.disconnect();
  }, [selector]);
}

export function useCountUp(to: number, durasi = 900) {
  const [nilai, setNilai] = useState(0);
  const ref = useRef<HTMLSpanElement>(null);
  useEffect(() => {
    if (typeof window === 'undefined') return;
    if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) { setNilai(to); return; }
    const el = ref.current;
    if (!el) { setNilai(to); return; }
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
    io.observe(el);
    return () => { io.disconnect(); cancelAnimationFrame(raf); };
  }, [to, durasi]);
  return { ref, nilai };
}
