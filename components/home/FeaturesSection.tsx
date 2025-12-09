import { YHColor } from '@/lib/constants/colors';
import {
  MdAutoAwesome,
  MdPsychology,
  MdCardGiftcard,
  MdShuffle,
  MdStyle,
  MdShare,
  MdMoreHoriz,
} from 'react-icons/md';
import { IconType } from 'react-icons';

interface Feature {
  icon: IconType;
  title: string;
  description: string;
}

const features: Feature[] = [
  {
    icon: MdAutoAwesome,
    title: 'AI 활용 학습',
    description: '학습 자료를 분석해, 노트와 카드를 자동 생성할 수 있습니다',
  },
  {
    icon: MdPsychology,
    title: '자동 장기기억 형성',
    description: '에빙하우스 망각곡선을 기반. 복습 주기에 맞게 학습을 추천해드립니다',
  },
  {
    icon: MdCardGiftcard,
    title: '리워드 & 앱테크',
    description: '출석, 학습, 광고 시청 등 꾸준한 유저분들과의 공생을 위한 리워드 기능',
  },
  {
    icon: MdShuffle,
    title: '메타인지 학습',
    description: '여러 정답·오답을 랜덤 제출, 답 위치 자동 셔플로 정확한 학습 확인',
  },
  {
    icon: MdStyle,
    title: '다양한 학습 방식',
    description: '플래시카드, 문제카드(객관식/주관식), 암기 모드, 시험 모드 지원',
  },
  {
    icon: MdShare,
    title: '노트 공유',
    description: '노트를 다른 유저와 공유하거나, 엑셀 추출/가져오기 가능',
  },
  {
    icon: MdMoreHoriz,
    title: '기본 기능 완비',
    description: 'TTS, 오답노트, 북마크, 다크모드, 아이패드 스플릿뷰 등',
  },
];

export default function FeaturesSection() {
  return (
    <section className="py-16 md:py-24 px-5 md:px-16">
      <div className="max-w-6xl mx-auto">
        {/* 헤더 */}
        <div className="text-center mb-16">
          <div
            className="inline-block px-4 py-2 rounded-full mb-6"
            style={{ backgroundColor: `${YHColor.primary}0D` }}
          >
            <span
              className="text-lg font-bold"
              style={{ color: YHColor.primary }}
            >
              Nemo가 특별한 이유
            </span>
          </div>
          <h2
            className="text-3xl md:text-5xl font-black leading-tight"
            style={{ color: YHColor.textDefault }}
          >
            효과적인 학습을 위한 모든 것
          </h2>
        </div>

        {/* 기능 카드 그리드 */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {features.map((feature, index) => {
            const Icon = feature.icon;
            return (
              <div
                key={index}
                className="p-8 rounded-2xl border-2 border-slate-200 bg-white shadow-lg hover:shadow-xl transition-shadow"
              >
                <div
                  className="w-16 h-16 rounded-2xl flex items-center justify-center mb-5"
                  style={{ backgroundColor: `${YHColor.primary}1A` }}
                >
                  <Icon
                    className="text-4xl"
                    style={{ color: YHColor.primary }}
                  />
                </div>
                <h3
                  className="text-xl font-bold mb-3"
                  style={{ color: YHColor.textDefault }}
                >
                  {feature.title}
                </h3>
                <p
                  className="text-base leading-relaxed"
                  style={{ color: YHColor.textSub }}
                >
                  {feature.description}
                </p>
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}


