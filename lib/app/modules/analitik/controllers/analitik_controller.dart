import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class AnalitikController extends GetxController {
  final String baseUrl = 'http://192.168.57.45:5000'; 
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
  List<FlSpot> get lineChartData => lineSpots.isEmpty 
      ? [const FlSpot(0, 40), const FlSpot(1, 55), const FlSpot(2, 15), const FlSpot(3, 50)] 
      : lineSpots;

  List<BarChartGroupData> get barChartData => barGroups.isEmpty 
      ? [_makeBarData(0, 3.5), _makeBarData(1, 4.0), _makeBarData(2, 8.5)] 
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
  
  // 🔥 REVISI: Pastikan kita mengambil ID terbaru setiap kali fungsi ini dipanggil
  // Tambahkan print ini agar kamu tahu ID berapa yang sedang dikirim ke Flask
  final savedUserId = box.read('user_id'); 
  int userId = (savedUserId != null) ? int.parse(savedUserId.toString()) : 9; 
  
  print("DEBUG: Fetching data untuk User ID: $userId");

  try {
    final response = await http.get(Uri.parse('$baseUrl/api/analitik/$userId'));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      
      // Cek apakah ada data di dalam array
      List dataSQL = jsonResponse['data'] ?? []; 
      
      if (dataSQL.isEmpty) {
        // Handle jika user belum punya riwayat
        lineSpots.value = [];
        barGroups.value = [];
        avgDistance.value = "0 cm";
        totalScreenTime.value = "0 jam";
        riskStatus.value = "Data Kosong";
        riskMessage.value = "Belum ada aktivitas terekam.";
        return;
      }

      List<FlSpot> newLineSpots = [];
      List<BarChartGroupData> newBarGroups = [];
      double totalJarak = 0, totalJam = 0;

      for (int i = 0; i < dataSQL.length; i++) {
        var item = dataSQL[i];
        double rataJarak = (item['rata_jarak'] as num).toDouble();
        double jam = (item['estimasi_jam_screen_time'] as num).toDouble();

        totalJarak += rataJarak;
        totalJam += jam;

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

      // Update Quick Stats
      avgDistance.value = "${(totalJarak / dataSQL.length).round()} cm";
      totalScreenTime.value = "${totalJam.round()} jam";
      
      if (totalJam > 20) {
        riskStatus.value = "Kritis";
        riskMessage.value = "Screen time mingguan tinggi. Istirahatkan mata.";
      } else {
        riskStatus.value = "Aman";
        riskMessage.value = "Pola penggunaan gadgetmu dalam batas wajar.";
      }
    } else {
      print("Error Status Code: ${response.statusCode}");
    }
  } catch (e) {
    print("Error Fetching Analitik: $e");
  } finally {
    isLoading.value = false;
  }
}
}