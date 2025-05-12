import 'package:flutter/material.dart';
import 'package:medical_app_base/models/doctor.dart';
import 'package:medical_app_base/widgets/doctor_avatar.dart';
import 'package:medical_app_base/screens/specialties_page.dart';
import '../utils/doctor_favorites_manager.dart';

class CardiologyPage extends StatefulWidget {
  const CardiologyPage({super.key});

  @override
  State<CardiologyPage> createState() => _CardiologyPageState();
}

class _CardiologyPageState extends State<CardiologyPage> {
  String searchQuery = '';
  bool showFavoritesOnly = false;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    await DoctorFavoritesManager.init();
    setState(() {});
  }

  bool isFavorite(Doctor doctor) {
    return DoctorFavoritesManager.isFavorite(doctor.name);
  }

  Future<void> _toggleFavorite(Doctor doctor) async {
    if (isFavorite(doctor)) {
      await DoctorFavoritesManager.removeFavorite(doctor.name);
    } else {
      await DoctorFavoritesManager.addFavorite(doctor);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final doctors = DoctorsData.cardiologyDoctors
        .where((doc) {
          final matchesSearch = doc.name.toLowerCase().contains(searchQuery.toLowerCase());
          if (showFavoritesOnly) {
            return matchesSearch && isFavorite(doc);
          }
          return matchesSearch;
        })
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cardiology Doctors'),
        actions: [
          IconButton(
            icon: Icon(
              showFavoritesOnly ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                showFavoritesOnly = !showFavoritesOnly;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Rest of the existing code...
        ],
      ),
    );
  }
} 