// lib/common/widgets/custom_text_form_field.dart
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final Color? textColor;
  final Color? hintcolor;
  final Color? borderColor;


  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.validator, this.prefixIcon, 
    this.textColor, this.hintcolor,
     this.borderColor, required MaterialColor hintColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        
        labelText: labelText,
        labelStyle: TextStyle(color:  hintcolor),
        prefixIcon:prefixIcon != null ? Icon(prefixIcon,color:  hintcolor,)
        :null
          ,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: borderColor ??Color.fromARGB(255, 60, 9, 70),
           ),
           
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: borderColor ?? Color.fromARGB(255, 60, 9, 70)),
          
        ),
    focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: borderColor ?? Colors.blue),
        ),
      ),
      validator: validator,
    );
  }
}