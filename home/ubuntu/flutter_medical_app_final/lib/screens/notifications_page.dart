import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color cyan = Color(0xFF00BCD4);
    final Color lightCyan = Color(0xFFB2EBF2);
    final List<Map<String, dynamic>> notifications = [
      {
        'section': 'Today',
        'items': [
          {
            'icon': Icons.calendar_today,
            'title': 'Appointment Scheduled',
            'desc': 'Your appointment with Dr. Smith has been scheduled for tomorrow at 10:00 AM.',
            'time': '2m ago',
            'iconColor': cyan,
          },
          {
            'icon': Icons.description,
            'title': 'Medical Report Ready',
            'desc': 'Your latest medical report is now available for review.',
            'time': '2h ago',
            'iconColor': cyan,
          },
        ],
      },
      {
        'section': 'Yesterday',
        'items': [
          {
            'icon': Icons.chat_bubble_outline,
            'title': 'Medical Record Updated',
            'desc': 'Your medical record has been updated with new test results.',
            'time': '1d ago',
            'iconColor': cyan,
          },
        ],
      },
      {
        'section': 'April 15',
        'items': [
          {
            'icon': Icons.calendar_today,
            'title': 'Appointment Reminder',
            'desc': 'Reminder: You have a follow-up appointment scheduled.',
            'time': '5d ago',
            'iconColor': cyan,
          },
        ],
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cyan, Color(0xFF0097A7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Notifications',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 48),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _filterButton('Today', cyan),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _filterButtonWithIcon('Search', Icons.search, cyan),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: _filterButton('Mark All', cyan),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            // Notifications List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: notifications.length,
                itemBuilder: (context, sectionIdx) {
                  final section = notifications[sectionIdx];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Header
                      Container(
                        width: double.infinity,
                        color: cyan,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          section['section'],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ...List.generate(section['items'].length, (itemIdx) {
                        final item = section['items'][itemIdx];
                        return Column(
                          children: [
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: lightCyan,
                                    child: Icon(item['icon'], color: item['iconColor']),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['title'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          item['desc'],
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    item['time'],
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (itemIdx != section['items'].length - 1)
                              Divider(height: 1, thickness: 0.5, indent: 60, endIndent: 0),
                          ],
                        );
                      }),
                      SizedBox(height: 8),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterButton(String label, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _filterButtonWithIcon(String label, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 18),
          SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}