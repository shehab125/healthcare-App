import 'package:flutter/material.dart';

class PharmacyDetailsPage extends StatelessWidget {
  final Map<String, dynamic> pharmacy;

  const PharmacyDetailsPage({Key? key, required this.pharmacy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pharmacy['name']),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1EC8C8), Color(0xFF6EE2F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pharmacy['name'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1EC8C8),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey[600], size: 24),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    pharmacy['address'],
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.grey[600], size: 24),
                SizedBox(width: 8),
                Text(
                  pharmacy['schedule'],
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 24),
                SizedBox(width: 8),
                Text(
                  '${pharmacy['rating']}/5',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
            // Add more details if available (e.g., phone, whatsapp, description)
          ],
        ),
      ),
    );
  }
} 