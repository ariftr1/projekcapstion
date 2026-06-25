import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  
  // Variabel untuk menyimpan nama panggilan user yang login
  var userName = "Memuat...".obs; 

  // Variabel reaktif untuk sensor (Bisa diupdate dari backend nanti)
  var eyeStatus = "KRITIS".obs;
  var statusColor = Colors.orange.obs;
  var distanceValue = "35 cm".obs;
  var blinkRateValue = "8 x/menit".obs;

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  // 🔥 Fungsi untuk memuat data di beranda
void loadHomeData() {
    // 1. Paksa hasil bacaan dari GetStorage menjadi String menggunakan .toString()
    //    dan sediakan fallback "Sahabat" jika datanya null.
    var rawName = box.read('nama');
    String name = (rawName != null) ? rawName.toString() : "Sahabat"; 
    
    // 2. Bersihkan spasi di depan/belakang teks
    name = name.trim();

    // 3. Ambil kata pertama untuk sapaan
    if (name.isNotEmpty) {
      userName.value = name.split(' ')[0]; 
    } else {
      userName.value = "Sahabat";
    }
  }
}