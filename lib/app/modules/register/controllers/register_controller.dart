import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../routes/app_pages.dart';
import 'package:get_storage/get_storage.dart'; 
import 'package:google_sign_in/google_sign_in.dart'; 
import '../../profil/controllers/profil_controller.dart'; 
import '../../home/controllers/home_controller.dart'; // 🔥 Pastikan import ini ada

class RegisterController extends GetxController {
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  
  final String baseUrl = 'http://192.168.18.20:5000';
  final box = GetStorage();

  // Mesin Google MyoGuard
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '188183375956-3ldudapu86m3q027ls65uc8cen8uigj6.apps.googleusercontent.com',
  );

  void togglePasswordView() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      
      // 1. Panggil Popup Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        isLoading.value = false;
        return; // Dibatalkan oleh user
      }

      // 2. Ambil data dari Google
      final String email = googleUser.email;
      final String nama = googleUser.displayName ?? "User Google";

      // 3. Kirim ke backend Flask
      var url = Uri.parse('$baseUrl/api/google-login');
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "nama": nama,
        }),
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // KONDISI A: Akun sudah terdaftar sebelumnya di MySQL
        if (data['status'] == 'success') {
          box.write('userId', data['user_id']);
          box.write('nama', data['nama']);
          box.write('email', data['email']);
          box.write('token', data['token'] ?? 'google_auth_token'); 
          box.write('login_method', 'google');

          // Masukkan data dari database
          box.write('tanggal_lahir', data['tanggal_lahir'] ?? '');
          box.write('umur', data['umur'] ?? 0);
          box.write('pekerjaan', data['pekerjaan'] ?? '');
          box.write('status_kacamata', data['status_kacamata'] ?? false);
          box.write('lama_berkacamata', data['lama_berkacamata'] ?? '');
          box.write('sph', data['sph'] ?? 0.0);
          box.write('cyl', data['cyl'] ?? 0.0);

          // Pasang pemicu refresh data ProfilView utama secara realtime
          if (Get.isRegistered<ProfilController>()) {
            Get.find<ProfilController>().loadUserData();
          } else {
            final profilController = Get.put(ProfilController());
            profilController.loadUserData();
          }

          // Pasang pemicu refresh sapaan nama di Beranda secara realtime
          if (Get.isRegistered<HomeController>()) {
            Get.find<HomeController>().loadHomeData();
          } else {
            final homeController = Get.put(HomeController());
            homeController.loadHomeData();
          }

          Get.snackbar("Sukses", "Akun sudah terdaftar, otomatis masuk!",
              backgroundColor: Colors.green, colorText: Colors.white);
          
          Get.offAllNamed(Routes.MAIN); 
        } 
        // KONDISI B: Akun benar-benar baru via Google
        else if (data['status'] == 'needs_password') {
          usernameController.text = data['nama'];
          emailController.text = data['email'];
          
          Get.snackbar(
            "Langkah Terakhir", 
            "Email Google berhasil diverifikasi. Silakan masukkan password untuk menyelesaikan pendaftaran MyoGuard.",
            backgroundColor: Colors.blueAccent, 
            colorText: Colors.white,
            duration: const Duration(seconds: 5)
          );
        }
      } else {
        Get.snackbar("Gagal", data['message'] ?? "Gagal memproses ke server",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
      
    } catch (error) {
      Get.snackbar("Error", "Gagal memuat Google Sign-In",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      print("Google Sign-In Error: $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    String email = emailController.text.trim();
    String username = usernameController.text.trim();
    String password = passwordController.text.trim(); 

    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      Get.snackbar("Peringatan", "Data tidak boleh kosong",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }

    isLoading.value = true;

    try {
      var url = Uri.parse('$baseUrl/api/register'); 
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nama": username,
          "email": email,
          "password": password, 
        }),
      );

      var data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Simpan data pendaftaran ke memori local perangkat
        box.write('nama', username);
        box.write('email', email);
        box.write('userId', data['user_id']);
        box.write('login_method', 'email');
        
        // Pasang data default kosong sejak awal registrasi sukses
        box.write('tanggal_lahir', '');
        box.write('umur', 0);
        box.write('pekerjaan', '');
        box.write('status_kacamata', false);
        box.write('lama_berkacamata', '');
        box.write('sph', 0.0);
        box.write('cyl', 0.0);

        // Paksa halaman Profil utama untuk memuat ulang datanya
        if (Get.isRegistered<ProfilController>()) {
          Get.find<ProfilController>().loadUserData();
        } else {
          final profilController = Get.put(ProfilController());
          profilController.loadUserData();
        }

        // Paksa sapaan Beranda untuk memuat data nama reaktif yang baru dibuat
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().loadHomeData();
        } else {
          final homeController = Get.put(HomeController());
          homeController.loadHomeData();
        }

        Get.snackbar("Sukses", "${data['message'] ?? 'User berhasil terdaftar'}!",
            backgroundColor: Colors.green, colorText: Colors.white);
        
        Get.offAllNamed(Routes.MAIN);
      } else {
        Get.snackbar("Gagal", data['error'] ?? "Gagal mendaftarkan akun",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Tidak dapat terhubung ke backend Flask",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    } finally {
      isLoading.value = false; 
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.onClose();
  }
}