import 'package:yhlab_web/models/blog_post.dart';
import 'package:yhlab_web/data/posts/forgetting_curve_post.dart';
import 'package:yhlab_web/data/posts/app_tech_post.dart';

/// 모든 블로그 글 목록
/// 새로운 글을 추가하려면:
/// 1. lib/data/posts/ 폴더에 새 파일 생성
/// 2. BlogPost 객체 정의
/// 3. 이 파일에서 import 후 아래 리스트에 추가
final List<BlogPost> allBlogPosts = [forgettingCurvePost, appTechPost];
