import 'package:flutter/material.dart';
import 'doctor_profile_screen.dart';
import 'rating_page.dart';
class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  final Color gradientStart = const Color(0xFF33E4DB);
  final Color gradientEnd = const Color(0xFF00BBD3);
  final Color mainColor = const Color(0xFF00BBD3);
  final Color text2 = const Color(0xFF222222);
  final Color elements = const Color(0xFFE6F6FE);
  final Color p = const Color(0xFFE0E0E0);

  List<bool> favorites = [false, false, false, false];

  Widget buildDoctorCard({
    required String image,
    required String name,
    required String specialty,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage(image),
            backgroundColor: p,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('assets/rating/Professional Doctor.png', width: 18, height: 18),
                    const SizedBox(width: 4),
                    Text("Professional Doctor", style: TextStyle(fontSize: 12, color: mainColor)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: mainColor)),
                const SizedBox(height: 2),
                Text(specialty, style: TextStyle(fontSize: 13, color: text2.withOpacity(0.5))),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorProfilePage(
                              image: image,
                              name: name,
                              specialty: specialty,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: elements,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/rating/Star 1.png', width: 16, height: 16),
                          const SizedBox(width: 2),
                          const Text("5", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        favorites[index] ? Icons.favorite : Icons.favorite_border,
                        color: mainColor,
                        size: 22,
                      ),
                      onPressed: () {
                        setState(() {
                          favorites[index] = !favorites[index];
                        });
                      },
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
          // الهيدر
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
            padding: const EdgeInsets.only(top: 48, left: 20, right: 20, bottom: 24),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Spacer(),
                const Text(
                  "Rating",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
          // الفلاتر
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), // تم توحيد البادينج
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), // نفس البادينج
                    minimumSize: const Size(0, 36), // ارتفاع مقارب للزر الآخر
                  ),
                  child: const Text(
                    "Filter",
                    style: TextStyle(
                      color: Color(0xFF00BBD3),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // قائمة الأطباء
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                buildDoctorCard(
                  image: 'assets/rating/Dr. Emma.png',
                  name: "Dr. Emma Hall, M.D.",
                  specialty: "General Doctor",
                  index: 0,
                ),
                buildDoctorCard(
                  image: 'assets/rating/Dr. Jacob.png',
                  name: "Dr. Jacob Lopez, M.D.",
                  specialty: "Surgical Dermatology",
                  index: 1,
                ),
                buildDoctorCard(
                  image: 'assets/rating/Dr. Lucy.png',
                  name: "Dr. Lucy Perez, Ph.D.",
                  specialty: "Clinical Dermatology",
                  index: 2,
                ),
                buildDoctorCard(
                  image: 'assets/rating/Dr. Quinn.png',
                  name: "Dr. Quinn Cooper, M.D.",
                  specialty: "Menopausal and Geriatric Gynecology",
                  index: 3,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: mainColor,
        unselectedItemColor: p,
        currentIndex: 0,
        onTap: (index) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('تم الضغط على عنصر رقم ${index + 1}')),
          );
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/rating/Home.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/rating/Messages.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/rating/User Profile.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/rating/Booking.png', width: 28, height: 28),
            label: '',
          ),
        ],
      ),
    );
  }
}