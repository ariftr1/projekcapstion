import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_profil_controller.dart';

class EditProfilView extends GetView<EditProfilController> {
  const EditProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 🔥 PERBAIKAN 1: Tambahkan width & height double.infinity 
        // agar background biru penuh ke seluruh layar dari atas sampai bawah
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF2052D9), Color(0xFF0F8FEA)]),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(onTap: () => Get.back(), child: const Icon(Icons.arrow_back, color: Colors.white, size: 28)),
                    const SizedBox(width: 16),
                    const Text('Edit Profil', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 40),

                // 🔥 PERBAIKAN 2: Tambahkan Label Teks "Nama Lengkap" di atas kotak
                const Text('Nama Lengkap', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                _buildField(hint: 'Masukkan Nama Lengkap', icon: Icons.person_outline, controller: controller.namaC),
                
                const SizedBox(height: 20),

                // 🔥 PERBAIKAN 2: Tambahkan Label Teks "Tanggal Lahir" di atas kotak
                const Text('Tanggal Lahir', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                // Date Picker Input
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().subtract(const Duration(days: 7300)),
                      firstDate: DateTime(1960),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      controller.tglLahirC.text = "${pickedDate.toLocal()}".split(' ')[0];
                      controller.hitungUmurOtomatis(pickedDate);
                    }
                  },
                  child: AbsorbPointer(
                    child: _buildField(hint: 'Pilih Tanggal Lahir (YYYY-MM-DD)', icon: Icons.calendar_today_outlined, controller: controller.tglLahirC),
                  ),
                ),
                
                const SizedBox(height: 20),

                // 🔥 PERBAIKAN 2: Tambahkan Label Teks "Umur" di atas kotak
                const Text('Umur', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                // Read-only Age Field
                TextField(
                  controller: controller.umurC,
                  readOnly: true, // Tidak bisa diketik manual
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.cake_outlined, color: Colors.white),
                    hintText: 'Umur akan terisi otomatis',
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withAlpha(30),
                    // Menambahkan border agar desain kotaknya sama dengan kotak lainnya
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.white, width: 1.5)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.white, width: 1.5)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.white, width: 2)),
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Tombol Simpan
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: Obx(() => OutlinedButton(
                    onPressed: controller.isLoading.value ? null : () => controller.simpanProfilDasar(),
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                    child: controller.isLoading.value 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Simpan Data Dasar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({required String hint, required IconData icon, required TextEditingController controller}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withAlpha(30), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white, width: 1.5)),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint, 
          hintStyle: const TextStyle(color: Colors.white70), 
          prefixIcon: Icon(icon, color: Colors.white), 
          border: InputBorder.none, 
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15)
        ),
      ),
    );
  }
}