import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});

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
                        "Kebijakan Privasi",
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

              // ISI KEBIJAKAN PRIVASI
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withAlpha(50), width: 1.5),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Terakhir diperbarui: Mei 2026\n",
                          style: TextStyle(fontSize: 12, color: Colors.white54),
                        ),
                        _buildSectionTitle("1. Penggunaan Kamera"),
                        _buildSectionText(
                          "Aplikasi MyoGuard membutuhkan akses kamera depan perangkat Anda semata-mata untuk fitur 'Guard'. Kamera digunakan secara real-time untuk mendeteksi landmark wajah dan menghitung jarak mata ke layar.",
                        ),
                        _buildSectionTitle("2. Keamanan Data Wajah"),
                        _buildSectionText(
                          "Kami sangat menghargai privasi Anda. MyoGuard TIDAK PERNAH mengambil foto, merekam video, menyimpan, atau mengirimkan data visual wajah Anda ke server mana pun. Semua pemrosesan deteksi wajah dilakukan secara lokal (offline) di dalam perangkat Anda.",
                        ),
                        _buildSectionTitle("3. Pengumpulan Data Akun"),
                        _buildSectionText(
                          "Ketika Anda mendaftar melalui Email atau Google Sign-In, kami hanya menyimpan informasi dasar seperti Nama, Alamat Email, dan ID Pengguna. Data ini digunakan untuk menyimpan riwayat aktivitas dan skor kesehatan mata Anda agar dapat diakses kembali.",
                        ),
                        _buildSectionTitle("4. Keamanan Server"),
                        _buildSectionText(
                          "Data akun dan riwayat analitik Anda disimpan secara aman di dalam database yang dilindungi. Kami tidak menjual atau membagikan data pribadi Anda kepada pihak ketiga mana pun.",
                        ),
                        _buildSectionTitle("5. Perubahan Kebijakan"),
                        _buildSectionText(
                          "Kebijakan ini dapat berubah sewaktu-waktu seiring dengan pembaruan fitur aplikasi. Kami akan memberi tahu Anda melalui aplikasi jika ada perubahan signifikan.",
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Text(
                            "Dengan menggunakan MyoGuard, Anda menyetujui kebijakan ini.",
                            style: TextStyle(fontSize: 12, color: Colors.white.withAlpha(150), fontStyle: FontStyle.italic),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Jarak aman bawah
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET BANTUAN UNTUK FORMAT TEKS
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSectionText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.white70,
        height: 1.6,
      ),
      textAlign: TextAlign.justify,
    );
  }
}