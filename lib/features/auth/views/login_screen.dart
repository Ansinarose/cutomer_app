import 'package:customer_application/bloc/bloc/app_bloc.dart';
import 'package:customer_application/bloc/bloc/app_event.dart';
import 'package:customer_application/bloc/bloc/app_state.dart';
import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/common/constants/textform_field.dart';
import 'package:customer_application/common/widgets/curved_appbar.dart';
import 'package:customer_application/features/auth/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/app_colors.dart';

class LoginScreenWrapper extends StatelessWidget {
  const LoginScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AuthBloc(), child: LoginScreen());
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {

        if(state is AuthLoading){

          return Center(
            child: CircularProgressIndicator(
              color:Color.fromARGB(255, 60, 9, 70) ,
            ),
          );
        }
        if(state is Authenticated ){
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
           });
        }
        return Scaffold(
          appBar: CurvedAppBar(
            title: 'Affordable and high\n quality fabrication and interiros',
            titleTextStyle: AppTextStyles.whiteBody,
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
                      // textColor: Color.fromARGB(255, 60, 9, 70),
                      // hintColor: Color.fromARGB(255, 60, 9, 70),
                      // borderColor:  Color.fromARGB(255, 60, 9, 70),
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
                      // textColor:  Color.fromARGB(255, 60, 9, 70),
                      // hintColor: Color.fromARGB(255, 60, 9, 70),
                      // borderColor:  Color.fromARGB(255, 60, 9, 70),
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
                    Row(
                      children: [
                        Text(
                          'Don’t have an account?',
                          style: AppTextStyles.body,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignupScreenWrapper()));
                            },
                            child: Text(
                              'SignUp',
                              style: AppTextStyles.subheading,
                            ))
                      ],
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {

                        authBloc.add(LoginEvent(password: passwordController.text.trim(),email: emailController.text.trim()));
                      },
                      child: Text('Login'),
                      style: AppButtonStyles.smallButton,
                    )
                    // Optional: Add some spacing below the button
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
