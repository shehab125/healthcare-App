import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Payment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3EC6E0), Color(0xFF4F8FEA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.check, color: Color(0xFF3EC6E0), size: 80),
                  ),
                ),
                const SizedBox(height: 32),
                const Text('Congratulation', style: TextStyle(color: Color(0xFF3EC6E0), fontWeight: FontWeight.bold, fontSize: 28)),
                const SizedBox(height: 8),
                const Text('Payment is Successfully', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('You have successfully booked an appointment with', style: TextStyle(color: Colors.black54, fontSize: 14)),
                      SizedBox(height: 8),
                      Text('Dr. Emma Hall, M.D.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 18, color: Color(0xFF3EC6E0)),
                          SizedBox(width: 6),
                          Text('Month 24, Year', style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(width: 16),
                          Icon(Icons.access_time, size: 18, color: Color(0xFF3EC6E0)),
                          SizedBox(width: 6),
                          Text('10:00 AM', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFF3EC6E0), width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Download Receipt', style: TextStyle(color: Color(0xFF3EC6E0), fontWeight: FontWeight.bold, fontSize: 16)),
                        SizedBox(width: 8),
                        Icon(Icons.download, color: Color(0xFF3EC6E0)),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      backgroundColor: const Color(0xFF3EC6E0),
                    ),
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text('Return Now', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 