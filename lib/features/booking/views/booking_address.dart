import 'package:customer_application/common/constants/app_colors.dart';
import 'package:customer_application/common/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingAddressScreen extends StatefulWidget {
  const BookingAddressScreen({super.key});

  @override
  _BookingAddressScreenState createState() => _BookingAddressScreenState();
}

class _BookingAddressScreenState extends State<BookingAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _houseController = TextEditingController();
  final _roadController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _landmarkController = TextEditingController();

  bool _autovalidate = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _houseController.dispose();
    _roadController.dispose();
    _pincodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.textPrimaryColor,
        title: Text('Add Delivery Address', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add a Delivery Address', style: AppTextStyles.heading),
              SizedBox(height: 20),
              Text('Contact Details',style: AppTextStyles.subheading,),
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration('Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              TextFormField(
                controller: _phoneController,
                decoration: _inputDecoration('Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length != 10) {
                    return 'Phone number should be 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              Text('Address', style: AppTextStyles.subheading),
              SizedBox(height: 10),
              
              TextFormField(
                controller: _houseController,
                decoration: _inputDecoration('House No/Building Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter house no/building name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              TextFormField(
                controller: _roadController,
                decoration: _inputDecoration('Road Name/Area/Colony'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter road name/area/colony';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              TextFormField(
                controller: _pincodeController,
                decoration: _inputDecoration('Pincode'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter pincode';
                  }
                  if (value.length != 6) {
                    return 'Pincode should be 6 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              TextFormField(
                controller: _cityController,
                decoration: _inputDecoration('City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter city';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              TextFormField(
                controller: _stateController,
                decoration: _inputDecoration('State'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter state';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              
              TextFormField(
                controller: _landmarkController,
                decoration: _inputDecoration('Landmark'),
              ),
              SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: _saveAddress,
                child: Text('Save Address & Continue',style: AppTextStyles.whiteBody,),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textPrimaryColor,
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppColors.textPrimaryColor),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.textPrimaryColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.textPrimaryColor, width: 2),
      ),
    );
  }

  void _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance.collection('customer').doc(user.uid).collection('addresses').add({
            'name': _nameController.text,
            'phone': _phoneController.text,
            'houseNo': _houseController.text,
            'road': _roadController.text,
            'pincode': _pincodeController.text,
            'city': _cityController.text,
            'state': _stateController.text,
            'landmark': _landmarkController.text,
            'timestamp': FieldValue.serverTimestamp(),
          });
          ScaffoldMessenger.of(context).showSnackBar(
            
            SnackBar(backgroundColor: AppColors.textPrimaryColor,
              content: Text('Address saved successfully')),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User not logged in')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving address: $e')),
        );
      }
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }
}