import 'package:flutter/material.dart';
import 'package:flutter_medical_app_final/screens/ophthalmology_page.dart';
import 'package:flutter_medical_app_final/screens/orthopedics_page.dart';
import 'package:flutter_medical_app_final/screens/dermatology_page.dart';
import 'package:flutter_medical_app_final/screens/cardiology_page.dart';
import 'package:flutter_medical_app_final/screens/general_medicine_page.dart';
import 'package:flutter_medical_app_final/screens/gynecology_page.dart';
import 'package:flutter_medical_app_final/screens/odontology_page.dart';
import 'package:flutter_medical_app_final/screens/oncology_page.dart';

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
        'image': 'assets/icons/specialties/cardiology.png',
        'page': const CardiologyPage(),
      },
      {
        'name': 'Dermatology',
        'image': 'assets/icons/specialties/dermatology.png',
        'page': const DermatologyPage(),
      },
      {
        'name': 'General Medicine',
        'image': 'assets/icons/specialties/general.png',
        'page': const GeneralMedicinePage(),
      },
      {
        'name': 'Gynecology',
        'image': 'assets/icons/specialties/gynecology.png',
        'page': const GynecologyPage(),
      },
      {
        'name': 'Odontology',
        'image': 'assets/icons/specialties/dentistry.png',
        'page': const OdontologyPage(),
      },
      {
        'name': 'Oncology',
        'image': 'assets/icons/specialties/oncology.png',
        'page': const OncologyPage(),
      },
      {
        'name': 'Ophthalmology',
        'image': 'assets/icons/specialties/ophthalmology.png',
        'page': const OphthalmologyPage(),
      },
      {
        'name': 'Orthopedics',
        'image': 'assets/icons/specialties/orthopedics.png',
        'page': const OrthopedicsPage(),
      },
    ];

    final filteredSpecialties = specialties.where((spec) =>
      spec['name'].toString().toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();

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
                        prefixIcon: Icon(Icons.search, color: Color(0xFF3EC8D6)),
                        contentPadding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color(0xFF3EC8D6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'A → Z',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF3EC8D6)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text('Filter', style: TextStyle(color: Color(0xFF3EC8D6))),
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
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
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
                        MaterialPageRoute(builder: (context) => specialty['page'] as Widget),
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
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            specialty['image'] as String,
                            width: 56,
                            height: 56,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            specialty['name'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
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
} 