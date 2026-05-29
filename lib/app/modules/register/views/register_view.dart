import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';
// 🔥 1. PASTIKAN IMPORT LOGIN CONTROLLER DI SINI (Sesuaikan path-nya jika berbeda)
import '../../login/controllers/login_controller.dart'; 

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
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
                    colors: [Color(0xFF2052D9), Color(0xFF6A11CB)],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.person_add_alt_1_rounded, color: Colors.white, size: 50),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'MYOGUARD',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 2),
                      ),
                      const SizedBox(height: 30), 
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
                  const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 30),

                  _buildTextField(
                    hint: 'Username',
                    textController: controller.usernameController,
                  ),

                  const SizedBox(height: 20),

                  _buildTextField(
                    hint: 'Email Address',
                    textController: controller.emailController,
                  ),

                  const SizedBox(height: 20),

                  _buildTextField(
                    hint: 'Password',
                    isPassword: true,
                    textController: controller.passwordController,
                  ),

                  const SizedBox(height: 40),

                  // Tombol Daftar Manual (Outlined Blue)
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: Obx(
                      () => OutlinedButton(
                        onPressed: controller.isLoading.value ? null : () => controller.register(),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF2052D9), width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Color(0xFF2052D9), strokeWidth: 2))
                            : const Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2052D9)),
                              ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account? ', style: TextStyle(color: Colors.black54)),
                      GestureDetector(
                        onTap: () => Get.offAllNamed(Routes.LOGIN), 
                        child: const Text('Sign In', style: TextStyle(color: Color(0xFF2052D9), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

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

                  // 🔥 2. TOMBOL GOOGLE SIGN-UP TERHUBUNG KE LOGIN CONTROLLER
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: Obx(() {
                      // Panggil LoginController untuk menggunakan logika Google yang sudah sempurna
                      final loginCtrl = Get.put(LoginController());
                      
                      return OutlinedButton(
                        onPressed: loginCtrl.isLoading.value ? null : () => loginCtrl.loginWithGoogle(),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.black26, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: loginCtrl.isLoading.value
                            ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.black54, strokeWidth: 2))
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/google_logo.png', 
                                    height: 24, 
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Sign-Up with Google',
                                    style: TextStyle(
                                      fontSize: 16, 
                                      fontWeight: FontWeight.w600, 
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                      );
                    }),
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

  // WIDGET HELPER TEXTFIELD
  Widget _buildTextField({required String hint, bool isPassword = false, TextEditingController? textController}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
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

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

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