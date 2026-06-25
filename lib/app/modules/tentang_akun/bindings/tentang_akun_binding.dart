import 'package:get/get.dart';
import '../controllers/tentang_akun_controller.dart';

class TentangAkunBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TentangAkunController>(() => TentangAkunController());
  }
}