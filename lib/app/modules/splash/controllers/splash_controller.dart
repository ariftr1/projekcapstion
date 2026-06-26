import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    
    // Timer 6 detik (menyesuaikan animasi progress bar di SplashView)
    Future.delayed(const Duration(seconds: 6), () {
      final box = GetStorage();
      
      // Ambil data riwayat user
      bool sudahOnboarding = box.read('sudah_onboarding') ?? false;
      String? token = box.read('token');

      print("Splash Selesai. Mengarahkan Navigasi...");

      // LOGIKA PENENTUAN RUTE
      if (sudahOnboarding == false) {
        // Jika baru pertama kali install
        Get.offAllNamed(Routes.ONBOARDING);
      } else if (token != null && token.isNotEmpty) {
        // Jika sudah login
        Get.offAllNamed(Routes.MAIN);
      } else {
        // Jika sudah onboarding tapi belum login
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }
}