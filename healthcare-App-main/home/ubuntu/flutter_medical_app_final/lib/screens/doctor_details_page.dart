import 'package:flutter/material.dart';

class DoctorDetailsPage extends StatelessWidget {
  final Map<String, dynamic> doctor;

  const DoctorDetailsPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          doctor['name'],
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(doctor['image']),
              ),
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Specialty', doctor['specialty']),
            _buildRatingRow(doctor['rating'], doctor['reviews']),
            _buildAvailabilityRow(doctor['isAvailable']),
            const SizedBox(height: 20),
            const Text(
              'tAbout the Doctor',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3EC8D6),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Here will be a detailed summary about the doctor, years of experience, certificates, and other important information.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm Appointment'),
                      content: Text(
                          'هل أنت متأكد أنك تريد حجز موعد مع ${doctor['name']}؟'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('إلغاء'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('تم حجز الموعد بنجاح!')),
                            );
                            // هنا يمكن إضافة منطق لحفظ الموعد في قاعدة البيانات أو جدول المواعيد
                          },
                          child: const Text('تأكيد',
                              style: TextStyle(color: Color(0xFF3EC8D6))),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3EC8D6),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize:
                    const Size(double.infinity, 50), // Full width button
              ),
              child: const Text(
                'حجز موعد',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
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

  Widget _buildRatingRow(double rating, int reviews) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'التقييم:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF3EC8D6),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                '$rating ($reviews تقييم)',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Divider(height: 20, thickness: 1, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildAvailabilityRow(bool isAvailable) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'الحالة:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF3EC8D6),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isAvailable
                  ? Colors.green.withOpacity(0.1)
                  : Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              isAvailable ? 'متاح الآن' : 'غير متاح',
              style: TextStyle(
                color: isAvailable ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 20, thickness: 1, color: Colors.grey),
        ],
      ),
    );
  }
}
