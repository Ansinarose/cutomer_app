// lib/features/home/views/home_screen.dart
import 'package:customer_application/bloc/bloc/app_bloc.dart';
import 'package:customer_application/bloc/bloc/app_event.dart';
import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/features/auth/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        actions: [
         IconButton(onPressed: (){
 
 final authBloc=BlocProvider.of<AuthBloc>(context);
 authBloc.add(LogoutEvent());
  Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);

//Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginScreen()));
         }, icon: Icon(Icons.logout,color: Colors.white,)) 
        ],
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