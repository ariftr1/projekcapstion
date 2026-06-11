import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_pages.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;
  var rememberMe = false.obs; 

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final String baseUrl = 'http://192.168.57.45:5000';

  Future<void> loginWithGoogle() async {
    try {
      print("🔵 [CCTV 1] Tombol Google ditekan!");
      isLoading.value = true;
      
      await _googleSignIn.signOut();
      print("🔵 [CCTV 2] Proses sign out masa lalu berhasil.");
      
      print("🔵 [CCTV 3] Menunggu respon dari jendela Google...");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      print("🔵 [CCTV 4] Hasil dari Google: $googleUser");
      
      if (googleUser == null) {
        print("🔴 [CCTV 5] GAGAL! Google Sign-In dibatalkan atau error diam-diam.");
        isLoading.value = false;
        Get.snackbar("Batal", "Proses login dibatalkan", backgroundColor: Colors.orange, colorText: Colors.white);
        return; 
      }

      final String email = googleUser.email;
      final String nama = googleUser.displayName ?? "User Google";
      print("🔵 [CCTV 6] Berhasil dapat data: $email | $nama");

      var url = Uri.parse('$baseUrl/api/google-login');
      print("🔵 [CCTV 7] Bersiap mengirim data ke Backend: $url");
      
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "nama": nama}),
      );

      print("🔵 [CCTV 8] Respon dari Backend: ${response.statusCode} | ${response.body}");

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data['status'] == 'success') {
          final box = GetStorage();
          box.write('userId', data['user_id']);
          box.write('userName', data['nama']);
          box.write('userEmail', data['email']);
          box.write('token', data['token']); 
          box.write('login_method', 'google'); 

          Get.snackbar("Sukses", "Berhasil masuk dengan Google!", backgroundColor: Colors.green, colorText: Colors.white);
          Get.offAllNamed(Routes.MAIN); 

        } else if (data['status'] == 'needs_password') {
          _tampilkanPopupBuatPassword(data['nama'], data['email']);
        }
      } else {
        Get.snackbar("Gagal", data['message'] ?? "Gagal menyimpan data ke server", backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (error) {
      print("🔴 [CCTV ERROR FATAL]: $error");
      Get.snackbar("Error", "Gagal memuat Google Sign-In: $error", backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  void _tampilkanPopupBuatPassword(String nama, String email) {
    final TextEditingController newPasswordController = TextEditingController();
    var isObscure = true.obs; 

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 15, offset: Offset(0, 10))],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFF2052D9).withOpacity(0.1), shape: BoxShape.circle),
                child: const Icon(Icons.shield_moon_rounded, color: Color(0xFF2052D9), size: 45),
              ),
              const SizedBox(height: 20),
              const Text("Satu Langkah Kecil!", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 12),
              Text(
                "Halo Kak $nama! 👋\nBiar data rekam jejak kesehatan matamu aman dan tidak hilang, yuk buat password khusus untuk akun MyoGuard kamu.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.5),
              ),
              const SizedBox(height: 24),
              Obx(() => TextField(
                controller: newPasswordController,
                obscureText: isObscure.value,
                style: const TextStyle(fontSize: 15, color: Colors.black87),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  labelText: "Buat Password Kamu",
                  labelStyle: const TextStyle(color: Colors.black38, fontSize: 14),
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: Color(0xFF2052D9)),
                  suffixIcon: IconButton(
                    icon: Icon(isObscure.value ? Icons.visibility_off : Icons.visibility, color: Colors.black38),
                    onPressed: () => isObscure.value = !isObscure.value,
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFF2052D9), width: 1.5)),
                ),
              )),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (newPasswordController.text.trim().length < 6) {
                      Get.snackbar("Eits!", "Password minimal 6 karakter ya biar aman.", backgroundColor: Colors.orange, colorText: Colors.white, margin: const EdgeInsets.all(15));
                      return;
                    }
                    Get.back(); 
                    _prosesRegisterGoogle(nama, email, newPasswordController.text.trim());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2052D9), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0),
                  child: const Text("Mulai Jaga Mata Sekarang!", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(foregroundColor: Colors.grey),
                child: const Text("Mungkin Nanti", style: TextStyle(fontWeight: FontWeight.w600)),
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false, 
    );
  }

  Future<void> _prosesRegisterGoogle(String nama, String email, String password) async {
    isLoading.value = true;
    try {
      // 🔥 PERUBAHAN: localhost diganti menjadi $baseUrl
      var urlRegister = Uri.parse('$baseUrl/api/register');
      var responseRegister = await http.post(
        urlRegister,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"nama": nama, "email": email, "password": password}),
      );

      if (responseRegister.statusCode == 201) {
        emailController.text = email;
        passwordController.text = password;
        await login(); 
      } else {
        Get.snackbar("Gagal", "Terjadi kesalahan saat membuat akun.", backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat terhubung ke server", backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  void togglePasswordView() => isPasswordHidden.value = !isPasswordHidden.value;
  void toggleRememberMe(bool? value) { if (value != null) rememberMe.value = value; }

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Peringatan", "Email dan Password tidak boleh kosong", backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      // 🔥 PERUBAHAN: localhost diganti menjadi $baseUrl
      var url = Uri.parse('$baseUrl/api/login');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        final box = GetStorage();
        box.write('userId', data['user_id']);
        box.write('userName', data['nama']);
        box.write('userEmail', data['email']);
        box.write('token', data['token']); 
        box.write('login_method', 'email'); 

        Get.snackbar("Sukses", "Selamat datang, ${data['nama']}!", backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed(Routes.MAIN); 
      } else {
        Get.snackbar("Gagal", data['message'] ?? "Email atau password salah", backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat terhubung ke server", backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading.value = false; 
    }
  }

  @override
  void onClose() => super.onClose();
}