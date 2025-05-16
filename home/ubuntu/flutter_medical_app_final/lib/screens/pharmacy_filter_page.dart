import 'package:flutter/material.dart';
import 'pharmacy_info_page.dart';
import 'home_screen.dart';
import 'pharmacy_page.dart';
import 'notifications_page_pharmacy.dart';
import 'profile_page.dart';
import 'schedule_page.dart';

class PharmacyFilterPage extends StatefulWidget {
  @override
  State<PharmacyFilterPage> createState() => _PharmacyFilterPageState();
}

class _PharmacyFilterPageState extends State<PharmacyFilterPage> {
  String city = 'Giza';
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
    {
      'name': 'صيدلية العزبي - وسط البلد',
      'address': 'شارع طلعت حرب، وسط البلد، القاهرة',
      'schedule': '8:00 AM - 12:00 AM',
      'distance': '5.5 km',
      'rating': 5,
      'location': {'lat': 30.0478, 'lng': 31.2381},
      'phone': '01000000005',
      'whatsapp': '+201000000005',
    },
    {
      'name': 'صيدلية سيف - مدينة نصر',
      'address': 'شارع عباس العقاد، مدينة نصر، القاهرة',
      'schedule': '8:00 AM - 12:00 AM',
      'distance': '10.0 km',
      'rating': 4,
      'location': {'lat': 30.0561, 'lng': 31.3300},
      'phone': '01000000006',
      'whatsapp': '+201000000006',
    },
    {
      'name': 'صيدلية دلمار وعطا الله - مدينة نصر',
      'address': 'شارع مصطفى النحاس، مدينة نصر، القاهرة',
      'schedule': '8:00 AM - 12:00 AM',
      'distance': '11.0 km',
      'rating': 3,
      'location': {'lat': 30.0532, 'lng': 31.3562},
      'phone': '01000000007',
      'whatsapp': '+201000000007',
    },
    {
      'name': 'صيدلية العزبي - المعادي',
      'address': 'شارع النصر، المعادي، القاهرة',
      'schedule': '8:00 AM - 12:00 AM',
      'distance': '12.0 km',
      'rating': 5,
      'location': {'lat': 29.9603, 'lng': 31.2617},
      'phone': '01000000008',
      'whatsapp': '+201000000008',
    },
    {
      'name': 'صيدلية سيف - حلوان',
      'address': 'شارع منصور، حلوان، القاهرة',
      'schedule': '8:00 AM - 12:00 AM',
      'distance': '15.0 km',
      'rating': 4,
      'location': {'lat': 29.8482, 'lng': 31.3342},
      'phone': '01000000009',
      'whatsapp': '+201000000009',
    },
    {
      'name': 'صيدلية العزبي - الدقي',
      'address': 'شارع التحرير، الدقي، الجيزة',
      'schedule': '8:00 AM - 11:00 PM',
      'distance': '2.5 km',
      'rating': 5,
      'location': {'lat': 30.0375, 'lng': 31.2118},
      'phone': '01000000010',
      'whatsapp': '+201000000010',
    },
    {
      'name': 'صيدلية سيف - المهندسين',
      'address': 'شارع شهاب، المهندسين، الجيزة',
      'schedule': '8:00 AM - 12:00 AM',
      'distance': '3.8 km',
      'rating': 4,
      'location': {'lat': 30.0542, 'lng': 31.2011},
      'phone': '01000000011',
      'whatsapp': '+201000000011',
    },
    {
      'name': 'صيدلية العزبي - الزمالك',
      'address': 'شارع 26 يوليو، الزمالك، القاهرة',
      'schedule': '8:00 AM - 10:00 PM',
      'distance': '6.2 km',
      'rating': 5,
      'location': {'lat': 30.0605, 'lng': 31.2243},
      'phone': '01000000012',
      'whatsapp': '+201000000012',
    },
    {
      'name': 'صيدلية سيف - المعادي',
      'address': 'شارع اللاسلكي، المعادي، القاهرة',
      'schedule': '8:00 AM - 12:00 AM',
      'distance': '13.0 km',
      'rating': 4,
      'location': {'lat': 29.9600, 'lng': 31.2767},
      'phone': '01000000013',
      'whatsapp': '+201000000013',
    },
    {
      'name': 'صيدلية مصر - امبابة',
      'address': 'شارع الوحدة، امبابة، الجيزة',
      'schedule': '9:00 AM - 9:00 PM',
      'distance': '7.0 km',
      'rating': 3,
      'location': {'lat': 30.0862, 'lng': 31.2231},
      'phone': '01000000014',
      'whatsapp': '+201000000014',
    },
    {
      'name': 'صيدلية رشدي - مصر الجديدة',
      'address': 'شارع بغداد، مصر الجديدة، القاهرة',
      'schedule': '8:00 AM - 10:00 PM',
      'distance': '14.0 km',
      'rating': 4,
      'location': {'lat': 30.1042, 'lng': 31.3467},
      'phone': '01000000015',
      'whatsapp': '+201000000015',
    },
    {
      'name': 'صيدلية العزبي - شبرا',
      'address': 'شارع شبرا، شبرا، القاهرة',
      'schedule': '8:00 AM - 10:00 PM',
      'distance': '9.0 km',
      'rating': 5,
      'location': {'lat': 30.0732, 'lng': 31.2471},
      'phone': '01000000016',
      'whatsapp': '+201000000016',
    },
    {
      'name': 'صيدلية سيف - بولاق الدكرور',
      'address': 'شارع الملك فيصل، بولاق الدكرور، الجيزة',
      'schedule': '8:00 AM - 12:00 AM',
      'distance': '5.0 km',
      'rating': 4,
      'location': {'lat': 30.0182, 'lng': 31.2000},
      'phone': '01000000017',
      'whatsapp': '+201000000017',
    },
    {
      'name': 'صيدلية مصر - العجوزة',
      'address': 'شارع النيل، العجوزة، الجيزة',
      'schedule': '9:00 AM - 9:00 PM',
      'distance': '4.0 km',
      'rating': 3,
      'location': {'lat': 30.0600, 'lng': 31.2200},
      'phone': '01000000018',
      'whatsapp': '+201000000018',
    },
    {
      'name': 'صيدلية رشدي - حلوان',
      'address': 'شارع منصور، حلوان، القاهرة',
      'schedule': '8:00 AM - 10:00 PM',
      'distance': '16.0 km',
      'rating': 4,
      'location': {'lat': 29.8482, 'lng': 31.3342},
      'phone': '01000000019',
      'whatsapp': '+201000000019',
    },
    {
      'name': 'صيدلية العزبي - حدائق الأهرام',
      'address': 'بوابة 3، حدائق الأهرام، الجيزة',
      'schedule': '8:00 AM - 10:00 PM',
      'distance': '18.0 km',
      'rating': 5,
      'location': {'lat': 29.9870, 'lng': 31.1300},
      'phone': '01000000020',
      'whatsapp': '+201000000020',
    },
    {
      'name': 'صيدلية سيف - الوراق',
      'address': 'شارع القومية، الوراق، الجيزة',
      'schedule': '8:00 AM - 12:00 AM',
      'distance': '8.0 km',
      'rating': 4,
      'location': {'lat': 30.1040, 'lng': 31.2200},
      'phone': '01000000021',
      'whatsapp': '+201000000021',
    },
    {
      'name': 'صيدلية مصر - المرج',
      'address': 'شارع محطة المرج، المرج، القاهرة',
      'schedule': '9:00 AM - 9:00 PM',
      'distance': '20.0 km',
      'rating': 3,
      'location': {'lat': 30.1890, 'lng': 31.3670},
      'phone': '01000000022',
      'whatsapp': '+201000000022',
    },
    {
      'name': 'صيدلية رشدي - مدينة السلام',
      'address': 'شارع جمال عبد الناصر، مدينة السلام، القاهرة',
      'schedule': '8:00 AM - 10:00 PM',
      'distance': '22.0 km',
      'rating': 4,
      'location': {'lat': 30.2000, 'lng': 31.4000},
      'phone': '01000000023',
      'whatsapp': '+201000000023',
    },
    {
      'name': 'صيدلية العزبي - المنيب',
      'address': 'شارع المنيب، المنيب، الجيزة',
      'schedule': '8:00 AM - 10:00 PM',
      'distance': '10.0 km',
      'rating': 5,
      'location': {'lat': 29.9600, 'lng': 31.2500},
      'phone': '01000000024',
      'whatsapp': '+201000000024',
    },
    {
      'name': 'صيدلية سيف - دار السلام',
      'address': 'شارع الفيوم، دار السلام، القاهرة',
      'schedule': '8:00 AM - 12:00 AM',
      'distance': '17.0 km',
      'rating': 4,
      'location': {'lat': 29.9600, 'lng': 31.3000},
      'phone': '01000000025',
      'whatsapp': '+201000000025',
    },
    {
      'name': 'صيدلية مصر - المطرية',
      'address': 'شارع المطرية، المطرية، القاهرة',
      'schedule': '9:00 AM - 9:00 PM',
      'distance': '19.0 km',
      'rating': 3,
      'location': {'lat': 30.1400, 'lng': 31.3300},
      'phone': '01000000026',
      'whatsapp': '+201000000026',
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPharmacies = allPharmacies.where((pharmacy) {
      final input = searchText.toLowerCase().trim();
      final name = pharmacy['name'].toLowerCase();
      final addr = pharmacy['address'].toLowerCase();
      final inCity = city.isEmpty || addr.contains(city.toLowerCase());
      return (input.isEmpty || name.contains(input) || addr.contains(input)) && inCity;
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
                  'Filter',
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
                SizedBox(height: 16),
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFE6F7FA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Icon(Icons.map, color: Color(0xFF1EC8C8), size: 60),
                  ),
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
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    leading: Icon(Icons.local_pharmacy, color: Color(0xFF1EC8C8), size: 36),
                    title: Text(pharmacy['name'], style: TextStyle(color: Color(0xFF1EC8C8), fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Address: ${pharmacy['address']}', style: TextStyle(color: Colors.black87, fontSize: 13)),
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
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on, color: Color(0xFF1EC8C8)),
                        Text(pharmacy['distance'], style: TextStyle(color: Color(0xFF1EC8C8), fontWeight: FontWeight.bold, fontSize: 13)),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PharmacyInfoPage(),
                        ),
                      );
                    },
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