import 'package:flutter/material.dart';

class MedicalRecordFilterPage extends StatelessWidget {
  const MedicalRecordFilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تصفية السجلات الطبية',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3EC8D6), Color(0xFF6EE2F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: const IconThemeData(
            color: Colors.white), // Set back button color to white
      ),
      body: const Center(
        child: Text(
          'خيارات التصفية ستكون هنا',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      ),
    );
  }
}
