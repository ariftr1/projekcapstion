import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

void main() async {
  // 1. Pastikan inisialisasi sistem siap
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Inisialisasi GetStorage
  await GetStorage.init(); 

  runApp(
    GetMaterialApp(
      title: "MyoGuard",
      // 🔥 PAKSA MULAI DARI SPLASH agar muncul 6 detik
      initialRoute: Routes.SPLASH, 
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}

// =========================================================================
// 🔥 KODE KHUSUS UNTUK CINCIN MELAYANG (FLOATING OVERLAY) 🔥
// =========================================================================

// Entry point untuk Overlay (Terpisah dari Main App)
@pragma("vm:entry-point")
void overlayMain() {
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
      backgroundColor: Colors.transparent, 
      body: Center(
        child: GestureDetector(
          onTap: () {
            // 🔥 SOLUSI AMAN: Gunakan print() saja. 
            // Ini tidak akan pernah menyebabkan error 'undefined_method'.
            print("Cincin diklik!");
          },
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black87,
              border: Border.all(color: Colors.greenAccent, width: 3.5),
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
      ),
    );
  }
}