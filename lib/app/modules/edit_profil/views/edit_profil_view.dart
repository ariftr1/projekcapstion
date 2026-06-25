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
                Row(
                  children: [
                    GestureDetector(onTap: () => Get.back(), child: const Icon(Icons.arrow_back, color: Colors.white, size: 28)),
                    const SizedBox(width: 16),
                    const Text('Edit Profil Dasar', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 40),
                
                _buildField(hint: 'Nama Lengkap', icon: Icons.person_outline, controller: controller.namaC),
                const SizedBox(height: 20),
                
                // Input Tanggal Lahir dengan DatePicker Klik Otomatis
// Input Tanggal Lahir dengan DatePicker Klik Otomatis
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().subtract(const Duration(days: 7300)), // Default ke 20 tahun yang lalu
                      firstDate: DateTime(1960),
                      lastDate: DateTime.now(),
                    );
                    
                    if (pickedDate != null) {
                      // 1. Format teks tanggal ke textfield
                      controller.tglLahirC.text = "${pickedDate.toLocal()}".split(' ')[0];
                      
                      // 🔥 2. PANGGIL FUNGSI HITUNG UMUR OTOMATIS DI SINI
                      controller.hitungUmurOtomatis(pickedDate);
                    }
                  },
                  child: AbsorbPointer(
                    child: _buildField(hint: 'Tanggal Lahir (YYYY-MM-DD)', icon: Icons.calendar_today_outlined, controller: controller.tglLahirC),
                  ),
                ),
                const SizedBox(height: 20),
                
                _buildField(hint: 'Umur', icon: Icons.cake_outlined, controller: controller.umurC, keyType: TextInputType.number),
                const SizedBox(height: 20),
                
                // Dropdown Pekerjaan Glassmorphism
                const Text("Status Pekerjaan", style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: Obx(() => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedPekerjaan.value,
                      dropdownColor: const Color(0xFF2052D9),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                      items: controller.opsiPekerjaan.map((String item) {
                        return DropdownMenuItem<String>(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (val) => controller.selectedPekerjaan.value = val!,
                    ),
                  )),
                ),
                
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: Obx(() => OutlinedButton(
                    onPressed: controller.isLoading.value ? null : () => controller.simpanProfilDasar(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
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

  Widget _buildField({required String hint, required IconData icon, required TextEditingController controller, TextInputType keyType = TextInputType.text}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withAlpha(30), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white, width: 1.5)),
      child: TextField(
        controller: controller,
        keyboardType: keyType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: Colors.white70), prefixIcon: Icon(icon, color: Colors.white), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15)),
      ),
    );
  }
}