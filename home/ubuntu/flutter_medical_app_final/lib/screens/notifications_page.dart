import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'صيدلية جديدة متاحة بالقرب منك!',
      'body': 'تمت إضافة MediCure Pharmacy إلى منطقتك. اكتشف المزيد الآن.',
      'date': 'اليوم'
    },
    {
      'title': 'موعد جديد مع الطبيب',
      'body': 'لديك موعد مع د. أحمد غداً الساعة 10 صباحاً.',
      'date': 'أمس'
    },
    {
      'title': 'تم تحديث بياناتك الشخصية',
      'body': 'تم تحديث ملفك الشخصي بنجاح.',
      'date': 'منذ 3 أيام'
    },
    {
      'title': 'عرض خاص على الأدوية',
      'body': 'احصل على خصم 20% على جميع الأدوية في Vitality Pharmacy.',
      'date': 'منذ أسبوع'
    },
    {
      'title': 'تم إضافة صيدلية CarePlus',
      'body': 'صيدلية CarePlus أصبحت متاحة الآن في منطقتك.',
      'date': 'منذ يومين'
    },
    {
      'title': 'تذكير بموعد التحاليل',
      'body': 'لا تنسَ موعد التحاليل غداً الساعة 9 صباحاً.',
      'date': 'اليوم'
    },
    {
      'title': 'تم قبول طلبك',
      'body': 'تم قبول طلبك بنجاح وسيتم التواصل معك قريباً.',
      'date': 'منذ 5 أيام'
    },
    {
      'title': 'رسالة من الدعم',
      'body': 'يرجى تحديث التطبيق للاستفادة من الميزات الجديدة.',
      'date': 'منذ 6 أيام'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FCFF),
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(color: Color(0xFF1EC8C8), fontWeight: FontWeight.bold)),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            elevation: 1,
            child: ListTile(
              leading: Icon(Icons.notifications, color: Color(0xFF1EC8C8), size: 32),
              title: Text(notification['title']!, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1EC8C8), fontSize: 16)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2),
                  Text(notification['body']!, style: TextStyle(color: Colors.black87, fontSize: 13)),
                  SizedBox(height: 4),
                  Text(notification['date']!, style: TextStyle(color: Colors.grey, fontSize: 11)),
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

  const NotificationDetailPage({Key? key, required this.title, required this.body, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FCFF),
      appBar: AppBar(
        title: Text('تفاصيل الإشعار', style: TextStyle(color: Color(0xFF1EC8C8), fontWeight: FontWeight.bold)),
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
                  child: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1EC8C8), fontSize: 20)),
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