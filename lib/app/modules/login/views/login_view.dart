import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
            colors: [Color(0xFF2052D9), Color(0xFF0F8FEA)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const SizedBox(height: 60),

                // 1. LOGO ATAS
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(40),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 1.5), // Garis tepi logo
                  ),
                  child: const Icon(Icons.gps_fixed_rounded, color: Colors.white, size: 40),
                ),

                const SizedBox(height: 30),

                const Text(
                  'Selamat Datang',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Masuk untuk melanjutkan ke aplikasi',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),

                const SizedBox(height: 40),

                // 2. INPUT EMAIL DENGAN GARIS TEPI
                _buildTextField(
                  hint: 'Email',
                  icon: Icons.email_outlined,
                ),

                const SizedBox(height: 20),

                // 3. INPUT PASSWORD DENGAN GARIS TEPI & TOMBOL MATA
                _buildTextField(
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),

                const SizedBox(height: 30),

                // 4. TOMBOL MASUK (OUTLINED STYLE)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    // Di login_view.dart
                    onPressed: () => Get.offAllNamed(Routes.HOME),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 2), // Garis putih
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.white.withAlpha(100))),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text('Atau', style: TextStyle(color: Colors.white)),
                    ),
                    Expanded(child: Divider(color: Colors.white.withAlpha(100))),
                  ],
                ),

                const SizedBox(height: 25),

                // 5. TOMBOL GOOGLE (OUTLINED STYLE)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Image.network(
                      'https://img.icons8.com/color/48/000000/google-logo.png',
                      height: 24,
                      errorBuilder: (context, error, stackTrace) => 
                          const Icon(Icons.g_mobiledata, color: Colors.white, size: 30),
                    ),
                    label: const Text(
                      'Masuk dengan akun google',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 2), // Garis putih
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum punya akun? ', style: TextStyle(color: Colors.white)),
                    // Cari bagian GestureDetector di login_view.dart
                  GestureDetector(
                    onTap: () {
                      // Pindah ke halaman REGISTER
                      Get.toNamed(Routes.REGISTER); 
                    },
                    child: const Text(
                      'Daftar',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
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

  // Fungsi Helper yang diperbarui untuk tampilan Outlined
  Widget _buildTextField({required String hint, required IconData icon, bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        // Background dibuat agak transparan agar gradasi di belakang tetap terlihat sedikit
        color: Colors.white.withAlpha(30), 
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white, width: 1.5), // Garis tepi putih
      ),
      child: isPassword
          ? Obx(
              () => TextField(
                obscureText: controller.isPasswordHidden.value,
                style: const TextStyle(color: Colors.white), // Teks input jadi putih
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(color: Colors.white70),
                  prefixIcon: Icon(icon, color: Colors.white),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordHidden.value ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white70,
                    ),
                    onPressed: controller.togglePasswordView,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                ),
              ),
            )
          : TextField(
              style: const TextStyle(color: Colors.white), // Teks input jadi putih
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: Icon(icon, color: Colors.white),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              ),
            ),
    );
  }
}