import 'package:flutter/material.dart';
import 'package:medical_app_base/utils/colors.dart'; // Adjusted import path
import 'package:medical_app_base/utils/styles.dart'; // Assuming styles might be used, or remove if not

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;
  final Color? color;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 50,
      onPressed: onPressed,
      color: isOutlined ? Colors.transparent : (color ?? AppColors.primaryColor),
      elevation: isOutlined ? 0 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isOutlined
            ? BorderSide(color: color ?? AppColors.primaryColor, width: 2)
            : BorderSide.none,
      ),
      child: Text(
        text,
        style: AppStyles.buttonTextStyle.copyWith(
          color: isOutlined ? (textColor ?? AppColors.primaryColor) : (textColor ?? Colors.white)
        ) 
      ),
    );
  }
}

