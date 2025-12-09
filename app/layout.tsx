import type { Metadata } from "next";
import "./globals.css";
import AppHeader from "@/components/AppHeader";
import AppFooter from "@/components/AppFooter";

export const metadata: Metadata = {
  title: "Nemo - 학습부터 장기기억, 앱테크까지",
  description:
    "평생 공부시대의 든든한 파트너! 에빙하우스 망각곡선 기반 과학적 복습 관리로 학습 효율을 극대화하세요.",
  keywords: "Nemo, 학습앱, 암기앱, 플래시카드, 망각곡선, 간격반복, 앱테크, 공부",
  openGraph: {
    title: "Nemo - 학습부터 장기기억, 앱테크까지",
    description:
      "과학적 복습 관리로 학습 효율을 극대화하세요. 망각곡선 기반 자동 복습 일정 관리.",
    type: "website",
    url: "https://yhlab-team.github.io",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="ko">
      <body className="antialiased">
        <div className="flex flex-col min-h-screen">
          <AppHeader />
          <main className="flex-1">{children}</main>
          <AppFooter />
        </div>
      </body>
    </html>
  );
}
