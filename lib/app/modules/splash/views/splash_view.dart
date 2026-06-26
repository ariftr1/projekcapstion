import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2052D9),
              Color(0xFF0F8FEA),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),

            // 2. LOGO TENGAH (MENGGUNAKAN LOGO1.PNG)
            // 2. LOGO TENGAH (MENGGUNAKAN LOGO1.PNG DENGAN LATAR PUTIH SOLID)
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(12), // Padding agar logo tidak terlalu mepet
              decoration: BoxDecoration(
                color: Colors.white, // Ganti dari .withOpacity(0.2) menjadi putih solid
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/logo1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            const SizedBox(height: 24),

            // 3. TEKS JUDUL
            const Text(
              'Myoguard',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
            
            const SizedBox(height: 8),

            // 4. TEKS SUB-JUDUL
            const Text(
              'Smart Health Assistant\nPencegahan Miopia',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.3,
              ),
            ),

            const Spacer(flex: 2),

            // 5. PROGRESS BAR
            Column(
              children: [
                Container(
                  width: 180,
                  height: 6,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(76),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 180),
                    duration: const Duration(seconds: 6),
                    builder: (context, value, child) {
                      return Container(
                        width: value,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 12),
                
                Text(
                  'Memuat...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(230),
                  ),
                ),
              ],
            ),

            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}