'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { YHColor } from '@/lib/constants/colors';
import { useState } from 'react';

export default function AppHeader() {
  const pathname = usePathname();
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  const navItems = [
    { label: '메인', path: '/' },
    { label: '블로그', path: '/blogs' },
  ];

  return (
    <header className="bg-white shadow-sm sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-5 md:px-16 py-4">
        <div className="flex items-center justify-between">
          {/* 로고 */}
          <Link href="/" className="flex items-center gap-3 group">
            <div
              className="p-2 rounded-xl transition-transform group-hover:scale-105"
              style={{
                background: `linear-gradient(135deg, ${YHColor.primary}, #8B5CF6)`,
              }}
            >
              <svg
                className="w-6 h-6 text-white"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"
                />
              </svg>
            </div>
            <span
              className="text-3xl font-black"
              style={{ color: YHColor.primary }}
            >
              YHLab
            </span>
          </Link>

          {/* 데스크톱 네비게이션 */}
          <nav className="hidden md:flex items-center gap-2">
            {navItems.map((item) => {
              const isSelected = pathname === item.path;
              return (
                <Link
                  key={item.path}
                  href={item.path}
                  className="px-6 py-3 rounded-lg font-medium transition-all"
                  style={{
                    backgroundColor: isSelected
                      ? `${YHColor.primary}14`
                      : 'transparent',
                    color: isSelected ? YHColor.primary : YHColor.textSub,
                    fontWeight: isSelected ? 700 : 500,
                  }}
                >
                  {item.label}
                </Link>
              );
            })}
          </nav>

          {/* 모바일 메뉴 버튼 */}
          <button
            className="md:hidden p-2"
            onClick={() => setIsMenuOpen(!isMenuOpen)}
          >
            <svg
              className="w-6 h-6"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M4 6h16M4 12h16M4 18h16"
              />
            </svg>
          </button>
        </div>

        {/* 모바일 메뉴 */}
        {isMenuOpen && (
          <nav className="md:hidden mt-4 pb-4 flex flex-col gap-2">
            {navItems.map((item) => {
              const isSelected = pathname === item.path;
              return (
                <Link
                  key={item.path}
                  href={item.path}
                  className="px-6 py-3 rounded-lg font-medium transition-all"
                  style={{
                    backgroundColor: isSelected
                      ? `${YHColor.primary}14`
                      : 'transparent',
                    color: isSelected ? YHColor.primary : YHColor.textSub,
                    fontWeight: isSelected ? 700 : 500,
                  }}
                  onClick={() => setIsMenuOpen(false)}
                >
                  {item.label}
                </Link>
              );
            })}
          </nav>
        )}
      </div>
    </header>
  );
}


