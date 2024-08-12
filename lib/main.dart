import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/controller/getx/connectivity_controller.dart';
import 'package:firebase_msg/controller/getx/global_controller.dart';
import 'package:firebase_msg/controller/getx/message_sending_controller.dart';
import 'package:firebase_msg/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    InitControllers.init();
    return GetMaterialApp(
      title: 'chat app',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            centerTitle: true,
            foregroundColor: Colors.black,
            elevation: 0,
            surfaceTintColor: Colors.transparent),
        useMaterial3: false,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class InitControllers {
  static init() {
    Get.put(AuthController());
    Get.put(ConnectivityController());
    Get.put(GlobalController());
    Get.put(MessageSendingController());
  }
}
