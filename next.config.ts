import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: 'export',
  images: {
    unoptimized: true,
  },
  // GitHub Pages를 위한 basePath 설정
  // repository 이름이 yhlab-team.github.io이므로 basePath는 빈 문자열
  basePath: '',
  trailingSlash: true,
};

export default nextConfig;
