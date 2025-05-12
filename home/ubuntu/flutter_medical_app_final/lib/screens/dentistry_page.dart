import 'package:flutter/material.dart';
import 'package:medical_app_base/models/doctor.dart';
import 'package:medical_app_base/widgets/doctor_card.dart';

class DentistryPage extends StatelessWidget {
  const DentistryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dentistry'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.teal[700]!,
                Colors.teal[500]!,
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: DoctorsData.dentistryDoctors.length,
        itemBuilder: (context, index) {
          final doctor = DoctorsData.dentistryDoctors[index];
          return DoctorCard(
            doctor: doctor,
            onTap: () {
              // TODO: Navigate to doctor details page
            },
          );
        },
      ),
    );
  }
} 