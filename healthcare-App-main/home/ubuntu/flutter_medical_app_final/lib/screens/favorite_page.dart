import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'pharmacy_page.dart';
import 'notifications_page.dart';
import 'profile_page.dart';
import 'schedule_page.dart';
import 'pharmacy_info_page.dart';
import 'doctor_details_page.dart';
import '../utils/favorites_manager.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String searchText = '';
  List<Map<String, dynamic>> allFavorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    await FavoritesManager.init();
    setState(() {
      allFavorites = FavoritesManager.getAllFavorites();
    });
  }

  Future<void> _removeFavorite(String identifier, String type) async {
    await FavoritesManager.removeFavorite(identifier, type);
    await _loadFavorites();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item removed from favorites')),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredFavorites = allFavorites.where((item) {
      final input = searchText.toLowerCase().trim();
      final name = (item['name'] ?? '').toLowerCase();
      final type = (item['type'] ?? '').toLowerCase();
      return input.isEmpty || name.contains(input) || type.contains(input);
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
                  'Favorites',
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Find your favorites',
                    style: TextStyle(
                        color: Color(0xFF1EC8C8),
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle: TextStyle(color: Color(0xFF1EC8C8)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
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
            child: filteredFavorites.isEmpty
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
                    itemCount: filteredFavorites.length,
                    itemBuilder: (context, index) {
                      final item = filteredFavorites[index];
                      final itemType = item['type'];

                      if (itemType == 'pharmacy') {
                        return _buildPharmacyCard(item);
                      } else if (itemType == 'doctor') {
                        return _buildDoctorCard(item);
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildPharmacyCard(Map<String, dynamic> pharmacy) {
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Color(0xFF1EC8C8)),
                  SizedBox(width: 6),
                  Text(
                    pharmacy['name'] ?? '',
                    style: TextStyle(
                      color: Color(0xFF1EC8C8),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Color(0xFFE6F7FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('Distance: ${pharmacy['distance'] ?? ''}',
                        style: TextStyle(
                            color: Color(0xFF1EC8C8),
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () =>
                        _removeFavorite(pharmacy['name'], 'pharmacy'),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text('Address: ${pharmacy['address'] ?? ''}',
                  style: TextStyle(color: Colors.black87, fontSize: 14)),
              Text('Attention Schedule: ${pharmacy['schedule'] ?? ''}',
                  style: TextStyle(color: Colors.black54, fontSize: 13)),
              SizedBox(height: 6),
              Row(
                children: [
                  Text('Recommended',
                      style: TextStyle(
                          color: Color(0xFF1EC8C8),
                          fontWeight: FontWeight.bold,
                          fontSize: 13)),
                  SizedBox(width: 8),
                  Row(
                    children: List.generate(
                        5,
                        (i) => Icon(
                              Icons.star,
                              color: i < (pharmacy['rating'] ?? 0)
                                  ? Color(0xFF1EC8C8)
                                  : Colors.grey[300],
                              size: 18,
                            )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
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
                builder: (context) => DoctorDetailsPage(doctor: doctor)),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        doctor['image'] ?? 'https://via.placeholder.com/150'),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      doctor['name'] ?? '',
                      style: TextStyle(
                        color: Color(0xFF1EC8C8),
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => _removeFavorite(doctor['name'], 'doctor'),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text('Specialty: ${doctor['specialty'] ?? ''}',
                  style: TextStyle(color: Colors.black87, fontSize: 14)),
              Text('Clinic: ${doctor['clinic'] ?? ''}',
                  style: TextStyle(color: Colors.black54, fontSize: 13)),
              SizedBox(height: 6),
              Row(
                children: [
                  Text('Rating',
                      style: TextStyle(
                          color: Color(0xFF1EC8C8),
                          fontWeight: FontWeight.bold,
                          fontSize: 13)),
                  SizedBox(width: 8),
                  Row(
                    children: List.generate(
                        5,
                        (i) => Icon(
                              Icons.star,
                              color: i < (doctor['rating'] ?? 0)
                                  ? Color(0xFF1EC8C8)
                                  : Colors.grey[300],
                              size: 18,
                            )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFF1EC8C8),
      unselectedItemColor: Colors.grey,
      currentIndex: 4, // Set to 4 for FavoritePage
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
            break;
          case 1:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => PharmacyPage()));
            break;
          case 2:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SchedulePage()));
            break;
          case 3:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => NotificationsPage()));
            break;
          case 4:
            // Current page, do nothing
            break;
          case 5:
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_pharmacy),
          label: 'Pharmacy',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Schedule',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
