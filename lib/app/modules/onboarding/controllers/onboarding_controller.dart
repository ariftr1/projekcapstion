import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_pages.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  var currentPage = 0.obs; 
  
  final box = GetStorage();

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < 2) { 
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  // 👇 PERBAIKAN DI SINI
  void startApp() {
    // 1. Simpan memori bahwa user sudah lewat onboarding
    box.write('isFirstTime', false); 
    
    // 2. Lempar ke halaman LOGIN (BUKAN ke Routes.MAIN atau Routes.HOME)
    Get.offAllNamed(Routes.LOGIN); 
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}