import 'package:flutter/material.dart';
import 'package:medical_app_base/screens/doctor_details_page.dart';
import '../utils/favorites_manager.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({super.key});

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. Sarah Ahmed',
      'specialty': 'Pediatrics',
      'rating': 4.8,
      'reviews': 120,
      'image': 'https://via.placeholder.com/150', // Placeholder image
      'isAvailable': true,
    },
    {
      'name': 'Dr. Mohamed Ali',
      'specialty': 'Orthopedics',
      'rating': 4.5,
      'reviews': 95,
      'image': 'https://via.placeholder.com/150', // Placeholder image
      'isAvailable': false,
    },
    {
      'name': 'Dr. Fatima Hassan',
      'specialty': 'Ophthalmology',
      'rating': 4.9,
      'reviews': 150,
      'image': 'https://via.placeholder.com/150', // Placeholder image
      'isAvailable': true,
    },
    {
      'name': 'Dr. Ahmed Ahmed',
      'specialty': 'Cardiology',
      'rating': 4.7,
      'reviews': 110,
      'image': 'https://via.placeholder.com/150', // Placeholder image
      'isAvailable': true,
    },
    {
      'name': 'Dr. Nora Said',
      'specialty': 'Dermatology',
      'rating': 4.6,
      'reviews': 80,
      'image': 'https://via.placeholder.com/150', // Placeholder image
      'isAvailable': false,
    },
    {
      'name': 'Dr. Khalid Mahmoud',
      'specialty': 'Dentistry',
      'rating': 4.7,
      'reviews': 130,
      'image': 'https://via.placeholder.com/150', // Placeholder image
      'isAvailable': true,
    },
    {
      'name': 'Dr. Omar Hussein',
      'specialty': 'ENT',
      'rating': 4.4,
      'reviews': 70,
      'image': 'https://via.placeholder.com/150', // Placeholder image
      'isAvailable': true,
    },
    {
      'name': 'Dr. Lila Mahmoud',
      'specialty': 'Obstetrics and Gynecology',
      'rating': 4.8,
      'reviews': 100,
      'image': 'https://via.placeholder.com/150', // Placeholder image
      'isAvailable': false,
    },
    {
      'name': 'Dr. Kareem Abdallah',
      'specialty': 'Gastroenterology',
      'rating': 4.5,
      'reviews': 90,
      'image': 'https://via.placeholder.com/150', // Placeholder image
      'isAvailable': true,
    },
  ];

  List<Map<String, dynamic>> _foundDoctors = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FavoritesManager.init();
    _foundDoctors = doctors;
    _searchController.addListener(_runFilter);
  }

  @override
  void dispose() {
    _searchController.removeListener(_runFilter);
    _searchController.dispose();
    super.dispose();
  }

  void _runFilter() {
    List<Map<String, dynamic>> results = [];
    if (_searchController.text.isEmpty) {
      results = doctors;
    } else {
      results = doctors.where((doctor) {
        final String searchTerm = _searchController.text.toLowerCase();
        return doctor['name'].toLowerCase().contains(searchTerm) ||
            doctor['specialty'].toLowerCase().contains(searchTerm);
      }).toList();
    }
    setState(() {
      _foundDoctors = results;
    });
  }

  void _toggleFavorite(Map<String, dynamic> doctor) async {
    final isFav = FavoritesManager.isFavorite(doctor['name'], 'doctor');
    if (isFav) {
      await FavoritesManager.removeFavorite(doctor['name'], 'doctor');
    } else {
      await FavoritesManager.addFavorite({...doctor, 'type': 'doctor'});
    }
    setState(() {
      // إعادة بناء الواجهة لتحديث أيقونة المفضلة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FCFF),
      body: SafeArea(
        child: Column(
          children: [
            // Header
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
                    'Doctors',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Find your favorite doctor',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search for a doctor...',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Color(0xFF3EC8D6)),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
            // Doctors List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _foundDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = _foundDoctors[index];
                  bool isFavorite =
                      FavoritesManager.isFavorite(doctor['name'], 'doctor');
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DoctorDetailsPage(doctor: doctor),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(doctor['image']),
                              backgroundColor: Colors.grey[200],
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doctor['name'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3EC8D6),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    doctor['specialty'],
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.amber, size: 20),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${doctor['rating']} (${doctor['reviews']} reviews)',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: doctor['isAvailable']
                                          ? Colors.green.withOpacity(0.1)
                                          : Colors.red.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      doctor['isAvailable']
                                          ? 'Available now'
                                          : 'Not available',
                                      style: TextStyle(
                                        color: doctor['isAvailable']
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Favorite Button
                            IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : Colors.grey,
                                size: 28,
                              ),
                              onPressed: () => _toggleFavorite(doctor),
                            ),
                          ],
                        ),
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
