import 'package:flutter/material.dart';

/// 블로그 글 데이터 모델
class BlogPost {
  final String id;
  final String title;
  final String subtitle;
  final String excerpt;
  final String fullContent;
  final String date;
  final String readTime;
  final IconData icon;
  final Color iconColor;
  final List<String> tags;

  const BlogPost({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.excerpt,
    required this.fullContent,
    required this.date,
    required this.readTime,
    required this.icon,
    required this.iconColor,
    required this.tags,
  });
}
