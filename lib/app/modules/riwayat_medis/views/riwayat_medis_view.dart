import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/riwayat_medis_controller.dart';

class RiwayatMedisView extends GetView<RiwayatMedisController> {
  const RiwayatMedisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF2052D9), Color(0xFF6A11CB)]),
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
                    const Text('Riwayat Medis Mata', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 40),
                
                // --- BAGIAN YANG DIPERBAIKI ---
                _buildFieldMedis(
                  label: 'SPH',
                  hint: 'Contoh: -1.50',
                  icon: Icons.remove_red_eye_outlined,
                  controller: controller.sphC,
                  desc: 'SPH (Sphere) menunjukkan kekuatan lensa untuk koreksi rabun jauh (minus) atau rabun dekat (plus).'
                ),
                const SizedBox(height: 20),
                _buildFieldMedis(
                  label: 'CYL',
                  hint: 'Contoh: -0.25',
                  icon: Icons.blur_on_outlined,
                  controller: controller.cylC,
                  desc: 'CYL (Cylinder) menunjukkan kekuatan lensa tambahan untuk mengoreksi mata silinder (astigmatisme).'
                ),
                // ------------------------------
                
                const SizedBox(height: 30),
                
                // Toggle Switch Kacamata
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: Colors.white.withAlpha(30), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white, width: 1.5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Menggunakan Kacamata?", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                      Obx(() => Switch(
                        value: controller.menggunakanKacamata.value,
                        activeColor: Colors.white,
                        activeTrackColor: Colors.green,
                        onChanged: (val) => controller.toggleKacamata(val),
                      )),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Dropdown Range Waktu
                Obx(() => controller.menggunakanKacamata.value
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Sudah Berapa Lama Berkacamata?", style: TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          decoration: BoxDecoration(color: Colors.white.withAlpha(30), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white, width: 1.5)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: controller.lamaBerkacamata.value,
                              dropdownColor: const Color(0xFF2052D9),
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                              isExpanded: true,
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                              items: controller.opsiRangeWaktu.map((String item) {
                                return DropdownMenuItem<String>(value: item, child: Text(item));
                              }).toList(),
                              onChanged: (val) => controller.lamaBerkacamata.value = val!,
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink()
                ),
                
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: Obx(() => OutlinedButton(
                    onPressed: controller.isLoading.value ? null : () => controller.simpanRiwayatMedis(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    child: controller.isLoading.value 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Simpan Riwayat Medis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGET BARU YANG RAPI ---
  Widget _buildFieldMedis({required String label, required String hint, required IconData icon, required TextEditingController controller, required String desc}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => Get.defaultDialog(
                title: "Info $label", 
                middleText: desc,
                contentPadding: const EdgeInsets.all(20)
              ),
              child: const Icon(Icons.info_outline, size: 16, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(color: Colors.white.withAlpha(30), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.white, width: 1.5)),
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: Colors.white70), prefixIcon: Icon(icon, color: Colors.white), border: InputBorder.none, contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15)),
          ),
        ),
      ],
    );
  }
}