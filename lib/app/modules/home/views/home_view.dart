import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. BACKGROUND GRADASI BIRU UTAMA
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2052D9), Color(0xFF0F8FEA)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // HEADER: Sapaan & Icon Pesan
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Hi, Arif! 👋',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          'Jaga kesehatan matamu hari ini!',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                      ],
                    ),
                    const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white, size: 30),
                  ],
                ),
              ),

              // KONTEN UTAMA (Scrollable)
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // 2. KARTU STATUS MATA (KRITIS)
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Status Mata', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 12),
                            Row(
                              children: const [
                                Icon(Icons.warning_rounded, color: Colors.orange, size: 40),
                                SizedBox(width: 12),
                                Text(
                                  'Kritis',
                                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF2052D9)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Mata kamu terlihat lelah. Segera istirahat!',
                              style: TextStyle(color: Colors.black54, fontSize: 15),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // 3. SEKSI DATA REAL-TIME
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Data Real-time', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Terakhir: 09:41', style: TextStyle(color: Colors.white70, fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // List Item Real-time
                      _buildDataItem(Icons.straighten, 'Rata-rata', '35 cm', true),
                      _buildDataItem(Icons.remove_red_eye_outlined, 'Blink Rate', '8 x/menit', false),
                      _buildDataItem(Icons.wb_sunny_outlined, 'Cahaya Sekitar', '120 lux', true),

                      const SizedBox(height: 24),

                      // 4. RECAP DAILY
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(40),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Recap Daily', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                Text('19:23 / 24:00', style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            LinearProgressIndicator(
                              value: 0.8,
                              backgroundColor: Colors.white24,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              minHeight: 8,
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Hari ini kamu menjaga mata dengan baik',
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 5. TOMBOL MULAI ISTIRAHAT
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          child: const Text(
                            'Mulai Istirahat',
                            style: TextStyle(color: Color(0xFF2052D9), fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // 6. BOTTOM NAVIGATION BAR
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: const Color(0xFF2052D9),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.monitor_heart_outlined), label: 'Monitor'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics_outlined), label: 'Analitik'),
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb_outline), label: 'Saran'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }

  // Widget helper untuk baris data sensor
  Widget _buildDataItem(IconData icon, String label, String value, bool isAlert) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
          const Spacer(),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(width: 8),
          Icon(
            isAlert ? Icons.arrow_drop_up_rounded : Icons.remove_rounded,
            color: isAlert ? Colors.yellow : Colors.white,
          ),
        ],
      ),
    );
  }
}