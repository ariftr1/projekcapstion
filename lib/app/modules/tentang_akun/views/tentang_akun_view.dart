import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tentang_akun_controller.dart';

class TentangAkunView extends GetView<TentangAkunController> {
  const TentangAkunView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF2052D9), Color(0xFF0F8FEA)]),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(onTap: () => Get.back(), child: const Icon(Icons.arrow_back, color: Colors.white, size: 28)),
                    const SizedBox(width: 16),
                    const Text('Tentang Akun', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 40),
                
                // Email Bawaan Terkunci Statis (Read-Only)
                const Text("Alamat Email Akun (Permanen)", style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                  decoration: BoxDecoration(color: Colors.white.withAlpha(15), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white38, width: 1.5)),
                  child: Row(
                    children: [
                      const Icon(Icons.email_outlined, color: Colors.white70),
                      const SizedBox(width: 12),
                      Obx(() => Text(controller.emailStatis.value, style: const TextStyle(color: Colors.white70, fontSize: 16))),
                    ],
                  ),
                ),
                
                const SizedBox(height: 30),
                const Text("Ubah Kata Sandi Keamanan", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                
                Obx(() => _buildPasswordField(hint: 'Masukkan Password Lama', controller: controller.oldPassC, obscure: controller.isObscureOld.value, onToggle: () => controller.isObscureOld.value = !controller.isObscureOld.value)),
                const SizedBox(height: 16),
                Obx(() => _buildPasswordField(hint: 'Masukkan Password Baru', controller: controller.newPassC, obscure: controller.isObscureNew.value, onToggle: () => controller.isObscureNew.value = !controller.isObscureNew.value)),
                const SizedBox(height: 16),
                Obx(() => _buildPasswordField(hint: 'Ketik Ulang Password Baru', controller: controller.confirmPassC, obscure: controller.isObscureConfirm.value, onToggle: () => controller.isObscureConfirm.value = !controller.isObscureConfirm.value)),
                
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: Obx(() => OutlinedButton(
                    onPressed: controller.isLoading.value ? null : () => controller.gantiPasswordSandi(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: controller.isLoading.value 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Perbarui Kata Sandi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({required String hint, required TextEditingController controller, required bool obscure, required VoidCallback onToggle}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withAlpha(30), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white, width: 1.5)),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.white),
          suffixIcon: IconButton(icon: Icon(obscure ? Icons.visibility_off : Icons.visibility, color: Colors.white70), onPressed: onToggle),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        ),
      ),
    );
  }
}