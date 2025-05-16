import 'package:flutter/material.dart';
import 'favorite_services_page.dart';
class FavoriteServicesPage extends StatefulWidget {
  const FavoriteServicesPage({Key? key}) : super(key: key);

  @override
  State<FavoriteServicesPage> createState() => _FavoriteServicesPageState();
}

class _FavoriteServicesPageState extends State<FavoriteServicesPage> {
  final Color gradientStart = const Color(0xFF33E4DB);
  final Color gradientEnd = const Color(0xFF00BBD3);
  final Color mainColor = const Color(0xFF00BBD3);
  final Color text2 = const Color(0xFF222222);
  final Color elements = const Color(0xFFE6F6FE);
  final Color p = const Color(0xFFE0E0E0);

  bool showDoctors = false;

  // حالة التوسيع لكل خدمة
  Map<String, bool> expandedServices = {
    'Cardiology': true,
    'Dermatology': false,
    'General Medicine': false,
    'Gynecology': false,
    'Odontology': false,
    'Oncology': false,
  };

  // وصف وعبارة Looking لكل قسم
  final Map<String, Map<String, String>> serviceDetails = {
    'Cardiology': {
      'description': 'This section is about heart and cardiovascular diseases, diagnosis, and treatment.',
      'looking': 'Looking Cardiology Doctors',
    },
    'Dermatology': {
      'description': 'This section covers skin, hair, and nail disorders, including acne, eczema, and more.',
      'looking': 'Looking Dermatology Doctors',
    },
    'General Medicine': {
      'description': 'General Medicine deals with the prevention, diagnosis, and treatment of adult diseases.',
      'looking': 'Looking General Medicine Doctors',
    },
    'Gynecology': {
      'description': 'Gynecology focuses on women\'s reproductive health and related medical conditions.',
      'looking': 'Looking Gynecology Doctors',
    },
    'Odontology': {
      'description': 'Odontology is concerned with the study and treatment of dental and oral diseases.',
      'looking': 'Looking Odontology Doctors',
    },
    'Oncology': {
      'description': 'Oncology is the branch of medicine that deals with the prevention, diagnosis, and treatment of cancer.',
      'looking': 'Looking Oncology Doctors',
    },
  };

  Widget buildServiceButton({
    required String icon,
    required String label,
    required bool expanded,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Image.asset(icon, width: 22, height: 22, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Icon(
                expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة عامة لعرض تفاصيل كل قسم
  Widget buildExpandedService(String section) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(12),
            child: Text(
              serviceDetails[section]!['description']!,
              style: TextStyle(color: text2.withOpacity(0.7)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: elements,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(12),
            child: Text(
              serviceDetails[section]!['looking']!,
              style: const TextStyle(
                color: Color(0xFF00BBD3),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
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
                      setState(() {
                        showDoctors = false;
                      });
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
          // محتوى الخدمات أو الأطباء
          if (!showDoctors)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                children: [
                  // Cardiology (expanded)
                  buildServiceButton(
                    icon: 'assets/favorite_services/Vector 158 (Stroke)-2.png',
                    label: 'Cardiology',
                    expanded: expandedServices['Cardiology']!,
                    onTap: () {
                      setState(() {
                        expandedServices['Cardiology'] = !expandedServices['Cardiology']!;
                      });
                    },
                  ),
                  if (expandedServices['Cardiology']!) buildExpandedService('Cardiology'),
                  // باقي الخدمات
                  buildServiceButton(
                    icon: 'assets/favorite_services/Vector 158 (Stroke)-2.png',
                    label: 'Dermatology',
                    expanded: expandedServices['Dermatology']!,
                    onTap: () {
                      setState(() {
                        expandedServices['Dermatology'] = !expandedServices['Dermatology']!;
                      });
                    },
                  ),
                  if (expandedServices['Dermatology']!) buildExpandedService('Dermatology'),
                  buildServiceButton(
                    icon: 'assets/favorite_services/Vector 158 (Stroke)-2.png',
                    label: 'General Medicine',
                    expanded: expandedServices['General Medicine']!,
                    onTap: () {
                      setState(() {
                        expandedServices['General Medicine'] = !expandedServices['General Medicine']!;
                      });
                    },
                  ),
                  if (expandedServices['General Medicine']!) buildExpandedService('General Medicine'),
                  buildServiceButton(
                    icon: 'assets/favorite_services/Vector 158 (Stroke)-2.png',
                    label: 'Gynecology',
                    expanded: expandedServices['Gynecology']!,
                    onTap: () {
                      setState(() {
                        expandedServices['Gynecology'] = !expandedServices['Gynecology']!;
                      });
                    },
                  ),
                  if (expandedServices['Gynecology']!) buildExpandedService('Gynecology'),
                  buildServiceButton(
                    icon: 'assets/favorite_services/Vector 158 (Stroke)-2.png',
                    label: 'Odontology',
                    expanded: expandedServices['Odontology']!,
                    onTap: () {
                      setState(() {
                        expandedServices['Odontology'] = !expandedServices['Odontology']!;
                      });
                    },
                  ),
                  if (expandedServices['Odontology']!) buildExpandedService('Odontology'),
                  buildServiceButton(
                    icon: 'assets/favorite_services/Vector 158 (Stroke)-2.png',
                    label: 'Oncology',
                    expanded: expandedServices['Oncology']!,
                    onTap: () {
                      setState(() {
                        expandedServices['Oncology'] = !expandedServices['Oncology']!;
                      });
                    },
                  ),
                  if (expandedServices['Oncology']!) buildExpandedService('Oncology'),
                ],
              ),
            )
          else
            Expanded(
              child: Center(
                child: Text(
                  "No favorite doctors yet.",
                  style: TextStyle(color: text2.withOpacity(0.7)),
                ),
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
            icon: Image.asset('assets/favorite_services/Home.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/favorite_services/Messages.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/favorite_services/User Profile.png', width: 28, height: 28),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/favorite_services/Booking-5.png', width: 28, height: 28),
            label: '',
          ),
        ],
      ),
    );
  }
}