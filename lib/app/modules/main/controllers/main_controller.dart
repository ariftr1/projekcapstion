import 'package:get/get.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    // Kunci HANYA Index 1 (Analitik) karena memang belum kita buat
    if (index == 1) {
      Get.snackbar(
        "Info", 
        "Fitur Analitik masih dalam tahap pengembangan.",
        snackPosition: SnackPosition.TOP,
      );
    } else {
      // Izinkan pindah ke halaman lain (termasuk Index 3 / Edukasi yang baru)
      currentIndex.value = index;
    }
  }
}