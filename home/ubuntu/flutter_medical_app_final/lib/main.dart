import 'package:flutter/material.dart';
import 'screens/doctors_page.dart';
import 'screens/doctor_profile_screen.dart';
import 'screens/favorite_page.dart';
import 'screens/favorite_services_page.dart';
import 'screens/favorite_female_doctors_page.dart';
import 'screens/favorite_male_doctors_page.dart';
import 'screens/rating_page.dart';
import 'package:medical_app_base/screens/home_screen.dart';
// إذا كنتِ تحتاجين صفحة البروفايل للتجربة أضيفيها أيضاً
// import 'doctor_profile_screen.dart';

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
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TestHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تجربة جميع الصفحات')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorsPage()));
            },
            child: const Text('صفحة الأطباء (DoctorsPage)'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritePage()));
            },
            child: const Text('صفحة المفضلة (FavoritePage)'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => FavoriteServicesPage()));
            },
            child: const Text('صفحة الخدمات المفضلة (FavoriteServicesPage)'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => FavoriteFemaleDoctorsPage()));
            },
            child: const Text('صفحة الطبيبات المفضلات (FavoriteFemaleDoctorsPage)'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => FavoriteMaleDoctorsPage()));
            },
            child: const Text('صفحة الأطباء المفضلين (FavoriteMaleDoctorsPage)'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => RatingPage()));
            },
            child: const Text('صفحة التقييم (RatingPage)'),
          ),
          // إذا أردتِ تجربة صفحة البروفايل مباشرة أضيفي زر لها هنا
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorProfilePage(
          //       image: 'assets/doctor profile/Dr. Jacob.png',
          //       name: 'Dr. Jacob Lopez, M.D.',
          //       specialty: 'Surgical Dermatology',
          //     )));
          //   },
          //   child: const Text('صفحة بروفايل دكتور (DoctorProfilePage)'),
          // ),
        ],
      ),
    );
  }
}