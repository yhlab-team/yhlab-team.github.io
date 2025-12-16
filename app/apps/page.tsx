'use client';

import Link from 'next/link';
import Image from 'next/image';
import { YHColor } from '@/lib/constants/colors';

interface ListItem {
    id: string;
    title: string;
    description: string;
    icon: React.ReactNode;
    href: string;
}

const appItems: ListItem[] = [
    {
        id: 'nemo',
        title: 'Nemo',
        description: '📌📑 학습부터 장기기억, 💰 앱테크까지평생 공부시대의 든든한 파트너!',
        icon: (
            <Image
                src="/assets/images/nemo_icon.png"
                alt="Nemo"
                width={48}
                height={48}
                className="rounded-xl"
            />
        ),
        href: '/',
    },
];

const webItems: ListItem[] = [
    {
        id: 'mp4-to-jpg',
        title: 'MP4 to JPG',
        description: '동영상에서 원하는 프레임을 JPG 이미지로 추출하세요',
        icon: (
            <div
                className="w-12 h-12 rounded-xl flex items-center justify-center"
                style={{ background: `linear-gradient(135deg, #FF6B6B, #FF8E53)` }}
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
                        d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z"
                    />
                </svg>
            </div>
        ),
        href: '/list/mp4-to-jpg',
    },
];

function ItemCard({ item }: { item: ListItem }) {
    return (
        <Link
            href={item.href}
            className="group flex items-center gap-4 p-5 bg-white/80 backdrop-blur-sm rounded-2xl border border-gray-100 shadow-sm hover:shadow-lg hover:border-gray-200 transition-all duration-300 hover:-translate-y-1"
        >
            <div className="flex-shrink-0">{item.icon}</div>
            <div className="flex-1 min-w-0">
                <h3
                    className="text-lg font-bold mb-1 group-hover:text-blue-600 transition-colors"
                    style={{ color: YHColor.textDefault }}
                >
                    {item.title}
                </h3>
                <p
                    className="text-sm line-clamp-2"
                    style={{ color: YHColor.textSub }}
                >
                    {item.description}
                </p>
            </div>
            <div className="flex-shrink-0">
                <svg
                    className="w-5 h-5 text-gray-400 group-hover:text-blue-500 group-hover:translate-x-1 transition-all"
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
            </div>
        </Link>
    );
}

function Section({
    title,
    emoji,
    items,
    color,
}: {
    title: string;
    emoji: string;
    items: ListItem[];
    color: string;
}) {
    return (
        <section className="mb-12">
            <div className="flex items-center gap-3 mb-6">
                <span className="text-3xl">{emoji}</span>
                <h2
                    className="text-2xl font-bold"
                    style={{ color }}
                >
                    {title}
                </h2>
                <div
                    className="flex-1 h-0.5 rounded-full opacity-20"
                    style={{ backgroundColor: color }}
                />
                <span
                    className="text-sm font-medium px-3 py-1 rounded-full"
                    style={{ backgroundColor: `${color}15`, color }}
                >
                    {items.length}개
                </span>
            </div>
            <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
                {items.map((item) => (
                    <ItemCard key={item.id} item={item} />
                ))}
            </div>
        </section>
    );
}

export default function ListPage() {
    return (
        <div className="min-h-screen py-12 px-5 md:px-16">
            <div className="max-w-6xl mx-auto">
                {/* 페이지 헤더 */}
                <div className="text-center mb-16">
                    <h1
                        className="text-4xl md:text-5xl font-black mb-4"
                        style={{ color: YHColor.textDefault }}
                    >
                        YHLab 서비스 목록
                    </h1>
                    <p
                        className="text-lg max-w-2xl mx-auto"
                        style={{ color: YHColor.textSub }}
                    >
                        앱과 웹 도구를 한 곳에서 만나보세요
                    </p>
                </div>

                {/* App 섹션 */}
                <Section
                    title="App"
                    emoji="📱"
                    items={appItems}
                    color="#8B5CF6"
                />

                {/* Web 섹션 */}
                <Section
                    title="Web Tools"
                    emoji="🌐"
                    items={webItems}
                    color={YHColor.primary}
                />
            </div>
        </div>
    );
}

