import 'package:flutter/material.dart';
import 'package:medical_app_base/utils/colors.dart'; // Adjusted import path

class AppStyles {
  static const TextStyle headlineStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.headlineColor,
  );

  static const TextStyle subHeadlineStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: AppColors.textColor,
  );

  static const TextStyle buttonStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}

