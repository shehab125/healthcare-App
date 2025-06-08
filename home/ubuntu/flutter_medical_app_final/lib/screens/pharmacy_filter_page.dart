import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'pharmacy_info_page.dart';
import 'home_screen.dart';
import 'pharmacy_page.dart';
import 'notifications_page_pharmacy.dart';
import 'profile_page.dart';
import 'schedule_page.dart';

class PharmacyFilterPage extends StatefulWidget {
  const PharmacyFilterPage({super.key});

  @override
  State<PharmacyFilterPage> createState() => _PharmacyFilterPageState();
}

class _PharmacyFilterPageState extends State<PharmacyFilterPage> {
  MapController mapController = MapController();
  LatLng? currentLocation;
  List<Marker> markers = [];
  bool isLoading = true;
  bool showMap = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (mounted) {
        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
          _addNearbyPharmacies();
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error getting location: $e')));
      }
    }
  }

  void _addNearbyPharmacies() {
    if (currentLocation == null) return;

    markers.add(
      Marker(
        point: currentLocation!,
        width: 80,
        height: 80,
        child: Icon(Icons.location_on, color: Colors.red, size: 40),
      ),
    );

    final nearbyPharmacies = [
      {
        'name': 'صيدلية العزبي',
        'location': LatLng(
          currentLocation!.latitude + 0.002,
          currentLocation!.longitude + 0.002,
        ),
      },
      {
        'name': 'صيدلية سيف',
        'location': LatLng(
          currentLocation!.latitude - 0.002,
          currentLocation!.longitude - 0.002,
        ),
      },
      {
        'name': 'صيدلية مصر',
        'location': LatLng(
          currentLocation!.latitude + 0.003,
          currentLocation!.longitude - 0.001,
        ),
      },
    ];

    for (var pharmacy in nearbyPharmacies) {
      markers.add(
        Marker(
          point: pharmacy['location'] as LatLng,
          width: 80,
          height: 80,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PharmacyInfoPage()),
              );
            },
            child: Column(
              children: [
                Icon(Icons.local_pharmacy, color: Color(0xFF1EC8C8), size: 40),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha((0.3 * 255).toInt()),
                        spreadRadius: 1,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Text(
                    pharmacy['name'] as String,
                    style: TextStyle(
                      color: Color(0xFF1EC8C8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  'Nearby Pharmacies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                if (showMap)
                  IconButton(
                    icon: Icon(Icons.my_location, color: Colors.white),
                    onPressed: _getCurrentLocation,
                  ),
              ],
            ),
          ),
        ),
      ),
      body: showMap
          ? (isLoading
              ? Center(child: CircularProgressIndicator())
              : currentLocation == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_off,
                              size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'Location not available',
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _getCurrentLocation,
                            child: Text('Try Again'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1EC8C8),
                            ),
                          ),
                        ],
                      ),
                    )
                  : FlutterMap(
                      mapController: mapController,
                      options: MapOptions(center: currentLocation, zoom: 15),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.medical_app',
                        ),
                        MarkerLayer(markers: markers),
                      ],
                    ))
          : Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showMap = true;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color(0xFF1EC8C8),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(
                              0xFF1EC8C8,
                            ).withAlpha((0.3 * 255).toInt()),
                            spreadRadius: 5,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Icon(Icons.map, color: Colors.white, size: 60),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'اضغط لعرض الصيدليات القريبة',
                      style: TextStyle(
                        color: Color(0xFF1EC8C8),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
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
