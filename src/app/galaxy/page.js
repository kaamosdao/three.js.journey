'use client';

import { useRef, useEffect, useMemo, useCallback } from 'react';
import clsx from 'clsx';
import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';
import * as dat from 'dat.gui';

import s from './page.module.scss';

export default function Home() {
  const canvasRef = useRef();
  const renderRef = useRef();
  const cameraRef = useRef();

  const sizes = useMemo(
    () => ({
      width: 0,
      height: 0,
    }),
    []
  );

  useEffect(() => {
    const handleSizes = () => {
      sizes.width = window.innerWidth;
      sizes.height = window.innerHeight;

      renderRef.current?.setSize(sizes.width, sizes.height);
      cameraRef.current.aspect = sizes.width / sizes.height;
      cameraRef.current?.updateProjectionMatrix();
    };

    window.addEventListener('resize', handleSizes);

    return () => {
      window.removeEventListener('resize', handleSizes);
    };
  }, [sizes]);

  const parameters = useRef({
    size: 0.1,
    particlesCount: 1000,
  });

  useEffect(() => {
    const scene = new THREE.Scene();
    cameraRef.current = new THREE.PerspectiveCamera(
      75,
      window.innerWidth / window.innerHeight,
      0.1,
      1000
    );

    let geometry = null;
    let material = null;
    let particles = null;

    const generateGalaxy = () => {
      if (particles !== null) {
        geometry.dispose();
        material.dispose();
        scene.remove(particles);
      }
      geometry = new THREE.BufferGeometry();
      const positions = new Float32Array(parameters.current.particlesCount * 3);

      for (let i = 0; i < parameters.current.particlesCount * 3; i++) {
        positions[i] = (Math.random() - 0.5) * 10;
      }

      geometry.setAttribute(
        'position',
        new THREE.BufferAttribute(positions, 3)
      );

      material = new THREE.PointsMaterial({
        size: parameters.current.size,
        color: 0x089df6,
        sizeAttenuation: true,
        depthWrite: false,
        blending: THREE.AdditiveBlending,
      });

      particles = new THREE.Points(geometry, material);

      scene.add(particles);
    };

    const gui = new dat.GUI();
    gui
      .add(parameters.current, 'particlesCount')
      .min(100)
      .max(100000)
      .step(100)
      .onFinishChange(generateGalaxy);
    gui
      .add(parameters.current, 'size')
      .min(0.001)
      .max(0.1)
      .step(0.001)
      .onFinishChange(generateGalaxy);

    generateGalaxy();

    cameraRef.current.position.z = 10;
    cameraRef.current.position.y = 10;
    cameraRef.current.lookAt(particles.position);

    renderRef.current = new THREE.WebGLRenderer({
      canvas: canvasRef.current,
    });
    renderRef.current.setSize(window.innerWidth, window.innerHeight);
    renderRef.current.setPixelRatio(Math.min(window.devicePixelRatio, 2));

    const controls = new OrbitControls(cameraRef.current, canvasRef.current);
    controls.update();

    function animate() {
      renderRef.current.render(scene, cameraRef.current);
      controls.update();
    }

    renderRef.current.setAnimationLoop(animate);
  }, []);

  return (
    <main>
      <canvas
        ref={canvasRef}
        className={clsx('canvas', s.canvas)}
      />
    </main>
  );
}
