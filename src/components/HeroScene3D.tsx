'use client';

import { useRef, useMemo, Suspense } from 'react';
import { Canvas, useFrame } from '@react-three/fiber';
import { Float, MeshDistortMaterial } from '@react-three/drei';
import * as THREE from 'three';

/* ── Partikel kecil melayang (titik-titik cahaya kota) ── */
function Particles({ count = 120 }: { count?: number }) {
  const mesh = useRef<THREE.Points>(null!);
  const positions = useMemo(() => {
    const arr = new Float32Array(count * 3);
    for (let i = 0; i < count; i++) {
      arr[i * 3] = (Math.random() - 0.5) * 10;
      arr[i * 3 + 1] = (Math.random() - 0.5) * 6;
      arr[i * 3 + 2] = (Math.random() - 0.5) * 6;
    }
    return arr;
  }, [count]);

  const colors = useMemo(() => {
    const arr = new Float32Array(count * 3);
    const palette = [
      new THREE.Color('#A40033'),  // crimson
      new THREE.Color('#C5C2D1'),  // silver
      new THREE.Color('#28264B'),  // navy
      new THREE.Color('#7B6FC4'),  // peri
      new THREE.Color('#059669'),  // emerald
    ];
    for (let i = 0; i < count; i++) {
      const c = palette[Math.floor(Math.random() * palette.length)];
      arr[i * 3] = c.r;
      arr[i * 3 + 1] = c.g;
      arr[i * 3 + 2] = c.b;
    }
    return arr;
  }, [count]);

  useFrame((_, delta) => {
    if (mesh.current) {
      mesh.current.rotation.y += delta * 0.03;
      mesh.current.rotation.x += delta * 0.01;
    }
  });

  return (
    <points ref={mesh}>
      <bufferGeometry>
        <bufferAttribute attach="attributes-position" count={count} array={positions} itemSize={3} />
        <bufferAttribute attach="attributes-color" count={count} array={colors} itemSize={3} />
      </bufferGeometry>
      <pointsMaterial size={0.06} vertexColors transparent opacity={0.85} sizeAttenuation />
    </points>
  );
}

/* ── Bola distorsi organik (simbol globe/smart city) ── */
function DistortSphere() {
  const mesh = useRef<THREE.Mesh>(null!);

  useFrame((state) => {
    if (mesh.current) {
      mesh.current.rotation.y = state.clock.elapsedTime * 0.15;
      mesh.current.rotation.z = Math.sin(state.clock.elapsedTime * 0.3) * 0.1;
    }
  });

  return (
    <Float speed={1.5} rotationIntensity={0.4} floatIntensity={0.6}>
      <mesh ref={mesh} scale={1.6}>
        <icosahedronGeometry args={[1, 8]} />
        <MeshDistortMaterial
          color="#28264B"
          roughness={0.3}
          metalness={0.8}
          distort={0.35}
          speed={2}
          transparent
          opacity={0.55}
        />
      </mesh>
    </Float>
  );
}

/* ── Ring orbit transparan ── */
function OrbitRing({ radius = 2.2, color = '#A40033' }: { radius?: number; color?: string }) {
  const ring = useRef<THREE.Mesh>(null!);
  useFrame((state) => {
    if (ring.current) {
      ring.current.rotation.x = Math.PI / 2.5 + Math.sin(state.clock.elapsedTime * 0.4) * 0.15;
      ring.current.rotation.z = state.clock.elapsedTime * 0.1;
    }
  });
  return (
    <mesh ref={ring}>
      <torusGeometry args={[radius, 0.012, 16, 100]} />
      <meshBasicMaterial color={color} transparent opacity={0.35} />
    </mesh>
  );
}

/* ── Scene utama ── */
function Scene() {
  return (
    <>
      <ambientLight intensity={0.4} />
      <directionalLight position={[5, 5, 5]} intensity={0.8} color="#E8E5F4" />
      <pointLight position={[-3, -2, 2]} intensity={0.5} color="#A40033" />
      <DistortSphere />
      <OrbitRing radius={2.4} color="#A40033" />
      <OrbitRing radius={2.9} color="#7B6FC4" />
      <Particles count={140} />
    </>
  );
}

export default function HeroScene3D() {
  return (
    <div
      className="pointer-events-none absolute inset-0 z-0"
      aria-hidden="true"
      style={{ opacity: 0.85 }}
    >
      <Suspense fallback={null}>
        <Canvas
          camera={{ position: [0, 0, 5.5], fov: 45 }}
          dpr={[1, 1.5]}
          gl={{ antialias: true, alpha: true }}
          style={{ background: 'transparent' }}
        >
          <Scene />
        </Canvas>
      </Suspense>
    </div>
  );
}
