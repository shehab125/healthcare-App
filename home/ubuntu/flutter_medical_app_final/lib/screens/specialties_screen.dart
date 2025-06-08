import 'package:flutter/material.dart';

class SpecialtiesScreen extends StatelessWidget {
  const SpecialtiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final specialties = [
      {
        'name': 'Cardiology',
<<<<<<< HEAD
        'icon': Icons.favorite,
=======
        'image': 'assets/icons/specialties/cardiology.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'color': const Color(0xFFE3F2FD),
      },
      {
        'name': 'Dermatology',
<<<<<<< HEAD
        'icon': Icons.spa,
=======
        'image': 'assets/icons/specialties/dermatology.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'color': const Color(0xFFE8F5E9),
      },
      {
        'name': 'General Medicine',
<<<<<<< HEAD
        'icon': Icons.medical_services,
=======
        'image': 'assets/icons/specialties/general.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'color': const Color(0xFFFFEBEE),
      },
      {
        'name': 'Gynecology',
<<<<<<< HEAD
        'icon': Icons.pregnant_woman,
=======
        'image': 'assets/icons/specialties/gynecology.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'color': const Color(0xFFF3E5F5),
      },
      {
        'name': 'Dentistry',
<<<<<<< HEAD
        'icon': Icons.healing,
=======
        'image': 'assets/icons/specialties/dentistry.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'color': const Color(0xFFE0F7FA),
      },
      {
        'name': 'Oncology',
<<<<<<< HEAD
        'icon': Icons.local_hospital,
=======
        'image': 'assets/icons/specialties/oncology.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'color': const Color(0xFFFFF3E0),
      },
      {
        'name': 'Ophthalmology',
<<<<<<< HEAD
        'icon': Icons.remove_red_eye,
=======
        'image': 'assets/icons/specialties/ophthalmology.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'color': const Color(0xFFE8EAF6),
      },
      {
        'name': 'Orthopedics',
<<<<<<< HEAD
        'icon': Icons.accessibility_new,
=======
        'image': 'assets/icons/specialties/orthopedics.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'color': const Color(0xFFF1F8E9),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Medical Specialties',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: specialties.length,
          itemBuilder: (context, index) {
            final specialty = specialties[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: InkWell(
                onTap: () {
                  // TODO: Navigate to specialty details
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: specialty['color'] as Color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
<<<<<<< HEAD
                          child: Icon(
                            specialty['icon'] as IconData,
                            size: 50,
                            color: Colors.blueAccent,
=======
                          child: Image.asset(
                            specialty['image'] as String,
                            width: 50,
                            height: 50,
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        specialty['name'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
} 
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
