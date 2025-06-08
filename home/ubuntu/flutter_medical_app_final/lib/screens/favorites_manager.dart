class FavoritesManager {
  static final List<Map<String, dynamic>> favoritePharmacies = [];

  static void addFavorite(Map<String, dynamic> pharmacy) {
    if (!favoritePharmacies.any((p) => p['name'] == pharmacy['name'])) {
      favoritePharmacies.add(Map<String, dynamic>.from(pharmacy));
    }
  }

  static void removeFavorite(Map<String, dynamic> pharmacy) {
    favoritePharmacies.removeWhere((p) => p['name'] == pharmacy['name']);
  }

  static bool isFavorite(Map<String, dynamic> pharmacy) {
    return favoritePharmacies.any((p) => p['name'] == pharmacy['name']);
  }
} 