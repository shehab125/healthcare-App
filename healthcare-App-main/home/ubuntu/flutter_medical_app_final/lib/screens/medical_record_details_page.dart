import 'package:flutter/material.dart';

class MedicalRecordDetailsPage extends StatelessWidget {
  final Map<String, dynamic> record;

  const MedicalRecordDetailsPage({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'tMedical Record Details',
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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Date', record['date']),
            _buildDetailRow('Doctor Name', record['doctor']),
            _buildDetailRow('Specialty', record['specialty']),
            _buildDetailRow('Diagnosis', record['diagnosis']),
            _buildDetailRow(
                'Medications', (record['medications'] as List).join(', ')),
            _buildDetailRow('Notes', record['notes']),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF3EC8D6),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
          const Divider(height: 20, thickness: 1, color: Colors.grey),
        ],
      ),
    );
  }
}
