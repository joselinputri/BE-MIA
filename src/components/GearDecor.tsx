'use client';

/**
 * GearDecor — roda gigi dekoratif berputar pelan.
 * Pakai SVG + CSS animation, bukan Three.js, supaya ringan dan tetap aksesibel.
 * Animasi mati otomatis saat prefers-reduced-motion.
 */
export default function GearDecor({ className = '' }: { className?: string }) {
  return (
    <div aria-hidden="true" className={`pointer-events-none select-none ${className}`}>
      <svg viewBox="0 0 200 200" width="120" height="120" className="gear-spin opacity-20">
        <GearPath cx={100} cy={100} r={60} teeth={12} fill="#959EC9" />
      </svg>
      <svg viewBox="0 0 140 140" width="80" height="80" className="gear-spin-reverse opacity-15 -mt-6 ml-14">
        <GearPath cx={70} cy={70} r={40} teeth={9} fill="#C5C2D1" />
      </svg>
    </div>
  );
}

function GearPath({ cx, cy, r, teeth, fill }: { cx: number; cy: number; r: number; teeth: number; fill: string }) {
  const inner = r * 0.7;
  const toothH = r * 0.22;
  const toothW = (Math.PI * 2) / teeth / 3.2;
  const koordinat = (nilai: number) => Number(nilai.toFixed(3));
  let d = '';

  for (let i = 0; i < teeth; i++) {
    const angle = (i / teeth) * Math.PI * 2;
    const a1 = angle - toothW;
    const a2 = angle + toothW;
    const outerR = r + toothH;

    if (i === 0) {
      d += `M ${koordinat(cx + Math.cos(a1) * r)} ${koordinat(cy + Math.sin(a1) * r)}`;
    }

    d += ` L ${koordinat(cx + Math.cos(a1) * outerR)} ${koordinat(cy + Math.sin(a1) * outerR)}`;
    d += ` L ${koordinat(cx + Math.cos(a2) * outerR)} ${koordinat(cy + Math.sin(a2) * outerR)}`;
    d += ` L ${koordinat(cx + Math.cos(a2) * r)} ${koordinat(cy + Math.sin(a2) * r)}`;

    const nextAngle = ((i + 1) / teeth) * Math.PI * 2;
    const na1 = nextAngle - toothW;
    d += ` A ${r} ${r} 0 0 1 ${koordinat(cx + Math.cos(na1) * r)} ${koordinat(cy + Math.sin(na1) * r)}`;
  }
  d += ' Z';

  return (
    <>
      <path d={d} fill={fill} />
      <circle cx={cx} cy={cy} r={inner * 0.5} fill="#E8EAE7" />
    </>
  );
}

export function GearHero() {
  return (
    <div aria-hidden="true" className="pointer-events-none absolute inset-0 overflow-hidden select-none">
      <svg viewBox="0 0 200 200" width="180" height="180" className="gear-spin opacity-[0.06] absolute -right-10 -top-10">
        <GearPath cx={100} cy={100} r={70} teeth={14} fill="#28264b" />
      </svg>
      <svg viewBox="0 0 160 160" width="130" height="130" className="gear-spin-reverse opacity-[0.05] absolute right-24 top-20">
        <GearPath cx={80} cy={80} r={50} teeth={10} fill="#A40033" />
      </svg>
      <svg viewBox="0 0 120 120" width="90" height="90" className="gear-spin opacity-[0.04] absolute -left-6 bottom-4">
        <GearPath cx={60} cy={60} r={38} teeth={8} fill="#959EC9" />
      </svg>
    </div>
  );
}
