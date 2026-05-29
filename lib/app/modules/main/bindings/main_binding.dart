import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../mode_guard/controllers/mode_guard_controller.dart';
import '../../profil/controllers/profil_controller.dart';
import '../../edukasi/controllers/edukasi_controller.dart';


class MainBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<MainController>(
      () => MainController(),
    );
    
    // 🔥 Daftarkan semua controller untuk tab di bawah sini
    Get.lazyPut<EdukasiController>(
      () => EdukasiController(),
    );
    
    Get.lazyPut<ModeGuardController>(
      () => ModeGuardController(),
    );

    
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ModeGuardController>(() => ModeGuardController());
    Get.lazyPut<ProfilController>(() => ProfilController());
    Get.lazyPut<EdukasiController>(() => EdukasiController());
  }
}