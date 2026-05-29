import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/mode_guard_controller.dart';

class ModeGuardView extends GetView<ModeGuardController> {
  // 🔥 Konstruktor ini wajib ada agar tidak error di main_view
  const ModeGuardView({super.key});

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
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 5), // 🔥 Diperkecil maksimal agar card naik ke atas
                
                // 1. AREA HEADER
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.transparent),
                        onPressed: () {}, 
                      ),
                      const Text(
                        'Mode Guard Aktif',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 0.5),
                      ),
                      const SizedBox(width: 48), 
                    ],
                  ),
                ),

                const SizedBox(height: 5), // 🔥 Diperkecil maksimal

                // 2. KARTU PUTIH UTAMA (PRESISI TANPA SCROLL)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Padding dalam diperketat
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Pelindung Visi Real-Time",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Pastikan wajah terlihat jelas oleh kamera",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 12), // Jarak ke kamera disesuaikan

                        // 3. KAMERA DENGAN RASIO SQUARE IDEAL (TIDAK KEPENDEKAN & TIDAK KEPANJANGAN)
                        Obx(() {
                          if (controller.isCameraInitialized.value && controller.cameraController != null) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: controller.statusColor.value,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: controller.statusColor.value.withOpacity(0.25),
                                    blurRadius: 12,
                                    spreadRadius: 1,
                                  )
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: AspectRatio(
                                  aspectRatio: 1.1, // 🔥 RASIO EMAS: Kotak proporsional, pas untuk wajah & hemat ruang
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: SizedBox(
                                        width: controller.cameraController!.value.previewSize!.height,
                                        height: controller.cameraController!.value.previewSize!.width,
                                        child: CameraPreview(controller.cameraController!),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          
                          // Tampilan placeholder rasio 1.1
                          return AspectRatio(
                            aspectRatio: 1.1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.videocam_off_rounded, size: 45, color: Colors.grey.shade400),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Kamera Nonaktif",
                                    style: TextStyle(color: Colors.grey.shade500, fontSize: 14, fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),

                        const SizedBox(height: 16), // Diperketat

                        // 4. DASHBOARD METRIK LIVE
                        Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildMetricItem(
                              icon: Icons.straighten_rounded, 
                              title: "Jarak", 
                              value: controller.isGuardActive.value ? "${controller.distanceValue.value} cm" : "--", 
                              color: controller.statusColor.value
                            ),
                            Container(width: 1, height: 35, color: Colors.grey.shade300),
                            _buildMetricItem(
                              icon: Icons.remove_red_eye_rounded, 
                              title: "Kedipan", 
                              value: controller.isGuardActive.value ? "${controller.blinkRate.value}x" : "--", 
                              color: Colors.orange
                            ),
                            Container(width: 1, height: 35, color: Colors.grey.shade300),
                            _buildMetricItem(
                              icon: Icons.timer_outlined, 
                              title: "Sesi", 
                              value: controller.isGuardActive.value ? controller.sessionTime.value : "00:00", 
                              color: Colors.purple
                            ),
                          ],
                        )),

                        const SizedBox(height: 16), // Diperketat

                        // 5. TOMBOL TRIGGER UTAMA
                        Obx(() => Column(
                          children: [
                            if (controller.isGuardActive.value) ...[
                              OutlinedButton.icon(
                                onPressed: () => controller.calibrateDistance(),
                                icon: const Icon(Icons.center_focus_strong_rounded, size: 16),
                                label: const Text("Kalibrasi Jarak Aman"),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF2052D9),
                                  side: const BorderSide(color: Color(0xFF2052D9)),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: controller.isGuardActive.value ? Colors.redAccent : const Color(0xFF2052D9),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                  elevation: controller.isGuardActive.value ? 0 : 3,
                                ),
                                onPressed: () => controller.toggleGuardMode(),
                                child: Text(
                                  controller.isGuardActive.value ? "Hentikan Pemantauan" : "Mulai Mode Guard",
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 0.5),
                                ),
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15), // Pemicu aman batas navigator bawah
              ],
            ),
          ),
        ),
      ),
    );
  }

  // WIDGET HELPER
  Widget _buildMetricItem({required IconData icon, required String title, required String value, required Color color}) {
    return Column(
      children: [
        Icon(icon, color: color.withOpacity(0.8), size: 24),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
        const SizedBox(height: 2),
        Text(title, style: TextStyle(fontSize: 11, color: Colors.grey.shade500, fontWeight: FontWeight.w500)),
      ],
    );
  }
}