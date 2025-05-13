import 'package:flutter/material.dart';
import 'package:flutter_medical_app_final/utils/colors.dart';
import 'package:flutter_medical_app_final/utils/styles.dart';
import 'package:flutter_medical_app_final/screens/favorite_page.dart';
import 'package:flutter_medical_app_final/screens/doctors_page.dart';
import 'package:flutter_medical_app_final/screens/pharmacy_page.dart';
import 'package:flutter_medical_app_final/screens/specialties_page.dart';
import 'package:flutter_medical_app_final/screens/record_page.dart';
import 'package:flutter_medical_app_final/screens/cardiology_page.dart';
import 'package:flutter_medical_app_final/screens/dermatology_page.dart';
import 'package:flutter_medical_app_final/screens/general_medicine_page.dart';
import 'package:flutter_medical_app_final/screens/gynecology_page.dart';
import 'package:flutter_medical_app_final/screens/odontology_page.dart';
import 'package:flutter_medical_app_final/screens/oncology_page.dart';
import 'package:flutter_medical_app_final/screens/schedule_page.dart';
import 'package:flutter_medical_app_final/screens/records_page.dart';
import 'package:flutter_medical_app_final/screens/profile_page.dart';
import 'package:flutter_medical_app_final/screens/notifications_page.dart';
import 'package:flutter_medical_app_final/screens/settings_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _MainHomeContent(),
      SchedulePage(),
      RecordsPage(),
      ProfilePage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.folder_open), label: 'Records'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class _MainHomeContent extends StatelessWidget {
  const _MainHomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3EC6E0), Color(0xFF4F8FEA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            padding: const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_none, color: Colors.white),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings_outlined, color: Colors.white),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.search, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Hi, WelcomeBack', style: TextStyle(color: Colors.white70, fontSize: 14)),
                            Text('Jane Doe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage('https://randomuser.me/api/portraits/women/44.jpg'),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Categories
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Categories', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    TextButton(
                      onPressed: () {},
                      child: const Text('See all', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCategoryButton(
                      icon: Icons.favorite_border,
                      label: 'Favorite',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritePage()));
                      },
                    ),
                    _buildCategoryButton(
                      icon: Icons.person_outline,
                      label: 'Doctors',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorsPage()));
                      },
                    ),
                    _buildCategoryButton(
                      icon: Icons.local_pharmacy_outlined,
                      label: 'Pharmacy',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PharmacyPage()));
                      },
                    ),
                    _buildCategoryButton(
                      icon: Icons.category_outlined,
                      label: 'Specialties',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SpecialtiesPage()));
                      },
                    ),
                    _buildCategoryButton(
                      icon: Icons.folder_open,
                      label: 'Record',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RecordPage()));
                      },
                    ),
                    _buildCategoryButton(
                      icon: Icons.payment,
                      label: 'Payment',
                      onTap: () {
                        Navigator.pushNamed(context, '/payment_method');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Upcoming Schedule
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Upcoming Schedule', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Month', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildDaysRow(),
                const SizedBox(height: 16),
                _buildScheduleCard(),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Specialties
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Specialties', style: AppStyles.headlineStyle),
                TextButton(
                  onPressed: () {},
                  child: const Text('See all'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1,
              children: [
                _buildSpecialtyButton(icon: Icons.favorite, label: 'Cardiology', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CardiologyPage()));
                }),
                _buildSpecialtyButton(icon: Icons.healing, label: 'Dermatology', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DermatologyPage()));
                }),
                _buildSpecialtyButton(icon: Icons.person, label: 'General Medicine', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GeneralMedicinePage()));
                }),
                _buildSpecialtyButton(icon: Icons.female, label: 'Gynecology', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GynecologyPage()));
                }),
                _buildSpecialtyButton(icon: Icons.mood, label: 'Odontology', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OdontologyPage()));
                }),
                _buildSpecialtyButton(icon: Icons.biotech, label: 'Oncology', onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OncologyPage()));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 6),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildDaysRow() {
    final days = [
      {'day': '9', 'label': 'MON'},
      {'day': '10', 'label': 'TUE'},
      {'day': '11', 'label': 'WED'},
      {'day': '12', 'label': 'THU'},
      {'day': '13', 'label': 'FRI'},
      {'day': '12', 'label': 'SAT'},
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((d) {
        final isSelected = d['day'] == '11';
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 48,
              height: 56,
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(d['day']!, style: TextStyle(color: isSelected ? AppColors.primaryColor : Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  Text(d['label']!, style: TextStyle(color: isSelected ? AppColors.primaryColor : Colors.white70, fontSize: 12)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildScheduleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('See all', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          _buildScheduleItemButton('11 Month - Wednesday - Today', '10:00 am', 'Dr. Olivia Turner', () {}),
          const SizedBox(height: 8),
          _buildScheduleItemButton('16 Month - Monday', '08:00 am', 'Dr. Alexander Bennett', () {}),
        ],
      ),
    );
  }

  Widget _buildScheduleItemButton(String date, String time, String doctor, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              const Icon(Icons.circle, size: 8, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: '$date   ', style: const TextStyle(color: Colors.white, fontSize: 13)),
                      TextSpan(text: '$time   ', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      TextSpan(text: doctor, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialtyButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 32),
              const SizedBox(height: 8),
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
} 