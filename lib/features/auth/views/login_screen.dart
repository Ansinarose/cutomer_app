



import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/common/constants/textform_field.dart';
import 'package:customer_application/common/widgets/curved_appbar.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CurvedAppBar(
        title: 'Affordable and high\n quality fabrication and interiros',titleTextStyle: AppTextStyles.whiteBody,
      ),
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50), // Add some spacing from the top
                Text('Login to your account', style: AppTextStyles.heading),
                SizedBox(height: 20),
                CustomTextFormField(
                  labelText: 'Email',
                  controller: emailController,
                  prefixIcon: Icons.email,
                  textColor: Color.fromARGB(255, 60, 9, 70),
                  hintColor: Colors.red,
                  borderColor:  Color.fromARGB(255, 60, 9, 70),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomTextFormField(
                  labelText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                  prefixIcon: Icons.lock,
                  textColor:  Color.fromARGB(255, 60, 9, 70),
                  hintColor: Colors.red,
                  borderColor:  Color.fromARGB(255, 60, 9, 70),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
            Text('Don’t have an account?            SignUp',style: AppTextStyles.body,),
               SizedBox(height: 20),
                TextButton(onPressed: (){}, child: Text('SignUp'),style: AppButtonStyles.smallButton,)
              // Optional: Add some spacing below the button
              ],
            ),
          ),
        ),
      ),
    );
  }
}