class FavoriteDoctorsManager {
  static final List<Map<String, String>> _favorites = [];

  static void addFavorite(Map<String, String> doctor) {
    // تأكد ألا يضاف مرتين
    if (!_favorites.any((d) => d['name'] == doctor['name'])) {
      _favorites.add(doctor);
    }
  }

  static void removeFavorite(String name) {
    _favorites.removeWhere((d) => d['name'] == name);
  }

  static bool isFavorite(String name) {
    return _favorites.any((d) => d['name'] == name);
  }

  static List<Map<String, String>> getFavorites() {
    return List.unmodifiable(_favorites);
  }
}