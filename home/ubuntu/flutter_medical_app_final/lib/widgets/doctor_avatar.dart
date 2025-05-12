import 'package:flutter/material.dart';

class DoctorAvatar extends StatelessWidget {
  final String name;
  final double radius;
  final Color? backgroundColor;

  const DoctorAvatar({
    super.key,
    required this.name,
    this.radius = 30,
    this.backgroundColor,
  });

  String get _initials {
    final nameParts = name.split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[1][0]}${nameParts[2][0]}';
    }
    return nameParts[0].substring(0, 2).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? Colors.blue[100],
      child: Text(
        _initials,
        style: TextStyle(
          color: Colors.blue[700],
          fontSize: radius * 0.8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
} 