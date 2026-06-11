import 'package:get/get.dart';

class EdukasiController extends GetxController {
  // Indikator kategori yang sedang aktif (0 = Tips Harian, 1 = Artikel Medis)
  var selectedCategory = 0.obs;

  void changeCategory(int index) {
    selectedCategory.value = index;
  }

  // 🔥 TAMBAHKAN INI: Variabel listArtikel yang berisi data edukasi
  // Menggunakan .obs agar reaktif jika datanya nanti diambil dari API
  var listArtikel = [
    {
      "judul": "Mengenal Aturan 20-20-20 untuk Mata",
      "deskripsi": "Istirahatkan matamu setiap 20 menit, lihat jarak 20 kaki, selama 20 detik untuk mencegah kelelahan layar.",
    },
    {
      "judul": "Bahaya Menatap Layar Terlalu Dekat",
      "deskripsi": "Jarak layar yang kurang dari 30cm dapat meningkatkan risiko miopia (rabun jauh) secara drastis pada generasi muda.",
    },
    {
      "judul": "Makanan Penuh Vitamin A untuk Mata",
      "deskripsi": "Wortel, bayam, dan ubi jalar mengandung beta-karoten tinggi yang sangat baik untuk menjaga ketajaman penglihatan.",
    },
    {
      "judul": "Pentingnya Berkedip Saat Menatap Gadget",
      "deskripsi": "Saat fokus pada layar, frekuensi kedipan mata turun drastis. Ini menyebabkan sindrom mata kering yang mengganggu.",
    }
  ].obs;
}