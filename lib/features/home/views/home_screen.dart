// lib/features/home/views/home_screen.dart
import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        backgroundColor: Appbarcolors.appbarbackgroundcolor,
        title: Text('Home', style: AppTextStyles.heading),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: AppButtonStyles.largeButton,
              onPressed: () {},
              child: Text('Large Button'),
            ),
            SizedBox(height: 16),
            TextButton(
              style: AppButtonStyles.smallButton,
              onPressed: () {},
              child: Text('Small Button'),
            ),
          ],
        ),
      ),
    );
  }
}