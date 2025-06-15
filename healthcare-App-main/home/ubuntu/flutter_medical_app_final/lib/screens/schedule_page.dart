import 'package:flutter/material.dart';
import 'package:medical_app_base/screens/home_screen.dart';
import 'package:medical_app_base/screens/doctors_page.dart';
import 'package:medical_app_base/screens/favorite_page.dart';
import 'package:medical_app_base/screens/profile_page.dart';
import 'package:medical_app_base/screens/appointment_details_page.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  int _selectedIndex = 2;
  String _currentFilter = 'All';

  final List<Map<String, dynamic>> appointments = [
    {
      'date': '2024-03-20',
      'time': '10:00 AM',
      'doctor': 'Dr. Sarah Ahmed',
      'specialty': 'Pediatrics',
      'status': 'Confirmed',
    },
    {
      'date': '2024-03-20',
      'time': '02:00 PM',
      'doctor': 'Dr. Mohamed Ali',
      'specialty': 'Orthopedics',
      'status': 'Pending',
    },
    {
      'date': '2024-03-21',
      'time': '09:30 AM',
      'doctor': 'Dr. Fatima Hassan',
      'specialty': 'Ophthalmology',
      'status': 'Confirmed',
    },
  ];

  List<Map<String, dynamic>> _filteredAppointments = [];

  @override
  void initState() {
    super.initState();
    _filteredAppointments = appointments;
  }

  void _applyFilter(String filter) {
    setState(() {
      _currentFilter = filter;
      if (filter == 'All') {
        _filteredAppointments = appointments;
      } else {
        _filteredAppointments = appointments.where((appt) => appt['status'] == filter).toList();
      }
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed':
        return Colors.green;
      case 'Pending':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
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
        // Already on Schedule page
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FavoritePage()),
        );
        break;
      case 4:
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
        title: Text('Schedule'),
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
          // Filter Buttons
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterButton('All'),
                  SizedBox(width: 8),
                  _buildFilterButton('Confirmed'),
                  SizedBox(width: 8),
                  _buildFilterButton('Pending'),
                  SizedBox(width: 8),
                  _buildFilterButton('Cancelled'),
                ],
              ),
            ),
          ),
          // Appointments List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _filteredAppointments.length,
              itemBuilder: (context, index) {
                final appointment = _filteredAppointments[index];
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
                          builder: (context) => AppointmentDetailsPage(appointment: appointment),
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
                                appointment['date'],
                                style: TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(appointment['status']).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  appointment['status'],
                                  style: TextStyle(
                                    color: _getStatusColor(appointment['status']),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Text(
                            '${appointment['doctor']} - ${appointment['specialty']}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: Colors.grey),
                              SizedBox(width: 4),
                              Text(
                                appointment['time'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AppointmentDetailsPage(appointment: appointment),
                                    ),
                                  );
                                },
                                icon: Icon(Icons.visibility, color: Colors.lightBlueAccent),
                                label: Text(
                                  'View Details',
                                  style: TextStyle(color: Colors.lightBlueAccent),
                                ),
                              ),
                              SizedBox(width: 8),
                              if (appointment['status'] != 'Cancelled')
                                TextButton.icon(
                                  onPressed: () {
                                    _showCancelDialog(appointment);
                                  },
                                  icon: Icon(Icons.cancel, color: Colors.red),
                                  label: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                            ],
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
          // Navigate to add new appointment
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

  void _showCancelDialog(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Cancellation'),
          content: Text('Are you sure you want to cancel your appointment with ${appointment['doctor']} on ${appointment['date']}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  appointments.remove(appointment);
                  _filteredAppointments.remove(appointment);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Appointment cancelled successfully!')),
                );
              },
              child: Text('Yes', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
