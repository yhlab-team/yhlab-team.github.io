import { YHColor } from '@/lib/constants/colors';

export default function DeveloperCommentSection() {
  return (
    <section className="py-16 md:py-20 px-5 md:px-16">
      <div className="max-w-lg mx-auto">
        <div
          className="rounded-2xl shadow-lg p-8 md:p-16"
          style={{
            backgroundColor: '#F8FAFC',
          }}
        >
          <div className="text-center">
            {/* 인용 아이콘 */}
            <svg
              className="w-10 h-10 md:w-14 md:h-14 mx-auto mb-6"
              style={{ color: `${YHColor.primary}4C` }}
              fill="currentColor"
              viewBox="0 0 24 24"
            >
              <path d="M14.017 21v-7.391c0-5.704 3.731-9.57 8.983-10.609l.995 2.151c-2.432.917-3.995 3.638-3.995 5.849h4v10h-9.983zm-14.017 0v-7.391c0-5.704 3.748-9.57 9-10.609l.996 2.151c-2.433.917-3.996 3.638-3.996 5.849h3.983v10h-9.983z" />
            </svg>

            {/* 제목 */}
            <h3
              className="text-xl md:text-2xl font-bold mb-6"
              style={{ color: YHColor.primary }}
            >
              개발자 코멘트
            </h3>

            {/* 내용 */}
            <p
              className="text-base md:text-lg leading-relaxed whitespace-pre-line"
              style={{ color: '#475569' }}
            >
              {`사람은 끝없이 망각합니다.

자격증 취득, 면접 준비, 세미나 준비 등
수 년 전 학습한 것을
다시 공부한 적 없으신가요?

죽을때 까지 공부할텐데..
장기기억 형성의 필요성을 느껴
편리한 복습을 위해 만들었습니다.`}
            </p>
          </div>
        </div>
      </div>
    </section>
  );
}


