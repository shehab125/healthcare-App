import 'package:flutter/material.dart';
import 'package:medical_app_base/screens/home_screen.dart';
import 'package:medical_app_base/screens/doctors_page.dart';
import 'package:medical_app_base/screens/schedule_page.dart';
import 'package:medical_app_base/screens/favorite_page.dart';
import 'package:medical_app_base/screens/profile_page.dart';
import 'package:medical_app_base/screens/add_medical_record_page.dart';
import 'package:medical_app_base/screens/medical_record_details_page.dart';

class RecordsPage extends StatefulWidget {
  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  int _selectedIndex = 2;
  String _currentFilter = 'All';

  final List<Map<String, dynamic>> medicalRecords = [
    {
      'date': '2024-03-15',
      'doctor': 'Dr. Ahmed Mohamed',
      'specialty': 'Cardiology',
      'diagnosis': 'High blood pressure',
      'medications': ['Blood pressure medications', 'Blood thinners'],
      'notes': 'Blood pressure must be monitored daily.',
    },
    {
      'date': '2024-02-28',
      'doctor': 'Dr. Sarah Ahmed',
      'specialty': 'Internal Medicine',
      'diagnosis': 'Common cold',
      'medications': ['Painkillers', 'Vitamins'],
      'notes': 'Complete rest for 3 days.',
    },
    {
      'date': '2024-01-10',
      'doctor': 'Dr. Omar Sami',
      'specialty': 'Pediatrics',
      'diagnosis': 'Childhood fever',
      'medications': ['Antipyretics', 'Antibiotics'],
      'notes': 'Follow up after 5 days.',
    },
    {
      'date': '2023-12-01',
      'doctor': 'Dr. Lina Hassan',
      'specialty': 'Ophthalmology',
      'diagnosis': 'Conjunctivitis',
      'medications': ['Eye drops', 'Antihistamines'],
      'notes': 'Avoid touching eyes.',
    },
    {
      'date': '2023-11-20',
      'doctor': 'Dr. Karim Nader',
      'specialty': 'Orthopedics',
      'diagnosis': 'Ankle sprain',
      'medications': ['Anti-inflammatory', 'Pain relievers'],
      'notes': 'Rest and elevation recommended.',
    },
  ];

  List<Map<String, dynamic>> _filteredRecords = [];

  @override
  void initState() {
    super.initState();
    _filteredRecords = medicalRecords;
  }

  void _applyFilter(String filter) {
    setState(() {
      _currentFilter = filter;
      if (filter == 'All') {
        _filteredRecords = medicalRecords;
      } else {
        _filteredRecords = medicalRecords
            .where((record) => record['specialty'] == filter)
            .toList();
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DoctorsPage()),
        );
        break;
      case 2:
        // Already on Records page
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SchedulePage()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FavoritePage()),
        );
        break;
      case 5:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medical Records'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlueAccent, Colors.blueAccent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar and Filter Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search in records...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                _buildFilterButton('Filter'),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.notifications, color: Colors.blueAccent),
                    onPressed: () {
                      // Handle notifications button press
                    },
                  ),
                ),
              ],
            ),
          ),
          // Filter Buttons
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterButtonSpecialty('All'),
                  SizedBox(width: 8),
                  _buildFilterButtonSpecialty('Pediatrics'),
                  SizedBox(width: 8),
                  _buildFilterButtonSpecialty('Orthopedics'),
                  SizedBox(width: 8),
                  _buildFilterButtonSpecialty('Ophthalmology'),
                  SizedBox(width: 8),
                  _buildFilterButtonSpecialty('Cardiology'),
                  SizedBox(width: 8),
                  _buildFilterButtonSpecialty('Internal Medicine'),
                ],
              ),
            ),
          ),
          // Medical Records List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _filteredRecords.length,
              itemBuilder: (context, index) {
                final record = _filteredRecords[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MedicalRecordDetailsPage(record: record),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                record['date'],
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.more_vert),
                                onPressed: () {
                                  // Handle more options
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Dr. ${record['doctor']}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            record['specialty'],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Diagnosis:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                          Text(
                            record['diagnosis'],
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Medications:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: record['medications'].map<Widget>((med) {
                              return Chip(
                                label: Text(med),
                                backgroundColor:
                                    Colors.lightBlueAccent.withOpacity(0.1),
                                labelStyle:
                                    TextStyle(color: Colors.lightBlueAccent),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Notes:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                          Text(
                            record['notes'],
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMedicalRecordPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlueAccent,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Records',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    return ElevatedButton(
      onPressed: () {
        // Handle filter button press
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.lightBlueAccent,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFilterButtonSpecialty(String label) {
    bool isSelected = _currentFilter == label;
    return ElevatedButton(
      onPressed: () => _applyFilter(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.lightBlueAccent : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.lightBlueAccent,
        elevation: isSelected ? 4 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
