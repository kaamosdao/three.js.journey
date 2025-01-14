'use client';

import { useRef, useEffect, useMemo, useCallback } from 'react';
import clsx from 'clsx';
import * as THREE from 'three';
import { OrbitControls } from 'three/addons/controls/OrbitControls.js';

import testVertexShader from 'shaders/patterns/vertex.glsl';
import testFragmentShader from 'shaders/patterns/fragment.glsl';

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

    const geometry = new THREE.PlaneGeometry(1, 1, 32, 32);

    const material = new THREE.ShaderMaterial({
      vertexShader: testVertexShader,
      fragmentShader: testFragmentShader,
      side: THREE.DoubleSide,
      uniforms: {
        uTime: { value: 0 },
      },
    });

    const mesh = new THREE.Mesh(geometry, material);

    scene.add(mesh);

    cameraRef.current.position.z = 1.5;
    cameraRef.current.lookAt(mesh.position);

    renderRef.current = new THREE.WebGLRenderer({
      canvas: canvasRef.current,
    });
    renderRef.current.setSize(window.innerWidth, window.innerHeight);
    renderRef.current.setPixelRatio(Math.min(window.devicePixelRatio, 2));

    const controls = new OrbitControls(cameraRef.current, canvasRef.current);
    controls.update();

    const clock = new THREE.Clock();

    function animate() {
      const delta = clock.getElapsedTime();

      renderRef.current.render(scene, cameraRef.current);
      material.uniforms.uTime.value = delta;
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
