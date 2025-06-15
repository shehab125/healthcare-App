import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesManager {
  static const String _favoritesKey = 'all_favorites';
  static List<Map<String, dynamic>> _favorites = [];

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString(_favoritesKey);
    if (favoritesJson != null) {
      try {
        final List<dynamic> decoded = json.decode(favoritesJson);
        _favorites = decoded.cast<Map<String, dynamic>>();
      } catch (e) {
        print('Error decoding favorites JSON: $e');
        _favorites = [];
      }
    }
  }

  static List<Map<String, dynamic>> getAllFavorites() {
    return _favorites;
  }

  static Future<void> addFavorite(Map<String, dynamic> item) async {
    if (!item.containsKey('id') &&
        (!item.containsKey('name') || !item.containsKey('type'))) {
      print(
          'Error: Favorite item must have an "id" or "name" and "type" field.');
      return;
    }

    bool exists = _favorites.any((f) {
      if (item.containsKey('id') && f.containsKey('id')) {
        return f['id'] == item['id'];
      } else if (item.containsKey('name') &&
          item.containsKey('type') &&
          f.containsKey('name') &&
          f.containsKey('type')) {
        return f['name'] == item['name'] && f['type'] == item['type'];
      }
      return false;
    });

    if (!exists) {
      _favorites.add(item);
      await _saveFavorites();
    }
  }

  static Future<void> removeFavorite(String identifier, String type) async {
    _favorites.removeWhere((f) {
      if (f.containsKey('id') && f['id'] == identifier) {
        return true;
      } else if (f.containsKey('name') &&
          f.containsKey('type') &&
          f['name'] == identifier &&
          f['type'] == type) {
        return true;
      }
      return false;
    });
    await _saveFavorites();
  }

  static bool isFavorite(String identifier, String type) {
    return _favorites.any((f) {
      if (f.containsKey('id') && f['id'] == identifier) {
        return true;
      } else if (f.containsKey('name') &&
          f.containsKey('type') &&
          f['name'] == identifier &&
          f['type'] == type) {
        return true;
      }
      return false;
    });
  }

  static Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_favoritesKey, json.encode(_favorites));
  }

  static Future<void> clearFavorites() async {
    _favorites.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoritesKey);
  }

  static List<Map<String, dynamic>> getFavoritesByType(String type) {
    return _favorites
        .where((f) => f.containsKey('type') && f['type'] == type)
        .toList();
  }
}
