import 'dart:ui'; 
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import '../../mode_guard/views/mode_guard_view.dart';

// --- IMPORT HALAMAN ANAK ---
import '../../home/views/home_view.dart';
import '../../analitik/views/analitik_view.dart'; // 🔥 REVISI: Impor Halaman Analitik Resmi
import '../../edukasi/views/edukasi_view.dart'; 
import '../../profil/views/profil_view.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody memastikan background halaman bisa tembus ke bawah navigator yang melayang
      extendBody: true, 
      body: Stack(
        children: [
          // 1. KONTEN HALAMAN (Layer Bawah)
          Obx(() => IndexedStack(
                index: controller.currentIndex.value,
                children: const [
                  HomeView(),       // Index 0
                  AnalitikView(),   // 🔥 REVISI: Wadah diisi AnalitikView (Bukan SizedBox lagi)
                  ModeGuardView(),  // Index 2
                  EdukasiView(),    // Index 3 
                  ProfilView(),     // Index 4
                ],
              )),
              
          // 2. FLOATING NAVIGATOR "BEYOND" STYLE (Layer Atas)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), // Efek Kaca Buram
                  child: Container(
                    height: 75, // Tinggi wadah navigator
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF121421).withOpacity(0.75), // Kaca Gelap Transparan
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15), // Pantulan cahaya di ujung kaca
                        width: 1,
                      ),
                    ),
                    child: Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildNavItem(0, Icons.home_rounded, 'Home'),
                            _buildNavItem(1, Icons.analytics_outlined, 'Analitik'),
                            _buildNavItem(2, Icons.shield_moon_rounded, 'Guard'), 
                            _buildNavItem(3, Icons.menu_book_rounded, 'Edukasi'), 
                            _buildNavItem(4, Icons.person_outline, 'Profil'),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET HELPER: TOMBOL NAVIGASI DENGAN EFEK NEON GLOW
  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = controller.currentIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300), // Kecepatan animasi
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          // Jika aktif, munculkan gradien biru-ungu
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFF2052D9), Color(0xFF6A11CB)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          // Jika aktif, munculkan cahaya neon di bawahnya
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF2052D9).withOpacity(0.6),
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              // Ikon menyala putih jika aktif, meredup jika tidak
              color: isSelected ? Colors.white : Colors.white54,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white54,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}