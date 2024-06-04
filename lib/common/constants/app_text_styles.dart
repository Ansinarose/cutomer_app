// lib/common/constants/app_text_styles.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Heading style with specified font size and weight
  static final TextStyle heading = TextStyle(
    color: AppColors.textPrimaryColor,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  // Body text style with specified font size
  static final TextStyle body = TextStyle(
    color: AppColors.textPrimaryColor,
    fontSize: 16,
  );

  // White body text style with specified font size
  static final TextStyle whiteBody = TextStyle(
    color: AppColors.textsecondaryColor,
    fontSize: 16,
  );

  // Subheading style with medium weight
  static final TextStyle subheading = TextStyle(
    color: AppColors.textPrimaryColor,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  // Caption style
  static final TextStyle caption = TextStyle(
    color: AppColors.textPrimaryColor,
    fontSize: 12,
  );

  // Button text style
  static final TextStyle button = TextStyle(
    color: AppColors.textsecondaryColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  // Add more text styles as needed
}