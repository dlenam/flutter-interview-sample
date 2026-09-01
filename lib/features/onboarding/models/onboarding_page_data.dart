import 'package:flutter/material.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.badge,
    required this.title,
    required this.description,
    required this.icon,
    this.imagePath,
  });

  final String badge;
  final String title;
  final String description;
  final IconData icon;
  final String? imagePath;
}
