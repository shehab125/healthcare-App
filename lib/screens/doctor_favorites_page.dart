import 'package:flutter/material.dart';
import 'package:medical_app_base/models/doctor.dart';
import 'package:medical_app_base/utils/doctor_favorites_manager.dart';
import 'package:medical_app_base/widgets/doctor_card.dart';

class DoctorFavoritesPage extends StatefulWidget {
  const DoctorFavoritesPage({super.key});

  @override
  State<DoctorFavoritesPage> createState() => _DoctorFavoritesPageState();
}

class _DoctorFavoritesPageState extends State<DoctorFavoritesPage> {
  String searchQuery = '';
  List<Doctor> favoriteDoctors = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    await DoctorFavoritesManager.init();
    setState(() {
      favoriteDoctors = _getAllFavoriteDoctors();
    });
  }

  List<Doctor> _getAllFavoriteDoctors() {
    final favoriteIds = DoctorFavoritesManager.getFavoriteDoctorIds();
    final allDoctors = [
      ...DoctorsData.cardiologyDoctors,
      ...DoctorsData.dermatologyDoctors,
      ...DoctorsData.generalMedicineDoctors,
      ...DoctorsData.gynecologyDoctors,
      ...DoctorsData.ophthalmologyDoctors,
      ...DoctorsData.orthopedicsDoctors,
      ...DoctorsData.dentistryDoctors,
      ...DoctorsData.oncologyDoctors,
    ];
    return allDoctors.where((doctor) => favoriteIds.contains(doctor.name)).toList();
  }

  Future<void> _toggleFavorite(Doctor doctor) async {
    await DoctorFavoritesManager.removeFavorite(doctor.name);
    setState(() {
      favoriteDoctors = _getAllFavoriteDoctors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = favoriteDoctors.where((doctor) {
      return doctor.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          doctor.specialty.toLowerCase().contains(searchQuery.toLowerCase()) ||
          doctor.hospital.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1EC8C8), Color(0xFF6EE2F5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Favorite Doctors',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search doctors...',
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF3EC8D6)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: filteredDoctors.isEmpty
          ? const Center(
              child: Text(
                'No favorite doctors found',
                style: TextStyle(
                  color: Color(0xFF3EC8D6),
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredDoctors.length,
              itemBuilder: (context, index) {
                final doctor = filteredDoctors[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(doctor.image),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doctor.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3EC8D6),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    doctor.specialty,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    doctor.hospital,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Color(0xFF3EC8D6),
                              ),
                              onPressed: () => _toggleFavorite(doctor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Experience: ${doctor.experience}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Rating: ${doctor.rating}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              doctor.consultationFee,
                              style: const TextStyle(
                                color: Color(0xFF3EC8D6),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF3EC8D6)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'Book Appointment',
                                style: TextStyle(color: Color(0xFF3EC8D6)),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF3EC8D6)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                'View Profile',
                                style: TextStyle(color: Color(0xFF3EC8D6)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
} 