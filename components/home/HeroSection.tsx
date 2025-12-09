import Image from 'next/image';
import { YHColor } from '@/lib/constants/colors';

export default function HeroSection() {
  return (
    <section className="py-10 px-5 md:px-16">
      <div className="max-w-4xl mx-auto text-center">
        {/* Nemo 아이콘 */}
        <div className="flex justify-center mb-10">
          <div className="w-28 h-28 md:w-36 md:h-36 rounded-3xl shadow-2xl overflow-hidden bg-white">
            <Image
              src="/assets/images/nemo_icon.png"
              alt="Nemo Icon"
              width={140}
              height={140}
              className="w-full h-full object-cover"
            />
          </div>
        </div>

        {/* 타이틀 */}
        <h1
          className="text-5xl md:text-7xl font-black mb-4"
          style={{ color: YHColor.textDefault }}
        >
          Nemo
        </h1>
        <p
          className="text-base md:text-xl mb-7"
          style={{ color: YHColor.textSub }}
        >
          Note + Memo
        </p>

        {/* 메인 카피 */}
        <h2
          className="text-2xl md:text-3xl font-black mb-4"
          style={{ color: YHColor.textDefault }}
        >
          📌📑 학습부터 장기기억, 💰 앱테크까지
        </h2>
        <p
          className="text-base md:text-xl"
          style={{ color: YHColor.textDefault }}
        >
          평생 공부시대의 든든한 파트너!
        </p>
      </div>
    </section>
  );
}


