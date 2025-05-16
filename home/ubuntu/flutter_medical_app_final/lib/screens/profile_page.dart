import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // للتحكم في لون أيقونات شريط الحالة
import 'package:medical_app_base/screens/login_screen.dart';
import 'package:medical_app_base/screens/edit_profile_page.dart';
import 'package:medical_app_base/screens/favorite_page.dart';
import 'package:medical_app_base/screens/payment_method_page.dart';
import 'package:medical_app_base/screens/settings_page.dart';
import 'package:medical_app_base/screens/home_screen.dart';

// صفحة الملف الشخصي
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // لون خلفية أيقونات القائمة
    final Color iconBgColor = Colors.lightBlueAccent;

    return Scaffold(
      backgroundColor: Colors.white, // خلفية بيضاء لبقية الصفحة
      // لجعل أيقونات شريط الحالة (مثل الساعة) باللون الأبيض على التدرج اللوني
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ---------------- رأس الصفحة مع التدرج اللوني ----------------
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00c6ff), Color(0xFF0072ff)], // من سماوي فاتح إلى أزرق
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  // حواف دائرية من الأسفل لتمييز القسم
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: SafeArea( // لتجنب شريط الحالة أعلى الشاشة
                  bottom: false,
                  child: Column(
                    children: [
                      // صف يحتوي على زر الرجوع والعنوان
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                                (route) => false,
                              );
                            }, // دالة الرجوع
                          ),
                          Expanded(
                            child: Text(
                              'My Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // عنصر وهمي لإبقاء العنوان في المنتصف
                          SizedBox(width: 48.0),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      // صف معلومات المستخدم (الصورة والاسم والبريد)
                      Row(
                        children: [
                          // صورة الملف الشخصي مع أيقونة تعديل صغيرة
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 40.0,
                                  backgroundImage: NetworkImage(
                                    'https://randomuser.me/api/portraits/women/79.jpg',
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EditProfilePage()),
                                    );
                                  },
                                  child: Container(
                                    width: 30.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      color: Color(0xFF0072ff),
                                      size: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16.0),
                          // بيانات المستخدم: الاسم ورقم الهاتف والبريد الإلكتروني
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Jane Doe',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              Text(
                                '+123 567 89000',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                'Janedoe@example.com',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              // ---------------- قائمة الخيارات الرئيسية ----------------
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: iconBgColor,
                        child: Icon(Icons.person, color: Colors.white),
                        radius: 20.0,
                      ),
                      title: Text('Profile'),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfilePage()),
                        );
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: iconBgColor,
                        child: Icon(Icons.favorite, color: Colors.white),
                        radius: 20.0,
                      ),
                      title: Text('Favorite'),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FavoritePage()),
                        );
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: iconBgColor,
                        child: Icon(Icons.account_balance_wallet, color: Colors.white),
                        radius: 20.0,
                      ),
                      title: Text('Payment Method'),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PaymentMethodPage()),
                        );
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: iconBgColor,
                        child: Icon(Icons.settings, color: Colors.white),
                        radius: 20.0,
                      ),
                      title: Text('Settings'),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsPage()),
                        );
                      },
                    ),
                    Divider(),
                    // زر تسجيل الخروج
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.logout, color: Colors.white),
                        label: Text('Logout', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: iconBgColor,
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                            (route) => false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 