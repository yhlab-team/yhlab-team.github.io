'use client';

import { useState, useRef, useCallback } from 'react';
import Link from 'next/link';
import { YHColor } from '@/lib/constants/colors';
import JSZip from 'jszip';

interface ExtractedFrame {
    index: number;
    timestamp: number;
    dataUrl: string;
}

export default function Mp4ToJpgPage() {
    const [videoFile, setVideoFile] = useState<File | null>(null);
    const [videoUrl, setVideoUrl] = useState<string>('');
    const [videoDuration, setVideoDuration] = useState<number>(0);
    const [frameCount, setFrameCount] = useState<number>(10);
    const [imageSize, setImageSize] = useState<number>(512);
    const [extractedFrames, setExtractedFrames] = useState<ExtractedFrame[]>([]);
    const [isExtracting, setIsExtracting] = useState<boolean>(false);
    const [progress, setProgress] = useState<number>(0);
    const [error, setError] = useState<string>('');

    const videoRef = useRef<HTMLVideoElement>(null);
    const canvasRef = useRef<HTMLCanvasElement>(null);
    const fileInputRef = useRef<HTMLInputElement>(null);

    // 파일 선택 핸들러
    const handleFileSelect = useCallback((e: React.ChangeEvent<HTMLInputElement>) => {
        const file = e.target.files?.[0];
        if (!file) return;

        // 비디오 파일 타입 검증
        if (!file.type.startsWith('video/')) {
            setError('비디오 파일만 업로드 가능합니다.');
            return;
        }

        setError('');
        setVideoFile(file);
        setExtractedFrames([]);

        // 기존 URL 정리
        if (videoUrl) {
            URL.revokeObjectURL(videoUrl);
        }

        const url = URL.createObjectURL(file);
        setVideoUrl(url);
    }, [videoUrl]);

    // 비디오 메타데이터 로드
    const handleVideoLoaded = useCallback(() => {
        if (videoRef.current) {
            setVideoDuration(videoRef.current.duration);
        }
    }, []);

    // 프레임 추출
    const extractFrames = useCallback(async () => {
        if (!videoRef.current || !canvasRef.current || !videoFile) return;

        const video = videoRef.current;
        const canvas = canvasRef.current;
        const ctx = canvas.getContext('2d');
        if (!ctx) return;

        setIsExtracting(true);
        setProgress(0);
        setExtractedFrames([]);
        setError('');

        const frames: ExtractedFrame[] = [];
        const duration = video.duration;
        const interval = duration / (frameCount + 1);

        // 비디오 비율 계산
        const videoRatio = video.videoWidth / video.videoHeight;
        let targetWidth = imageSize;
        let targetHeight = imageSize;

        if (videoRatio > 1) {
            targetHeight = Math.round(imageSize / videoRatio);
        } else {
            targetWidth = Math.round(imageSize * videoRatio);
        }

        canvas.width = targetWidth;
        canvas.height = targetHeight;

        try {
            for (let i = 0; i < frameCount; i++) {
                const timestamp = interval * (i + 1);

                // 비디오 시간 이동
                video.currentTime = timestamp;

                // seeked 이벤트 대기
                await new Promise<void>((resolve, reject) => {
                    const timeout = setTimeout(() => reject(new Error('시간 초과')), 5000);
                    const handleSeeked = () => {
                        clearTimeout(timeout);
                        video.removeEventListener('seeked', handleSeeked);
                        resolve();
                    };
                    video.addEventListener('seeked', handleSeeked);
                });

                // 프레임 캡처
                ctx.drawImage(video, 0, 0, targetWidth, targetHeight);
                const dataUrl = canvas.toDataURL('image/jpeg', 0.9);

                frames.push({
                    index: i + 1,
                    timestamp,
                    dataUrl,
                });

                setProgress(Math.round(((i + 1) / frameCount) * 100));
            }

            setExtractedFrames(frames);
        } catch (err) {
            setError('프레임 추출 중 오류가 발생했습니다.');
            console.error(err);
        } finally {
            setIsExtracting(false);
            setProgress(100);
        }
    }, [frameCount, imageSize, videoFile]);

    // 파일명에서 확장자 제거
    const getVideoBaseName = useCallback(() => {
        if (!videoFile) return 'video';
        const name = videoFile.name;
        const lastDot = name.lastIndexOf('.');
        return lastDot > 0 ? name.substring(0, lastDot) : name;
    }, [videoFile]);

    // 단일 이미지 다운로드
    const downloadSingleImage = useCallback((frame: ExtractedFrame) => {
        const baseName = getVideoBaseName();
        const link = document.createElement('a');
        link.href = frame.dataUrl;
        link.download = `${baseName}_${String(frame.index).padStart(3, '0')}.jpg`;
        link.click();
    }, [getVideoBaseName]);

    // 전체 이미지 ZIP 다운로드
    const downloadAllAsZip = useCallback(async () => {
        if (extractedFrames.length === 0) return;

        const baseName = getVideoBaseName();
        const zip = new JSZip();
        const folder = zip.folder(baseName);

        for (const frame of extractedFrames) {
            // data URL을 blob으로 변환
            const response = await fetch(frame.dataUrl);
            const blob = await response.blob();
            folder?.file(`${baseName}_${String(frame.index).padStart(3, '0')}.jpg`, blob);
        }

        const content = await zip.generateAsync({ type: 'blob' });
        const link = document.createElement('a');
        link.href = URL.createObjectURL(content);
        link.download = `${baseName}_frames.zip`;
        link.click();
        URL.revokeObjectURL(link.href);
    }, [extractedFrames, getVideoBaseName]);

    // 초기화
    const handleReset = useCallback(() => {
        if (videoUrl) {
            URL.revokeObjectURL(videoUrl);
        }
        setVideoFile(null);
        setVideoUrl('');
        setVideoDuration(0);
        setExtractedFrames([]);
        setProgress(0);
        setError('');
        if (fileInputRef.current) {
            fileInputRef.current.value = '';
        }
    }, [videoUrl]);

    // 타임스탬프 포맷
    const formatTime = (seconds: number): string => {
        const mins = Math.floor(seconds / 60);
        const secs = Math.floor(seconds % 60);
        const ms = Math.floor((seconds % 1) * 100);
        return `${mins}:${String(secs).padStart(2, '0')}.${String(ms).padStart(2, '0')}`;
    };

    return (
        <div className="min-h-screen py-12 px-5 md:px-16">
            <div className="max-w-4xl mx-auto">
                {/* 뒤로가기 & 헤더 */}
                <div className="mb-8">
                    <Link
                        href="/apps"
                        className="inline-flex items-center gap-2 text-gray-500 hover:text-gray-700 transition-colors mb-6"
                    >
                        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                        </svg>
                        목록으로
                    </Link>

                    <div className="flex items-center gap-4">
                        <div
                            className="w-14 h-14 rounded-2xl flex items-center justify-center"
                            style={{ background: `linear-gradient(135deg, #FF6B6B, #FF8E53)` }}
                        >
                            <svg className="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" />
                            </svg>
                        </div>
                        <div>
                            <h1 className="text-3xl md:text-4xl font-black" style={{ color: YHColor.textDefault }}>
                                MP4 to JPG
                            </h1>
                            <p className="text-gray-500 mt-1">동영상에서 원하는 프레임을 이미지로 추출</p>
                        </div>
                    </div>
                </div>

                {/* 에러 메시지 */}
                {error && (
                    <div className="mb-6 p-4 bg-red-50 border border-red-200 rounded-xl text-red-600 flex items-center gap-3">
                        <svg className="w-5 h-5 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        {error}
                    </div>
                )}

                {/* 파일 업로드 영역 */}
                {!videoFile ? (
                    <div
                        className="border-2 border-dashed border-gray-300 rounded-2xl p-12 text-center hover:border-blue-400 hover:bg-blue-50/50 transition-all cursor-pointer"
                        onClick={() => fileInputRef.current?.click()}
                    >
                        <input
                            ref={fileInputRef}
                            type="file"
                            accept="video/*"
                            onChange={handleFileSelect}
                            className="hidden"
                        />
                        <div className="w-20 h-20 mx-auto mb-6 rounded-full bg-gray-100 flex items-center justify-center">
                            <svg className="w-10 h-10 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
                            </svg>
                        </div>
                        <p className="text-xl font-bold mb-2" style={{ color: YHColor.textDefault }}>
                            동영상 파일을 선택하세요
                        </p>
                        <p className="text-gray-500">
                            클릭하거나 파일을 드래그하세요 (MP4, MOV, WebM 등)
                        </p>
                    </div>
                ) : (
                    <div className="space-y-6">
                        {/* 비디오 프리뷰 */}
                        <div className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 shadow-sm border border-gray-100">
                            <div className="flex items-center justify-between mb-4">
                                <h2 className="text-lg font-bold" style={{ color: YHColor.textDefault }}>
                                    선택된 영상
                                </h2>
                                <button
                                    onClick={handleReset}
                                    className="text-gray-500 hover:text-red-500 transition-colors text-sm flex items-center gap-1"
                                >
                                    <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                                    </svg>
                                    초기화
                                </button>
                            </div>

                            <video
                                ref={videoRef}
                                src={videoUrl}
                                onLoadedMetadata={handleVideoLoaded}
                                className="w-full max-h-[400px] rounded-xl bg-black"
                                controls
                                muted
                            />

                            <div className="mt-4 flex flex-wrap gap-4 text-sm text-gray-500">
                                <span className="flex items-center gap-2">
                                    <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                    </svg>
                                    {videoFile.name}
                                </span>
                                <span className="flex items-center gap-2">
                                    <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                                    </svg>
                                    {formatTime(videoDuration)}
                                </span>
                                <span className="flex items-center gap-2">
                                    <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 7v10c0 2.21 3.582 4 8 4s8-1.79 8-4V7M4 7c0 2.21 3.582 4 8 4s8-1.79 8-4M4 7c0-2.21 3.582-4 8-4s8 1.79 8 4" />
                                    </svg>
                                    {(videoFile.size / (1024 * 1024)).toFixed(2)} MB
                                </span>
                            </div>
                        </div>

                        {/* 설정 패널 */}
                        <div className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 shadow-sm border border-gray-100">
                            <h2 className="text-lg font-bold mb-6" style={{ color: YHColor.textDefault }}>
                                추출 설정
                            </h2>

                            <div className="grid md:grid-cols-2 gap-6">
                                {/* 프레임 수 설정 */}
                                <div>
                                    <label className="block text-sm font-medium mb-3" style={{ color: YHColor.textSub }}>
                                        추출할 프레임 수
                                    </label>
                                    <div className="flex items-center gap-4">
                                        <input
                                            type="range"
                                            min={2}
                                            max={100}
                                            value={frameCount}
                                            onChange={(e) => setFrameCount(Number(e.target.value))}
                                            className="flex-1 h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-blue-500"
                                        />
                                        <div className="flex items-center gap-2">
                                            <input
                                                type="number"
                                                min={2}
                                                max={100}
                                                value={frameCount}
                                                onChange={(e) => {
                                                    const val = Number(e.target.value);
                                                    if (val >= 2 && val <= 100) setFrameCount(val);
                                                }}
                                                className="w-20 px-3 py-2 border border-gray-200 rounded-lg text-center font-mono text-black"
                                            />
                                            <span className="text-gray-500 text-sm">장</span>
                                        </div>
                                    </div>
                                    <p className="text-xs text-gray-400 mt-2">최소 2장 ~ 최대 100장</p>
                                </div>

                                {/* 이미지 크기 설정 */}
                                <div>
                                    <label className="block text-sm font-medium mb-3" style={{ color: YHColor.textSub }}>
                                        이미지 최대 크기
                                    </label>
                                    <div className="flex items-center gap-4">
                                        <input
                                            type="range"
                                            min={100}
                                            max={1024}
                                            step={10}
                                            value={imageSize}
                                            onChange={(e) => setImageSize(Number(e.target.value))}
                                            className="flex-1 h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer accent-blue-500"
                                        />
                                        <div className="flex items-center gap-2">
                                            <input
                                                type="number"
                                                min={100}
                                                max={1024}
                                                value={imageSize}
                                                onChange={(e) => {
                                                    const val = Number(e.target.value);
                                                    if (val >= 100 && val <= 1024) setImageSize(val);
                                                }}
                                                className="w-24 px-3 py-2 border border-gray-200 rounded-lg text-center font-mono text-black"
                                            />
                                            <span className="text-gray-500 text-sm">px</span>
                                        </div>
                                    </div>
                                    <p className="text-xs text-gray-400 mt-2">최소 100px ~ 최대 1024px (원본 비율 유지)</p>
                                </div>
                            </div>

                            {/* 추출 버튼 */}
                            <button
                                onClick={extractFrames}
                                disabled={isExtracting}
                                className="w-full mt-8 py-4 rounded-xl font-bold text-white transition-all disabled:opacity-50 disabled:cursor-not-allowed hover:scale-[1.02] active:scale-[0.98]"
                                style={{ background: `linear-gradient(135deg, #FF6B6B, #FF8E53)` }}
                            >
                                {isExtracting ? (
                                    <span className="flex items-center justify-center gap-3">
                                        <svg className="w-5 h-5 animate-spin" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15" />
                                        </svg>
                                        추출 중... {progress}%
                                    </span>
                                ) : (
                                    <span className="flex items-center justify-center gap-2">
                                        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                                        </svg>
                                        {frameCount}개 프레임 추출하기
                                    </span>
                                )}
                            </button>
                        </div>

                        {/* 추출된 프레임 결과 */}
                        {extractedFrames.length > 0 && (
                            <div className="bg-white/80 backdrop-blur-sm rounded-2xl p-6 shadow-sm border border-gray-100">
                                <div className="flex items-center justify-between mb-6">
                                    <h2 className="text-lg font-bold" style={{ color: YHColor.textDefault }}>
                                        추출된 프레임 ({extractedFrames.length}장)
                                    </h2>
                                    <button
                                        onClick={downloadAllAsZip}
                                        className="px-4 py-2 bg-blue-500 hover:bg-blue-600 text-white rounded-lg font-medium transition-colors flex items-center gap-2"
                                    >
                                        <svg className="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
                                        </svg>
                                        전체 ZIP 다운로드
                                    </button>
                                </div>

                                <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-4">
                                    {extractedFrames.map((frame) => (
                                        <div
                                            key={frame.index}
                                            className="group relative rounded-xl overflow-hidden bg-gray-100 cursor-pointer"
                                            onClick={() => downloadSingleImage(frame)}
                                        >
                                            <img
                                                src={frame.dataUrl}
                                                alt={`Frame ${frame.index}`}
                                                className="w-full aspect-video object-cover"
                                            />
                                            <div className="absolute inset-0 bg-black/60 opacity-0 group-hover:opacity-100 transition-opacity flex items-center justify-center">
                                                <svg className="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4" />
                                                </svg>
                                            </div>
                                            <div className="absolute bottom-0 left-0 right-0 px-2 py-1 bg-black/50 text-white text-xs">
                                                #{frame.index} • {formatTime(frame.timestamp)}
                                            </div>
                                        </div>
                                    ))}
                                </div>
                            </div>
                        )}
                    </div>
                )}

                {/* 숨겨진 캔버스 (프레임 추출용) */}
                <canvas ref={canvasRef} className="hidden" />
            </div>
        </div>
    );
}

