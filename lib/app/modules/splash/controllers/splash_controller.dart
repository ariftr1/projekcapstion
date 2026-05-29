import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    
    // Timer 2 detik (samakan dengan durasi animasi di view)
    Future.delayed(const Duration(seconds: 6), () {
      print("Waktu habis! Mencoba pindah ke Onboarding...");
      
      // Get.offAllNamed akan menghapus splash dari memori 
      // sehingga user tidak bisa tekan 'back' ke splash lagi.
      Get.offAllNamed(Routes.ONBOARDING);
    });
  }
}