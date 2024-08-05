import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/utils/app_lottie_view.dart';
import 'package:firebase_msg/view/landing_screen/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Get.find<AuthController>().handleScreens(context));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppLottieView(path: 'assets/lotties/splash.json'),
      ),
    );
  }
}
