import 'package:flutter/material.dart';
import 'pharmacy_info_page.dart';
import 'pharmacy_filter_page.dart';
import 'home_screen.dart';
import 'notifications_page.dart';
import 'profile_page.dart';
import 'schedule_page.dart';
import 'favorite_page.dart';

class PharmacyPage extends StatefulWidget {
  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  final List<Map<String, dynamic>> pharmacies = [
    {
      'name': 'MediCure Pharmacy',
      'address': '778 Locust View Drive\nOakland, CA',
      'schedule': '7:15 AM - 6:30 PM',
      'recommended': true,
      'rating': 5,
      'icon': Icons.local_pharmacy,
      'favorite': false,
    },
    {
      'name': 'Vitality Pharmacy',
      'address': '778 Locust View Drive\nOakland, CA',
      'schedule': '7:15 AM - 6:30 PM',
      'recommended': true,
      'rating': 4,
      'icon': Icons.health_and_safety,
      'favorite': false,
    },
    {
      'name': 'PureHealth Pharmacy',
      'address': '778 Locust View Drive\nOakland, CA',
      'schedule': '7:15 AM - 6:30 PM',
      'recommended': true,
      'rating': 3,
      'icon': Icons.add_circle_outline,
      'favorite': false,
    },
    {
      'name': 'Stay Health Pharmacy',
      'address': '778 Locust View Drive\nOakland, CA',
      'schedule': '7:15 AM - 6:30 PM',
      'recommended': true,
      'rating': 2,
      'icon': Icons.vaccines,
      'favorite': false,
    },
  ];

  bool showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayedPharmacies = showFavoritesOnly
        ? pharmacies.where((ph) => ph['favorite'] == true).toList()
        : pharmacies;
    return Scaffold(
      backgroundColor: Color(0xFFF8FCFF),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
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
              padding: EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Pharmacy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Find Your Pharmacy',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              prefixIcon: Icon(Icons.search, color: Color(0xFF1EC8C8)),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.filter_list, color: Color(0xFF1EC8C8)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PharmacyFilterPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Sort By', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.sort_by_alpha, color: Color(0xFF1EC8C8), size: 18),
                            SizedBox(width: 4),
                            Text('A-Z', style: TextStyle(color: Color(0xFF1EC8C8), fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      _buildFilterButton('Info', context),
                      _buildFilterButton('Favorites', context),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                itemCount: displayedPharmacies.length,
                itemBuilder: (context, index) {
                  final pharmacy = displayedPharmacies[index];
                  final originalIndex = pharmacies.indexOf(pharmacy);
                  return _buildPharmacyCard(pharmacy, originalIndex, context);
                },
              ),
            ),
            _buildBottomNavBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.white, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white.withOpacity(0.15),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        ),
        onPressed: () {
          if (label == 'Info') {
            setState(() {
              showFavoritesOnly = false;
            });
          } else if (label == 'Favorites') {
            setState(() {
              showFavoritesOnly = true;
            });
          }
        },
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Caveat',
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildPharmacyCard(Map<String, dynamic> pharmacy, int originalIndex, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PharmacyInfoPage(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Color(0xFFE6F7FA),
                child: Icon(pharmacy['icon'], color: Color(0xFF1EC8C8), size: 36),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            pharmacy['name'],
                            style: TextStyle(
                              color: Color(0xFF1EC8C8),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: AnimatedSwitcher(
                            duration: Duration(milliseconds: 250),
                            transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
                            child: Icon(
                              pharmacy['favorite'] ? Icons.favorite : Icons.favorite_border,
                              key: ValueKey(pharmacy['favorite']),
                              color: Color(0xFF1EC8C8),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              pharmacies[originalIndex]['favorite'] = !pharmacies[originalIndex]['favorite'];
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(pharmacies[originalIndex]['favorite'] ? 'Added to favorites' : 'Removed from favorites'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.info_outline, color: Color(0xFF1EC8C8)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PharmacyInfoPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Address: ' + pharmacy['address'],
                      style: TextStyle(color: Colors.black87, fontSize: 13),
                    ),
                    Text(
                      'Schedule: ' + pharmacy['schedule'],
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          'Recommended',
                          style: TextStyle(
                            color: Color(0xFF1EC8C8),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(width: 8),
                        Row(
                          children: List.generate(5, (i) => Icon(
                            Icons.star,
                            color: i < pharmacy['rating'] ? Color(0xFF1EC8C8) : Colors.grey[300],
                            size: 18,
                          )),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Color(0xFFE6F7FA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home, color: Color(0xFF1EC8C8)),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.local_pharmacy, color: Color(0xFF1EC8C8)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PharmacyPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_none, color: Color(0xFF1EC8C8)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: Color(0xFF1EC8C8)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today, color: Color(0xFF1EC8C8)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SchedulePage()),
              );
            },
          ),
        ],
      ),
    );
  }
} 