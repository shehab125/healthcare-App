import 'package:flutter/material.dart';
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
              );
            },
          ),
        ],
      ),
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
