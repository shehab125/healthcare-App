import 'package:medical_app_base/services/local_storage_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final LocalStorageService _storage = LocalStorageService();
  Map<String, dynamic>? _currentUser;

  // Get current user
  Map<String, dynamic>? get currentUser => _currentUser;

  // Email & Password Sign Up
  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
    String fullName,
    String phoneNumber,
  ) async {
    try {
      // Check if user already exists
      final existingUser = await _storage.getUser(email);
      if (existingUser != null) {
        throw Exception('User already exists');
      }

      // Create new user
      final userData = {
        'email': email,
        'password':
            password, // Note: In a real app, you should hash the password
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'role': 'patient',
        'createdAt': DateTime.now().toIso8601String(),
      };

      await _storage.saveUser(userData);
      _currentUser = userData;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  // Email & Password Sign In
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final user = await _storage.getUser(email);
      if (user == null) {
        throw Exception('User not found');
      }

      if (user['password'] != password) {
        throw Exception('Invalid password');
      }

      _currentUser = user;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  // Sign Out
  Future<void> signOut() async {
    _currentUser = null;
  }

  // Update User Profile
  Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
    String? phoneNumber,
  }) async {
    if (_currentUser == null) {
      throw Exception('No user logged in');
    }

    final updates = {
      if (displayName != null) 'fullName': displayName,
      if (photoURL != null) 'photoURL': photoURL,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
    };

    _currentUser!.addAll(updates);
    await _storage.saveUser(_currentUser!);
  }
}
