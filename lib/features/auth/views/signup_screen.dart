// // lib/features/auth/views/login_screen.dart
// import 'package:customer_application/bloc/bloc/app_bloc.dart';
// import 'package:customer_application/bloc/bloc/app_event.dart';
// import 'package:customer_application/bloc/bloc/app_state.dart';
// import 'package:customer_application/common/constants/app_button_styles.dart';
// import 'package:customer_application/common/constants/app_colors.dart';
// import 'package:customer_application/common/constants/app_text_styles.dart';
// import 'package:customer_application/common/widgets/curved_appbar.dart';
// import 'package:customer_application/features/auth/models/user_model.dart';
// import 'package:customer_application/features/auth/views/login_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../common/constants/textform_field.dart';

// class SignupScreenWrapper extends StatelessWidget {
//   const SignupScreenWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(create: (context) => AuthBloc(), child: SignUpScreen());
//   }
// }

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController NameController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final authBloc = BlocProvider.of<AuthBloc>(context);

//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {

//         if(state is Authenticated){
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//          Navigator.pushNamedAndRemoveUntil(context, '/carousel', (route) => false);
//       });
//         }
//         return Scaffold(
//           appBar: CurvedAppBar(
//             backgroundImage:
//                 'assets/images/interior-design-violet-22273327.webp',
//             title: '',
//           ),
//           backgroundColor: AppColors.scaffoldBackgroundcolor,
//           body: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 50),
//                     Text('SignUp with Email', style: AppTextStyles.heading),
//                     SizedBox(height: 20),
//                     CustomTextFormField(
//                       labelText: 'Name',
//                       controller: NameController,
//                       prefixIcon: Icons.person,
//                       // ignore: body_might_complete_normally_nullable
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your Name';
//                         }

//                         // return null;
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     CustomTextFormField(
//                       labelText: 'Email',
//                       controller: emailController,
//                       prefixIcon: Icons.email,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                           return 'Please enter a valid email address';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     CustomTextFormField(
//                       labelText: 'Password',
//                       controller: passwordController,
//                       obscureText: true,
//                       prefixIcon: Icons.lock,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your password';
//                         }
//                         if (value.length < 6) {
//                           return 'Password must be at least 6 characters long';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Text('Already have an account?  ',
//                             style: AppTextStyles.body),
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (context) => LoginScreen()));
//                           },
//                           child: Text('Login', style: AppTextStyles.subheading),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Center(
//                       child: TextButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             // Handle signup logic here
//                            UserModel user=UserModel(
//                             name: NameController.text,
//                             email:emailController.text,
//                             password:passwordController.text,
//                            );
//                             authBloc.add(SignupEvent(user: user));
//                           }
//                         },
//                         child: Text('SignUp'),
//                         style: AppButtonStyles.largeButton,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// lib/features/auth/views/login_screen.dart
import 'package:customer_application/bloc/bloc/app_bloc.dart';
import 'package:customer_application/bloc/bloc/app_event.dart';
import 'package:customer_application/bloc/bloc/app_state.dart';
import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/common/widgets/curved_appbar.dart';
import 'package:customer_application/features/auth/models/user_model.dart';
import 'package:customer_application/features/auth/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/constants/textform_field.dart';

class SignupScreenWrapper extends StatelessWidget {
  const SignupScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => AuthBloc(), child: SignUpScreen());
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController NameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is Authenticated) {
      Navigator.pushNamedAndRemoveUntil(context, '/carousel', (route) => false);
    } else if (state is AuthenticatedError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  builder: (context, state){

        return Scaffold(
          appBar: CurvedAppBar(
            backgroundImage:
                'assets/images/interior-design-violet-22273327.webp',
            title: '',
          ),
          backgroundColor: AppColors.scaffoldBackgroundcolor,
          body: state is AuthLoading
          ? Center(child: CircularProgressIndicator(),) :
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50),
                    Text('SignUp with Email', style: AppTextStyles.heading),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      labelText: 'Name',
                      controller: NameController,
                      prefixIcon: Icons.person,
                      // ignore: body_might_complete_normally_nullable
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        }

                        // return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomTextFormField(
                      labelText: 'Email',
                      controller: emailController,
                      prefixIcon: Icons.email,
                     validator: (value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }
  // Use a more comprehensive email regex
  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
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
                        Text('Already have an account?  ',
                            style: AppTextStyles.body),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          },
                          child: Text('Login', style: AppTextStyles.subheading),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Handle signup logic here
                           UserModel user=UserModel(
                            name: NameController.text,
                            email:emailController.text,
                            password:passwordController.text,
                           );
                            authBloc.add(SignupEvent(user: user));
                          }
                        },
                        child: Text('SignUp'),
                        style: AppButtonStyles.largeButton,
                      ),
                    ),
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
