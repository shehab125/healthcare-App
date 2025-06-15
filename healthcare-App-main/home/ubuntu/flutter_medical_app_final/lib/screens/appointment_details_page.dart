import 'package:flutter/material.dart';

class AppointmentDetailsPage extends StatelessWidget {
  final Map<String, dynamic> appointment;

  const AppointmentDetailsPage({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'tAppointment Details',
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
            _buildDetailRow('Date', appointment['date']),
            _buildDetailRow('Time', appointment['time']),
            _buildDetailRow('Doctor', appointment['doctor']),
            _buildDetailRow('Specialty', appointment['specialty']),
            _buildDetailRow('Status', appointment['status'],
                color: _getStatusColor(appointment['status'])),
            const SizedBox(height: 20),
            // Add more details or actions here if needed
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? color}) {
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
            style: TextStyle(
              fontSize: 15,
              color: color ?? Colors.black87,
            ),
          ),
          const Divider(height: 20, thickness: 1, color: Colors.grey),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
