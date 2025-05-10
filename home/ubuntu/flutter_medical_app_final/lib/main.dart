import 'package:flutter/material.dart';
import 'package:medical_app_base/screens/welcome_screen.dart';
import 'package:medical_app_base/utils/colors.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical App Base',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        fontFamily: 'Roboto',
        textTheme: Theme.of(context).textTheme.copyWith(
          titleLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: AppColors.textColor),
          bodyMedium: TextStyle(fontSize: 14.0, color: AppColors.textColor),
        ).apply(
          bodyColor: AppColors.textColor,
          displayColor: AppColors.textColor,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue) 
            .copyWith(secondary: AppColors.accentColor, background: AppColors.backgroundColor),
      ),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

