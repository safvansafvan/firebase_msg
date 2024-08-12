import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.onInit();
  }

  int currentIndex = 0;
  void updateCurrentState(int v) {
    currentIndex = v;
    log(currentIndex.toString());
    update();
  }
}
