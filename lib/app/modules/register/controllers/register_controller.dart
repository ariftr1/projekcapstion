import 'package:get/get.dart';

class RegisterController extends GetxController {
  // 1. Variabel reaktif untuk menyembunyikan/menampilkan password
  var isPasswordHidden = true.obs;

  // 2. Fungsi untuk mengubah status saat icon mata diklik
  void togglePasswordView() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
}