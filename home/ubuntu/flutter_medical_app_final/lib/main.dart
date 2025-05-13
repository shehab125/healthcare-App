import 'package:flutter/material.dart';
import 'package:flutter_medical_app_final/screens/welcome_screen.dart';
import 'package:flutter_medical_app_final/utils/colors.dart';
import 'package:flutter_medical_app_final/screens/payment/payment_method_page.dart';
import 'package:flutter_medical_app_final/screens/payment/add_card_page.dart';
import 'package:flutter_medical_app_final/screens/payment/payment_page.dart';
import 'package:flutter_medical_app_final/screens/payment/payment_success_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical App',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        fontFamily: 'Roboto',
        textTheme: Theme.of(context).textTheme.copyWith(
          titleLarge: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: AppColors.textColor),
          bodyMedium: const TextStyle(fontSize: 14.0, color: AppColors.textColor),
        ).apply(
          bodyColor: AppColors.textColor,
          displayColor: AppColors.textColor,
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue) 
            .copyWith(secondary: AppColors.accentColor, background: AppColors.backgroundColor),
      ),
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
      routes: {
        '/payment_method': (context) => const PaymentMethodPage(),
        '/add_card': (context) => const AddCardPage(),
        '/payment': (context) => const PaymentPage(),
        '/payment_success': (context) => const PaymentSuccessPage(),
      },
    );
  }
}

