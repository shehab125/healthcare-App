import 'package:flutter/material.dart';
import 'package:medical_app_base/models/doctor.dart';
import 'package:medical_app_base/widgets/doctor_card.dart';
import 'package:medical_app_base/screens/specialties_page.dart';

class CardiologyPage extends StatefulWidget {
  const CardiologyPage({super.key});

  @override
  State<CardiologyPage> createState() => _CardiologyPageState();
}

class _CardiologyPageState extends State<CardiologyPage> {
  String searchQuery = '';
  bool showFavoritesOnly = false;

  @override
  void initState() {
    super.initState();
  }

  bool isFavorite(Doctor doctor) {
    return false;
  }

  Future<void> _toggleFavorite(Doctor doctor) async {
    // Implementation needed
  }

  @override
  Widget build(BuildContext context) {
    final doctors = DoctorsData.cardiologyDoctors
        .where((doc) {
          final matchesSearch = doc.name.toLowerCase().contains(searchQuery.toLowerCase());
          if (showFavoritesOnly) {
            return matchesSearch && isFavorite(doc);
          }
          return matchesSearch;
        })
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      body: SafeArea(
        child: Column(
          children: [
            // Header with gradient background and title
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 24, bottom: 12),
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
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Text(
                    'Cardiology',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Find Your Doctor',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
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
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3EC8D6),
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
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SpecialtiesPage()),
                            );
                          },
                          child: const Text('See all', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // List of doctors
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                itemCount: doctors.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DoctorCard(
                      doctor: doctor,
                      onInfo: () {},
                      onCalendar: () {},
                      onHelp: () {},
                      onFavorite: () => _toggleFavorite(doctor),
                      isFavorite: isFavorite(doctor),
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