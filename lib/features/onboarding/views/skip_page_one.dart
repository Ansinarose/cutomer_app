

import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/features/auth/views/auth_option_screen.dart';
import 'package:flutter/material.dart';

class SkipPageOne extends StatelessWidget {
  const SkipPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: AppColors.scaffoldBackgroundcolor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
               height: 400,
               width: 400, 
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/R.png'))
              ),
              ),
            ),
            Text('Welcome to ',style: AppTextStyles.heading,),
            Text('ALFA Aluminium works',style: AppTextStyles.heading,),
            SizedBox(height: 20,),
            Text('Your dream interiors, expertly fabricated and installed.',style: AppTextStyles.body,),
            Text('Enjoy a hassle-free transformation with  our professional services',style: AppTextStyles.body,),

            SizedBox(height: 30,),
            TextButton(
              style: AppButtonStyles.largeButton,
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AuthOptionScreen()));
              }, child: Text('Get Started',style: AppTextStyles.whiteBody,),)
          ],
        ),
      ),
    );
  }
}