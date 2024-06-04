

import 'package:customer_application/bloc/bloc/app_bloc.dart';
import 'package:customer_application/bloc/bloc/app_state.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/features/onboarding/views/skip_page_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<splashBloc, splashState>(
      listener: (context, state) {
        if (state is splashLoaded) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SkipPageOne()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundcolor,
        body: Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
         width: 70,
        
         height: 70,
        
         decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/387-3872576_purple-home-5-icon-free-icons-house-with.png'),fit: BoxFit.fill)
         ),
              ),
              SizedBox(
                height: 20,
              ),
            

           Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'ALFA\n',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color:  AppColors.textPrimaryColor,
                  ),
                ),
                TextSpan(
                  text: 'Aluminium works',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
            ],
          ),
        ),
      ),
    );
  }
}