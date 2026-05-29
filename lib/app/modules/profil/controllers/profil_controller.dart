import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_pages.dart';
import 'package:google_sign_in/google_sign_in.dart'; // 🔥 Tambahkan ini untuk Logout Google

class ProfilController extends GetxController {
  final box = GetStorage();

  // Variabel reaktif untuk menyimpan data profil (Tanpa hardcode)
  var userName = "Memuat...".obs; 
  var userEmail = "memuat...".obs;
  var userInitials = "-".obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    // 🔥 Jika kosong, tampilkan peringatan "Data Kosong", bukan "Nanda"
    String name = box.read('userName') ?? "Data Kosong";
    String email = box.read('userEmail') ?? "Email Kosong";

    userName.value = name;
    userEmail.value = email;
    userInitials.value = _generateInitials(name);
  }

  String _generateInitials(String name) {
    if (name == "Data Kosong") return "??";
    
    List<String> nameParts = name.trim().split(' ');
    if (nameParts.isEmpty || nameParts[0].isEmpty) return "US";
    
    if (nameParts.length == 1) {
      return nameParts[0].substring(0, nameParts[0].length > 1 ? 2 : 1).toUpperCase();
    }
    return (nameParts[0][0] + nameParts[1][0]).toUpperCase();
  }

  Future<void> logout() async {
    // 1. Hapus semua data dari memori internal Poco Pad
    box.remove('userName');
    box.remove('userEmail');
    box.remove('userId');
    box.remove('token'); 
    box.remove('login_method');
    
    // 2. 🔥 Paksa putus sesi dari Google Sign-In
    try {
      await GoogleSignIn().signOut();
    } catch (e) {
      print("Gagal sign out dari Google: $e");
    }
    
    // 3. Lempar kembali ke halaman Login
    Get.offAllNamed(Routes.LOGIN);
  }
}