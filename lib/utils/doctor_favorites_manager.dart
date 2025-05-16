import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/doctor.dart';

class DoctorFavoritesManager {
  static const String _favoritesKey = 'favorite_doctors';
  static List<String> _favoriteDoctorIds = [];

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString(_favoritesKey);
    if (favoritesJson != null) {
      final List<dynamic> decoded = json.decode(favoritesJson);
      _favoriteDoctorIds = decoded.cast<String>();
    }
  }

  static List<String> getFavoriteDoctorIds() {
    return _favoriteDoctorIds;
  }

  static Future<void> addFavorite(Doctor doctor) async {
    if (!_favoriteDoctorIds.contains(doctor.name)) {
      _favoriteDoctorIds.add(doctor.name);
      await _saveFavorites();
    }
  }

  static Future<void> removeFavorite(String doctorName) async {
    _favoriteDoctorIds.remove(doctorName);
    await _saveFavorites();
  }

  static bool isFavorite(String doctorName) {
    return _favoriteDoctorIds.contains(doctorName);
  }

  static Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_favoritesKey, json.encode(_favoriteDoctorIds));
  }

  static Future<void> clearFavorites() async {
    _favoriteDoctorIds.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoritesKey);
  }
} 