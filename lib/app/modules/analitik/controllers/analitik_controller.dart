import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class AnalitikController extends GetxController {
  final String baseUrl = 'http://172.20.10.13:5000'; 
  final box = GetStorage(); 

  var isMingguan = true.obs;
  var isLoading = false.obs;

  var avgDistance = "0 cm".obs;
  var totalScreenTime = "0j 0m".obs;
  var complianceScore = "0%".obs;
  var riskStatus = "Aman".obs;
  var riskMessage = "Memuat analisis...".obs;

  var lineSpots = <FlSpot>[].obs;
  var barGroups = <BarChartGroupData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataDariBackend(); 
  }

  // --- GETTER YANG DIBUTUHKAN VIEW ---
// --- GETTER YANG DIBUTUHKAN VIEW ---
  // 🔥 KITA HAPUS DATA PALSU AGAR KETAHUAN JIKA SERVER GAGAL
  // --- GETTER YANG DIBUTUHKAN VIEW ---
  // Kita buat 0 agar kita tidak tertipu lagi oleh data palsu
  List<FlSpot> get lineChartData => lineSpots.isEmpty 
      ? [const FlSpot(0, 0)] 
      : lineSpots;

  List<BarChartGroupData> get barChartData => barGroups.isEmpty 
      ? [_makeBarData(0, 0)] 
      : barGroups;

  BarChartGroupData _makeBarData(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(toY: y, color: Colors.blue, width: 16, borderRadius: BorderRadius.circular(4))
    ]);
  }

  void switchTab(bool mingguan) {
    isMingguan.value = mingguan;
    fetchDataDariBackend(); 
  }

  Future<void> fetchDataDariBackend() async {
    isLoading.value = true;
    
    final savedUserId = box.read('userId'); 
    int userId = (savedUserId != null) ? int.parse(savedUserId.toString()) : 0; 
    
    print("DEBUG: Fetching data Analitik untuk User ID: $userId");

    // 🚨 DETEKTIF 1: Jika ID Kosong/0
    if (userId == 0) {
      isLoading.value = false;
      Get.snackbar("Akses Terblokir", "ID User tidak terbaca di memori. Silakan Logout dan Login ulang.", backgroundColor: Colors.orange, colorText: Colors.white, duration: const Duration(seconds: 5));
      return;
    }

    try {
      final response = await http.get(Uri.parse('$baseUrl/api/analitik/$userId'));

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        
        // 🚨 DETEKTIF 2: Jika query database di Flask bermasalah
        if (jsonResponse['status'] == 'error') {
          Get.snackbar("Eror Database", jsonResponse['pesan'] ?? "Gagal mengambil data SQL", backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 5));
          isLoading.value = false;
          return;
        }

        List dataSQL = jsonResponse['data'] ?? []; 
        
        if (dataSQL.isEmpty) {
          lineSpots.value = [];
          barGroups.value = [];
          avgDistance.value = "0 cm";
          totalScreenTime.value = "0 jam";
          // INI HARUSNYA MUNCUL JIKA SERVER BERHASIL TAPI DATA KOSONG
          riskStatus.value = "Data Kosong"; 
          riskMessage.value = "Belum ada aktivitas terekam.";
          return;
        }

List<FlSpot> newLineSpots = [];
        List<BarChartGroupData> newBarGroups = [];
        double totalJarak = 0, totalJam = 0;
        double totalKedipan = 0; // 🔥 Tambahan: Menampung total kedipan dari SQL

        for (int i = 0; i < dataSQL.length; i++) {
          var item = dataSQL[i];
          double rataJarak = (item['rata_jarak'] as num).toDouble();
          double jam = (item['estimasi_jam_screen_time'] as num).toDouble();
          double rataKedipan = (item['rata_kedipan'] as num).toDouble(); // 🔥 Tambahan: Ambil nilai kedipan harian

          totalJarak += rataJarak;
          totalJam += jam;
          totalKedipan += rataKedipan; // 🔥 Tambahan: Akumulasikan kedipan

          double skor = rataJarak >= 30 ? 100.0 : (rataJarak / 30) * 100;
          newLineSpots.add(FlSpot(i.toDouble(), skor));
          
          newBarGroups.add(BarChartGroupData(x: i, barRods: [
            BarChartRodData(
              toY: jam, 
              color: jam > 6 ? Colors.redAccent : Colors.blue, 
              width: 16, 
              borderRadius: BorderRadius.circular(4)
            )
          ]));
        }

        lineSpots.value = newLineSpots;
        barGroups.value = newBarGroups;

        // Hitung Rata-rata Akhir Secara Aktual
        int avgJarakFinal = dataSQL.isNotEmpty ? (totalJarak / dataSQL.length).round() : 0;
        int avgKedipanFinal = dataSQL.isNotEmpty ? (totalKedipan / dataSQL.length).round() : 0;

        avgDistance.value = "$avgJarakFinal cm";
        totalScreenTime.value = "${totalJam.round()} jam";
        
        // 🔥 PENYESUAIAN UTAMA: Hubungkan ke API Machine Learning + Safety Override di Flask
        try {
          final predictResponse = await http.post(
            Uri.parse('$baseUrl/api/predict-risk'),
            headers: {"Content-Type": "application/json"},
            body: json.encode({
              "durasi_layar_menit": (totalJam * 60).round(),
              "waktu_penggunaan": "Siang",
              "rata_rata_jarak_cm": avgJarakFinal,
              "rata_rata_kedipan_bpm": avgKedipanFinal,
              "total_pelanggaran_jarak": avgJarakFinal < 30 ? 12 : 0 // Asumsi trigger statis untuk demo skripsi
            }),
          );

          if (predictResponse.statusCode == 200) {
            var aiData = json.decode(predictResponse.body);
            // Menangkap balasan dinamis dari server Flask
            riskStatus.value = aiData['prediksi_risiko'] ?? "Aman";
            riskMessage.value = aiData['rekomendasi'] ?? "Pola penggunaan gadgetmu dalam batas wajar.";
          } else {
            riskStatus.value = "Eror ML";
            riskMessage.value = "Gagal memproses prediksi dari server AI (Status: ${predictResponse.statusCode}).";
          }
        } catch (aiError) {
          print("Error saat request prediksi ke Flask: $aiError");
          riskStatus.value = "Offline";
          riskMessage.value = "Model AI tidak merespons atau koneksi terputus.";
        }

      } else {
        // 🚨 DETEKTIF 3: Jika Flask membalas dengan status selain 200 (misal 404 atau 500)
        Get.snackbar("Server Eror", "Kode: ${response.statusCode}. Cek terminal Flask!", backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 5));
      }
    } catch (e) {
      // 🚨 DETEKTIF 4: Jika IP salah / Firewall / Jaringan publik memblokir koneksi
      Get.snackbar("Koneksi Terputus", "Sistem gagal terhubung ke backend: $e", backgroundColor: Colors.redAccent, colorText: Colors.white, duration: const Duration(seconds: 5));
    } finally {
      isLoading.value = false;
    }
  }
}