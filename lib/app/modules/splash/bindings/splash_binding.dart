import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // SEBELUMNYA: Get.lazyPut<SplashController>(() => SplashController());
    // GANTI MENJADI: Get.put
    Get.put<SplashController>(SplashController()); 
  }
}