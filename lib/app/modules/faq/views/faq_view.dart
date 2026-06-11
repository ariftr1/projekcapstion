import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/faq_controller.dart';

class FaqView extends GetView<FaqController> {
  const FaqView({super.key});

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
                        "FAQ (Pusat Bantuan)",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48), 
                  ],
                ),
              ),

              // LIST PERTANYAAN
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  children: [
                    _buildFaqItem(
                      pertanyaan: "Apa itu fitur Guard di MyoGuard?",
                      jawaban: "Fitur Guard menggunakan kamera perangkatmu untuk mendeteksi jarak mata ke layar secara real-time. Jika wajahmu terlalu dekat, aplikasi akan memberikan peringatan agar matamu tetap rileks dan terhindar dari risiko miopia.",
                    ),
                    _buildFaqItem(
                      pertanyaan: "Apakah MyoGuard merekam wajah saya?",
                      jawaban: "Sama sekali tidak! Kamera hanya digunakan untuk mendeteksi titik wajah dan menghitung jarak. MyoGuard tidak pernah merekam, menyimpan, apalagi mengirimkan foto atau video wajahmu ke server. Privasimu 100% aman.",
                    ),
                    _buildFaqItem(
                      pertanyaan: "Apa itu Aturan 20-20-20?",
                      jawaban: "Ini adalah metode kesehatan mata dari ahli optometri. Setiap 20 menit menatap layar, istirahatkan matamu dengan melihat objek sejauh 20 kaki (sekitar 6 meter) selama 20 detik. MyoGuard akan membantumu mengingatkan aturan ini.",
                    ),
                    _buildFaqItem(
                      pertanyaan: "Kenapa saya harus membuat akun?",
                      jawaban: "Akun diperlukan agar data riwayat aktivitas dan skor kesehatan matamu tidak hilang. Dengan akun, kamu bisa melihat menu Analitik dan memantau perkembangan kesehatan matamu dari waktu ke waktu.",
                    ),
                    _buildFaqItem(
                      pertanyaan: "Bagaimana jika deteksi kamera tidak akurat?",
                      jawaban: "Pastikan kamu berada di ruangan dengan pencahayaan yang cukup. Posisi HP atau laptop juga sebaiknya sejajar dengan wajah agar sensor dapat membaca jarak dengan maksimal.",
                    ),
                    const SizedBox(height: 40), 
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem({required String pertanyaan, required String jawaban}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(20),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withAlpha(50), width: 1.5),
        ),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            iconColor: Colors.white,
            collapsedIconColor: Colors.white70,
            title: Text(
              pertanyaan,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            children: [
              Text(
                jawaban,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}