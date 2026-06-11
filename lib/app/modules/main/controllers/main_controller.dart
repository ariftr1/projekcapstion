import 'package:get/get.dart';

class MainController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    // 🔥 REVISI: Hapus pemblokiran Index 1 agar pengguna bisa membuka halaman Analitik
    currentIndex.value = index;
  }
}