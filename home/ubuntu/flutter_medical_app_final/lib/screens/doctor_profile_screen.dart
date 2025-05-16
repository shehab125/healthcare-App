import 'package:flutter/material.dart';
import 'doctor_profile_screen.dart';

class DoctorProfilePage extends StatelessWidget {
  final String image;
  final String name;
  final String specialty;

  const DoctorProfilePage({
    Key? key,
    required this.image,
    required this.name,
    required this.specialty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color gradientStart = const Color(0xFF33E4DB);
    final Color gradientEnd = const Color(0xFF00BBD3);
    final Color mainColor = const Color(0xFF00BBD3);
    final Color text2 = const Color(0xFF222222);
    final Color elements = const Color(0xFFE6F6FE);
    final Color p = const Color(0xFFE0E0E0);

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
            padding: const EdgeInsets.only(top: 48, left: 20, right: 20, bottom: 16),
            child: Column(
              children: [
                // Row: Back + Schedule
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      ),
                      child: Row(
                        children: [
                          Image.asset('assets/doctor profile/schedule (2).png', width: 18, height: 18),
                          const SizedBox(width: 4),
                          const Text('Schedule'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Row: 4 icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _circleIcon('assets/doctor profile/Group 50.png'),
                    const SizedBox(width: 8),
                    _circleIcon('assets/doctor profile/Group 51.png'),
                    const SizedBox(width: 8),
                    _circleIcon('assets/doctor profile/Group 52.png'),
                    const SizedBox(width: 8),

                  ],
                ),
                const SizedBox(height: 8),
                // Doctor Info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(image),
                      backgroundColor: p,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white)),
                          const SizedBox(height: 4),
                          Text(specialty,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.white70)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: elements,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset('assets/doctor profile/Group 18.png', width: 16, height: 16),
                                    const SizedBox(width: 2),
                                    const Text("5", style: TextStyle(fontWeight: FontWeight.bold)),
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
                                    Image.asset('assets/doctor profile/Group 14.png', width: 16, height: 16),
                                    const SizedBox(width: 2),
                                    const Text("40", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // معلومات الطبيب
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // البوكس الأول: الخبرة
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/doctor profile/Group 53.png', width: 18, height: 18),
                      const SizedBox(width: 8),
                      const Text(
                        "15 years experience",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF222222),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // البوكس الثاني: الدوام
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/doctor profile/Vector.png', width: 18, height: 18),
                      const SizedBox(width: 8),
                      const Text(
                        "Mon-Sat / 9:00AM - 5:00PM",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF222222),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFFE9F6FD), // لون أزرق فاتح جداً مثل الصورة
                borderRadius: BorderRadius.circular(16),
                // يمكنك إضافة ظل خفيف إذا أردت
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: text2,
                    fontSize: 14,
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(
                      text: "Focus: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: text2,
                      ),
                    ),
                    TextSpan(
                      text: "The impact of hormonal imbalances on skin conditions, specializing in acne, hirsutism, and other skin disorders.",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: text2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              children: [
                _sectionTitle("Profile", mainColor),
                _sectionText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", text2),
                const SizedBox(height: 12),
                _sectionTitle("Career Path", mainColor),
                _sectionText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", text2),
                const SizedBox(height: 12),
                _sectionTitle("Highlights", mainColor),
                _sectionText("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", text2),
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
            icon: Image.asset('assets/doctor profile/Home.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/doctor profile/Messages.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/doctor profile/User Profile.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/doctor profile/Booking.png', width: 28, height: 28),
            label: '',
          ),
        ],
      ),
    );
  }

  // Widget for circle icon
  Widget _circleIcon(String asset) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset(asset, width: 20, height: 20),
      ),
    );
  }

  // Widget for section title
  Widget _sectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  // Widget for section text
  Widget _sectionText(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        text,
        style: TextStyle(color: color.withOpacity(0.7)),
      ),
    );
  }
}