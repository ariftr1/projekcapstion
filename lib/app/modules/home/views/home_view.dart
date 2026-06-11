import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../edukasi/controllers/edukasi_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 Panggil EdukasiController untuk meminjam datanya di Home
    final edukasiC = Get.put(EdukasiController());

    // Membungkus Scaffold dengan Obx agar jika nilai controller (seperti userName)
    // berubah secara dinamis, tampilan akan otomatis di-refresh
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
              // 1. HEADER AREA
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
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Jaga kesehatan matamu hari ini!',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Stack(
                      children: [
                        Icon(
                          Icons.notifications_none_rounded, // Ganti jadi ikon notifikasi agar lebih relevan
                          color: Colors.white,
                          size: 30,
                        ),
                        // Titik merah notifikasi (opsional, pemanis UI)
                        Positioned(
                          right: 2,
                          top: 2,
                          child: CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // 2. CONTENT AREA (Bisa di-scroll)
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // --- Nanti Kartu Status Mata Utama Ditaruh di Sini ---
                      
                      const SizedBox(height: 10),

                      // BUTTON MULAI ISTIRAHAT
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: OutlinedButton(
                            onPressed: () {
                              // TODO: Tambahkan aksi untuk tombol ini (misal buka Mode Guard)
                            
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              shadowColor: Colors.black.withAlpha(50),
                            ),
                            child: const Text(
                              'Mulai Istirahat 20-20-20',
                              style: TextStyle(
                                color: Color(0xFF2052D9),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // 🔥 PANGGIL WIDGET CAROUSEL EDUKASI DI SINI
                      _buildEdukasiCarousel(edukasiC),

                      const SizedBox(height: 120), // Spasi bawah agar konten tidak tertutup floating navigator
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

  // ========================================================
  // WIDGET HELPER: CAROUSEL EDUKASI (MEMAKAI DATA DARI CONTROLLER)
  // ========================================================
  Widget _buildEdukasiCarousel(EdukasiController edukasiC) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Info Kesehatan Mata 📖",
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        SizedBox(
          height: 170, // Tinggi area scroll
          // Gunakan Obx hanya di bagian yang butuh render ulang list
          child: Obx(() {
            // ⚠️ PENTING: Ganti 'listArtikel' dengan nama variabel array yang ada di EdukasiController kamu!
            // Jika di controllermu namanya 'edukasiList', maka ganti jadi edukasiC.edukasiList
            var dataArtikel = edukasiC.listArtikel; 

            if (dataArtikel.isEmpty) {
              return const Center(
                child: Text(
                  "Belum ada artikel edukasi.",
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: dataArtikel.length,
              itemBuilder: (context, index) {
                var artikel = dataArtikel[index];
                
                return _buildCardEdukasi(
                  // ⚠️ Sesuaikan 'judul' dan 'deskripsi' dengan field data model kamu
                  judul: artikel['judul'] ?? 'Judul Artikel', 
                  deskripsi: artikel['deskripsi'] ?? 'Deskripsi singkat...',
                  onTap: () {
                    // TODO: Arahkan ke halaman detail edukasi jika ada
                  },
                );
              },
            );
          }),
        ),
      ],
    );
  }

  // Desain Kartu Edukasi (Glassmorphism)
  Widget _buildCardEdukasi({required String judul, required String deskripsi, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        width: 250,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(20),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withAlpha(50), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(40),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.menu_book_rounded, color: Colors.white, size: 24),
            ),
            const Spacer(),
            Text(
              judul,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14, 
                fontWeight: FontWeight.bold, 
                color: Colors.white,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  "Baca selengkapnya",
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.blue[100]),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_rounded, color: Colors.blue[100], size: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }
}