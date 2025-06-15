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
import 'package:medical_app_base/services/local_storage_service.dart';

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
  final LocalStorageService _storage = LocalStorageService();
  List<Map<String, dynamic>> allPharmacies = [];
  List<Map<String, dynamic>> nearbyPharmacies = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _getCurrentLocation();
    await _loadAllPharmacies();
    _filterNearbyPharmacies();
    _addPharmaciesToMap();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      if (mounted) {
        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
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

  Future<void> _loadAllPharmacies() async {
    try {
      final loaded = await _storage.getPharmacies();
      if (mounted) {
        setState(() {
          allPharmacies = loaded;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading pharmacies: $e')));
      }
    }
  }

  void _filterNearbyPharmacies() {
    if (currentLocation == null) {
      nearbyPharmacies = [];
      return;
    }

    nearbyPharmacies = allPharmacies.where((pharmacy) {
      final lat = pharmacy['latitude'] as double?;
      final lon = pharmacy['longitude'] as double?;

      if (lat == null || lon == null) return false;

      final distanceInMeters = Geolocator.distanceBetween(
        currentLocation!.latitude,
        currentLocation!.longitude,
        lat,
        lon,
      );

      const double radiusInMeters = 10000; // 10 km radius
      return distanceInMeters <= radiusInMeters;
    }).toList();
  }

  void _addPharmaciesToMap() {
    markers.clear();
    if (currentLocation != null) {
      markers.add(
        Marker(
          point: currentLocation!,
          width: 80,
          height: 80,
          child: Icon(Icons.location_on, color: Colors.red, size: 40),
        ),
      );
    }

    for (var pharmacy in nearbyPharmacies) {
      final icon = pharmacy['icon'] as IconData? ?? Icons.local_pharmacy;
      markers.add(
        Marker(
          point: LatLng(pharmacy['latitude'], pharmacy['longitude']),
          width: 100,
          height: 120,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PharmacyInfoPage()),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Color(0xFF1EC8C8), size: 40),
                SizedBox(height: 4),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha((0.3 * 255).toInt()),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        pharmacy['name'] as String,
                        style: TextStyle(
                          color: Color(0xFF1EC8C8),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
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
      appBar: AppBar(
        title: Text('تصفية الصيدليات'),
        backgroundColor: Color(0xFF1EC8C8),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              setState(() {
                showMap = !showMap;
              });
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : showMap
              ? FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    center: currentLocation,
                    zoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(markers: markers),
                  ],
                )
              : ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    Text(
                      'الصيدليات القريبة',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1EC8C8),
                      ),
                    ),
                    SizedBox(height: 16),
                    ...nearbyPharmacies.map((pharmacy) {
                      return Card(
                        child: ListTile(
                          leading: Icon(
                              pharmacy['icon'] as IconData? ??
                                  Icons.local_pharmacy,
                              color: Color(0xFF1EC8C8)),
                          title: Text(pharmacy['name']!),
                          subtitle: Text(pharmacy['address']!),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PharmacyInfoPage()),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ],
                ),
    );
  }
}
