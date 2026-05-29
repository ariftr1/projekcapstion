import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); 
  
  final box = GetStorage();
  
  // Cek riwayat user
  bool sudahOnboarding = box.read('sudah_onboarding') ?? false;
  String? token = box.read('token');

  // Logika Rute Awal
  String ruteAwal;
  if (sudahOnboarding == false) {
    ruteAwal = Routes.ONBOARDING;
  } else if (token != null && token.isNotEmpty) {
    ruteAwal = Routes.MAIN;
  } else {
    ruteAwal = Routes.LOGIN;
  }

  runApp(
    GetMaterialApp(
      title: "MyoGuard",
      initialRoute: ruteAwal,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}

// =========================================================================
// 🔥 KODE KHUSUS UNTUK CINCIN MELAYANG (FLOATING OVERLAY) 🔥
// =========================================================================

// 1. Entry point khusus (Portal agar Flutter bisa menggambar di luar aplikasi)
@pragma("vm:entry-point")
void overlayMain() {
  // Pastikan binding internal Android siap
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyoGuardOverlayUI(),
    ),
  );
}

// 2. Desain Visual Cincin Melayangnya
class MyoGuardOverlayUI extends StatelessWidget {
  const MyoGuardOverlayUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background wajib transparan agar tidak menutupi layar Poco Pad
      backgroundColor: Colors.transparent, 
      body: Center(
        child: Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black87, // Warna dasar cincin
            border: Border.all(
              color: Colors.greenAccent, // Garis cincin
              width: 3.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.greenAccent.withOpacity(0.5),
                blurRadius: 15,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.remove_red_eye_rounded,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }
}