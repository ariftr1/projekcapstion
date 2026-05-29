import 'package:get/get.dart';

class EdukasiController extends GetxController {
  // Indikator kategori yang sedang aktif (0 = Tips Harian, 1 = Artikel Medis)
  var selectedCategory = 0.obs;

  void changeCategory(int index) {
    selectedCategory.value = index;
  }
}