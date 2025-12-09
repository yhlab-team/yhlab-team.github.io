'use client';

import { useEffect, useRef } from 'react';
import { YHColor } from '@/lib/constants/colors';

export default function WaveHeader() {
  const canvasRef = useRef<HTMLCanvasElement>(null);

  useEffect(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    let animationId: number;
    let offset = 0;

    const animate = () => {
      const width = canvas.width;
      const height = canvas.height;

      ctx.clearRect(0, 0, width, height);

      // 첫 번째 물결
      ctx.fillStyle = `${YHColor.primary}26`;
      ctx.beginPath();
      ctx.moveTo(0, height * 0.5);
      
      for (let x = 0; x < width; x++) {
        const y = height * 0.5 + Math.sin((x + offset) * 0.01) * 30;
        ctx.lineTo(x, y);
      }
      
      ctx.lineTo(width, 0);
      ctx.lineTo(0, 0);
      ctx.closePath();
      ctx.fill();

      // 두 번째 물결
      ctx.fillStyle = `${YHColor.primary}33`;
      ctx.beginPath();
      ctx.moveTo(0, height * 0.6);
      
      for (let x = 0; x < width; x++) {
        const y = height * 0.6 + Math.sin((x - offset * 0.7) * 0.015) * 25;
        ctx.lineTo(x, y);
      }
      
      ctx.lineTo(width, 0);
      ctx.lineTo(0, 0);
      ctx.closePath();
      ctx.fill();

      offset += 2;
      animationId = requestAnimationFrame(animate);
    };

    const handleResize = () => {
      canvas.width = canvas.offsetWidth;
      canvas.height = canvas.offsetHeight;
    };

    handleResize();
    window.addEventListener('resize', handleResize);
    animate();

    return () => {
      window.removeEventListener('resize', handleResize);
      cancelAnimationFrame(animationId);
    };
  }, []);

  return (
    <div className="w-full h-32 md:h-40 relative">
      <canvas
        ref={canvasRef}
        className="w-full h-full"
        style={{ display: 'block' }}
      />
      <div
        className="absolute inset-0 pointer-events-none"
        style={{
          background: `linear-gradient(to bottom, ${YHColor.primary}1A, transparent)`,
        }}
      />
    </div>
  );
}


