import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String? photoURL;
  final String? phoneNumber;
  final String role;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  final Map<String, dynamic>? preferences;
  final List<String>? favoriteDoctors;
  final List<String>? favoritePharmacies;
  final List<String>? medicalRecords;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.photoURL,
    this.phoneNumber,
    required this.role,
    required this.createdAt,
    this.lastLoginAt,
    this.preferences,
    this.favoriteDoctors,
    this.favoritePharmacies,
    this.medicalRecords,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      photoURL: data['photoURL'],
      phoneNumber: data['phoneNumber'],
      role: data['role'] ?? 'patient',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastLoginAt: data['lastLoginAt'] != null
          ? (data['lastLoginAt'] as Timestamp).toDate()
          : null,
      preferences: data['preferences'],
      favoriteDoctors: List<String>.from(data['favoriteDoctors'] ?? []),
      favoritePharmacies: List<String>.from(data['favoritePharmacies'] ?? []),
      medicalRecords: List<String>.from(data['medicalRecords'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'role': role,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLoginAt': lastLoginAt != null ? Timestamp.fromDate(lastLoginAt!) : null,
      'preferences': preferences,
      'favoriteDoctors': favoriteDoctors,
      'favoritePharmacies': favoritePharmacies,
      'medicalRecords': medicalRecords,
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? photoURL,
    String? phoneNumber,
    String? role,
    DateTime? createdAt,
    DateTime? lastLoginAt,
    Map<String, dynamic>? preferences,
    List<String>? favoriteDoctors,
    List<String>? favoritePharmacies,
    List<String>? medicalRecords,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      preferences: preferences ?? this.preferences,
      favoriteDoctors: favoriteDoctors ?? this.favoriteDoctors,
      favoritePharmacies: favoritePharmacies ?? this.favoritePharmacies,
      medicalRecords: medicalRecords ?? this.medicalRecords,
    );
  }
} 