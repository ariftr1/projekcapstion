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

                // 2. BOX RINGKASAN DATA MEDIS
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
                        Obx(() => _buildStatItem(title: "SPH", value: controller.sph.value)),
                        Container(width: 1.5, height: 40, color: Colors.white.withAlpha(50)),
                        Obx(() => _buildStatItem(title: "CYL", value: controller.cyl.value)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 3. MENU PENGATURAN & PROFIL (3 Halaman Baru)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Pengaturan & Profil', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
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
                              icon: Icons.person_outline_rounded,
                              title: 'Edit Profil Dasar',
                              onTap: () => Get.toNamed(Routes.EDIT_PROFIL),
                              showDivider: true,
                            ),
                            _buildMenuItem(
                              icon: Icons.medical_services_outlined,
                              title: 'Riwayat Medis Mata',
                              onTap: () => Get.toNamed(Routes.RIWAYAT_MEDIS),
                              showDivider: true,
                            ),
                            _buildMenuItem(
                              icon: Icons.manage_accounts_outlined,
                              title: 'Tentang Akun & Sandi',
                              onTap: () => Get.toNamed(Routes.TENTANG_AKUN),
                              showDivider: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 4. MENU BANTUAN & INFORMASI (FAQ, Privasi, About)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Bantuan & Informasi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
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
                              icon: Icons.help_outline_rounded,
                              title: 'FAQ',
                              onTap: () => Get.toNamed(Routes.FAQ),
                              showDivider: true,
                            ),
                            _buildMenuItem(
                              icon: Icons.shield_outlined,
                              title: 'Kebijakan Privasi',
                              onTap: () => Get.toNamed(Routes.PRIVACY_POLICY),
                              showDivider: true,
                            ),
                            _buildMenuItem(
                              icon: Icons.info_outline_rounded,
                              title: 'Tentang Aplikasi',
                              onTap: () => Get.toNamed(Routes.ABOUT),
                              showDivider: false,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 5. TOMBOL LOGOUT
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withAlpha(30),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.redAccent, width: 1.5),
                    ),
                    child: _buildMenuItem(
                      icon: Icons.logout_rounded,
                      title: 'Keluar Aplikasi',
                      titleColor: Colors.redAccent,
                      iconColor: Colors.redAccent,
                      onTap: () => controller.logout(),
                      showDivider: false,
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),

// 6. LOGO & VERSI APLIKASI
              Column(
                children: [
                  // 🔥 LOGO MYOGUARD BERGAYA APP ICON
                  Container(
                    width: 70, // Diperbesar sedikit dari 60 ke 70 agar logo jelas
                    height: 70,
                    padding: const EdgeInsets.all(10), // Ruang napas agar logo tidak menabrak bingkai
                    decoration: BoxDecoration(
                      color: Colors.white, // Bantal putih solid agar warna logo sangat kontras & jelas
                      borderRadius: BorderRadius.circular(18), // Sudut membulat estetik
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logo1.png', // Memanggil logo yang sama dengan di Login
                      fit: BoxFit.contain, 
                    ),
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
              
              const SizedBox(height: 100), // Spasi Floating Navbar
            ],
          ),
        ),
      ),
    ),
  );
}

  Widget _buildStatItem({required String title, required String value}) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white70)),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool showDivider,
    Color titleColor = Colors.white,
    Color iconColor = Colors.white,
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
                Icon(Icons.chevron_right_rounded, color: Colors.white.withAlpha(120), size: 20),
              ],
            ),
          ),
          if (showDivider) 
            Divider(color: Colors.white.withAlpha(40), height: 1, indent: 20, endIndent: 20),
        ],
      ),
    );
  }
}