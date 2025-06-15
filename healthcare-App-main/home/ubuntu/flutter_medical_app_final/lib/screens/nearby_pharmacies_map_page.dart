import 'package:flutter/material.dart';
import 'package:medical_app_base/services/local_storage_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class NearbyPharmaciesMapPage extends StatefulWidget {
  const NearbyPharmaciesMapPage({super.key});

  @override
  State<NearbyPharmaciesMapPage> createState() =>
      _NearbyPharmaciesMapPageState();
}

class _NearbyPharmaciesMapPageState extends State<NearbyPharmaciesMapPage> {
  final LocalStorageService _storage = LocalStorageService();
  List<Map<String, dynamic>> pharmacies = [];
  List<Map<String, dynamic>> _nearbyPharmacies = [];
  bool isLoading = true;
  Position? _currentPosition;
  String? _locationError;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _determinePositionAndLoadData();
  }

  Future<void> _determinePositionAndLoadData() async {
    await _determinePosition();
    await _loadPharmacies();
    _filterNearbyPharmacies();
    if (_currentPosition != null && mounted) {
      _mapController.move(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          _mapController.zoom);
    }
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
      if (mounted) {
        setState(() {
          // No need to call _filterNearbyPharmacies here directly anymore,
          // as _determinePositionAndLoadData will handle it.
        });
      }
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
      await _addSamplePharmacies();
      final loadedPharmacies = await _storage.getPharmacies();
      if (mounted) {
        setState(() {
          pharmacies = loadedPharmacies;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error loading pharmacies: $e')));
      }
    }
  }

  void _filterNearbyPharmacies() {
    if (_currentPosition == null) {
      setState(() {
        _nearbyPharmacies = [];
      });
      return;
    }

    setState(() {
      _nearbyPharmacies = pharmacies.where((pharmacy) {
        final lat = pharmacy['latitude'] as double?;
        final lon = pharmacy['longitude'] as double?;

        if (lat == null || lon == null) return false;

        final distanceInMeters = Geolocator.distanceBetween(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
          lat,
          lon,
        );

        const double radiusInMeters = 10000; // 10 km radius
        return distanceInMeters <= radiusInMeters;
      }).toList();
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

    // Add general sample pharmacies if they don't exist
    for (var pharmacy in samplePharmacies) {
      bool exists = (await _storage.getPharmacies())
          .any((p) => p['name'] == pharmacy['name']);
      if (!exists) {
        await _storage.savePharmacy(pharmacy);
      }
    }

    // Add location-dependent sample pharmacies only if current location is available
    if (_currentPosition != null) {
      final List<Map<String, dynamic>> locationDependentPharmacies = [
        {
          'name': 'Local Pharmacy 1',
          'address': 'Near Your Location',
          'schedule': '9:00 AM - 9:00 PM',
          'recommended': 1,
          'rating': 4,
          'favorite': 0,
          'latitude': _currentPosition!.latitude +
              0.005, // Slightly offset from current location
          'longitude': _currentPosition!.longitude - 0.005,
        },
        {
          'name': 'Local Pharmacy 2',
          'address': 'Also Near You',
          'schedule': '10:00 AM - 8:00 PM',
          'recommended': 0,
          'rating': 3,
          'favorite': 0,
          'latitude': _currentPosition!.latitude -
              0.005, // Slightly offset from current location
          'longitude': _currentPosition!.longitude + 0.005,
        },
      ];

      for (var pharmacy in locationDependentPharmacies) {
        bool exists = (await _storage.getPharmacies())
            .any((p) => p['name'] == pharmacy['name']);
        if (!exists) {
          await _storage.savePharmacy(pharmacy);
        }
      }
    }
  }

  void _centerMapOnCurrentLocation() {
    if (_currentPosition != null) {
      _mapController.move(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          15.0); // Increased zoom for better view of nearby pharmacies
    }
  }

  Future<void> _launchMapsUrl(double latitude, double longitude, String name) async {
    // Try to launch with geo URI (more universal for map apps)
    Uri geoUri = Uri.parse('geo:$latitude,$longitude?q=$name');
    if (await canLaunchUrl(geoUri)) {
      await launchUrl(geoUri);
      return;
    }

    // Fallback to Google Maps web link
    Uri googleMapsUri = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude&query_place_id=$name');
    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
      return;
    }

    // If all else fails
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not launch maps application.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Pharmacies Map'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1EC8C8), Color(0xFF6EE2F5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _locationError != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_off, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(_locationError!, style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _determinePosition,
                    child: Text('Try Again'),
                  ),
                ],
              ),
            )
          : _currentPosition == null
              ? Center(child: CircularProgressIndicator())
              : FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: LatLng(_currentPosition!.latitude,
                        _currentPosition!.longitude),
                    initialZoom: 15.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                      userAgentPackageName: 'com.example.medical_app_base',
                    ),
                    MarkerLayer(
                      markers: [
                        ..._nearbyPharmacies
                            .where((p) =>
                                p['latitude'] != null && p['longitude'] != null)
                            .map(
                              (pharmacy) => Marker(
                                point: LatLng(pharmacy['latitude'] as double,
                                    pharmacy['longitude'] as double),
                                width: 80,
                                height: 80,
                                child: GestureDetector(
                                  onTap: () {
                                    _launchMapsUrl(
                                      pharmacy['latitude'] as double,
                                      pharmacy['longitude'] as double,
                                      pharmacy['name'] as String,
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.pin_drop,
                                          color: Colors.red, size: 40),
                                      Text(pharmacy['name'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 10)),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ],
                ),
      floatingActionButton: _currentPosition != null && _locationError == null
          ? FloatingActionButton(
              onPressed: _centerMapOnCurrentLocation,
              child: const Icon(Icons.my_location),
              backgroundColor: Color(0xFF1EC8C8),
            )
          : null,
    );
  }
}
