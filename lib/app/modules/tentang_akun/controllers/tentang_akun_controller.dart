import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TentangAkunController extends GetxController {
  var isLoading = false.obs;
  var isObscureOld = true.obs;
  var isObscureNew = true.obs;
  var isObscureConfirm = true.obs;

  var emailStatis = "".obs;
  final oldPassC = TextEditingController();
  final newPassC = TextEditingController();
  final confirmPassC = TextEditingController();

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Otomatis mengunci email dari registrasi awal, user dilarang merubahnya
    emailStatis.value = box.read('email') ?? 'Email Kosong';
  }

  Future<void> gantiPasswordSandi() async {
    if (oldPassC.text.isEmpty || newPassC.text.isEmpty || confirmPassC.text.isEmpty) {
      Get.snackbar("Peringatan", "Semua kolom kata sandi wajib diisi!", backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }
    if (newPassC.text != confirmPassC.text) {
      Get.snackbar("Peringatan", "Konfirmasi sandi baru tidak cocok. Periksa kembali!", backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    try {
      var response = await http.put(
        Uri.parse('http://172.20.10.13:5000/api/ganti-password'),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${box.read('token')}"},
        body: jsonEncode({
          "password_lama": oldPassC.text,
          "password_baru": newPassC.text
        }),
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        oldPassC.clear();
        newPassC.clear();
        confirmPassC.clear();
        Get.back();
        Get.snackbar("Sukses", "Kata sandi akun berhasil diperbarui!", backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Gagal", data['message'] ?? "Terjadi kesalahan", backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal menghubungi server", backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally { isLoading.value = false; }
  }
}