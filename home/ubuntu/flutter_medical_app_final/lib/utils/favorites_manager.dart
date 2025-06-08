import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesManager {
  static const String _favoritesKey = 'favorite_pharmacies';
  static List<Map<String, dynamic>> _favoritePharmacies = [];

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString(_favoritesKey);
    if (favoritesJson != null) {
      final List<dynamic> decoded = json.decode(favoritesJson);
      _favoritePharmacies = decoded.cast<Map<String, dynamic>>();
    }
  }

  static List<Map<String, dynamic>> getFavoritePharmacies() {
    return _favoritePharmacies;
  }

  static Future<void> addFavorite(Map<String, dynamic> pharmacy) async {
    if (!_favoritePharmacies.any((p) => p['name'] == pharmacy['name'])) {
      _favoritePharmacies.add(pharmacy);
      await _saveFavorites();
    }
  }

  static Future<void> removeFavorite(String pharmacyName) async {
    _favoritePharmacies.removeWhere((p) => p['name'] == pharmacyName);
    await _saveFavorites();
  }

  static bool isFavorite(String pharmacyName) {
    return _favoritePharmacies.any((p) => p['name'] == pharmacyName);
  }

  static Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_favoritesKey, json.encode(_favoritePharmacies));
  }

  static Future<void> clearFavorites() async {
    _favoritePharmacies.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoritesKey);
  }
} 