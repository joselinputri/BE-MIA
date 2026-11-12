'use client';

import { useState, useRef, useCallback, useEffect } from 'react';
import Image from 'next/image';

interface KomparasiSliderProps {
  fotoSebelum: string;
  fotoSesudah: string;
  altSebelum?: string;
  altSesudah?: string;
}

export default function KomparasiSlider({
  fotoSebelum,
  fotoSesudah,
  altSebelum = 'Kondisi sebelum perbaikan',
  altSesudah = 'Kondisi sesudah perbaikan',
}: KomparasiSliderProps) {
  const [posisiSlider, setPosisiSlider] = useState(50);
  const [sedangGeser, setSedangGeser] = useState(false);
  const containerRef = useRef<HTMLDivElement>(null);

  const tanganiGeser = useCallback(
    (clientX: number) => {
      if (!containerRef.current) return;
      const rect = containerRef.current.getBoundingClientRect();
      const x = clientX - rect.left;
      const persen = Math.max(0, Math.min(100, (x / rect.width) * 100));
      setPosisiSlider(persen);
    },
    []
  );

  const onTouchMove = useCallback(
    (e: TouchEvent) => {
      if (!sedangGeser) return;
      tanganiGeser(e.touches[0].clientX);
    },
    [sedangGeser, tanganiGeser]
  );

  const onMouseMove = useCallback(
    (e: MouseEvent) => {
      if (!sedangGeser) return;
      tanganiGeser(e.clientX);
    },
    [sedangGeser, tanganiGeser]
  );

  const stopGeser = useCallback(() => {
    setSedangGeser(false);
  }, []);

  useEffect(() => {
    if (sedangGeser) {
      window.addEventListener('mousemove', onMouseMove);
      window.addEventListener('mouseup', stopGeser);
      window.addEventListener('touchmove', onTouchMove);
      window.addEventListener('touchend', stopGeser);
    }
    return () => {
      window.removeEventListener('mousemove', onMouseMove);
      window.removeEventListener('mouseup', stopGeser);
      window.removeEventListener('touchmove', onTouchMove);
      window.removeEventListener('touchend', stopGeser);
    };
  }, [sedangGeser, onMouseMove, onTouchMove, stopGeser]);

  return (
    <div className="space-y-2">
      <div
        ref={containerRef}
        onMouseDown={(e) => {
          setSedangGeser(true);
          tanganiGeser(e.clientX);
        }}
        onTouchStart={(e) => {
          setSedangGeser(true);
          tanganiGeser(e.touches[0].clientX);
        }}
        className="relative h-64 sm:h-80 w-full overflow-hidden rounded-2xl border-2 border-navy/20 select-none cursor-ew-resize bg-slate-900 shadow-md"
      >
        {/* Lapisan Foto Sesudah (Dasar) */}
        <div className="absolute inset-0 pointer-events-none">
          <img
            src={fotoSesudah}
            alt={altSesudah}
            className="h-full w-full object-cover select-none pointer-events-none"
            draggable={false}
          />
          <span className="absolute bottom-3 right-3 bg-emerald-700/90 backdrop-blur-xs text-white text-[10px] font-extrabold uppercase px-2.5 py-1 rounded-lg shadow-sm">
            Sesudah (Tuntas)
          </span>
        </div>

        {/* Lapisan Foto Sebelum (Dipotong oleh Posisi Slider) */}
        <div
          className="absolute inset-0 overflow-hidden pointer-events-none"
          style={{ width: `${posisiSlider}%` }}
        >
          <img
            src={fotoSebelum}
            alt={altSebelum}
            className="absolute inset-0 h-full max-w-none object-cover select-none pointer-events-none"
            draggable={false}
            style={{ width: containerRef.current ? `${containerRef.current.clientWidth}px` : '100%' }}
          />
          <span className="absolute bottom-3 left-3 bg-crimson/90 backdrop-blur-xs text-white text-[10px] font-extrabold uppercase px-2.5 py-1 rounded-lg shadow-sm">
            Sebelum
          </span>
        </div>

        {/* Garis Pemisah & Handle Geser */}
        <div
          className="absolute top-0 bottom-0 w-0.5 bg-white shadow-[0_0_10px_rgba(0,0,0,0.5)] z-20 pointer-events-none"
          style={{ left: `${posisiSlider}%` }}
        >
          <div className="absolute top-1/2 -translate-y-1/2 -translate-x-1/2 w-8 h-8 rounded-full bg-white text-navy flex items-center justify-center shadow-lg border border-navy/20 text-xs font-black">
            ↔
          </div>
        </div>
      </div>

      <div className="flex items-center justify-between text-[11px] text-navy/60 px-1">
        <span>⬅ Geser ke kiri: lihat hasil perbaikan</span>
        <span>Geser ke kanan: lihat kondisi awal ➡</span>
      </div>
    </div>
  );
}

