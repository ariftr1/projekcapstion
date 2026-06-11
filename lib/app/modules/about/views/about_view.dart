import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2052D9), Color(0xFF6A11CB)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // HEADER & TOMBOL KEMBALI
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                      onPressed: () => Get.back(),
                    ),
                    const Expanded(
                      child: Text(
                        "Tentang Aplikasi",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), // Penyeimbang agar teks rata tengah
                  ],
                ),
              ),

              // KONTEN TENTANG APLIKASI
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // LOGO BESAR
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(30),
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(20),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.gps_fixed_rounded, color: Colors.white, size: 60),
                        ),
                        const SizedBox(height: 24),

                        // NAMA APLIKASI
                        const Text(
                          "MyoGuard",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // VERSI
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(40),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "Versi 1.0.0",
                            style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 40),

                        // DESKRIPSI APLIKASI
                        const Text(
                          "MyoGuard adalah aplikasi kesehatan cerdas yang dirancang untuk membantu mencegah miopia (rabun jauh) sejak dini. \n\nMenggunakan teknologi deteksi wajah secara real-time, aplikasi ini akan memantau jarak aman antara mata dengan layar perangkat, serta mengingatkan Anda untuk beristirahat menggunakan metode 20-20-20.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white70,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 50),

                        // CREDIT / FOOTER
                        const Divider(color: Colors.white24),
                        const SizedBox(height: 20),
                        const Text(
                          "Dikembangkan untuk Proyek Capstone 2026",
                          style: TextStyle(fontSize: 12, color: Colors.white54),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "© 2026 MyoGuard Team",
                          style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}