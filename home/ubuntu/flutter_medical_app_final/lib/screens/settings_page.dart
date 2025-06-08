import 'package:flutter/material.dart';
import 'package:medical_app_base/screens/password_manager_page.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> settings = [
      // {
      //   'icon': Icons.notifications,
      //   'title': 'Notification Setting',
      //   'color': Colors.lightBlueAccent,
      // },
      {
        'icon': Icons.lock,
        'title': 'Password Manager',
        'color': Colors.lightBlueAccent,
      },
      {
        'icon': Icons.delete,
        'title': 'Delete Account',
        'color': Colors.redAccent,
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // AppBar متدرج مع زوايا سفلية مستديرة
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00c6ff), Color(0xFF0072ff)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            padding: EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 24),
            child: Center(
              child: Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 32),
          // Password Manager
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha((0.08 * 255).toInt()),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.lightBlueAccent,
                  child: Icon(Icons.key, color: Colors.white),
                ),
                title: Text('Password Manager'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PasswordManagerPage(),
                    ),
                  );
                },
              ),
            ),
          ),
          // Delete Account
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha((0.08 * 255).toInt()),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                title: Text('Delete Account'),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                  // Action for delete account
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
