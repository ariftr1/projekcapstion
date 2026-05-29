import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background utama putih bersih
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. HEADER DENGAN LENGKUNGAN GELOMBANG (WAVE)
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 280,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    // Menggabungkan biru MyoGuard dengan sedikit ungu agar mirip referensi
                    colors: [Color(0xFF2052D9), Color(0xFF6A11CB)], 
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Ikon/Logo MyoGuard
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.remove_red_eye, color: Colors.white, size: 50),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'MYOGUARD',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2),
                      ),
                      const SizedBox(height: 30), // Spasi sebelum area potongan
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // 2. KONTEN FORM
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Judul
                  const Text(
                    'Welcome back !',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 40),

                  // Input Email (Desain Kapsul Abu-abu Terang)
                  _buildTextField(
                    hint: 'Email / Username',
                    textController: controller.emailController,
                  ),

                  const SizedBox(height: 20),

                  // Input Password
                  _buildTextField(
                    hint: 'Password',
                    isPassword: true,
                    textController: controller.passwordController,
                  ),

                  const SizedBox(height: 15),

                  // Remember Me & Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Obx(() => Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: controller.toggleRememberMe,
                            activeColor: const Color(0xFF2052D9),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          )),
                          const Text('Remember me', style: TextStyle(color: Colors.black54, fontSize: 13)),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forget password?',
                          style: TextStyle(color: Colors.black54, fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Tombol Login (Outlined Blue)
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: Obx(
                      () => OutlinedButton(
                        onPressed: controller.isLoading.value ? null : () => controller.login(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF2052D9), width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Lebih membulat
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Color(0xFF2052D9), strokeWidth: 2))
                            : const Text(
                                'Login',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2052D9)),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Link ke Register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('New user? ', style: TextStyle(color: Colors.black54)),
                      GestureDetector(
                        onTap: () => Get.toNamed(Routes.REGISTER),
                        child: const Text('Sign Up', style: TextStyle(color: Color(0xFF2052D9), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Divider OR
                  Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.black12, thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('OR', style: TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                      Expanded(child: Divider(color: Colors.black12, thickness: 1)),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Barisan Tombol Social Media (Persiapan Google)
                  // Tombol Google Sign-In
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: OutlinedButton(
                      onPressed: controller.isLoading.value ? null : () => controller.loginWithGoogle(),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.black26, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), 
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 🔥 GANTI DENGAN KODE INI
                          Image.asset(
                            'assets/images/google_logo.png', // Path menuju file aset kamu
                            height: 24, // Sesuaikan ukurannya di sini
                            // Catatan: Jika gambarmu `.svg`, kamu butuh package 'flutter_svg'
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Sign-In with Google',
                            style: TextStyle(
                              fontSize: 16, 
                              fontWeight: FontWeight.w600, 
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // WIDGET HELPER TEXTFIELD BARU (Sesuai Referensi)
  Widget _buildTextField({required String hint, bool isPassword = false, TextEditingController? textController}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100, // Warna abu-abu terang
        borderRadius: BorderRadius.circular(30),
      ),
      child: isPassword
          ? Obx(
              () => TextField(
                controller: textController,
                obscureText: controller.isPasswordHidden.value,
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(color: Colors.black38),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordHidden.value ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black38,
                    ),
                    onPressed: controller.togglePasswordView,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
                ),
              ),
            )
          : TextField(
              controller: textController,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.black38),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
              ),
            ),
    );
  }
}

// ==============================================================
// CUSTOM CLIPPER UNTUK MEMBUAT EFEK LENGKUNGAN GELOMBANG (WAVE)
// ==============================================================
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);

    // Lengkungan pertama (kiri bawah)
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    // Lengkungan kedua (kanan atas)
    var secondControlPoint = Offset(size.width - (size.width / 3.25), size.height - 80);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}