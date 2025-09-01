import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget prefixIcon;
  final Widget ? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final FormFieldValidator<String> validator;

  const CustomFormTextField(
    
    {super.key, 
    required this.controller,
    required this.hintText,
     required this.prefixIcon,
     this.suffixIcon,
     required this.keyboardType,
     this.obscureText = false,

     required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon ?? const SizedBox.shrink(),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
    );
  }
}
