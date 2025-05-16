import 'package:flutter/material.dart';
import 'favorite_services_page.dart';
import 'favorite_doctors_manager.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final Color gradientStart = const Color(0xFF33E4DB);
  final Color gradientEnd = const Color(0xFF00BBD3);
  final Color mainColor = const Color(0xFF00BBD3);
  final Color text2 = const Color(0xFF222222);
  final Color elements = const Color(0xFFE6F6FE);
  final Color p = const Color(0xFFE0E0E0);

  bool showDoctors = true;

  Widget buildDoctorCard({
    required String image,
    required String name,
    required String specialty,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundImage: AssetImage(image),
            backgroundColor: elements,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('assets/favorite/Group 55.png', width: 18, height: 18),
                    const SizedBox(width: 4),
                    Text("Professional Doctor", style: TextStyle(fontSize: 12, color: mainColor)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: mainColor)),
                const SizedBox(height: 2),
                Text(specialty, style: TextStyle(fontSize: 13, color: text2.withOpacity(0.5))),
                const SizedBox(height: 8),
                SizedBox(
                  width: 170,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('تم حجز موعد مع $name')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 4),
                        const Text("Make Appointment"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.favorite, color: mainColor, size: 22),
        ],
      ),
    );
  }

  Widget buildServiceCard() {
    // يمكنك تخصيص الخدمات لاحقًا
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Center(
        child: Text(
          "No favorite services yet.",
          style: TextStyle(color: text2.withOpacity(0.5), fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // جلب قائمة الأطباء المفضلين من المانجر
    final favoriteDoctors = FavoriteDoctorsManager.getFavorites();

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
                  "Favorite",
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    minimumSize: const Size(0, 36),
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
          // التبديل بين الأطباء والخدمات
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showDoctors = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: showDoctors ? mainColor : Colors.white,
                      foregroundColor: showDoctors ? Colors.white : mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 4),
                        const Text("Doctors"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // هنا نفتح صفحة الخدمات المفضلة
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FavoriteServicesPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !showDoctors ? mainColor : Colors.white,
                      foregroundColor: !showDoctors ? Colors.white : mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 4),
                        const Text("Services"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // قائمة الأطباء أو الخدمات
          Expanded(
            child: showDoctors
                ? (favoriteDoctors.isEmpty
                ? Center(
              child: Text(
                "No favorite doctors yet.",
                style: TextStyle(color: text2.withOpacity(0.5), fontSize: 16),
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: favoriteDoctors.length,
              itemBuilder: (context, index) {
                final doctor = favoriteDoctors[index];
                return buildDoctorCard(
                  image: doctor['image']!,
                  name: doctor['name']!,
                  specialty: doctor['specialty']!,
                );
              },
            ))
                : buildServiceCard(),
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
            icon: Image.asset('assets/favorite/Home.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/favorite/Messages.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/favorite/User Profile.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/favorite/Booking.png', width: 28, height: 28),
            label: '',
          ),
        ],
      ),
    );
  }
}