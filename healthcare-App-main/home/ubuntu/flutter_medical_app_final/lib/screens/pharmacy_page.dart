import 'package:flutter/material.dart';
import 'package:medical_app_base/services/local_storage_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'pharmacy_info_page.dart';
import 'pharmacy_filter_page.dart';
import 'home_screen.dart';
import 'notifications_page.dart';
import 'profile_page.dart';
import 'schedule_page.dart';
import 'favorite_page.dart';
import 'nearby_pharmacies_map_page.dart';
import 'pharmacy_details_page.dart';
import '../utils/favorites_manager.dart';

class PharmacyPage extends StatefulWidget {
  @override
  _PharmacyPageState createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
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
    FavoritesManager.init();
    _determinePosition();
    _loadPharmacies();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        setState(() {
          _locationError = 'خدمة الموقع غير مفعلة.';
        });
      }
      return Future.error('خدمة الموقع غير مفعلة.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          setState(() {
            _locationError = 'تم رفض أذونات الموقع.';
          });
        }
        return Future.error('تم رفض أذونات الموقع');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        setState(() {
          _locationError =
              'أذونات الموقع مرفوضة بشكل دائم، يرجى تمكينها يدوياً.';
        });
      }
      return Future.error(
          'أذونات الموقع مرفوضة بشكل دائم، يرجى تمكينها يدوياً.');
    }

    if (mounted) {
      setState(() {
        _locationError = null;
      });
    }
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (mounted) {
        setState(() {}); // Update UI with location
      }
    } catch (e) {
      if (mounted) {
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
        'recommended': true,
        'rating': 5,
        'favorite': false,
        'latitude': 37.7749,
        'longitude': -122.4194,
      },
      {
        'name': 'Vitality Pharmacy',
        'address': '778 Locust View Drive\nOakland, CA',
        'schedule': '7:15 AM - 6:30 PM',
        'recommended': true,
        'rating': 4,
        'favorite': false,
        'latitude': 37.7849,
        'longitude': -122.4094,
      },
      {
        'name': 'PureHealth Pharmacy',
        'address': '778 Locust View Drive\nOakland, CA',
        'schedule': '7:15 AM - 6:30 PM',
        'recommended': true,
        'rating': 3,
        'favorite': false,
        'latitude': 37.7949,
        'longitude': -122.4294,
      },
      {
        'name': 'Stay Health Pharmacy',
        'address': '778 Locust View Drive\nOakland, CA',
        'schedule': '7:15 AM - 6:30 PM',
        'recommended': true,
        'rating': 2,
        'favorite': false,
        'latitude': 37.7649,
        'longitude': -122.4394,
      },
      {
        'name': 'Always Open Pharmacy',
        'address': '123 Main St\nAnytown, USA',
        'schedule': '24/7 Open',
        'recommended': true,
        'rating': 5,
        'favorite': false,
        'latitude': 37.7700,
        'longitude': -122.4200,
      },
    ];

    // Add general sample pharmacies if they don't exist
    for (var pharmacy in samplePharmacies) {
      bool exists = (await _storage.getPharmacies())
          .any((p) => p['name'] == pharmacy['name']);
      if (!exists) {
        await _storage.savePharmacy(pharmacy);
      }
    }
  }

  void _toggleFavorite(Map<String, dynamic> pharmacy) async {
    final isFav = FavoritesManager.isFavorite(pharmacy['name'], 'pharmacy');
    if (isFav) {
      await FavoritesManager.removeFavorite(pharmacy['name'], 'pharmacy');
    } else {
      await FavoritesManager.addFavorite({...pharmacy, 'type': 'pharmacy'});
    }
    setState(() {
      // إعادة بناء الواجهة لتحديث أيقونة المفضلة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FCFF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Updated height
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
                  'Pharmacies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.location_on, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NearbyPharmaciesMapPage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedFilter,
                          decoration: InputDecoration(
                            labelText: 'Filter by',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            labelStyle: TextStyle(color: Color(0xFF1EC8C8)),
                          ),
                          items: <String>[
                            'All',
                            'Top Rated',
                            '24/7 Open',
                            'Nearby'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedFilter = newValue!;
                              _applyFilter();
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PharmacyFilterPage())).then((result) {
                              if (result != null) {
                                setState(() {
                                  _filteredPharmacies = result;
                                });
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1EC8C8),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Text('Advanced Filter',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _filteredPharmacies.isEmpty
                      ? Center(child: Text('No pharmacies found.'))
                      : ListView.builder(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemCount: _filteredPharmacies.length,
                          itemBuilder: (context, index) {
                            final pharmacy = _filteredPharmacies[index];
                            bool isFavorite = FavoritesManager.isFavorite(
                                pharmacy['name'], 'pharmacy');
                            return Card(
                              margin: EdgeInsets.only(bottom: 16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 4,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PharmacyDetailsPage(
                                                pharmacy: pharmacy)),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                              pharmacy['icon'] ??
                                                  Icons.local_pharmacy,
                                              color: Color(0xFF1EC8C8),
                                              size: 36),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              pharmacy['name'] ?? '',
                                              style: TextStyle(
                                                color: Color(0xFF1EC8C8),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isFavorite
                                                  ? Colors.red
                                                  : Colors.grey,
                                              size: 28,
                                            ),
                                            onPressed: () =>
                                                _toggleFavorite(pharmacy),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                          'Address: ${pharmacy['address'] ?? ''}',
                                          style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 14)),
                                      Text(
                                          'Schedule: ${pharmacy['schedule'] ?? ''}',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 13)),
                                      SizedBox(height: 8),
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
                                                      color: i <
                                                              (pharmacy[
                                                                      'rating'] ??
                                                                  0)
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
                          },
                        ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF1EC8C8),
        unselectedItemColor: Colors.grey,
        currentIndex: 1, // Set to 1 for PharmacyPage
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
              break;
            case 1:
              // Current page, do nothing
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FavoritePage()));
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
      ),
    );
  }
}
