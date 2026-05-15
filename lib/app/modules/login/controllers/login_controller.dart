import 'package:get/get.dart';

class LoginController extends GetxController {
  var isPasswordHidden = true.obs;

  void togglePasswordView() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
}