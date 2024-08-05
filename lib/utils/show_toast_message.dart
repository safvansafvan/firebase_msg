import 'package:flutter/material.dart';
import 'package:get/get.dart';

void appSnackBarWidget({required String title, required String message}) {
  Get.snackbar(
    title,
    message,
    animationDuration: const Duration(seconds: 2),
    duration: const Duration(seconds: 2),
    forwardAnimationCurve: Curves.ease,
    margin: const EdgeInsets.symmetric(horizontal: 30).copyWith(top: 10),
  );
}
