class Doctor {
  final String name;
  final String specialty;
  final String image;
  final String experience;
  final String rating;
  final String hospital;
  final String availability;
  final String consultationFee;

  const Doctor({
    required this.name,
    required this.specialty,
    required this.image,
    required this.experience,
    required this.rating,
    required this.hospital,
    required this.availability,
    required this.consultationFee,
  });
}

// Sample doctors data
class DoctorsData {
  static const List<Doctor> ophthalmologyDoctors = [
    Doctor(
      name: 'Dr. Ahmed Hassan',
      specialty: 'Ophthalmology',
      image: 'assets/images/doctors/doctor1.png',
      experience: '15 years',
      rating: '4.8',
      hospital: 'Eye Care Hospital',
      availability: 'Mon, Wed, Fri',
      consultationFee: '300 EGP',
    ),
    Doctor(
      name: 'Dr. Sarah Mohamed',
      specialty: 'Ophthalmology',
      image: 'assets/images/doctors/doctor2.png',
      experience: '12 years',
      rating: '4.9',
      hospital: 'Vision Center',
      availability: 'Sun, Tue, Thu',
      consultationFee: '350 EGP',
    ),
    Doctor(
      name: 'Dr. Mohamed Ali',
      specialty: 'Ophthalmology',
      image: 'assets/images/doctors/doctor3.png',
      experience: '10 years',
      rating: '4.7',
      hospital: 'Modern Eye Clinic',
      availability: 'Sat, Mon, Wed',
      consultationFee: '280 EGP',
    ),
  ];

  static const List<Doctor> orthopedicsDoctors = [
    Doctor(
      name: 'Dr. Karim Mahmoud',
      specialty: 'Orthopedics',
      image: 'assets/images/doctors/doctor4.png',
      experience: '18 years',
      rating: '4.9',
      hospital: 'Bone & Joint Hospital',
      availability: 'Mon, Wed, Fri',
      consultationFee: '400 EGP',
    ),
    Doctor(
      name: 'Dr. Nour El-Din',
      specialty: 'Orthopedics',
      image: 'assets/images/doctors/doctor5.png',
      experience: '14 years',
      rating: '4.8',
      hospital: 'Sports Medicine Center',
      availability: 'Sun, Tue, Thu',
      consultationFee: '380 EGP',
    ),
    Doctor(
      name: 'Dr. Hana Ibrahim',
      specialty: 'Orthopedics',
      image: 'assets/images/doctors/doctor6.png',
      experience: '12 years',
      rating: '4.7',
      hospital: 'Orthopedic Clinic',
      availability: 'Sat, Mon, Wed',
      consultationFee: '350 EGP',
    ),
  ];

  static const List<Doctor> cardiologyDoctors = [
    Doctor(
      name: 'Dr. Omar Farouk',
      specialty: 'Cardiology',
      image: 'assets/images/doctors/doctor7.png',
      experience: '20 years',
      rating: '4.9',
      hospital: 'Heart Center',
      availability: 'Mon, Wed, Fri',
      consultationFee: '450 EGP',
    ),
    Doctor(
      name: 'Dr. Laila Ahmed',
      specialty: 'Cardiology',
      image: 'assets/images/doctors/doctor8.png',
      experience: '15 years',
      rating: '4.8',
      hospital: 'Cardiac Hospital',
      availability: 'Sun, Tue, Thu',
      consultationFee: '420 EGP',
    ),
    Doctor(
      name: 'Dr. Mahmoud El-Sayed',
      specialty: 'Cardiology',
      image: 'assets/images/doctors/doctor11.png',
      experience: '18 years',
      rating: '4.9',
      hospital: 'Modern Heart Clinic',
      availability: 'Sat, Mon, Wed',
      consultationFee: '480 EGP',
    ),
  ];

  static const List<Doctor> dermatologyDoctors = [
    Doctor(
      name: 'Dr. Yasmine Hassan',
      specialty: 'Dermatology',
      image: 'assets/images/doctors/doctor9.png',
      experience: '12 years',
      rating: '4.8',
      hospital: 'Skin Care Clinic',
      availability: 'Mon, Wed, Fri',
      consultationFee: '350 EGP',
    ),
    Doctor(
      name: 'Dr. Tarek Mohamed',
      specialty: 'Dermatology',
      image: 'assets/images/doctors/doctor10.png',
      experience: '10 years',
      rating: '4.7',
      hospital: 'Dermatology Center',
      availability: 'Sun, Tue, Thu',
      consultationFee: '320 EGP',
    ),
    Doctor(
      name: 'Dr. Noha Ali',
      specialty: 'Dermatology',
      image: 'assets/images/doctors/doctor12.png',
      experience: '14 years',
      rating: '4.9',
      hospital: 'Beauty & Skin Clinic',
      availability: 'Sat, Mon, Wed',
      consultationFee: '380 EGP',
    ),
  ];

  static const List<Doctor> generalMedicineDoctors = [
    Doctor(
      name: 'Dr. Ahmed El-Masry',
      specialty: 'General Medicine',
      image: 'assets/images/doctors/doctor13.png',
      experience: '16 years',
      rating: '4.8',
      hospital: 'General Hospital',
      availability: 'Mon, Wed, Fri',
      consultationFee: '250 EGP',
    ),
    Doctor(
      name: 'Dr. Mona Hassan',
      specialty: 'General Medicine',
      image: 'assets/images/doctors/doctor14.png',
      experience: '12 years',
      rating: '4.7',
      hospital: 'Family Medicine Center',
      availability: 'Sun, Tue, Thu',
      consultationFee: '220 EGP',
    ),
    Doctor(
      name: 'Dr. Khaled Ibrahim',
      specialty: 'General Medicine',
      image: 'assets/images/doctors/doctor15.png',
      experience: '14 years',
      rating: '4.9',
      hospital: 'Modern Medical Center',
      availability: 'Sat, Mon, Wed',
      consultationFee: '280 EGP',
    ),
  ];

  static const List<Doctor> gynecologyDoctors = [
    Doctor(
      name: 'Dr. Fatma Mahmoud',
      specialty: 'Gynecology',
      image: 'assets/images/doctors/doctor16.png',
      experience: '18 years',
      rating: '4.9',
      hospital: 'Women\'s Health Center',
      availability: 'Mon, Wed, Fri',
      consultationFee: '400 EGP',
    ),
    Doctor(
      name: 'Dr. Amira Hassan',
      specialty: 'Gynecology',
      image: 'assets/images/doctors/doctor17.png',
      experience: '15 years',
      rating: '4.8',
      hospital: 'Modern Gynecology Clinic',
      availability: 'Sun, Tue, Thu',
      consultationFee: '380 EGP',
    ),
    Doctor(
      name: 'Dr. Samira Ali',
      specialty: 'Gynecology',
      image: 'assets/images/doctors/doctor18.png',
      experience: '12 years',
      rating: '4.7',
      hospital: 'Family Health Center',
      availability: 'Sat, Mon, Wed',
      consultationFee: '350 EGP',
    ),
  ];

  static const List<Doctor> dentistryDoctors = [
    Doctor(
      name: 'Dr. Karim El-Sayed',
      specialty: 'Dentistry',
      image: 'assets/images/doctors/doctor19.png',
      experience: '14 years',
      rating: '4.8',
      hospital: 'Dental Care Center',
      availability: 'Mon, Wed, Fri',
      consultationFee: '300 EGP',
    ),
    Doctor(
      name: 'Dr. Rania Mohamed',
      specialty: 'Dentistry',
      image: 'assets/images/doctors/doctor20.png',
      experience: '12 years',
      rating: '4.7',
      hospital: 'Modern Dental Clinic',
      availability: 'Sun, Tue, Thu',
      consultationFee: '280 EGP',
    ),
    Doctor(
      name: 'Dr. Hossam Ali',
      specialty: 'Dentistry',
      image: 'assets/images/doctors/doctor21.png',
      experience: '16 years',
      rating: '4.9',
      hospital: 'Smile Dental Center',
      availability: 'Sat, Mon, Wed',
      consultationFee: '320 EGP',
    ),
  ];

  static const List<Doctor> oncologyDoctors = [
    Doctor(
      name: 'Dr. Mohamed El-Gharbawy',
      specialty: 'Oncology',
      image: 'assets/images/doctors/doctor22.png',
      experience: '20 years',
      rating: '4.9',
      hospital: 'Cancer Treatment Center',
      availability: 'Mon, Wed, Fri',
      consultationFee: '500 EGP',
    ),
    Doctor(
      name: 'Dr. Nermeen Hassan',
      specialty: 'Oncology',
      image: 'assets/images/doctors/doctor23.png',
      experience: '16 years',
      rating: '4.8',
      hospital: 'Modern Oncology Clinic',
      availability: 'Sun, Tue, Thu',
      consultationFee: '480 EGP',
    ),
    Doctor(
      name: 'Dr. Ahmed El-Masry',
      specialty: 'Oncology',
      image: 'assets/images/doctors/doctor24.png',
      experience: '18 years',
      rating: '4.9',
      hospital: 'Cancer Research Center',
      availability: 'Sat, Mon, Wed',
      consultationFee: '520 EGP',
    ),
  ];
} 