import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../profil/controllers/profil_controller.dart';

class RiwayatMedisController extends GetxController {
  var isLoading = false.obs;
  final box = GetStorage();

  final sphC = TextEditingController();
  final cylC = TextEditingController();
  
  var menggunakanKacamata = false.obs;
  var lamaBerkacamata = "< 1 Tahun".obs;
  final List<String> opsiRangeWaktu = ["< 1 Tahun", "1-2 Tahun", "3-5 Tahun", "> 5 Tahun"];

  @override
  void onInit() {
    super.onInit();
    sphC.text = box.read('sph')?.toString() ?? '';
    cylC.text = box.read('cyl')?.toString() ?? '';
    
    // 1. Load status kacamata
    bool status = box.read('status_kacamata') ?? false;
    menggunakanKacamata.value = status;
    
    // 2. Load durasi, pastikan nilainya valid dengan daftar pilihan
    String savedLama = box.read('lama_berkacamata') ?? "< 1 Tahun";
    if (opsiRangeWaktu.contains(savedLama)) {
      lamaBerkacamata.value = savedLama;
    } else {
      lamaBerkacamata.value = "< 1 Tahun"; // Default jika data tidak valid
    }
  }

  // Fungsi untuk menangani perubahan switch agar UI langsung sinkron
  void toggleKacamata(bool val) {
    menggunakanKacamata.value = val;
    // Jika user mematikan kacamata, kita tidak perlu mereset nilai dropdown, 
    // tapi saat disimpan nanti, logic kita akan otomatis mengirim "Tidak Pakai"
  }

  Future<void> simpanRiwayatMedis() async {
    isLoading.value = true;
    try {
      // Menentukan nilai yang akan dikirim ke backend
      String durasiToSave = menggunakanKacamata.value ? lamaBerkacamata.value : "Tidak Pakai";

      var response = await http.put(
        Uri.parse('http://172.20.10.13:5000/api/update-riwayat-medis'),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${box.read('token')}"},
        body: jsonEncode({
          "sph": double.tryParse(sphC.text) ?? 0.0,
          "cyl": double.tryParse(cylC.text) ?? 0.0,
          "status_kacamata": menggunakanKacamata.value,
          "lama_berkacamata": durasiToSave
        }),
      );
      
      if (response.statusCode == 200) {
        // Simpan ke local storage
        box.write('sph', double.tryParse(sphC.text) ?? 0.0);
        box.write('cyl', double.tryParse(cylC.text) ?? 0.0);
        box.write('status_kacamata', menggunakanKacamata.value);
        box.write('lama_berkacamata', durasiToSave);

        if (Get.isRegistered<ProfilController>()) Get.find<ProfilController>().loadUserData();
        Get.back();
        Get.snackbar("Sukses", "Data medis mata berhasil diperbarui!", backgroundColor: Colors.green, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal terhubung ke server", backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally { isLoading.value = false; }
  }
}