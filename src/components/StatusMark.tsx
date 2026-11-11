import { statusDari } from '@/lib/status';

export function Bentuk({ status, ukuran = 14 }: { status: string; ukuran?: number }) {
  const { warna, bentuk } = statusDari(status);
  return (
    <svg width={ukuran} height={ukuran} viewBox="0 0 16 16" aria-hidden="true" className="shrink-0">
      {bentuk === 'circle' && <circle cx="8" cy="8" r="7" fill={warna} />}
      {bentuk === 'square' && <rect x="1.5" y="1.5" width="13" height="13" rx="2" fill={warna} />}
      {bentuk === 'diamond' && <polygon points="8,0.5 15.5,8 8,15.5 0.5,8" fill={warna} />}
      {bentuk === 'triangle' && <polygon points="8,1 15.5,15 0.5,15" fill={warna} />}
    </svg>
  );
}

export function StatusLabel({ status }: { status: string }) {
  const s = statusDari(status);
  return (
    <span className="inline-flex items-center gap-1.5 text-xs font-bold">
      <Bentuk status={status} /> {s.label}
    </span>
  );
}

