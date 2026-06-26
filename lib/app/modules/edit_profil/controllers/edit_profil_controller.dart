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
  final umurC = TextEditingController(); 
  
  var selectedPekerjaan = "Mahasiswa".obs;
  final List<String> opsiPekerjaan = ["Mahasiswa", "Karyawan", "PNS", "Freelance", "Pelajar", "Lainnya"];

  // 🔥 PERBAIKAN 1: Pisahkan Base URL agar mudah diganti dan dibaca. 
  // Pastikan tidak ada spasi di dalam string ini.
  final String baseUrl = "http://172.20.10.13:5000";

  @override
  void onInit() {
    super.onInit();
    namaC.text = box.read('nama') ?? '';
    tglLahirC.text = box.read('tanggal_lahir') ?? '';
    
    var savedUmur = box.read('umur');
    umurC.text = (savedUmur == null || savedUmur == 0) ? '' : savedUmur.toString();
    
    // Mencegah layar merah/error asersi jika data kosong
    String? pekerjaanSaved = box.read('pekerjaan');
    if (pekerjaanSaved == null || pekerjaanSaved.trim().isEmpty || !opsiPekerjaan.contains(pekerjaanSaved)) {
      selectedPekerjaan.value = "Mahasiswa"; 
    } else {
      selectedPekerjaan.value = pekerjaanSaved;
    }
  }

  // Menghitung umur secara otomatis berdasarkan DateTime Pilihan
  void hitungUmurOtomatis(DateTime tanggalLahir) {
    DateTime hariIni = DateTime.now();
    int umur = hariIni.year - tanggalLahir.year;

    if (hariIni.month < tanggalLahir.month || 
       (hariIni.month == tanggalLahir.month && hariIni.day < tanggalLahir.day)) {
      umur--;
    }

    umurC.text = umur.toString();
  }

  Future<void> simpanProfilDasar() async {
    if (namaC.text.trim().isEmpty) {
      Get.snackbar("Peringatan", "Nama lengkap wajib diisi!", backgroundColor: Colors.orange, colorText: Colors.white);
      return;
    }
    
    isLoading.value = true;
    try {
      // 🔥 PERBAIKAN 2: Validasi keberadaan Token sebelum nembak API
      String token = box.read('token') ?? '';
      if (token.isEmpty) {
        Get.snackbar("Error", "Sesi login tidak valid. Silakan login ulang.", backgroundColor: Colors.redAccent, colorText: Colors.white);
        isLoading.value = false;
        return;
      }

      // 🔥 PERBAIKAN 3: Menggunakan .trim() pada URL untuk memastikan tidak ada spasi (%20)
      var url = Uri.parse('$baseUrl/api/update-profil-dasar'.trim());
      
      var response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json", 
          "Authorization": "Bearer $token"
        },
        body: jsonEncode({
          "nama": namaC.text.trim(),
          "tanggal_lahir": tglLahirC.text.isEmpty ? null : tglLahirC.text,
          "umur": int.tryParse(umurC.text) ?? 0,
          "pekerjaan": selectedPekerjaan.value
        }),
      );
      
      if (response.statusCode == 200) {
        // Simpan ke local storage
        box.write('nama', namaC.text.trim());
        box.write('tanggal_lahir', tglLahirC.text);
        box.write('umur', int.tryParse(umurC.text) ?? 0);
        box.write('pekerjaan', selectedPekerjaan.value);

        // Memaksa halaman Profil utama memperbarui tampilannya
        if (Get.isRegistered<ProfilController>()) {
          Get.find<ProfilController>().loadUserData();
        }
        
        Get.back();
        Get.snackbar("Sukses", "Profil dasar berhasil diperbarui!", backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        // 🔥 PERBAIKAN 4: Ekstraksi pesan error dari backend JSON (jika Flask mengirim respons 'message')
        String errorMessage = "Gagal menyimpan. Kode: ${response.statusCode}";
        try {
          var errorData = jsonDecode(response.body);
          if (errorData['message'] != null) {
            errorMessage = errorData['message'];
          }
        } catch (_) {}
        
        Get.snackbar("Gagal", errorMessage, backgroundColor: Colors.redAccent, colorText: Colors.white);
        print("Response body error: ${response.body}");
      }
    } catch (e) {
      print("Error Update Profil: $e"); 
      Get.snackbar("Koneksi Gagal", "Sistem gagal terhubung ke backend. Pastikan server menyala.", backgroundColor: Colors.redAccent, colorText: Colors.white);
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