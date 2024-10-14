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
    size: 0.003,
    particlesCount: 20000,
    radius: 2,
    branches: 3,
    spin: 3,
    randomness: 1,
    randomnessPower: 6,
    innerColor: '#e170d2',
    outerColor: '#089df6',
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

      /**
       * POSITIONS
       */

      const positions = new Float32Array(parameters.current.particlesCount * 3);
      const colors = new Float32Array(parameters.current.particlesCount * 3);

      for (let i = 0; i < parameters.current.particlesCount * 3; i++) {
        const i3 = i * 3;
        const radius = Math.random() * parameters.current.radius;
        const angle =
          ((i % parameters.current.branches) / parameters.current.branches) *
          2 *
          Math.PI;
        const spinAngle = parameters.current.spin * radius;

        const randomX =
          Math.pow(Math.random(), parameters.current.randomnessPower) *
          (Math.random() < 0.5 ? -1 : 1) *
          parameters.current.randomness *
          radius;

        const randomY =
          Math.pow(Math.random(), parameters.current.randomnessPower) *
          (Math.random() < 0.5 ? -1 : 1) *
          parameters.current.randomness *
          radius;

        const randomZ =
          Math.pow(Math.random(), parameters.current.randomnessPower) *
          (Math.random() < 0.5 ? -1 : 1) *
          parameters.current.randomness *
          radius;

        positions[i3] = Math.cos(angle + spinAngle) * radius + randomX;
        positions[i3 + 1] = randomY;
        positions[i3 + 2] = Math.sin(angle + spinAngle) * radius + randomZ;

        const innerColor = new THREE.Color(parameters.current.innerColor);
        const outerColor = new THREE.Color(parameters.current.outerColor);

        const mixedColor = innerColor.clone();
        mixedColor.lerp(outerColor, radius / parameters.current.radius);

        colors[i3] = mixedColor.r;
        colors[i3 + 1] = mixedColor.g;
        colors[i3 + 2] = mixedColor.b;
      }

      geometry.setAttribute(
        'position',
        new THREE.BufferAttribute(positions, 3)
      );
      geometry.setAttribute('color', new THREE.BufferAttribute(colors, 3));

      material = new THREE.PointsMaterial({
        size: parameters.current.size,
        sizeAttenuation: true,
        depthWrite: false,
        blending: THREE.AdditiveBlending,
        vertexColors: true,
      });

      particles = new THREE.Points(geometry, material);

      scene.add(particles);
    };

    /**
     * GUI
     */

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
      .max(0.01)
      .step(0.001)
      .onFinishChange(generateGalaxy);
    gui
      .add(parameters.current, 'radius')
      .min(1)
      .max(5)
      .step(0.1)
      .onFinishChange(generateGalaxy);
    gui
      .add(parameters.current, 'branches')
      .min(2)
      .max(10)
      .step(1)
      .onFinishChange(generateGalaxy);
    gui
      .add(parameters.current, 'spin')
      .min(-5)
      .max(5)
      .step(0.001)
      .onFinishChange(generateGalaxy);
    gui
      .add(parameters.current, 'randomness')
      .min(0)
      .max(2)
      .step(0.001)
      .onFinishChange(generateGalaxy);
    gui
      .add(parameters.current, 'randomnessPower')
      .min(1)
      .max(10)
      .step(0.001)
      .onFinishChange(generateGalaxy);
    gui
      .addColor(parameters.current, 'innerColor')
      .onFinishChange(generateGalaxy);
    gui
      .addColor(parameters.current, 'outerColor')
      .onFinishChange(generateGalaxy);

    generateGalaxy();

    cameraRef.current.position.z = 2;
    cameraRef.current.position.y = 2;
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
