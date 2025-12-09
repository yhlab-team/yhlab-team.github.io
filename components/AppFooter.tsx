import { YHColor } from '@/lib/constants/colors';

export default function AppFooter() {
  return (
    <footer className="bg-slate-900 text-slate-400 py-10 px-5">
      <div className="max-w-7xl mx-auto text-center">
        <p className="text-sm mb-4">
          © 2024 YHLab. All rights reserved.
        </p>
        <p className="text-xs" style={{ color: YHColor.textSub }}>
          AI로 교육을 혁신하겠습니다
        </p>
      </div>
    </footer>
  );
}


