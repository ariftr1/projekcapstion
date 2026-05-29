import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_profil_controller.dart';

class EditProfilView extends GetView<EditProfilController> {
  const EditProfilView({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // 1. HEADER
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Edit Profil',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                // 2. INPUT USERNAME
                _buildTextField(
                  hint: 'Username',
                  icon: Icons.person_outline,
                  textController: controller.usernameController,
                ),

                const SizedBox(height: 20),

                // 3. INPUT EMAIL
                _buildTextField(
                  hint: 'Email',
                  icon: Icons.email_outlined,
                  textController: controller.emailController,
                ),

                const SizedBox(height: 20),

                // 4. INPUT PASSWORD SAAT INI (Dummy Visual)
                Obx(() => _buildTextField(
                  hint: 'Password saat ini (Belum Aktif)',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  obscureVal: controller.isObscureOld.value,
                  onToggleObscure: controller.toggleOldPassword,
                  textController: controller.oldPasswordController,
                )),

                const SizedBox(height: 20),

                // 5. INPUT PASSWORD BARU (Dummy Visual)
                Obx(() => _buildTextField(
                  hint: 'Password baru (Belum Aktif)',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  obscureVal: controller.isObscureNew.value,
                  onToggleObscure: controller.toggleNewPassword,
                  textController: controller.newPasswordController,
                )),

                const SizedBox(height: 40),

                // 6. TOMBOL SIMPAN
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: Obx(() => OutlinedButton(
                    onPressed: controller.isLoading.value ? null : () => controller.updateProfile(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 24, width: 24,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : const Text(
                            'Simpan Perubahan',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                  )),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // WIDGET HELPER
  Widget _buildTextField({
    required String hint, 
    required IconData icon, 
    bool isPassword = false, 
    TextEditingController? textController,
    bool obscureVal = false,
    VoidCallback? onToggleObscure,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: TextField(
        controller: textController,
        obscureText: isPassword ? obscureVal : false,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white70),
          prefixIcon: Icon(icon, color: Colors.white),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(obscureVal ? Icons.visibility_off : Icons.visibility, color: Colors.white70),
                  onPressed: onToggleObscure,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
        ),
      ),
    );
  }
}