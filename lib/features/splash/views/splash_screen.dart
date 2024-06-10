import 'package:customer_application/bloc/bloc/app_bloc.dart';
import 'package:customer_application/bloc/bloc/app_event.dart';
import 'package:customer_application/bloc/bloc/app_state.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/features/home/views/home_screen.dart';
import 'package:customer_application/features/onboarding/views/skip_page_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPageWrapper extends StatelessWidget {
  const SplashPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(CheckLoginStatusEvent()),
      child: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
      

        if(state is Authenticated){
        
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomeScreenWrapper()));
        }else if(state is UnAuthenticated){
    
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SkipPageOne()));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundcolor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/387-3872576_purple-home-5-icon-free-icons-house-with.png'),
                        fit: BoxFit.fill)),
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
                        color: AppColors.textPrimaryColor,
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
