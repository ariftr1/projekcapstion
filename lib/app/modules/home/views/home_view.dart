import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../edukasi/controllers/edukasi_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final edukasiC = Get.put(EdukasiController());

    return Obx(() => Scaffold(
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
              // 1. HEADER AREA DENGAN NOTIFIKASI
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, ${controller.userName.value}! 👋',
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          const Text('Jaga kesehatan matamu hari ini!', style: TextStyle(fontSize: 14, color: Colors.white70)),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {}, 
                      icon: const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 28),
                    ),
                  ],
                ),
              ),

              // 2. CONTENT AREA
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // BUTTON MULAI ISTIRAHAT
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                            child: const Text('Mulai Istirahat 20-20-20', style: TextStyle(color: Color(0xFF2052D9), fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // 3. DAFTAR EDUKASI VERTIKAL
                      _buildEdukasiList(edukasiC),

                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  // WIDGET LIST VERTIKAL
  Widget _buildEdukasiList(EdukasiController edukasiC) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text("Info Kesehatan Mata 📖", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        const SizedBox(height: 16),
        Obx(() => Column(
          children: edukasiC.listArtikel.map((artikel) {
            return _buildCardEdukasiVertikal(
              judul: artikel['judul'] ?? '', 
              deskripsi: artikel['deskripsi'] ?? '',
            );
          }).toList(),
        )),
      ],
    );
  }

  // DESAIN KARTU VERTIKAL
  Widget _buildCardEdukasiVertikal({required String judul, required String deskripsi}) {
    return GestureDetector(
      onTap: () => _showDetailArtikel(judul, deskripsi),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(20),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withAlpha(50), width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white.withAlpha(40), borderRadius: BorderRadius.circular(15)),
              child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(judul, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text("Baca selengkapnya", style: TextStyle(fontSize: 12, color: Colors.blue[100], fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // BOTTOM SHEET DETAIL
  void _showDetailArtikel(String judul, String deskripsi) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.6,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, color: Colors.grey[300])),
            const SizedBox(height: 20),
            Text(judul, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Expanded(child: SingleChildScrollView(child: Text(deskripsi, style: const TextStyle(fontSize: 16, color: Colors.black87)))),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}