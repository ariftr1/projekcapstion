import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2052D9), Color(0xFF0F8FEA)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 1. KONTEN GESER
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  children: [
                    _buildPageContent(
                      icon: Icons.visibility,
                      number: '1',
                      title: 'Risiko Miopia Digital',
                      description: 'Terlalu lama menatap layar dapat\nmeningkatkan risiko miopia dan\nkelelahan mata jangka panjang.',
                    ),
                    _buildPageContent(
                      icon: Icons.medical_information, 
                      number: '2',
                      title: 'Pantau Kesehatan Mata',
                      description: 'MyoGuard memantau jarak layar,\nkedipan mata, pencahayaan, dan\nkebiasaan digitalmu secara real-time.',
                    ),
                    // 👇 TAMBAHKAN ONBOARDING 3 DI SINI
                    _buildPageContent(
                      icon: Icons.phonelink_setup_rounded, 
                      number: '3',
                      title: 'Dapatkan Saran Pintar',
                      description: 'Dapatkan rekomendasi personal\nberbasis AI untuk menjaga kesehatan\nmatamu setiap hari.',
                    ),
                  ],
                ),
              ),

              // 2. NAVIGASI BAWAH (DINAMIS)
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Obx(() {
                  // Jika halaman terakhir (index 2), tampilkan tombol "Mulai Sekarang"
                  if (controller.currentPage.value == 2) {
                    return SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        onPressed: controller.startApp,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Mulai Sekarang',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Jika halaman 1 atau 2, tampilkan navigasi biasa
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: controller.startApp, // Lewati langsung ke Home
                          child: const Text(
                            'Lewati',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Row(
                          children: List.generate(3, (index) => _buildDot(index)),
                        ),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle, 
                            color: Color(0xFF5A95F5),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 20),
                            onPressed: controller.nextPage,
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER (SAMA SEPERTI SEBELUMNYA) ---
  Widget _buildPageContent({required IconData icon, required String number, required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 1),
          Center(
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF5A95F5),
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Center(child: Icon(icon, size: 100, color: Colors.white)),
            ),
          ),
          const Spacer(flex: 2),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF5A95F5)),
            child: Center(child: Text(number, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 12),
          Text(description, style: const TextStyle(fontSize: 16, color: Colors.white, height: 1.5)),
          const Spacer(flex: 1),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    bool isActive = controller.currentPage.value == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withAlpha(128),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}