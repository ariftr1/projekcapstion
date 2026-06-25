import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_pages.dart';

class ProfilController extends GetxController {
  final box = GetStorage();

  // 🔥 VARIABEL OBSERVABLE YANG SINKRON DENGAN VIEW
  var userName = "Memuat...".obs; 
  var userEmail = "memuat...".obs;
  var userInitials = "-".obs;
  
  var umur = "-".obs;
  var sph = "0.00".obs;
  var cyl = "0.00".obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    // 🔥 Membaca dari laci 'nama' dan 'email' (Hasil set dari Login/Google Login)
    String name = box.read('nama') ?? "Data Kosong";
    String email = box.read('email') ?? "Email Kosong";

    // Masukkan ke variabel reaktif
    userName.value = name;
    userEmail.value = email;
    userInitials.value = _generateInitials(name);
    
    // Membaca data medis
    var rawUmur = box.read('umur');
    var rawSph = box.read('sph');
    var rawCyl = box.read('cyl');

    umur.value = (rawUmur == null || rawUmur == 0 || rawUmur.toString() == "0") ? "-" : rawUmur.toString();
    sph.value = (rawSph == null || rawSph == 0.0 || rawSph.toString() == "0") ? "0.00" : rawSph.toString();
    cyl.value = (rawCyl == null || rawCyl == 0.0 || rawCyl.toString() == "0") ? "0.00" : rawCyl.toString();
  }

  String _generateInitials(String name) {
    if (name == "Data Kosong" || name.trim().isEmpty) return "??";
    List<String> nameParts = name.trim().split(' ');
    if (nameParts.isEmpty || nameParts[0].isEmpty) return "US";
    if (nameParts.length == 1) return nameParts[0].substring(0, nameParts[0].length > 1 ? 2 : 1).toUpperCase();
    return (nameParts[0][0] + nameParts[1][0]).toUpperCase();
  }

// Contoh fungsi Logout yang benar di Controller Profil/Settings kamu:
  void logout() async {
    final box = GetStorage();
    await box.erase(); // 🔥 INI WAJIB! Menghapus ID 9, token, dll dari memori HP
    Get.offAllNamed(Routes.LOGIN); // Lempar ke halaman login
  }
}