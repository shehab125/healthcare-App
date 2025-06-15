import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  late SharedPreferences _prefs;
  late Database _database;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _database = await openDatabase(
      join(await getDatabasesPath(), 'medical_app.db'),
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            email TEXT PRIMARY KEY,
            password TEXT,
            fullName TEXT,
            phoneNumber TEXT,
            role TEXT,
            createdAt TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE pharmacies(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            address TEXT,
            schedule TEXT,
            recommended INTEGER,
            rating INTEGER,
            favorite INTEGER,
            latitude REAL,
            longitude REAL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE pharmacies ADD COLUMN latitude REAL');
          await db.execute('ALTER TABLE pharmacies ADD COLUMN longitude REAL');
        }
      },
    );
  }

  // User Methods
  Future<void> saveUser(Map<String, dynamic> userData) async {
    await _database.insert(
      'users',
      userData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    final List<Map<String, dynamic>> maps = await _database.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isEmpty) return null;
    return maps.first;
  }

  // Pharmacy Methods
  Future<void> savePharmacy(Map<String, dynamic> pharmacyData) async {
    await _database.insert(
      'pharmacies',
      pharmacyData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getPharmacies() async {
    final List<Map<String, dynamic>> maps = await _database.query('pharmacies');
    return List.generate(maps.length, (i) {
      return {
        'id': maps[i]['id'],
        'name': maps[i]['name'],
        'address': maps[i]['address'],
        'schedule': maps[i]['schedule'],
        'recommended': maps[i]['recommended'] == 1 ? true : false,
        'rating': maps[i]['rating'],
        'favorite': maps[i]['favorite'] == 1 ? true : false,
        'latitude': maps[i]['latitude'],
        'longitude': maps[i]['longitude'],
      };
    });
  }

  // Settings Methods
  Future<void> saveSetting(String key, dynamic value) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    }
  }

  T? getSetting<T>(String key) {
    return _prefs.get(key) as T?;
  }
}
