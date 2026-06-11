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
          // Menggunakan SingleChildScrollView agar tidak error 'overflow' di layar kecil
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // 1. BAGIAN HEADER PROFIL
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 40, 24, 30),
                  child: Row(
                    children: [
                      // Avatar Dinamis
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          color: Colors.white.withAlpha(40),
                        ),
                        child: Center(
                          child: Obx(() => Text(
                            controller.userInitials.value,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                          )),
                        ),
                      ),
                      const SizedBox(width: 20),
                      
                      // Informasi Nama & Email Dinamis
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Text(
                              controller.userName.value,
                              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            )),
                            const SizedBox(height: 4),
                            Obx(() => Text(
                              controller.userEmail.value,
                              style: const TextStyle(
                                fontSize: 14, 
                                color: Colors.white70, 
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white70,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. KARTU PENGATURAN AKUN
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pengaturan Akun',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(20),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Column(
                          children: [
                            _buildMenuItem(
                              icon: Icons.manage_accounts_rounded,
                              iconColor: Colors.white,
                              title: 'Edit profil',
                              titleColor: Colors.white,
                              showDivider: true,
                              onTap: () {
                                Get.toNamed(Routes.EDIT_PROFIL); 
                              },
                            ),
                            
                            // Tombol Keluar dihubungkan ke fungsi logout
                            _buildMenuItem(
                              icon: Icons.logout_rounded,
                              iconColor: const Color(0xFFE53935),
                              title: 'Logout',
                              titleColor: const Color(0xFFE53935),
                              showDivider: false,
                              onTap: () => controller.logout(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 3. KARTU BANTUAN & INFORMASI (BAGIAN YANG SEBELUMNYA HILANG)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Bantuan & Informasi',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(20),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Column(
                          children: [
                            // Tombol FAQ
                            _buildMenuItem(
                              icon: Icons.help_outline_rounded,
                              iconColor: Colors.white,
                              title: 'FAQ',
                              titleColor: Colors.white,
                              showDivider: true,
                              onTap: () {
                                Get.toNamed(Routes.FAQ); 
                              },
                            ),
                            // Tombol Kebijakan Privasi
                            _buildMenuItem(
                              icon: Icons.shield_outlined,
                              iconColor: Colors.white,
                              title: 'Kebijakan Privasi',
                              titleColor: Colors.white,
                              showDivider: true,
                              onTap: () {
                                Get.toNamed(Routes.PRIVACY_POLICY); 
                              },
                            ),
                            // Tombol Tentang Aplikasi
                            _buildMenuItem(
                              icon: Icons.info_outline_rounded,
                              iconColor: Colors.white,
                              title: 'Tentang Aplikasi',
                              titleColor: Colors.white,
                              showDivider: false,
                              onTap: () {
                                Get.toNamed(Routes.ABOUT); 
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // 4. LOGO APLIKASI DI BAWAH
                Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: const Icon(Icons.gps_fixed_rounded, color: Colors.white, size: 30),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'MyoGuard App',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Versi 1.0.0',
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
                
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Color titleColor,
    required bool showDivider,
    required VoidCallback onTap,
  }) {
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
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: titleColor),
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: Colors.white.withAlpha(150), size: 20),
              ],
            ),
          ),
          if (showDivider)
            Divider(
              color: Colors.white.withAlpha(50),
              height: 1,
              indent: 20,
              endIndent: 20,
            ),
        ],
      ),
    );
  }
}