'use client';

import { useEffect, useRef } from 'react';
import * as THREE from 'three';

export default function HeroScene3D() {
  const containerRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const container = containerRef.current;
    if (!container) return;

    /* ── Setup ── */
    const w = container.clientWidth;
    const h = container.clientHeight;

    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(45, w / h, 0.1, 100);
    camera.position.set(0, 0, 5.5);

    const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true });
    renderer.setSize(w, h);
    renderer.setPixelRatio(Math.min(window.devicePixelRatio, 1.5));
    container.appendChild(renderer.domElement);

    /* ── Lights ── */
    scene.add(new THREE.AmbientLight(0xe8e5f4, 0.5));
    const dirLight = new THREE.DirectionalLight(0xe8e5f4, 0.8);
    dirLight.position.set(5, 5, 5);
    scene.add(dirLight);
    const pointLight = new THREE.PointLight(0xa40033, 0.6, 20);
    pointLight.position.set(-3, -2, 2);
    scene.add(pointLight);

    /* ── Icosahedron (globe) ── */
    const icoGeo = new THREE.IcosahedronGeometry(1.5, 4);
    const icoMat = new THREE.MeshStandardMaterial({
      color: 0x28264b,
      roughness: 0.3,
      metalness: 0.85,
      transparent: true,
      opacity: 0.5,
      wireframe: false,
    });
    const ico = new THREE.Mesh(icoGeo, icoMat);
    scene.add(ico);

    /* ── Wireframe overlay ── */
    const wireGeo = new THREE.IcosahedronGeometry(1.52, 2);
    const wireMat = new THREE.MeshBasicMaterial({
      color: 0x7b6fc4,
      wireframe: true,
      transparent: true,
      opacity: 0.15,
    });
    const wire = new THREE.Mesh(wireGeo, wireMat);
    scene.add(wire);

    /* ── Orbit rings ── */
    function makeRing(radius: number, color: number) {
      const geo = new THREE.TorusGeometry(radius, 0.012, 16, 120);
      const mat = new THREE.MeshBasicMaterial({ color, transparent: true, opacity: 0.3 });
      const mesh = new THREE.Mesh(geo, mat);
      mesh.rotation.x = Math.PI / 2.5;
      scene.add(mesh);
      return mesh;
    }
    const ring1 = makeRing(2.3, 0xa40033);
    const ring2 = makeRing(2.8, 0x7b6fc4);

    /* ── Particles ── */
    const PARTICLE_COUNT = 160;
    const pGeo = new THREE.BufferGeometry();
    const pPositions = new Float32Array(PARTICLE_COUNT * 3);
    const pColors = new Float32Array(PARTICLE_COUNT * 3);
    const palette = [
      new THREE.Color(0xa40033),
      new THREE.Color(0xc5c2d1),
      new THREE.Color(0x28264b),
      new THREE.Color(0x7b6fc4),
      new THREE.Color(0x059669),
    ];

    for (let i = 0; i < PARTICLE_COUNT; i++) {
      pPositions[i * 3] = (Math.random() - 0.5) * 10;
      pPositions[i * 3 + 1] = (Math.random() - 0.5) * 6;
      pPositions[i * 3 + 2] = (Math.random() - 0.5) * 6;
      const c = palette[Math.floor(Math.random() * palette.length)];
      pColors[i * 3] = c.r;
      pColors[i * 3 + 1] = c.g;
      pColors[i * 3 + 2] = c.b;
    }
    pGeo.setAttribute('position', new THREE.BufferAttribute(pPositions, 3));
    pGeo.setAttribute('color', new THREE.BufferAttribute(pColors, 3));

    const pMat = new THREE.PointsMaterial({
      size: 0.055,
      vertexColors: true,
      transparent: true,
      opacity: 0.85,
      sizeAttenuation: true,
    });
    const particles = new THREE.Points(pGeo, pMat);
    scene.add(particles);

    /* ── Mouse parallax ── */
    let mouseX = 0;
    let mouseY = 0;
    function onMouseMove(e: MouseEvent) {
      mouseX = (e.clientX / window.innerWidth - 0.5) * 2;
      mouseY = (e.clientY / window.innerHeight - 0.5) * 2;
    }
    window.addEventListener('mousemove', onMouseMove);

    /* ── Animate ── */
    const clock = new THREE.Clock();
    let animId = 0;

    function animate() {
      animId = requestAnimationFrame(animate);
      const t = clock.getElapsedTime();

      // Globe rotation
      ico.rotation.y = t * 0.15;
      ico.rotation.z = Math.sin(t * 0.3) * 0.1;
      wire.rotation.y = t * 0.12;
      wire.rotation.z = Math.sin(t * 0.25) * 0.08;

      // Float effect
      ico.position.y = Math.sin(t * 0.8) * 0.15;
      wire.position.y = ico.position.y;

      // Rings
      ring1.rotation.z = t * 0.08;
      ring1.rotation.x = Math.PI / 2.5 + Math.sin(t * 0.4) * 0.12;
      ring2.rotation.z = -t * 0.06;
      ring2.rotation.x = Math.PI / 2.8 + Math.cos(t * 0.35) * 0.1;

      // Particles slow rotation
      particles.rotation.y = t * 0.025;
      particles.rotation.x = t * 0.008;

      // Camera parallax
      camera.position.x += (mouseX * 0.3 - camera.position.x) * 0.02;
      camera.position.y += (-mouseY * 0.3 - camera.position.y) * 0.02;
      camera.lookAt(0, 0, 0);

      renderer.render(scene, camera);
    }
    animate();

    /* ── Resize ── */
    function onResize() {
      if (!container) return;
      const nw = container.clientWidth;
      const nh = container.clientHeight;
      camera.aspect = nw / nh;
      camera.updateProjectionMatrix();
      renderer.setSize(nw, nh);
    }
    window.addEventListener('resize', onResize);

    /* ── Cleanup ── */
    return () => {
      cancelAnimationFrame(animId);
      window.removeEventListener('mousemove', onMouseMove);
      window.removeEventListener('resize', onResize);
      renderer.dispose();
      icoGeo.dispose();
      icoMat.dispose();
      wireGeo.dispose();
      wireMat.dispose();
      pGeo.dispose();
      pMat.dispose();
      if (container.contains(renderer.domElement)) {
        container.removeChild(renderer.domElement);
      }
    };
  }, []);

  return (
    <div
      ref={containerRef}
      className="pointer-events-none absolute inset-0 z-0"
      aria-hidden="true"
      style={{ opacity: 0.85 }}
    />
  );
}
