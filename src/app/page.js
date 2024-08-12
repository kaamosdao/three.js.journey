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
  // const raf = useMemo(
  //   () => ({
  //     time: 0,
  //   }),
  //   []
  // );

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
    const handleFullscreen = () => {
      const fullscreenElement =
        document.fullscreenElement || document.webkitFullscreenElement;

      if (!fullscreenElement) {
        if (canvasRef.current.requestFullscreen) {
          canvasRef.current.requestFullscreen();
        } else if (canvasRef.current.webkitRequestFullscreen) {
          canvasRef.current.webkitRequestFullscreen();
        }
      } else {
        if (document.exitFullscreen) {
          document.exitFullscreen();
        } else if (document.webkitExitFullscreen) {
          document.webkitExitFullscreen();
        }
      }
    };
    window.addEventListener('dblclick', handleFullscreen);

    return () => {
      window.removeEventListener('dblclick', handleFullscreen);
    };
  }, []);

  useEffect(() => {
    const scene = new THREE.Scene();
    cameraRef.current = new THREE.PerspectiveCamera(
      75,
      window.innerWidth / window.innerHeight,
      0.1,
      1000
    );

    const geometry = new THREE.BoxGeometry(1, 1, 1);
    const material = new THREE.MeshBasicMaterial({ color: 0xff0000 });
    const mesh = new THREE.Mesh(geometry, material);
    scene.add(mesh);

    cameraRef.current.position.z = 3;
    cameraRef.current.position.y = 2;
    cameraRef.current.lookAt(mesh.position);

    renderRef.current = new THREE.WebGLRenderer({
      canvas: canvasRef.current,
    });
    renderRef.current.setSize(window.innerWidth, window.innerHeight);
    renderRef.current.setPixelRatio(Math.min(window.devicePixelRatio, 2));

    const clock = new THREE.Clock();
    const controls = new OrbitControls(cameraRef.current, canvasRef.current);
    controls.update();

    function animate() {
      // const currentTime = performance.now();
      // const delta = currentTime - raf.time;
      // raf.time = currentTime;
      const delta = clock.getElapsedTime();

      // mesh.rotation.y += 0.001 * delta;
      mesh.rotation.y = delta;
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
