import 'package:flutter/material.dart';
import 'package:flutter_medical_app_final/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hint,
    this.isPassword = false,
    required this.controller,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
} 