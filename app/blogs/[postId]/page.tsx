import { notFound } from 'next/navigation';
import { allBlogPosts } from '@/lib/data/blog-posts';
import { YHColor } from '@/lib/constants/colors';
import Link from 'next/link';
import fs from 'fs';
import path from 'path';
import { MDXRemote } from 'next-mdx-remote/rsc';
import Image from 'next/image';
import { MdAutoGraph, MdMonetizationOn } from 'react-icons/md';
import { IconType } from 'react-icons';

// MDX 컴포넌트 정의
const components = {
  h1: (props: any) => (
    <h1
      className="text-3xl md:text-4xl font-black mb-6 mt-10"
      style={{ color: YHColor.textDefault }}
      {...props}
    />
  ),
  h2: (props: any) => (
    <h2
      className="text-2xl md:text-3xl font-black mb-4 mt-10"
      style={{ color: YHColor.textDefault }}
      {...props}
    />
  ),
  h3: (props: any) => (
    <h3
      className="text-xl md:text-2xl font-black mb-3 mt-8"
      style={{ color: YHColor.textDefault }}
      {...props}
    />
  ),
  p: (props: any) => (
    <p
      className="text-base md:text-lg leading-relaxed mb-6"
      style={{ color: '#334155' }}
      {...props}
    />
  ),
  ul: (props: any) => (
    <ul className="list-disc list-inside mb-6 space-y-2 ml-4" {...props} />
  ),
  li: (props: any) => (
    <li className="text-base md:text-lg" style={{ color: '#334155' }} {...props} />
  ),
  strong: (props: any) => (
    <strong className="font-bold" style={{ color: YHColor.textDefault }} {...props} />
  ),
  img: (props: any) => (
    <div className="my-8 rounded-xl overflow-hidden">
      <Image
        src={props.src}
        alt={props.alt || ''}
        width={800}
        height={600}
        className="w-full h-auto"
      />
      {props.alt && (
        <p className="text-center text-sm text-slate-500 mt-3 italic">
          {props.alt}
        </p>
      )}
    </div>
  ),
};

// 아이콘 맵핑
const iconMap: { [key: string]: IconType } = {
  auto_graph: MdAutoGraph,
  monetization_on: MdMonetizationOn,
};

export async function generateStaticParams() {
  return allBlogPosts.map((post) => ({
    postId: post.id,
  }));
}

export async function generateMetadata({ params }: { params: Promise<{ postId: string }> }) {
  const { postId } = await params;
  const post = allBlogPosts.find((p) => p.id === postId);

  if (!post) {
    return {
      title: '글을 찾을 수 없습니다',
    };
  }

  return {
    title: `${post.title} - Nemo Library`,
    description: post.excerpt,
    openGraph: {
      title: post.title,
      description: post.excerpt,
    },
  };
}

export default async function BlogDetailPage({
  params,
}: {
  params: Promise<{ postId: string }>;
}) {
  const { postId } = await params;
  const post = allBlogPosts.find((p) => p.id === postId);

  if (!post) {
    notFound();
  }

  // MDX 파일 읽기
  const mdxPath = path.join(process.cwd(), 'content', `${postId}.mdx`);
  const mdxContent = fs.readFileSync(mdxPath, 'utf-8');

  return (
    <div>
      {/* 헤더 섹션 */}
      <div
        className="w-full py-10 md:py-16 px-5 md:px-16"
        style={{
          background: `linear-gradient(135deg, ${YHColor.primary}14, white)`,
        }}
      >
        <div className="max-w-3xl mx-auto">
          <Link
            href="/blogs"
            className="inline-flex items-center gap-2 text-slate-600 hover:text-slate-900 mb-8 transition-colors"
          >
            <svg
              className="w-5 h-5"
              fill="none"
              stroke="currentColor"
              viewBox="0 0 24 24"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M15 19l-7-7 7-7"
              />
            </svg>
            <span className="font-semibold">목록으로</span>
          </Link>

          {/* 아이콘 */}
          <div
            className="w-20 h-20 rounded-2xl flex items-center justify-center mb-6"
            style={{ backgroundColor: `${YHColor.primary}1A` }}
          >
            {(() => {
              const Icon = iconMap[post.icon];
              return Icon ? (
                <Icon className="text-5xl" style={{ color: YHColor.primary }} />
              ) : (
                <span className="text-5xl">📝</span>
              );
            })()}
          </div>

          {/* 제목 */}
          <h1
            className="text-3xl md:text-5xl font-black mb-4 leading-tight"
            style={{ color: YHColor.textDefault }}
          >
            {post.title}
          </h1>

          {/* 부제 */}
          <p
            className="text-base md:text-xl mb-6 leading-relaxed font-medium"
            style={{ color: YHColor.textSub }}
          >
            {post.subtitle}
          </p>

          {/* 메타 정보 */}
          <div className="flex items-center gap-4 text-sm text-slate-500 mb-5">
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
          </div>

          {/* 태그 */}
          <div className="flex flex-wrap gap-2">
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
        </div>
      </div>

      {/* 본문 섹션 */}
      <div className="py-10 md:py-16 px-5 md:px-16">
        <div className="max-w-3xl mx-auto">
          <div className="h-px bg-slate-200 mb-10" />

          {/* MDX 컨텐츠 */}
          <article className="prose prose-lg max-w-none">
            <MDXRemote source={mdxContent} components={components} />
          </article>

          <div className="h-px bg-slate-200 my-10" />

          {/* CTA 섹션 */}
          <div
            className="p-8 md:p-12 rounded-2xl border"
            style={{
              background: `linear-gradient(135deg, ${YHColor.primary}1A, ${YHColor.primary}0D)`,
              borderColor: `${YHColor.primary}33`,
            }}
          >
            <div className="text-center">
              <div className="text-5xl mb-4">🚀</div>
              <h3
                className="text-2xl md:text-3xl font-black mb-3"
                style={{ color: YHColor.textDefault }}
              >
                Nemo와 함께 시작하세요
              </h3>
              <p className="text-base md:text-lg text-slate-600 mb-8">
                과학적으로 검증된 학습법으로
                <br />더 효율적인 공부를 경험해보세요
              </p>

              <div className="flex flex-col md:flex-row gap-4 justify-center">
                <a
                  href="https://apps.apple.com/app/id1547183996"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="bg-black text-white px-6 py-4 rounded-xl font-bold flex items-center justify-center gap-2 hover:bg-gray-800 transition-colors"
                >
                  <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M17.05 20.28c-.98.95-2.05.8-3.08.35-1.09-.46-2.09-.48-3.24 0-1.44.62-2.2.44-3.06-.35C2.79 15.25 3.51 7.59 9.05 7.31c1.35.07 2.29.74 3.08.8 1.18-.24 2.31-.93 3.57-.84 1.51.12 2.65.72 3.4 1.8-3.12 1.87-2.38 5.98.48 7.13-.57 1.5-1.31 2.99-2.54 4.09l.01-.01zM12.03 7.25c-.15-2.23 1.66-4.07 3.74-4.25.29 2.58-2.34 4.5-3.74 4.25z" />
                  </svg>
                  App Store에서 다운로드
                </a>

                <a
                  href="https://play.google.com/store/apps/details?id=com.Nemo.ParkYoungHo"
                  target="_blank"
                  rel="noopener noreferrer"
                  className="bg-green-500 text-white px-6 py-4 rounded-xl font-bold flex items-center justify-center gap-2 hover:bg-green-600 transition-colors"
                >
                  <svg className="w-6 h-6" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M3.609 1.814L13.792 12 3.61 22.186a.996.996 0 0 1-.61-.92V2.734a1 1 0 0 1 .609-.92zm10.89 10.893l2.302 2.302-10.937 6.333 8.635-8.635zm3.199-3.198l2.807 1.626a1 1 0 0 1 0 1.73l-2.808 1.626L15.206 12l2.492-2.491zM5.864 2.658L16.802 8.99l-2.303 2.303-8.635-8.635z" />
                  </svg>
                  Google Play에서 다운로드
                </a>
              </div>
            </div>
          </div>

          <div className="mt-12 text-center">
            <Link
              href="/blogs"
              className="inline-flex items-center gap-2 px-6 py-3 border-2 border-slate-200 rounded-xl text-slate-600 hover:text-slate-900 hover:border-slate-300 transition-colors font-semibold"
            >
              <svg
                className="w-5 h-5"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M15 19l-7-7 7-7"
                />
              </svg>
              글 목록으로 돌아가기
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}


