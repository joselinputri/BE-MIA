'use client';

import { useEffect, useRef, useState } from 'react';
import * as THREE from 'three';
import { Play, Pause } from 'lucide-react';

interface ThreeGearsProps {
  className?: string;
  density?: 'compact' | 'normal';
}

/**
 * ThreeGears
 * Visualisasi mekanika 3D roda gigi pelayanan publik berbasis Three.js.
 * Didesain ergonomis dan inklusif:
 * - Menghormati prefers-reduced-motion (aksesibilitas gangguan vestibular)
 * - Kontrol manual jeda/putar yang ramah screen-reader
 * - Efek tilt halus yang tidak memusingkan
 * - Hemat daya (pause saat di luar viewport / tab latar)
 */
export default function ThreeGears({ className = '', density = 'normal' }: ThreeGearsProps) {
  const mountRef = useRef<HTMLDivElement>(null);
  const [isPaused, setIsPaused] = useState(false);
  const [reducedMotion, setReducedMotion] = useState(false);
  const animRef = useRef<{ pause: () => void; resume: () => void; toggle: () => void; isPaused: () => boolean } | null>(null);

  useEffect(() => {
    // Cek preferensi aksesibilitas gerak
    const motionQuery = window.matchMedia('(prefers-reduced-motion: reduce)');
    setReducedMotion(motionQuery.matches);
    if (motionQuery.matches) {
      setIsPaused(true);
    }

    const container = mountRef.current;
    if (!container) return;

    const width = container.clientWidth || 320;
    const height = container.clientHeight || 240;

    // 1. Scene & Camera
    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(40, width / height, 0.1, 100);
    camera.position.set(0, 0, 7.5);

    // 2. Renderer dengan optimasi baterai dan anti-aliasing
    const renderer = new THREE.WebGLRenderer({
      alpha: true,
      antialias: true,
      powerPreference: 'low-power',
    });
    renderer.setSize(width, height);
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
    container.appendChild(renderer.domElement);

    // 3. Pencahayaan lembut (tidak menyilaukan)
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.85);
    scene.add(ambientLight);

    const dirLight1 = new THREE.DirectionalLight(0xffffff, 1.2);
    dirLight1.position.set(5, 8, 6);
    scene.add(dirLight1);

    const dirLight2 = new THREE.DirectionalLight(0x959ec9, 0.6);
    dirLight2.position.set(-5, -4, 4);
    scene.add(dirLight2);

    // 4. Pembantu Geometri Roda Gigi 3D
    function createGearMesh(teeth: number, outerRadius: number, innerRadius: number, depth: number, colorHex: number) {
      const shape = new THREE.Shape();
      const toothDepth = outerRadius - innerRadius;
      const anglePerTooth = (Math.PI * 2) / teeth;

      for (let i = 0; i < teeth; i++) {
        const a = i * anglePerTooth;
        const a1 = a;
        const a2 = a + anglePerTooth * 0.25;
        const a3 = a + anglePerTooth * 0.55;
        const a4 = a + anglePerTooth * 0.8;

        if (i === 0) {
          shape.moveTo(Math.cos(a1) * innerRadius, Math.sin(a1) * innerRadius);
        } else {
          shape.lineTo(Math.cos(a1) * innerRadius, Math.sin(a1) * innerRadius);
        }

        // Puncak gigi roda
        shape.lineTo(Math.cos(a2) * (innerRadius + toothDepth), Math.sin(a2) * (innerRadius + toothDepth));
        shape.lineTo(Math.cos(a3) * (innerRadius + toothDepth), Math.sin(a3) * (innerRadius + toothDepth));
        // Lembah gigi roda
        shape.lineTo(Math.cos(a4) * innerRadius, Math.sin(a4) * innerRadius);
      }
      shape.closePath();

      // Lubang poros tengah
      const holePath = new THREE.Path();
      const holeRadius = innerRadius * 0.38;
      holePath.absarc(0, 0, holeRadius, 0, Math.PI * 2, true);
      shape.holes.push(holePath);

      // Lubang ventilasi ringan roda gigi klasik (3 lubang simetris)
      const ventCount = teeth >= 12 ? 3 : 0;
      if (ventCount > 0) {
        const ventRadius = innerRadius * 0.16;
        const ventDist = innerRadius * 0.68;
        for (let v = 0; v < ventCount; v++) {
          const vAngle = (v * (Math.PI * 2)) / ventCount;
          const vPath = new THREE.Path();
          vPath.absarc(Math.cos(vAngle) * ventDist, Math.sin(vAngle) * ventDist, ventRadius, 0, Math.PI * 2, true);
          shape.holes.push(vPath);
        }
      }

      const extrudeSettings = {
        depth,
        bevelEnabled: true,
        bevelSegments: 2,
        steps: 1,
        bevelSize: 0.04,
        bevelThickness: 0.04,
      };

      const geometry = new THREE.ExtrudeGeometry(shape, extrudeSettings);
      geometry.center();

      const material = new THREE.MeshStandardMaterial({
        color: colorHex,
        metalness: 0.25,
        roughness: 0.45,
      });

      return new THREE.Mesh(geometry, material);
    }

    // Buat 3 roda gigi yang saling terhubung (representing: Warga - Disposisi - Eksekusi OPD)
    const gearGroup = new THREE.Group();

    // Roda gigi utama (DPUPR & OPD - Crimson #A40033)
    const gearMain = createGearMesh(14, 1.5, 1.18, 0.28, 0xa40033);
    gearMain.position.set(-0.85, 0.15, 0);
    gearGroup.add(gearMain);

    // Roda gigi sekunder (Sistem Verifikasi - Navy/Slate #4E5174)
    const gearSec = createGearMesh(10, 1.08, 0.85, 0.24, 0x4e5174);
    gearSec.position.set(1.28, 0.72, 0.08);
    gearGroup.add(gearSec);

    // Roda gigi ketiga (Warga - Peri/Violet #959EC9)
    const gearTert = createGearMesh(8, 0.88, 0.68, 0.2, 0x959ec9);
    gearTert.position.set(1.15, -1.02, -0.05);
    gearGroup.add(gearTert);

    // Miringkan sedikit untuk sudut pandang isometrik ramah mata
    gearGroup.rotation.x = 0.28;
    gearGroup.rotation.y = -0.32;
    scene.add(gearGroup);

    // Interaktivitas mouse yang sangat halus (damping)
    let targetRotX = 0.28;
    let targetRotY = -0.32;
    let currentRotX = 0.28;
    let currentRotY = -0.32;

    const handleMouseMove = (e: MouseEvent) => {
      const rect = container.getBoundingClientRect();
      const x = ((e.clientX - rect.left) / rect.width) * 2 - 1;
      const y = -(((e.clientY - rect.top) / rect.height) * 2 - 1);
      // Sudut rotasi tilt dijaga sangat kecil (maks +- 0.15 rad) agar tidak membuat pusing
      targetRotX = 0.28 + y * 0.12;
      targetRotY = -0.32 + x * 0.15;
    };

    window.addEventListener('mousemove', handleMouseMove);

    // Handle Resize responsif
    const handleResize = () => {
      if (!container) return;
      const w = container.clientWidth;
      const h = container.clientHeight;
      if (w === 0 || h === 0) return;
      camera.aspect = w / h;
      camera.updateProjectionMatrix();
      renderer.setSize(w, h);
    };
    window.addEventListener('resize', handleResize);

    // Status jeda animasi
    let running = !motionQuery.matches;

    // IntersectionObserver agar berhenti saat discroll keluar layar
    let isVisible = true;
    const observer = new IntersectionObserver(
      (entries) => {
        isVisible = entries[0].isIntersecting;
      },
      { threshold: 0.05 }
    );
    observer.observe(container);

    let animationId = 0;
    const speed = 0.008; // Kecepatan pelan, nyaman dan tidak mengganggu fokus baca

    const animate = () => {
      animationId = requestAnimationFrame(animate);

      if (!running || !isVisible) {
        return;
      }

      // Rotasi roda gigi dengan rasio gigi
      gearMain.rotation.z += speed;
      gearSec.rotation.z -= speed * (14 / 10);
      gearTert.rotation.z += speed * (14 / 8) * 0.65;

      // Damping tilt mouse halus
      currentRotX += (targetRotX - currentRotX) * 0.05;
      currentRotY += (targetRotY - currentRotY) * 0.05;
      gearGroup.rotation.x = currentRotX;
      gearGroup.rotation.y = currentRotY;

      renderer.render(scene, camera);
    };

    animate();

    // Kontrol play/pause untuk aksesibilitas
    animRef.current = {
      pause: () => {
        running = false;
        setIsPaused(true);
      },
      resume: () => {
        running = true;
        setIsPaused(false);
      },
      toggle: () => {
        running = !running;
        setIsPaused(!running);
      },
      isPaused: () => !running,
    };

    return () => {
      window.removeEventListener('mousemove', handleMouseMove);
      window.removeEventListener('resize', handleResize);
      observer.disconnect();
      cancelAnimationFrame(animationId);
      if (container.contains(renderer.domElement)) {
        container.removeChild(renderer.domElement);
      }
      renderer.dispose();
    };
  }, []);

  const handleToggle = () => {
    if (animRef.current) {
      animRef.current.toggle();
    }
  };

  return (
    <div className={`relative flex items-center justify-center ${className}`}>
      {/* Container Kanvas WebGL Three.js */}
      <div
        ref={mountRef}
        className="w-full h-full min-h-[220px] select-none pointer-events-none"
        aria-hidden="true"
      />

      {/* Tombol Aksesibilitas: Jeda / Putar Animasi */}
      <div className="absolute bottom-2 right-2 z-10">
        <button
          type="button"
          onClick={handleToggle}
          title={isPaused ? 'Putar animasi 3D' : 'Jeda animasi 3D (ramah disabilitas visual)'}
          aria-label={isPaused ? 'Putar animasi roda gigi' : 'Jeda animasi roda gigi'}
          className="flex items-center gap-1.5 px-2.5 py-1 text-[11px] font-semibold text-white/80 bg-navy/80 hover:bg-navy backdrop-blur-sm rounded-lg border border-white/20 shadow-sm transition-all focus:outline-none focus:ring-2 focus:ring-crimson"
        >
          {isPaused ? (
            <>
              <Play className="w-3 h-3 text-emerald-400" />
              <span>Putar</span>
            </>
          ) : (
            <>
              <Pause className="w-3 h-3 text-amber-300" />
              <span>Jeda 3D</span>
            </>
          )}
        </button>
      </div>
    </div>
  );
}

