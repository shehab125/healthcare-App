import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'New Pharmacy Available Near You!',
      'body':
          'MediCure Pharmacy has been added to your area. Discover more now.',
      'date': 'Today'
    },
    {
      'title': 'New Doctor Appointment',
      'body': 'You have an appointment with Dr. Ahmed tomorrow at 10 AM.',
      'date': 'Yesterday'
    },
    {
      'title': 'Your Profile Has Been Updated',
      'body': 'Your profile has been successfully updated.',
      'date': '3 days ago'
    },
    {
      'title': 'Special Offer on Medications',
      'body': 'Get 20% off on all medications at Vitality Pharmacy.',
      'date': '1 week ago'
    },
    {
      'title': 'CarePlus Pharmacy Added',
      'body': 'CarePlus Pharmacy is now available in your area.',
      'date': '2 days ago'
    },
    {
      'title': 'Lab Test Reminder',
      'body': 'Don\'t forget your lab test appointment tomorrow at 9 AM.',
      'date': 'Today'
    },
    {
      'title': 'Your Request Has Been Accepted',
      'body':
          'Your request has been successfully accepted and we will contact you soon.',
      'date': '5 days ago'
    },
    {
      'title': 'Message from Support',
      'body': 'Please update the app to benefit from new features.',
      'date': '6 days ago'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FCFF),
      appBar: AppBar(
        title: Text('Notifications',
            style: TextStyle(
                color: Color(0xFF1EC8C8), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF1EC8C8)),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => SizedBox(height: 12),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 1,
            child: ListTile(
              leading:
                  Icon(Icons.notifications, color: Color(0xFF1EC8C8), size: 32),
              title: Text(notification['title']!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1EC8C8),
                      fontSize: 16)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2),
                  Text(notification['body']!,
                      style: TextStyle(color: Colors.black87, fontSize: 13)),
                  SizedBox(height: 4),
                  Text(notification['date']!,
                      style: TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
              isThreeLine: true,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationDetailPage(
                      title: notification['title']!,
                      body: notification['body']!,
                      date: notification['date']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class NotificationDetailPage extends StatelessWidget {
  final String title;
  final String body;
  final String date;

  const NotificationDetailPage(
      {Key? key, required this.title, required this.body, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FCFF),
      appBar: AppBar(
        title: Text('Notification Details',
            style: TextStyle(
                color: Color(0xFF1EC8C8), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF1EC8C8)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.notifications, color: Color(0xFF1EC8C8), size: 36),
                SizedBox(width: 12),
                Expanded(
                  child: Text(title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1EC8C8),
                          fontSize: 20)),
                ),
              ],
            ),
            SizedBox(height: 24),
            Text(body, style: TextStyle(color: Colors.black87, fontSize: 16)),
            SizedBox(height: 32),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.grey, size: 18),
                SizedBox(width: 6),
                Text(date, style: TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
