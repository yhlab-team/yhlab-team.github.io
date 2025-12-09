import Link from 'next/link';
import { allBlogPosts } from '@/lib/data/blog-posts';
import { YHColor } from '@/lib/constants/colors';
import { MdAutoGraph, MdMonetizationOn } from 'react-icons/md';
import { IconType } from 'react-icons';

export const metadata = {
  title: 'Nemo Library - 학습 과학과 Nemo의 이야기',
  description:
    '효율적인 학습법부터 실용적인 팁까지, 당신의 학습을 한 단계 업그레이드할 인사이트를 공유합니다.',
};

// 아이콘 맵핑
const iconMap: { [key: string]: IconType } = {
  auto_graph: MdAutoGraph,
  monetization_on: MdMonetizationOn,
};

export default function BlogListPage() {
  return (
    <div>
      {/* 헤더 섹션 */}
      <div
        className="w-full py-16 md:py-20 px-5 md:px-16"
        style={{
          background: `linear-gradient(135deg, ${YHColor.primary}0D, white)`,
        }}
      >
        <div className="max-w-4xl mx-auto">
          <div className="flex items-start gap-4 mb-5">
            <div
              className="p-3 rounded-xl"
              style={{ backgroundColor: `${YHColor.primary}1A` }}
            >
              <svg
                className="w-7 h-7 md:w-9 md:h-9"
                style={{ color: YHColor.primary }}
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
            <div>
              <h1
                className="text-4xl md:text-5xl font-black mb-5"
                style={{
                  background: `linear-gradient(135deg, ${YHColor.primary}, #8B5CF6)`,
                  WebkitBackgroundClip: 'text',
                  WebkitTextFillColor: 'transparent',
                }}
              >
                Nemo Library
              </h1>
            </div>
          </div>
          <div className="pl-1">
            <h2 className="text-xl md:text-2xl font-semibold mb-2 text-slate-700">
              학습 과학과 Nemo의 이야기
            </h2>
            <p className="text-sm md:text-base text-slate-600 leading-relaxed">
              효율적인 학습법부터 실용적인 팁까지, 당신의 학습을 한 단계
              업그레이드할 인사이트를 공유합니다.
            </p>
          </div>
        </div>
      </div>

      {/* 블로그 글 목록 */}
      <div className="py-10 md:py-16 px-5 md:px-16">
        <div className="max-w-4xl mx-auto space-y-8">
          {allBlogPosts.map((post) => (
            <Link
              key={post.id}
              href={`/blogs/${post.id}`}
              className="block"
            >
              <article className="bg-white rounded-2xl border border-slate-200 shadow-lg hover:shadow-xl transition-shadow p-6 md:p-8">
                <div className="flex items-start gap-4 mb-5">
                  <div
                    className="p-3 rounded-xl flex-shrink-0"
                    style={{
                      backgroundColor: `${YHColor.primary}1A`,
                    }}
                  >
                    {(() => {
                      const Icon = iconMap[post.icon];
                      return Icon ? (
                        <Icon
                          className="text-4xl"
                          style={{ color: YHColor.primary }}
                        />
                      ) : (
                        <span className="text-3xl">📝</span>
                      );
                    })()}
                  </div>
                  <div className="flex-1">
                    <h2
                      className="text-2xl md:text-3xl font-black mb-2 leading-tight"
                      style={{ color: YHColor.textDefault }}
                    >
                      {post.title}
                    </h2>
                    <p
                      className="text-sm md:text-base font-medium"
                      style={{ color: YHColor.textSub }}
                    >
                      {post.subtitle}
                    </p>
                  </div>
                </div>

                <p
                  className="text-base mb-5 leading-relaxed line-clamp-3"
                  style={{ color: '#475569' }}
                >
                  {post.excerpt}
                </p>

                {/* 태그 */}
                <div className="flex flex-wrap gap-2 mb-4">
                  {post.tags.map((tag) => (
                    <span
                      key={tag}
                      className="px-3 py-1 rounded-md text-sm font-semibold"
                      style={{
                        backgroundColor: `${YHColor.primary}1A`,
                        color: YHColor.primary,
                      }}
                    >
                      {tag}
                    </span>
                  ))}
                </div>

                {/* 메타 정보 */}
                <div className="flex items-center gap-4 text-sm text-slate-500">
                  <span className="flex items-center gap-1">
                    <svg
                      className="w-4 h-4"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <rect
                        x="3"
                        y="4"
                        width="18"
                        height="18"
                        rx="2"
                        ry="2"
                        strokeWidth={2}
                        strokeLinecap="round"
                        strokeLinejoin="round"
                      />
                      <line
                        x1="16"
                        y1="2"
                        x2="16"
                        y2="6"
                        strokeWidth={2}
                        strokeLinecap="round"
                      />
                      <line
                        x1="8"
                        y1="2"
                        x2="8"
                        y2="6"
                        strokeWidth={2}
                        strokeLinecap="round"
                      />
                      <line
                        x1="3"
                        y1="10"
                        x2="21"
                        y2="10"
                        strokeWidth={2}
                        strokeLinecap="round"
                      />
                    </svg>
                    {post.date}
                  </span>
                  <span className="flex items-center gap-1">
                    <svg
                      className="w-4 h-4"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <circle
                        cx="12"
                        cy="12"
                        r="10"
                        strokeWidth={2}
                        strokeLinecap="round"
                      />
                      <polyline
                        points="12 6 12 12 16 14"
                        strokeWidth={2}
                        strokeLinecap="round"
                        strokeLinejoin="round"
                      />
                    </svg>
                    {post.readTime} 읽기
                  </span>
                  <span
                    className="ml-auto flex items-center gap-1 font-semibold"
                    style={{ color: YHColor.primary }}
                  >
                    자세히 보기
                    <svg
                      className="w-4 h-4"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth={2}
                        d="M9 5l7 7-7 7"
                      />
                    </svg>
                  </span>
                </div>
              </article>
            </Link>
          ))}
        </div>
      </div>
    </div>
  );
}


