import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/foundation.dart'; 
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

// 🔥 Perhatikan tambahan 'with WidgetsBindingObserver' di sini
class ModeGuardController extends GetxController with WidgetsBindingObserver {
  final String baseUrl = 'http://192.168.18.7:5000';
  final box = GetStorage();

  // --- VARIABEL UNTUK UI ---
  var isGuardActive = false.obs;
  var distanceValue = 0.obs;
  var blinkRate = 0.obs;
  var sessionTime = "00:00".obs;
  Rx<Color> statusColor = Colors.grey.obs; 

  // --- VARIABEL KAMERA & AI ---
  CameraController? cameraController;
  FaceDetector? _faceDetector;
  var isCameraInitialized = false.obs;
  bool _isProcessingFrame = false;
  
  // --- TIMERS ---
  Timer? _sessionTimer;
  Timer? _patrolTimer;
  int _secondsElapsed = 0;

  // --- LOGIKA SIKLUS AI (BURST 7 DETIK) ---
  DateTime _faseMulaiPatroli = DateTime.now();
  int _jumlahKedipanMenitIni = 0;
  bool _isBlinkingState = false;
  bool _sudahKirimDataMenitIni = false;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this); // 🔥 Daftarkan pemantau siklus minimize/resume
    _initForegroundTask();
    _initFaceDetector();
  }

  void _initFaceDetector() {
    final options = FaceDetectorOptions(
      enableClassification: true, 
      performanceMode: FaceDetectorMode.fast, // 🔥 Mode Cepat
    );
    _faceDetector = FaceDetector(options: options);
  }

  Future<void> _initCamera() async {
    try {
      List<CameraDescription> cameras = await availableCameras();
      CameraDescription frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.nv21, // 🔥 Format paling stabil untuk Android
      );

      await cameraController!.initialize();
      isCameraInitialized.value = true;

      await Future.delayed(const Duration(milliseconds: 1000));

      if (!isGuardActive.value) return;

      _faseMulaiPatroli = DateTime.now(); 
      _sudahKirimDataMenitIni = false;
      _jumlahKedipanMenitIni = 0;

      await cameraController!.startImageStream((CameraImage image) {
        if (isGuardActive.value && !_isProcessingFrame) {
          _processCameraImage(image);
        }
      });
      
    } catch (e) {
      print("❌ Kamera gagal diinisialisasi: $e");
    }
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (image.planes.isEmpty || image.planes[0].bytes.isEmpty) return;

    final sekarang = DateTime.now();
    final selisihDetik = sekarang.difference(_faseMulaiPatroli).inSeconds;

    if (selisihDetik >= 7) {
      if (!_sudahKirimDataMenitIni) {
        _sudahKirimDataMenitIni = true; 
        
        int estimasiBlinkRate = ((_jumlahKedipanMenitIni / 7) * 60).round();
        blinkRate.value = estimasiBlinkRate;
        
        _sendDataToFlaskBackend(distanceValue.value, estimasiBlinkRate);
      }
      return; 
    }

    if (_isProcessingFrame) return;
    _isProcessingFrame = true;

    try {
      final WriteBuffer allBytes = WriteBuffer();
      for (final Plane plane in image.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final rotation = InputImageRotation.rotation0deg;

      final inputImage = InputImage.fromBytes(
        bytes: bytes,
        metadata: InputImageMetadata(
          size: Size(image.width.toDouble(), image.height.toDouble()),
          rotation: rotation, 
          format: InputImageFormat.nv21, 
          bytesPerRow: image.planes[0].bytesPerRow,
        ),
      );
      
      final List<Face> faces = await _faceDetector!.processImage(inputImage);

      if (faces.isNotEmpty) {
        Face face = faces.first;

      // 1. Hitung Jarak
// 1. Deteksi otomatis posisi tablet (Portrait atau Landscape)
        bool isPortrait = Get.height > Get.width;

        // 2. Pilih Konstanta Ajaib berdasarkan posisi
        // Menggunakan 4860 untuk Portrait, dan 4240 hasil rasio untuk Landscape
        double konstanta = isPortrait ? 4860.0 : 4240.0;

        // 3. Hitung Jarak Jitu
        double faceWidth = face.boundingBox.width;
        int estimatedDistance = (konstanta / faceWidth).round();
        
        // 4. Batas wajar agar angka tidak lompat ekstrem saat wajah keluar frame
        if (estimatedDistance < 10) estimatedDistance = 10;
        if (estimatedDistance > 150) estimatedDistance = 150;
        
        distanceValue.value = estimatedDistance;

        if (face.leftEyeOpenProbability != null && face.rightEyeOpenProbability != null) {
          bool mataTertutup = face.leftEyeOpenProbability! < 0.4 && face.rightEyeOpenProbability! < 0.4;
          if (mataTertutup) {
            if (!_isBlinkingState) {
              _jumlahKedipanMenitIni++; 
              _isBlinkingState = true;
            }
          } else {
            _isBlinkingState = false; 
          }
        }

        int safeThreshold = box.read('safe_distance') ?? 35;
        if (estimatedDistance < (safeThreshold - 5)) {
          statusColor.value = Colors.red;
        } else if (estimatedDistance < safeThreshold) {
          statusColor.value = Colors.orange;
        } else {
          statusColor.value = Colors.green;
        }
      } else {
        distanceValue.value = 0;
        statusColor.value = Colors.grey;
      }
    } catch (e) {
      print("Error AI: $e");
    } finally {
      _isProcessingFrame = false;
    }
  }

  void _startPatrolLoop() {
    _patrolTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (isGuardActive.value) {
        _faseMulaiPatroli = DateTime.now();
        _sudahKirimDataMenitIni = false;
        _jumlahKedipanMenitIni = 0;
      }
    });
  }

  Future<void> _sendDataToFlaskBackend(int jarak, int rateKedipan) async {
    int userId = box.read('userId') ?? 0;
    if (userId == 0) return;

    try {
      var url = Uri.parse('$baseUrl/api/guard-mode/evaluate');
      await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": userId,
          "jarak_cm": jarak,
          "kedipan_per_menit": rateKedipan, 
        }),
      );
    } catch (e) {
      print("Gagal sync backend: $e");
    }
  }

  Future<void> toggleGuardMode() async {
    bool isOverlayGranted = await FlutterOverlayWindow.isPermissionGranted();
    if (!isOverlayGranted) {
      bool? reqOverlay = await FlutterOverlayWindow.requestPermission();
      if (reqOverlay != true) return; 
    }

    if (await FlutterForegroundTask.checkNotificationPermission() != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }

    if (!isGuardActive.value) {
      isGuardActive.value = true;
      
      await FlutterOverlayWindow.showOverlay(
        enableDrag: true, 
        overlayTitle: "MyoGuard AI",
        overlayContent: "Memantau kesehatan mata...",
        flag: OverlayFlag.defaultFlag,
        alignment: OverlayAlignment.topRight, 
        width: 300, 
        height: 300,
      );

      await Future.delayed(const Duration(milliseconds: 500));
      await _initCamera(); 

      FlutterForegroundTask.startService(
        notificationTitle: 'MyoGuard Sedang Aktif',
        notificationText: 'Menjaga kesehatan mata Anda...',
      );
      
      _startSessionTimer();
      _startPatrolLoop(); 
        
      Get.snackbar("Mode Guard Aktif", "Kamera dan Pemantau AI berjalan.", backgroundColor: Colors.green, colorText: Colors.white);

    } else {
      isGuardActive.value = false;
      _stopSessionTimer();
      _patrolTimer?.cancel();
      
      await FlutterOverlayWindow.closeOverlay(); 
      
      if (cameraController != null) {
        try {
          await cameraController!.stopImageStream();
        } catch (_) {}
        
        await Future.delayed(const Duration(milliseconds: 200));
        await cameraController!.dispose();
        cameraController = null;
        isCameraInitialized.value = false;
      }
      
      await FlutterForegroundTask.stopService();
      
      distanceValue.value = 0;
      blinkRate.value = 0;
      statusColor.value = Colors.grey;

      Get.snackbar("Mode Guard Nonaktif", "Sistem pemantauan dihentikan.", backgroundColor: Colors.orange, colorText: Colors.white);
    }
  }

  // 🔥 FUNGSI SIKLUS HIDUP (Aplikasi di-minimize / dibuka kembali)
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (cameraController == null || !cameraController!.value.isInitialized) return;

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) {
      if (isGuardActive.value) {
        cameraController?.stopImageStream().catchError((e) => print("Aman: $e"));
        print("⏸️ [LIFECYCLE] Aplikasi di-minimize, kamera diistirahatkan.");
      }
    } else if (state == AppLifecycleState.resumed) {
      if (isGuardActive.value) {
        print("▶️ [LIFECYCLE] Aplikasi dibuka kembali, menyalakan kamera...");
        cameraController?.startImageStream((CameraImage image) {
          if (isGuardActive.value && !_isProcessingFrame) {
            _processCameraImage(image);
          }
        }).catchError((e) => print("Gagal resume stream: $e"));
      }
    }
  }

  // --- UTILITY & STOPWATCH LAYER ---
  void _initForegroundTask() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'myoguard_service',
        channelName: 'MyoGuard Background Service',
        channelDescription: 'Melindungi mata Anda di latar belakang.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000, 
        isOnceEvent: false,
        autoRunOnBoot: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  void _startSessionTimer() {
    _secondsElapsed = 0;
    sessionTime.value = "00:00";
    _sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _secondsElapsed++;
      int minutes = _secondsElapsed ~/ 60;
      int seconds = _secondsElapsed % 60;
      sessionTime.value = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    });
  }

  void _stopSessionTimer() {
    _sessionTimer?.cancel();
    sessionTime.value = "00:00";
  }

  void calibrateDistance() {
    if (distanceValue.value > 0) {
      box.write('safe_distance', distanceValue.value);
      Get.snackbar("Kalibrasi Berhasil", "Jarak aman Anda: ${distanceValue.value} cm", backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      Get.snackbar("Kalibrasi Gagal", "Wajah tidak terdeteksi.", backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this); // 🔥 Hapus pemantau siklus
    _sessionTimer?.cancel();
    _patrolTimer?.cancel();
    _faceDetector?.close();
    cameraController?.dispose();
    super.onClose();
  }
}