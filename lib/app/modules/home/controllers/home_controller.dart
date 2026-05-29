import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final box = GetStorage();
  
  // Variabel untuk menyimpan nama user yang login
  var userName = "Nanda".obs; 

  // Variabel reaktif untuk sensor (Bisa diupdate dari backend nanti)
  var eyeStatus = "KRITIS".obs;
  var statusColor = Colors.orange.obs;
  var distanceValue = "35 cm".obs;
  var blinkRateValue = "8 x/menit".obs;

  @override
  void onInit() {
    super.onInit();
    // Mengambil nama dari memori lokal saat halaman Home dibuka
    String name = box.read('userName') ?? "User";
    // Mengambil nama panggilan (kata pertama saja) agar UI lebih rapi
    userName.value = name.split(' ')[0]; 
  }
}