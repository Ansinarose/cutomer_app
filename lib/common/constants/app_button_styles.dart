// lib/common/constants/app_button_styles.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppButtonStyles {
  // Large button style
  static final ButtonStyle largeButton = TextButton.styleFrom(
    foregroundColor: AppColors.textsecondaryColor,
    backgroundColor: AppColors.textPrimaryColor,
    minimumSize: Size(200, 50),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    textStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    shadowColor: Colors.black.withOpacity(0.2),
    elevation: 5,
  ).copyWith(
    overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
  );

  // Small button style
  static final ButtonStyle smallButton = TextButton.styleFrom(
    foregroundColor: AppColors.textsecondaryColor,
    backgroundColor: AppColors.textPrimaryColor,
    minimumSize: Size(150, 50),
    padding: EdgeInsets.symmetric(horizontal: 12.0),
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    shadowColor: Colors.black.withOpacity(0.2),
    elevation: 5,
  ).copyWith(
    overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
  );

  static final ButtonStyle smallButtonWhite = TextButton.styleFrom(
    foregroundColor: AppColors.textPrimaryColor,
    backgroundColor: AppColors.textsecondaryColor,
    minimumSize: Size(150, 50),
    padding: EdgeInsets.symmetric(horizontal: 12.0),
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    shadowColor: Colors.black.withOpacity(0.2),
    elevation: 5,
  ).copyWith(
    overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
  );
}
