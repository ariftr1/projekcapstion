import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Kita tidak pakai appbar, langsung body saja
      body: Container(
        width: double.infinity,
        // 1. MEMBUAT BACKGROUND GRADASI BIRU
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // Ganti kode Hex warna di bawah ini sesuai yang ada di Figma kamu!
            colors: [
              Color(0xFF2052D9), // Biru tua (atas)
              Color(0xFF0F8FEA), // Biru muda (bawah)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Spacer untuk mendorong konten sedikit ke tengah
            const Spacer(flex: 3),

            // 2. LOGO TENGAH
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                // Warna background kotak transparan (20% opacity)
                color: Colors.white.withOpacity(0.2), 
                // Membuat sudutnya melengkung
                borderRadius: BorderRadius.circular(28),
                // (Opsional) Garis pinggir tipis jika diperlukan
                border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
              ),
              child: const Center(
                // Saya pakai icon GPS/Target bawaan Flutter sebagai pengganti sementara
                // Kalau kamu sudah export logo asli dari Figma, bisa ganti pakai Image.asset
                child: Icon(
                  Icons.gps_fixed_rounded,
                  color: Colors.white,
                  size: 48,
                ),
              ),
            ),
            
            const SizedBox(height: 24),

            // 3. TEKS JUDUL (MyoGuard)
            const Text(
              'MyoGuard',
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
              textAlign: TextAlign.center, // Teks rata tengah
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
                height: 1.3, // Jarak antar baris
              ),
            ),

            const Spacer(flex: 2),

            // 5. PROGRESS BAR (Memuat...)
            Column(
              children: [
                // Membuat custom progress bar memanjang
                Container(
                  width: 180, // Panjang total bar
                  height: 6,
                  alignment: Alignment.centerLeft, // Pastikan animasi mulai dari kiri
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(76), // Background agak redup
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // 👇 INI KODE ANIMASINYA
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 180), // Bergerak dari 0 px ke 180 px
                    duration: const Duration(seconds: 6), // Lama animasi 2 detik (sesuai timer)
                    builder: (context, value, child) {
                      return Container(
                        width: value, // Lebar mengikuti nilai animasi
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white, // Warna bar yang berjalan (solid)
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Teks "Memuat..."
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