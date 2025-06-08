import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:medical_app_base/services/local_storage_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'pharmacy_info_page.dart';
import 'home_screen.dart';
import 'notifications_page.dart';
import 'profile_page.dart';
import 'schedule_page.dart';
import 'favorite_page.dart';
import 'nearby_pharmacies_map_page.dart';
import 'pharmacy_details_page.dart';
=======
import 'pharmacy_info_page.dart';
import 'pharmacy_filter_page.dart';
import 'home_screen.dart';
import 'notifications_page_pharmacy.dart';
import 'profile_page.dart';
import 'schedule_page.dart';
import 'favorite_page.dart';
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b

class PharmacyPage extends StatefulWidget {
  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
<<<<<<< HEAD
  final LocalStorageService _storage = LocalStorageService();
  List<Map<String, dynamic>> pharmacies = [];
  List<Map<String, dynamic>> _filteredPharmacies = [];
  bool isLoading = true;
  Position? _currentPosition;
  String? _locationError;
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _determinePosition();
    _loadPharmacies();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationError = 'خدمة الموقع غير مفعلة.';
      });
      return Future.error('خدمة الموقع غير مفعلة.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationError = 'تم رفض أذونات الموقع.';
        });
        return Future.error('تم رفض أذونات الموقع');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationError = 'أذونات الموقع مرفوضة بشكل دائم، يرجى تمكينها يدوياً.';
      });
      return Future.error(
          'أذونات الموقع مرفوضة بشكل دائم، يرجى تمكينها يدوياً.');
    }

    setState(() {
      _locationError = null;
    });
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {}); // Update UI with location
    } catch (e) {
      setState(() {
        _locationError = 'فشل الحصول على الموقع: ${e.toString()}';
        _currentPosition = Position(
            latitude: 0.0,
            longitude: 0.0,
            timestamp: DateTime.now(),
            accuracy: 0.0,
            altitude: 0.0,
            heading: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0,
            isMocked: false,
            altitudeAccuracy: 0.0,
            headingAccuracy: 0.0);
      });
    }
  }

  Future<void> _loadPharmacies() async {
    try {
      // Ensure sample pharmacies are always present (added if not existing)
      await _addSamplePharmacies(); // Call unconditionally

      final loadedPharmacies = await _storage.getPharmacies();
      setState(() {
        pharmacies = loadedPharmacies; // Now this will include all samples
        _applyFilter(); // Apply filter after loading
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading pharmacies: $e')));
    }
  }

  void _applyFilter() {
    setState(() {
      if (_selectedFilter == 'All') {
        _filteredPharmacies = List.from(pharmacies);
      } else if (_selectedFilter == 'Top Rated') {
        _filteredPharmacies = List.from(pharmacies)
          ..sort((a, b) => (b['rating'] as int).compareTo(a['rating'] as int));
      } else if (_selectedFilter == '24/7 Open') {
        _filteredPharmacies = pharmacies
            .where((p) => p['schedule'].toString().contains('24/7 Open'))
            .toList();
      } else if (_selectedFilter == 'Nearby') {
        // No filtering on this screen, handled by navigation
        _filteredPharmacies = List.from(pharmacies); // Keep all for this list
      }
    });
  }

  Future<void> _addSamplePharmacies() async {
    final samplePharmacies = [
      {
        'name': 'MediCure Pharmacy',
        'address': '778 Locust View Drive\nOakland, CA',
        'schedule': '7:15 AM - 6:30 PM',
        'recommended': 1,
        'rating': 5,
        'favorite': 0,
        'latitude': 37.7749,
        'longitude': -122.4194,
      },
      {
        'name': 'Vitality Pharmacy',
        'address': '778 Locust View Drive\nOakland, CA',
        'schedule': '7:15 AM - 6:30 PM',
        'recommended': 1,
        'rating': 4,
        'favorite': 0,
        'latitude': 37.7849,
        'longitude': -122.4094,
      },
      {
        'name': 'PureHealth Pharmacy',
        'address': '778 Locust View Drive\nOakland, CA',
        'schedule': '7:15 AM - 6:30 PM',
        'recommended': 1,
        'rating': 3,
        'favorite': 0,
        'latitude': 37.7949,
        'longitude': -122.4294,
      },
      {
        'name': 'Stay Health Pharmacy',
        'address': '778 Locust View Drive\nOakland, CA',
        'schedule': '7:15 AM - 6:30 PM',
        'recommended': 1,
        'rating': 2,
        'favorite': 0,
        'latitude': 37.7649,
        'longitude': -122.4394,
      },
      {
        'name': 'Always Open Pharmacy',
        'address': '123 Main St\nAnytown, USA',
        'schedule': '24/7 Open',
        'recommended': 1,
        'rating': 5,
        'favorite': 0,
        'latitude': 37.7700,
        'longitude': -122.4200,
      },
    ];

    for (var pharmacy in samplePharmacies) {
      bool exists = (await _storage.getPharmacies())
          .any((p) => p['name'] == pharmacy['name']);
      if (!exists) {
        await _storage.savePharmacy(pharmacy);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacies'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1EC8C8), Color(0xFF6EE2F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.map, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NearbyPharmaciesMapPage(),
                ),
=======
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
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
              );
            },
          ),
        ],
      ),
<<<<<<< HEAD
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for pharmacies...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                // TODO: Implement search functionality
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilterButton(
                  text: 'All',
                  isSelected: _selectedFilter == 'All',
                  onPressed: () {
                    setState(() {
                      _selectedFilter = 'All';
                    });
                    _applyFilter();
                  },
                ),
                FilterButton(
                  text: 'Nearby',
                  isSelected: _selectedFilter == 'Nearby',
                  onPressed: () {
                    setState(() {
                      _selectedFilter = 'Nearby';
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NearbyPharmaciesMapPage(),
                      ),
                    );
                  },
                ),
                FilterButton(
                  text: 'Top Rated',
                  isSelected: _selectedFilter == 'Top Rated',
                  onPressed: () {
                    setState(() {
                      _selectedFilter = 'Top Rated';
                      _applyFilter();
                    });
                  },
                ),
                FilterButton(
                  text: '24/7 Open',
                  isSelected: _selectedFilter == '24/7 Open',
                  onPressed: () {
                    setState(() {
                      _selectedFilter = '24/7 Open';
                      _applyFilter();
                    });
                  },
                ),
              ],
            ),
          ),
          _locationError != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_off, size: 80, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(_locationError!,
                          style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _determinePosition,
                        child: Text('Try Again'),
                      ),
                    ],
                  ),
                )
              : isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _filteredPharmacies.length,
                        itemBuilder: (context, index) {
                          final pharmacy = _filteredPharmacies[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pharmacy['name'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1EC8C8),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          color: Colors.grey[600], size: 18),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          pharmacy['address'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[700]),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time,
                                          color: Colors.grey[600], size: 18),
                                      SizedBox(width: 4),
                                      Text(
                                        pharmacy['schedule'],
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700]),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.amber, size: 18),
                                      SizedBox(width: 4),
                                      Text(
                                        '${pharmacy['rating']}/5',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700]),
                                      ),
                                      Spacer(),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PharmacyDetailsPage(
                                                      pharmacy: pharmacy),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.info, size: 20),
                                        label: Text('Details'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF1EC8C8),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  const FilterButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(text),
      selected: isSelected,
      onSelected: (selected) {
        onPressed();
      },
      selectedColor: Color(0xFF1EC8C8),
      labelStyle:
          TextStyle(color: isSelected ? Colors.white : Color(0xFF1EC8C8)),
      shape:
          StadiumBorder(side: BorderSide(color: Color(0xFF1EC8C8), width: 1.5)),
      backgroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}
=======
    );
  }
} 
>>>>>>> 5a67e16128241255dd3da8fb8ba5e804f0a4e71b
