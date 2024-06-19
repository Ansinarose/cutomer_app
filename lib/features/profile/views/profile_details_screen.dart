import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_application/common/constants/app_button_styles.dart';
import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:customer_application/common/constants/textform_field.dart';
import 'package:customer_application/common/widgets/photo_widget.dart';
import 'package:customer_application/features/profile/views/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileDetailsAddScreen extends StatefulWidget {
  const ProfileDetailsAddScreen({super.key});

  @override
  State<ProfileDetailsAddScreen> createState() => _ProfileDetailsAddScreenState();
}

class _ProfileDetailsAddScreenState extends State<ProfileDetailsAddScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text('Fill the Details', style: AppTextStyles.heading)),
                SizedBox(height: 30),
                CustomTextFormField(
                  labelText: 'Full Name',
                  controller: nameController,
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  labelText: 'Phone Number',
                  controller: phoneNumberController,
                  prefixIcon: Icons.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  labelText: 'Email Id',
                  controller: emailController,
                  prefixIcon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      labelStyle: TextStyle(color: Color.fromARGB(255, 60, 9, 70)),
                      prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 60, 9, 70)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                    ),
                    value: gender,
                    onChanged: (String? newValue) {
                      setState(() {
                        gender = newValue;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                    items: <String>['Male', 'Female', 'Other']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  labelText: 'Occupation',
                  controller: occupationController,
                  prefixIcon: Icons.work,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your occupation';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  labelText: 'Pincode',
                  controller: pincodeController,
                  prefixIcon: Icons.location_pin,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your pincode';
                    }
                    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                      return 'Please enter a valid 6-digit pincode';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  labelText: 'City',
                  controller: cityController,
                  prefixIcon: Icons.location_city,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  labelText: 'State',
                  controller: stateController,
                  prefixIcon: Icons.map,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your state';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Center(child: PhotoWidget()),
                SizedBox(height: 20),
                Center(
                  child: TextButton(
                    style: AppButtonStyles.largeButton,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        User? user = _auth.currentUser;
                        if (user != null) {
                          Map<String, dynamic> userData = {
                            'uid': user.uid,
                            'name': nameController.text,
                            'email': emailController.text,
                            'phone_number': phoneNumberController.text,
                            'gender': gender,
                            'occupation': occupationController.text,
                            'pincode': pincodeController.text,
                            'city': cityController.text,
                            'state': stateController.text,
                          };

                          try {
                            await _firestore
                                .collection('users')
                                .doc(user.uid)
                                .set(userData);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Profile details saved successfully!'),
                              ),
                            );

                            if (mounted) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => ProfileScreen()),
                                (route) => false,
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to save profile details: $e'),
                              ),
                            );
                          }
                        }
                      } else {
                        setState(() {
                          _autovalidateMode = AutovalidateMode.always;
                        });
                      }
                    },
                    child: Text('SAVE'),
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
