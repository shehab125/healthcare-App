import 'package:flutter/material.dart';
import 'package:medical_app_base/screens/cardiology_page.dart';
import 'package:medical_app_base/screens/dermatology_page.dart';
import 'package:medical_app_base/screens/general_medicine_page.dart';
import 'package:medical_app_base/screens/gynecology_page.dart';
import 'package:medical_app_base/screens/odontology_page.dart';
import 'package:medical_app_base/screens/oncology_page.dart';

class GeneralMedicinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('General Medicine')),
      body: Center(child: Text('General Medicine Page')),
    );
  }
} 