import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'pharmacy_page.dart';
import 'notifications_page_pharmacy.dart';
import 'profile_page.dart';
import 'schedule_page.dart';
import 'pharmacy_info_page.dart';
import '../utils/favorites_manager.dart';

class PharmacyFavoritesPage extends StatefulWidget {
  const PharmacyFavoritesPage({super.key});

  @override
  State<PharmacyFavoritesPage> createState() => _PharmacyFavoritesPageState();
}

class _PharmacyFavoritesPageState extends State<PharmacyFavoritesPage> {
  String searchText = '';
  List<Map<String, dynamic>> favoritePharmacies = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    await FavoritesManager.init();
    setState(() {
      favoritePharmacies = FavoritesManager.getFavoritePharmacies();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPharmacies = favoritePharmacies.where((pharmacy) {
      if (pharmacy.isEmpty) return false;
      final input = searchText.toLowerCase().trim();
      final name = (pharmacy['name'] as String? ?? '').toLowerCase();
      final address = (pharmacy['address'] as String? ?? '').toLowerCase();
      return input.isEmpty || name.contains(input) || address.contains(input);
    }).toList();

    return Scaffold(
      backgroundColor: Color(0xFFF8FCFF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
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
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 8),
                Text(
                  'Favorite Pharmacies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find your favorite pharmacy',
                  style: TextStyle(
                    color: Color(0xFF1EC8C8),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Search Pharmacy Name or Address',
                    labelStyle: TextStyle(color: Color(0xFF1EC8C8)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    suffixIcon: searchText.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: Color(0xFF1EC8C8)),
                            onPressed: () {
                              setState(() {
                                searchText = '';
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredPharmacies.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 80,
                          color: Color(0xFF1EC8C8),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No favorites yet',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    itemCount: filteredPharmacies.length,
                    itemBuilder: (context, index) {
                      final pharmacy = filteredPharmacies[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 2,
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PharmacyInfoPage()),
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on, color: Color(0xFF1EC8C8)),
                                    SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        pharmacy['name'] as String? ?? '',
                                        style: TextStyle(
                                          color: Color(0xFF1EC8C8),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE6F7FA),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        'Distance: ${pharmacy['distance'] as String? ?? ''}',
                                        style: TextStyle(
                                          color: Color(0xFF1EC8C8),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Address: ${pharmacy['address'] as String? ?? ''}',
                                  style: TextStyle(color: Colors.black87, fontSize: 14),
                                ),
                                Text(
                                  'Attention Schedule: ${pharmacy['schedule'] as String? ?? ''}',
                                  style: TextStyle(color: Colors.black54, fontSize: 13),
                                ),
                                SizedBox(height: 6),
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
                                      children: List.generate(
                                        5,
                                        (i) => Icon(
                                          Icons.star,
                                          color: i < (pharmacy['rating'] as int? ?? 0)
                                              ? Color(0xFF1EC8C8)
                                              : Colors.grey[300],
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
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
      bottomNavigationBar: _buildBottomNavBar(context),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.local_pharmacy, color: Color(0xFF1EC8C8)),
            onPressed: () {
              Navigator.push(
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
