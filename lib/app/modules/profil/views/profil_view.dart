import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profil_controller.dart';
import '../../../routes/app_pages.dart';

class ProfilView extends GetView<ProfilController> {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF2052D9), Color(0xFF6A11CB)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // 1. HEADER PROFIL
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 40, 24, 20),
                  child: Column(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5),
                          color: Colors.white.withAlpha(40),
                        ),
                        child: Center(
                          child: Obx(() => Text(
                                controller.userInitials.value,
                                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                              )),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(() => Text(
                            controller.userName.value,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          )),
                      const SizedBox(height: 4),
                      Obx(() => Text(
                            controller.userEmail.value,
                            style: const TextStyle(fontSize: 14, color: Colors.white70),
                          )),
                    ],
                  ),
                ),

                // 2. BOX RINGKASAN DATA MEDIS (SUDAH DIPERBAIKI)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(20),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(() => _buildStatItem(title: "Umur", value: controller.umur.value)),
                        Container(width: 1.5, height: 40, color: Colors.white.withAlpha(50)),
                        Obx(() => _buildStatItem(
                            title: "SPH", 
                            value: controller.sph.value, 
                            showInfo: true, 
                            desc: "SPH (Sphere) menunjukkan kekuatan lensa untuk koreksi rabun jauh (minus) atau rabun dekat (plus).")),
                        Container(width: 1.5, height: 40, color: Colors.white.withAlpha(50)),
                        Obx(() => _buildStatItem(
                            title: "CYL", 
                            value: controller.cyl.value, 
                            showInfo: true, 
                            desc: "CYL (Cylinder) menunjukkan kekuatan lensa tambahan untuk mengoreksi mata silinder (astigmatisme).")),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 3. MENU PENGATURAN
                _buildMenuSection("Pengaturan & Profil", [
                  _buildMenuItem(Icons.person_outline_rounded, 'Edit Profil', () => Get.toNamed(Routes.EDIT_PROFIL), true),
                  _buildMenuItem(Icons.medical_services_outlined, 'Riwayat Medis Mata', () => Get.toNamed(Routes.RIWAYAT_MEDIS), true),
                  _buildMenuItem(Icons.manage_accounts_outlined, 'Tentang Akun & Sandi', () => Get.toNamed(Routes.TENTANG_AKUN), false),
                ]),

                // 4. MENU BANTUAN
                _buildMenuSection("Bantuan & Informasi", [
                  _buildMenuItem(Icons.help_outline_rounded, 'FAQ', () => Get.toNamed(Routes.FAQ), true),
                  _buildMenuItem(Icons.shield_outlined, 'Kebijakan Privasi', () => Get.toNamed(Routes.PRIVACY_POLICY), true),
                  _buildMenuItem(Icons.info_outline_rounded, 'Tentang Aplikasi', () => Get.toNamed(Routes.ABOUT), false),
                ]),

                // 5. LOGOUT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withAlpha(30),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.redAccent, width: 1.5),
                    ),
                    child: _buildMenuItem(Icons.logout_rounded, 'Keluar Aplikasi', () => controller.logout(), false, Colors.redAccent, Colors.redAccent),
                  ),
                ),

                const SizedBox(height: 40),
                
                // 6. LOGO & VERSI
                Column(
                  children: [
                    Container(
                      width: 70, height: 70,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Image.asset('assets/images/logo1.png', fit: BoxFit.contain),
                    ),
                    const SizedBox(height: 12),
                    const Text('MyoGuard App', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    const Text('Versi 1.0.0', style: TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // WIDGET STATISTIK MEDIS (DI SINI PERBAIKANNYA)
  Widget _buildStatItem({required String title, required String value, bool showInfo = false, String? desc}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70)),
            if (showInfo)
              GestureDetector(
                onTap: () => Get.defaultDialog(title: title, middleText: desc!, contentPadding: const EdgeInsets.all(20)),
                child: const Padding(
                  padding: EdgeInsets.only(left: 4),
                  child: Icon(Icons.info_outline, size: 14, color: Colors.white),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _buildMenuSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(color: Colors.white.withAlpha(20), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white, width: 1.5)),
            child: Column(children: children),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, bool showDivider, [Color titleColor = Colors.white, Color iconColor = Colors.white]) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 24),
                const SizedBox(width: 16),
                Expanded(child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: titleColor))),
                Icon(Icons.chevron_right_rounded, color: Colors.white.withAlpha(120), size: 20),
              ],
            ),
          ),
          if (showDivider) Divider(color: Colors.white.withAlpha(40), height: 1, indent: 20, endIndent: 20),
        ],
      ),
    );
  }
}