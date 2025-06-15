import 'package:flutter/material.dart';
import 'package:medical_app_base/utils/colors.dart';
import 'package:medical_app_base/utils/styles.dart';
import 'package:medical_app_base/screens/favorite_page.dart';
import 'package:medical_app_base/screens/doctors_page.dart';
import 'package:medical_app_base/screens/pharmacy_page.dart';
import 'package:medical_app_base/screens/specialties_page.dart';
import 'package:medical_app_base/screens/record_page.dart';
import 'package:medical_app_base/screens/cardiology_page.dart';
import 'package:medical_app_base/screens/dermatology_page.dart';
import 'package:medical_app_base/screens/general_medicine_page.dart';
import 'package:medical_app_base/screens/gynecology_page.dart';
import 'package:medical_app_base/screens/odontology_page.dart';
import 'package:medical_app_base/screens/oncology_page.dart';
import 'package:medical_app_base/screens/schedule_page.dart';
import 'package:medical_app_base/screens/records_page.dart';
import 'package:medical_app_base/screens/profile_page.dart';
import 'package:medical_app_base/screens/notifications_page.dart';
import 'package:medical_app_base/screens/settings_page.dart';
import 'package:medical_app_base/screens/chat_page.dart';
import 'package:medical_app_base/screens/medical_records_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Schedule'),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder_open), label: 'Records'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

class _MainHomeContent extends StatefulWidget {
  const _MainHomeContent({Key? key}) : super(key: key);

  @override
  State<_MainHomeContent> createState() => _MainHomeContentState();
}

class _MainHomeContentState extends State<_MainHomeContent> {
  File? _imageFile;
  // String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    // _loadProfileImage();
  }

  // Future<void> _loadProfileImage() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _profileImageUrl = prefs.getString('profile_image_url');
  //   });
  // }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
        // _profileImageUrl = null; // Clear network image to show local
      });
      // TODO: Upload image to Cloudinary
      // For now, let's just display it locally
      // _uploadImageToCloudinary(_imageFile!); // Call the upload function
    }
  }

  // Future<void> _uploadImageToCloudinary(File image) async {
  //   // This is a placeholder for Cloudinary upload logic
  //   // You will need to replace this with actual Cloudinary API calls
  //   // using your Cloud Name, API Key, and API Secret.
  //   // Example: using a package or direct http request
  //   print('Uploading image to Cloudinary: ${image.path}');
  //
  //   // Dummy URL for demonstration
  //   String dummyUrl = 'https://via.placeholder.com/150'; // Replace with actual Cloudinary URL
  //
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('profile_image_url', dummyUrl);
  //
  //   // setState(() {
  //   //   _profileImageUrl = dummyUrl;
  //   // });
  //
  //   // ScaffoldMessenger.of(context).showSnackBar(
  //   //   SnackBar(content: Text('Profile image updated (Cloudinary upload placeholder)!')),
  //   // );
  // }

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
            padding:
                const EdgeInsets.only(top: 48, left: 16, right: 16, bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.notifications_none,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NotificationsPage()));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings_outlined,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsPage()));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.chat_bubble_outline,
                              color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage()));
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Hi, WelcomeBack',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 14)),
                            Text('Jane Doe',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                          ],
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: _imageFile != null
                                ? FileImage(_imageFile!)
                                    as ImageProvider<Object>
                                : const NetworkImage(
                                    'https://randomuser.me/api/portraits/women/44.jpg'), // Default image
                          ),
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
                    Text('Categories',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18)),
                    TextButton(
                      onPressed: () {},
                      child: const Text('See all',
                          style: TextStyle(color: Colors.white)),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FavoritePage()));
                      },
                    ),
                    _buildCategoryButton(
                      icon: Icons.person_outline,
                      label: 'Doctors',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctorsPage()));
                      },
                    ),
                    _buildCategoryButton(
                      icon: Icons.local_pharmacy_outlined,
                      label: 'Pharmacy',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PharmacyPage()));
                      },
                    ),
                    _buildCategoryButton(
                      icon: Icons.star_border,
                      label: 'Specialties',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SpecialtiesPage()));
                      },
                    ),
                    _buildCategoryButton(
                      icon: Icons.folder_open,
                      label: 'Record',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecordsPage()));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text('Upcoming Schedule',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                const SizedBox(height: 16),
                // Upcoming Schedule
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5, // Sample data
                    itemBuilder: (context, index) {
                      DateTime date = DateTime.now().add(Duration(days: index));
                      bool isToday = index == 0;
                      return Container(
                        width: 70,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: isToday ? Colors.white : Colors.white24,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${date.day}',
                              style: TextStyle(
                                color: isToday ? Colors.blue : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              '${_getDayOfWeek(date.weekday)}',
                              style: TextStyle(
                                color: isToday ? Colors.blue : Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('See all',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('Month',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildScheduleItem(
                        date: '11 Month - Wednesday - Today',
                        time: '10:00 am',
                        doctor: 'Dr. Olivia Turner',
                      ),
                      _buildScheduleItem(
                        date: '16 Month - Monday',
                        time: '08:00 am',
                        doctor: 'Dr. Alexander Bennett',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Specialties
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Specialties',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SpecialtiesPage()));
                  },
                  child: const Text('See all',
                      style: TextStyle(color: Colors.blueAccent)),
                ),
              ],
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildSpecialtyItem(
                  icon: Icons.favorite,
                  label: 'Cardiology',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CardiologyPage()));
                  }),
              _buildSpecialtyItem(
                  icon: Icons.healing,
                  label: 'Dermatology',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DermatologyPage()));
                  }),
              _buildSpecialtyItem(
                  icon: Icons.person,
                  label: 'General Medicine',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GeneralMedicinePage()));
                  }),
              _buildSpecialtyItem(
                  icon: Icons.female,
                  label: 'Gynecology',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GynecologyPage()));
                  }),
              _buildSpecialtyItem(
                  icon: Icons.sentiment_satisfied_alt,
                  label: 'Odontology',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OdontologyPage()));
                  }),
              _buildSpecialtyItem(
                  icon: Icons.science,
                  label: 'Oncology',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OncologyPage()));
                  }),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _getDayOfWeek(int weekday) {
    switch (weekday) {
      case 1:
        return 'MON';
      case 2:
        return 'TUE';
      case 3:
        return 'WED';
      case 4:
        return 'THU';
      case 5:
        return 'FRI';
      case 6:
        return 'SAT';
      case 7:
        return 'SUN';
      default:
        return '';
    }
  }

  Widget _buildCategoryButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem(
      {required String date, required String time, required String doctor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 4,
            backgroundColor: Colors.blueAccent,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$date - $time',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  doctor,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtyItem(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.blueAccent, size: 40),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
