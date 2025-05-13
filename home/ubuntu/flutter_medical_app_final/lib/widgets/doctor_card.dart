import 'package:flutter/material.dart';
import 'package:flutter_medical_app_final/models/doctor.dart';
import 'package:flutter_medical_app_final/widgets/doctor_avatar.dart';

class DoctorCard extends StatelessWidget {
  final Doctor doctor;
  final VoidCallback? onInfo;
  final VoidCallback? onCalendar;
  final VoidCallback? onHelp;
  final VoidCallback? onFavorite;
  final bool isFavorite;

  const DoctorCard({
    super.key,
    required this.doctor,
    this.onInfo,
    this.onCalendar,
    this.onHelp,
    this.onFavorite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DoctorAvatar(name: doctor.name, radius: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF3EC8D6), fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialty,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                OutlinedButton(
                  onPressed: onInfo,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF3EC8D6)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  ),
                  child: const Text('Info', style: TextStyle(color: Color(0xFF3EC8D6))),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.calendar_today, color: Color(0xFF3EC8D6), size: 22),
                      onPressed: onCalendar,
                    ),
                    IconButton(
                      icon: const Icon(Icons.help_outline, color: Color(0xFF3EC8D6), size: 22),
                      onPressed: onHelp,
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: const Color(0xFF3EC8D6),
                        size: 22,
                      ),
                      onPressed: onFavorite,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 