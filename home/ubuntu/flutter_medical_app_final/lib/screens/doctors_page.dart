import 'package:flutter/material.dart';
import 'doctor_profile_screen.dart';
import 'rating_page.dart';
import 'favorite_doctors_manager.dart';

class DoctorsPage extends StatefulWidget {
  const DoctorsPage({Key? key}) : super(key: key);

  @override
  State<DoctorsPage> createState() => _DoctorsPageState();
}

class _DoctorsPageState extends State<DoctorsPage> {
  final Color gradientStart = const Color(0xFF33E4DB);
  final Color gradientEnd = const Color(0xFF00BBD3);
  final Color mainColor = const Color(0xFF00BBD3);
  final Color text2 = const Color(0xFF222222);
  final Color elements = const Color(0xFFE6F6FE);
  final Color p = const Color(0xFFE0E0E0);

  int selectedNav = 0;

  // بيانات الأطباء
  final List<Map<String, String>> doctors = [
    {
      'image': 'assets/doctor/Dr. Ava.png',
      'name': "Dr. Ava Williams, M.D.",
      'specialty': "Maternal-Fetal Medicine",
    },
    {
      'image': 'assets/doctor/Dr. Benjamin.png',
      'name': "Dr. Benjamin Davis",
      'specialty': "Retinal Specialist",
    },
    {
      'image': 'assets/doctor/Dr. Chloe.png',
      'name': "Dr. Chloe Green, M.D.",
      'specialty': "Obstetrics and Gynecology (OB/GYN)",
    },
    {
      'image': 'assets/doctor/Dr. Christopher.png',
      'name': "Dr. Christopher Evans",
      'specialty': "Spine Surgeon",
    },
  ];

  // جلب حالة المفضلة من المانجر
  bool isFavorite(String name) {
    return FavoriteDoctorsManager.isFavorite(name);
  }

  void toggleFavorite(Map<String, String> doctor) {
    setState(() {
      if (isFavorite(doctor['name']!)) {
        FavoriteDoctorsManager.removeFavorite(doctor['name']!);
      } else {
        FavoriteDoctorsManager.addFavorite(doctor);
      }
    });
  }

  Widget buildDoctorCard({
    required Map<String, String> doctor,
    required int index,
    bool isLast = false,
  }) {
    const double iconSize = 22;
    if (isLast) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            doctor['name']!,
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 36,
            backgroundImage: AssetImage(doctor['image']!),
            backgroundColor: p,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(doctor['name']!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: mainColor)),
                const SizedBox(height: 4),
                Text(doctor['specialty']!,
                    style: TextStyle(
                        fontSize: 13, color: text2.withOpacity(0.5))),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorProfilePage(
                              image: doctor['image']!,
                              name: doctor['name']!,
                              specialty: doctor['specialty']!,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: elements,
                        foregroundColor: mainColor,
                        side: BorderSide(color: mainColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        elevation: 0,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 4),
                          const Text("Info"),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        isFavorite(doctor['name']!)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: mainColor,
                        size: iconSize,
                      ),
                      onPressed: () => toggleFavorite(doctor),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: elements,
      body: Column(
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [gradientStart, gradientEnd],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            padding: const EdgeInsets.only(
                top: 48, left: 20, right: 20, bottom: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Spacer(),
                    const Text(
                      "Doctors",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
                const SizedBox(height: 4),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Find Your Doctor",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: TextField(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم الضغط على البحث!')),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: "Search...",
                      prefixIcon: Icon(Icons.search, color: mainColor),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Categories without arrows
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Text("Sort By", style: TextStyle(color: text2)),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: const Text(
                    "A-Z",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم الضغط على الفلتر!')),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: mainColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    minimumSize: const Size(0, 36),
                  ),
                  child: Text(
                    "Filter",
                    style: TextStyle(
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RatingPage(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        "Top Rating",
                        style: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: doctors.length,
              itemBuilder: (context, index) {
                return buildDoctorCard(
                  doctor: doctors[index],
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: mainColor,
        unselectedItemColor: p,
        currentIndex: selectedNav,
        onTap: (index) {
          setState(() {
            selectedNav = index;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم الضغط على عنصر رقم ${index + 1}')),
          );
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/doctor/Home.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/doctor/Messages.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/doctor/User Profile.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/doctor/Booking-4.png', width: 28, height: 28),
            label: '',
          ),
        ],
      ),
    );
  }
}