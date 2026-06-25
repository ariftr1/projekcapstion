import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../profil/controllers/profil_controller.dart';

class EditProfilController extends GetxController {
  var isLoading = false.obs;
  final box = GetStorage();

  final namaC = TextEditingController();
  final tglLahirC = TextEditingController();
  final umurC = TextEditingController(); // Controller ini akan terisi otomatis
  
  var selectedPekerjaan = "Mahasiswa".obs;
  final List<String> opsiPekerjaan = ["Mahasiswa", "Karyawan", "PNS", "Freelance", "Pelajar", "Lainnya"];

  @override
  void onInit() {
    super.onInit();
    namaC.text = box.read('nama') ?? '';
    tglLahirC.text = box.read('tanggal_lahir') ?? '';
    
    var savedUmur = box.read('umur');
    umurC.text = (savedUmur == null || savedUmur == 0) ? '' : savedUmur.toString();
    
    // 🔥 SINKRONISASI DROPDOWN (Mencegah Layar Merah Asersi):
    String? pekerjaanSaved = box.read('pekerjaan');
    
    if (pekerjaanSaved == null || pekerjaanSaved.trim().isEmpty || !opsiPekerjaan.contains(pekerjaanSaved)) {
      selectedPekerjaan.value = "Mahasiswa"; // Kembalikan ke opsi default jika kosong
    } else {
      selectedPekerjaan.value = pekerjaanSaved;
    }
  }

  // 🔥 FUNGSI: Menghitung umur secara otomatis berdasarkan DateTime Pilihan
  void hitungUmurOtomatis(DateTime tanggalLahir) {
    DateTime hariIni = DateTime.now();
    int umur = hariIni.year - tanggalLahir.year;

    // Koreksi jika bulan/tanggal hari ini belum melewati hari ulang tahunnya
    if (hariIni.month < tanggalLahir.month || 
       (hariIni.month == tanggalLahir.month && hariIni.day < tanggalLahir.day)) {
      umur--;
    }

    // Masukkan hasil hitungan ke dalam TextField Umur secara instan
    umurC.text = umur.toString();
  }

  Future<void> simpanProfilDasar() async {
    if (namaC.text.trim().isEmpty) {
      Get.snackbar("Gagal", "Nama lengkap wajib diisi!", backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }
    
    isLoading.value = true;
    try {
      var response = await http.put(
        // 🔥 PERBAIKAN IP ADDRESS: Mengubah .6 menjadi .7
        Uri.parse('http://172.20.10.13:5000/api/update-profil-dasar'),
        headers: {"Content-Type": "application/json", "Authorization": "Bearer ${box.read('token')}"},
        body: jsonEncode({
          "nama": namaC.text.trim(),
          "tanggal_lahir": tglLahirC.text.isEmpty ? null : tglLahirC.text,
          "umur": int.tryParse(umurC.text) ?? 0,
          "pekerjaan": selectedPekerjaan.value
        }),
      );
      
      if (response.statusCode == 200) {
        box.write('nama', namaC.text.trim());
        box.write('tanggal_lahir', tglLahirC.text);
        box.write('umur', int.tryParse(umurC.text) ?? 0);
        box.write('pekerjaan', selectedPekerjaan.value);

        // Memaksa halaman Profil utama memperbarui tampilannya secara realtime
        if (Get.isRegistered<ProfilController>()) Get.find<ProfilController>().loadUserData();
        
        Get.back();
        Get.snackbar("Sukses", "Profil dasar berhasil disimpan!", backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        // 🔥 Tambahan: Beri tahu jika errornya dari backend Flask
        Get.snackbar("Gagal", "Gagal menyimpan. Kode: ${response.statusCode}", backgroundColor: Colors.orange, colorText: Colors.white);
        print("Response body error: ${response.body}");
      }
    } catch (e) {
      // 🔥 Memunculkan eror di terminal agar gampang dilacak
      print("Error Update Profil: $e"); 
      Get.snackbar("Error", "Gagal terhubung ke server", backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally { 
      isLoading.value = false; 
    }
  }

  @override
  void onClose() {
    namaC.dispose();
    tglLahirC.dispose();
    umurC.dispose();
    super.onClose();
  }
}