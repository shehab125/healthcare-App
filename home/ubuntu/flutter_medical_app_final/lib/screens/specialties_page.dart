import 'package:flutter/material.dart';
import 'package:medical_app_base/screens/ophthalmology_page.dart';
import 'package:medical_app_base/screens/orthopedics_page.dart';
import 'package:medical_app_base/screens/dermatology_page.dart';
import 'package:medical_app_base/screens/cardiology_page.dart';
import 'package:medical_app_base/screens/general_medicine_page.dart';
import 'package:medical_app_base/screens/gynecology_page.dart';
import 'package:medical_app_base/screens/odontology_page.dart';
import 'package:medical_app_base/screens/oncology_page.dart';

class SpecialtiesPage extends StatefulWidget {
  const SpecialtiesPage({super.key});

  @override
  State<SpecialtiesPage> createState() => _SpecialtiesPageState();
}

class _SpecialtiesPageState extends State<SpecialtiesPage> {
  String searchQuery = '';

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
        'page': const CardiologyPage(),
      },
      {
        'name': 'Dermatology',
<<<<<<< HEAD
        'icon': Icons.spa,
=======
        'image': 'assets/icons/specialties/dermatology.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'page': const DermatologyPage(),
      },
      {
        'name': 'General Medicine',
<<<<<<< HEAD
        'icon': Icons.medical_services,
=======
        'image': 'assets/icons/specialties/general.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'page': const GeneralMedicinePage(),
      },
      {
        'name': 'Gynecology',
<<<<<<< HEAD
        'icon': Icons.pregnant_woman,
=======
        'image': 'assets/icons/specialties/gynecology.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'page': const GynecologyPage(),
      },
      {
        'name': 'Odontology',
<<<<<<< HEAD
        'icon': Icons.healing,
=======
        'image': 'assets/icons/specialties/dentistry.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'page': const OdontologyPage(),
      },
      {
        'name': 'Oncology',
<<<<<<< HEAD
        'icon': Icons.local_hospital,
=======
        'image': 'assets/icons/specialties/oncology.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'page': const OncologyPage(),
      },
      {
        'name': 'Ophthalmology',
<<<<<<< HEAD
        'icon': Icons.remove_red_eye,
=======
        'image': 'assets/icons/specialties/ophthalmology.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'page': const OphthalmologyPage(),
      },
      {
        'name': 'Orthopedics',
<<<<<<< HEAD
        'icon': Icons.accessibility_new,
=======
        'image': 'assets/icons/specialties/orthopedics.png',
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
        'page': const OrthopedicsPage(),
      },
    ];

<<<<<<< HEAD
    final filteredSpecialties = specialties
        .where((spec) => spec['name']
            .toString()
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();
=======
    final filteredSpecialties = specialties.where((spec) =>
      spec['name'].toString().toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b

    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      body: SafeArea(
        child: Column(
          children: [
            // Header with gradient background and title
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3EC8D6), Color(0xFF6EE2F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                children: const [
                  Text(
                    'Specialties',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Find Your Doctor',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // Search bar and filter/sort row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) => setState(() => searchQuery = value),
                      decoration: const InputDecoration(
                        hintText: 'Search…',
                        border: InputBorder.none,
<<<<<<< HEAD
                        prefixIcon:
                            Icon(Icons.search, color: Color(0xFF3EC8D6)),
=======
                        prefixIcon: Icon(Icons.search, color: Color(0xFF3EC8D6)),
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
<<<<<<< HEAD
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
=======
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
                        decoration: BoxDecoration(
                          color: Color(0xFF3EC8D6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'A → Z',
<<<<<<< HEAD
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
=======
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF3EC8D6)),
<<<<<<< HEAD
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text('Filter',
                            style: TextStyle(color: Color(0xFF3EC8D6))),
=======
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text('Filter', style: TextStyle(color: Color(0xFF3EC8D6))),
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
                      ),
                      const Spacer(),
                      const Text(
                        'Doctors',
                        style: TextStyle(
                          color: Color(0xFF3EC8D6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Specialties grid
            Expanded(
              child: GridView.builder(
<<<<<<< HEAD
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
=======
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 18,
                ),
                itemCount: filteredSpecialties.length,
                itemBuilder: (context, index) {
                  final specialty = filteredSpecialties[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
<<<<<<< HEAD
                        MaterialPageRoute(
                            builder: (context) => specialty['page'] as Widget),
=======
                        MaterialPageRoute(builder: (context) => specialty['page'] as Widget),
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3EC8D6), Color(0xFF6EE2F5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
<<<<<<< HEAD
                            blurRadius: 8,
                            offset: Offset(0, 4),
=======
                            blurRadius: 4,
                            offset: Offset(0, 2),
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
<<<<<<< HEAD
                          Icon(
                            specialty['icon'] as IconData,
                            size: 60,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 12),
=======
                          Image.asset(
                            specialty['image'] as String,
                            width: 56,
                            height: 56,
                          ),
                          const SizedBox(height: 16),
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
                          Text(
                            specialty['name'] as String,
                            style: const TextStyle(
                              color: Colors.white,
<<<<<<< HEAD
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
=======
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
} 
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
