import 'package:flutter/material.dart';
import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/features/auth/views/auth_option_screen.dart';

class SkipPageOne extends StatelessWidget {
  const SkipPageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenHeight = size.height;
    final double screenWidth = size.width;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.03,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: screenHeight * 0.4,
                    width: screenWidth * 0.8,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/R.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                Text('Welcome to', style: AppTextStyles.heading),
                Text('ALFA Aluminium works', style: AppTextStyles.heading),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Your dream interiors, expertly fabricated and installed. Enjoy a hassle-free transformation with our professional services',
                  style: AppTextStyles.body,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.04),
                SizedBox(
                  width: screenWidth * 0.8,
                  child: TextButton(
                    style: AppButtonStyles.largeButton,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => AuthOptionScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Get Started',
                      style: AppTextStyles.whiteBody,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}