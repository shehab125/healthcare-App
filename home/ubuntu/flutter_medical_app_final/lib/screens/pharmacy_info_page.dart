import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'pharmacy_page.dart';
import 'notifications_page.dart';
import 'profile_page.dart';
import 'schedule_page.dart';

class PharmacyInfoPage extends StatefulWidget {
  const PharmacyInfoPage({Key? key}) : super(key: key);

  @override
  State<PharmacyInfoPage> createState() => _PharmacyInfoPageState();
}

class _PharmacyInfoPageState extends State<PharmacyInfoPage> {
  String city = '';
  String address = '';
  String searchText = '';

  final List<Map<String, dynamic>> allPharmacies = [
    {
      'name': 'صيدلية العزبي - الجيزة',
      'address': 'شارع جامعة الدول العربية، الجيزة',
      'schedule': '8:00 AM - 10:00 PM',
      'distance': '3.2 km',
      'rating': 5,
      'location': {'lat': 30.0459, 'lng': 31.2243},
      'phone': '01000000001',
      'whatsapp': '+201000000001',
    },
    {
      'name': 'صيدلية سيف - الجيزة',
      'address': 'شارع فيصل، الجيزة',
      'schedule': '8:00 AM - 11:00 PM',
      'distance': '4.7 km',
      'rating': 4,
      'location': {'lat': 30.0131, 'lng': 31.2096},
      'phone': '01000000002',
      'whatsapp': '+201000000002',
    },
    {
      'name': 'صيدلية مصر - الجيزة',
      'address': 'شارع الهرم، الجيزة',
      'schedule': '9:00 AM - 9:00 PM',
      'distance': '6.0 km',
      'rating': 4,
      'location': {'lat': 29.9947, 'lng': 31.1506},
      'phone': '01000000003',
      'whatsapp': '+201000000003',
    },
    {
      'name': 'صيدلية رشدي - السواح',
      'address': 'شارع السواح، السواح، القاهرة',
      'schedule': '8:00 AM - 10:00 PM',
      'distance': '8.1 km',
      'rating': 3,
      'location': {'lat': 30.0992, 'lng': 31.2922},
      'phone': '01000000004',
      'whatsapp': '+201000000004',
    },
    // ... أضف باقي الصيدليات كما في التعديل السابق ...
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPharmacies = allPharmacies.where((pharmacy) {
      final input = searchText.toLowerCase().trim();
      final name = pharmacy['name'].toLowerCase();
      final addr = pharmacy['address'].toLowerCase();
      final inCity = city.isEmpty || addr.contains(city.toLowerCase());
      final inAddress = address.isEmpty || addr.contains(address.toLowerCase());
      return (input.isEmpty || name.contains(input) || addr.contains(input)) && inCity && inAddress;
    }).toList();

    return Scaffold(
      backgroundColor: Color(0xFFF8FCFF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1EC8C8), Color(0xFF6EE2F5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 8),
                Text(
                  'Pharmacy Filter',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      city = '';
                      address = '';
                      searchText = '';
                    });
                  },
                  child: Text('Clear all', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Find your nearest pharmacy', style: TextStyle(color: Color(0xFF1EC8C8), fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Add Your City',
                          labelStyle: TextStyle(color: Color(0xFF1EC8C8)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          suffixIcon: city.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear, color: Color(0xFF1EC8C8)),
                                  onPressed: () => setState(() => city = ''),
                                )
                              : null,
                        ),
                        onChanged: (value) => setState(() => city = value),
                        controller: TextEditingController(text: city),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Address',
                          labelStyle: TextStyle(color: Color(0xFF1EC8C8)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          suffixIcon: address.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear, color: Color(0xFF1EC8C8)),
                                  onPressed: () => setState(() => address = ''),
                                )
                              : null,
                        ),
                        onChanged: (value) => setState(() => address = value),
                        controller: TextEditingController(text: address),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Search Pharmacy Name or Address',
                    labelStyle: TextStyle(color: Color(0xFF1EC8C8)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onChanged: (value) => setState(() => searchText = value),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filteredPharmacies.length,
              itemBuilder: (context, index) {
                final pharmacy = filteredPharmacies[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.local_pharmacy, color: Color(0xFF1EC8C8), size: 36),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(pharmacy['name'], style: TextStyle(color: Color(0xFF1EC8C8), fontWeight: FontWeight.bold, fontSize: 17)),
                            ),
                            Icon(Icons.location_on, color: Color(0xFF1EC8C8)),
                            SizedBox(width: 4),
                            Text(pharmacy['distance'], style: TextStyle(color: Color(0xFF1EC8C8), fontWeight: FontWeight.bold, fontSize: 13)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text('Address: ${pharmacy['address']}', style: TextStyle(color: Colors.black87, fontSize: 14)),
                        Text('Attention Schedule: ${pharmacy['schedule']}', style: TextStyle(color: Colors.black54, fontSize: 13)),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text('Recommended', style: TextStyle(color: Color(0xFF1EC8C8), fontWeight: FontWeight.bold, fontSize: 13)),
                            SizedBox(width: 8),
                            Row(
                              children: List.generate(5, (i) => Icon(
                                Icons.star,
                                color: i < pharmacy['rating'] ? Color(0xFF1EC8C8) : Colors.grey[300],
                                size: 18,
                              )),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text('Phone: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: 15)),
                            Text(pharmacy['phone'] ?? '', style: TextStyle(color: Colors.black87, fontSize: 15)),
                          ],
                        ),
                        if (pharmacy['whatsapp'] != null && pharmacy['whatsapp'].toString().isNotEmpty) ...[
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text('WhatsApp: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 15)),
                              Text(pharmacy['whatsapp'], style: TextStyle(color: Colors.green, fontSize: 15)),
                            ],
                          ),
                        ],
                        SizedBox(height: 8),
                        if (pharmacy['location'] != null && pharmacy['location']['lat'] != null && pharmacy['location']['lng'] != null)
                          Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFE6F7FA),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text('Lat: ${pharmacy['location']['lat']}\nLng: ${pharmacy['location']['lng']}', style: TextStyle(color: Color(0xFF1EC8C8))),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: Color(0xFFE6F7FA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home, color: Color(0xFF1EC8C8)),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.local_pharmacy, color: Color(0xFF1EC8C8)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PharmacyPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_none, color: Color(0xFF1EC8C8)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: Color(0xFF1EC8C8)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.calendar_today, color: Color(0xFF1EC8C8)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SchedulePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}