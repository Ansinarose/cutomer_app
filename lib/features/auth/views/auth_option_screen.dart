import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/features/auth/views/login_screen.dart';
import 'package:customer_application/features/auth/views/signup_screen.dart';
import 'package:customer_application/features/privacy_policy/views/privacy_policy_screen.dart';
import 'package:customer_application/features/terms_conditions/view/termsand_conditions.dart';
import 'package:flutter/material.dart';


class AuthOptionScreen extends StatefulWidget {
  const AuthOptionScreen({super.key});

  @override
  State<AuthOptionScreen> createState() => _AuthOptionScreenState();
}

class _AuthOptionScreenState extends State<AuthOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                image: DecorationImage(image: AssetImage('assets/images/login.jpg'),fit: BoxFit.cover),
                
                ),
                  height: 300,
                  width: 300,
                  
                ),
              ),
            ),
            Text('Discover your',style: AppTextStyles.heading,),
             Text('Dream Home here',style: AppTextStyles.heading,),
             SizedBox(height: 20,),
            Text('Expertly crafted interiors and fabrication, delivered and installed professionally. Transform your  space  with ease and affordability ',style: AppTextStyles.body,),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreenWrapper()));
                  }, child: Text('Login'),style: AppButtonStyles.smallButtonWhite,),
                  SizedBox(width: 30,),
                  TextButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreenWrapper()));
                  }, child: Text('SignUp'),style: AppButtonStyles.smallButton,)
                ],
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Already dont have account? ',style: AppTextStyles.body,),
                ),
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SignupScreenWrapper()));
                }, child: Text('Signup',style: AppTextStyles.subheading,)),
                
              ],
              
            ),
            Row(
              children: [
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PrivacyPolicyScreen()));
                }, child: Text('Privacy policy',style: AppTextStyles.body,)),
                SizedBox(width: 30,),
                TextButton(onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TermsAndConditionsScreen()));
                }, child: Text('Terms & Conditions',style: AppTextStyles.body,))
              ],
            )
          ],
        ),
      ),
    );
  }
}