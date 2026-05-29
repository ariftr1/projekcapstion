import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../profil/controllers/profil_controller.dart'; 

class EditProfilController extends GetxController {
  var isLoading = false.obs;
  var isObscureOld = true.obs;
  var isObscureNew = true.obs;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Semua user diperlakukan sama
    usernameController.text = box.read('userName') ?? '';
    emailController.text = box.read('userEmail') ?? '';
  }

  void toggleOldPassword() => isObscureOld.value = !isObscureOld.value;
  void toggleNewPassword() => isObscureNew.value = !isObscureNew.value;

  Future<void> updateProfile() async {
    String newName = usernameController.text.trim();
    String newEmail = emailController.text.trim();
    String oldPass = oldPasswordController.text.trim(); 
    String newPass = newPasswordController.text.trim(); 

    if (newName.isEmpty || newEmail.isEmpty) {
      Get.snackbar("Peringatan", "Username dan Email tidak boleh kosong",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      var url = Uri.parse('http://192.168.18.7:5000/api/update-profile');
      String? token = box.read('token');

      if (token == null || token.isEmpty) {
        Get.snackbar("Error", "Sesi tidak valid, silakan logout dan login ulang.",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
        isLoading.value = false;
        return;
      }

      var response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          "nama": newName,
          "email": newEmail,
          "password_lama": oldPass.isNotEmpty ? oldPass : null, 
          "password_baru": newPass.isNotEmpty ? newPass : null, 
        }),
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        box.write('userName', newName);
        box.write('userEmail', newEmail);

        if (Get.isRegistered<ProfilController>()) {
          Get.find<ProfilController>().loadUserData();
        }

        Get.back(); 
        Get.snackbar("Sukses", "Profil berhasil diperbarui!",
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Gagal", data['error'] ?? "Terjadi kesalahan",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
        isLoading.value = false;
      }
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat terhubung ke server",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      isLoading.value = false;
    }
  }
}