'use client';

import { useRef, useEffect, useMemo, useCallback } from 'react';
import clsx from 'clsx';
import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';

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

  useEffect(() => {
    const scene = new THREE.Scene();
    cameraRef.current = new THREE.PerspectiveCamera(
      75,
      window.innerWidth / window.innerHeight,
      0.1,
      1000
    );

    const geometry = new THREE.BufferGeometry();
    const count = 1000;
    const positions = new Float32Array(count * 3);
    const colors = new Float32Array(count * 3);

    for (let index = 0; index < count * 3; index++) {
      positions[index] = (Math.random() - 0.5) * 10;
      colors[index] = Math.random();
    }

    geometry.setAttribute('position', new THREE.BufferAttribute(positions, 3));
    geometry.setAttribute('color', new THREE.BufferAttribute(colors, 3));

    const textureLoader = new THREE.TextureLoader();
    const texture = textureLoader.load('/particles/star-0.jpg');

    const material = new THREE.PointsMaterial({
      size: 0.3,
      // color: 0x089df6,
      alphaMap: texture,
      transparent: true,
      blending: THREE.AdditiveBlending,
      vertexColors: true,
    });
    // material.alphaTest = 0.001;
    // material.depthTest = false;
    material.depthWrite = false;

    const particles = new THREE.Points(geometry, material);

    scene.add(particles);

    cameraRef.current.position.z = 3;
    cameraRef.current.position.y = 2;
    cameraRef.current.lookAt(particles.position);

    renderRef.current = new THREE.WebGLRenderer({
      canvas: canvasRef.current,
    });
    renderRef.current.setSize(window.innerWidth, window.innerHeight);
    renderRef.current.setPixelRatio(Math.min(window.devicePixelRatio, 2));

    const clock = new THREE.Clock();
    const controls = new OrbitControls(cameraRef.current, canvasRef.current);
    controls.update();

    function animate() {
      // const elapsedTime = clock.getElapsedTime();
      //
      // for (let index = 0; index < count; index++) {
      // const i3 = index * 3;
      // geometry.attributes.position.array[i3 + 1] = Math.sin(
      // elapsedTime + geometry.attributes.position.array[i3]
      // );
      // }
      // geometry.attributes.position.needsUpdate = true;
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
