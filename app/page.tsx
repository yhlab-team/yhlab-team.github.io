import WaveHeader from '@/components/home/WaveHeader';
import HeroSection from '@/components/home/HeroSection';
import DeveloperCommentSection from '@/components/home/DeveloperCommentSection';
import FeaturesSection from '@/components/home/FeaturesSection';
import DownloadSection from '@/components/home/DownloadSection';

export default function HomePage() {
  return (
    <>
      <WaveHeader />
      <HeroSection />
      <DeveloperCommentSection />
      <FeaturesSection />
      <DownloadSection />
    </>
  );
}
