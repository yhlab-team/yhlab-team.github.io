export default function DownloadSection() {
  return (
    <section className="py-20 md:py-28 px-5 md:px-16">
      <div className="max-w-4xl mx-auto text-center">
        <h2 className="text-3xl md:text-4xl font-black mb-4 text-slate-900">
          지금 바로 시작해야 더 많이 기억할 수 있어요
        </h2>
        <p className="text-base md:text-xl text-slate-600 mb-16">
          iOS와 Android에서 무료로 다운로드
        </p>

        {/* 다운로드 버튼 */}
        <div className="flex flex-col md:flex-row gap-5 justify-center items-center">
          <a
            href="https://apps.apple.com/app/id1547183996"
            target="_blank"
            rel="noopener noreferrer"
            className="w-full md:w-80 bg-black text-white px-8 py-6 rounded-2xl font-bold text-base flex items-center justify-center gap-3 hover:bg-gray-800 transition-colors shadow-lg"
          >
            <svg className="w-7 h-7" fill="currentColor" viewBox="0 0 24 24">
              <path d="M17.05 20.28c-.98.95-2.05.8-3.08.35-1.09-.46-2.09-.48-3.24 0-1.44.62-2.2.44-3.06-.35C2.79 15.25 3.51 7.59 9.05 7.31c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.38 5.98.48 7.13-.57 1.5-1.31 2.99-2.54 4.09l.01-.01zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z" />
            </svg>
            App Store에서 다운로드
          </a>

          <a
            href="https://play.google.com/store/apps/details?id=com.Nemo.ParkYoungHo"
            target="_blank"
            rel="noopener noreferrer"
            className="w-full md:w-80 bg-green-500 text-white px-8 py-6 rounded-2xl font-bold text-base flex items-center justify-center gap-3 hover:bg-green-600 transition-colors shadow-lg"
          >
            <svg className="w-7 h-7" fill="currentColor" viewBox="0 0 24 24">
              <path d="M3.609 1.814L13.792 12 3.61 22.186a.996.996 0 0 1-.61-.92V2.734a1 1 0 0 1 .609-.92zm10.89 10.893l2.302 2.302-10.937 6.333 8.635-8.635zm3.199-3.198l2.807 1.626a1 1 0 0 1 0 1.73l-2.808 1.626L15.206 12l2.492-2.491zM5.864 2.658L16.802 8.99l-2.303 2.303-8.635-8.635z" />
            </svg>
            Google Play에서 다운로드
          </a>
        </div>
      </div>
    </section>
  );
}


