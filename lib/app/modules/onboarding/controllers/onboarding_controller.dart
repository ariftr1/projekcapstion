import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart'; // Import rute

class OnboardingController extends GetxController {
  final pageController = PageController();
  var currentPage = 0.obs; 

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

  // 👇 FUNGSI BARU UNTUK TOMBOL "MULAI SEKARANG"
  void startApp() {
    // Pindah ke halaman LOGIN dan hapus riwayat onboarding
    Get.offAllNamed(Routes.LOGIN); 
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}