import 'package:get/get.dart';
import '../controllers/mode_guard_controller.dart';

class ModeGuardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ModeGuardController>(
      () => ModeGuardController(),
    );
  }
}