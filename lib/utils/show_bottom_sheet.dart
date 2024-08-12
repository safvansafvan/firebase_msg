import 'package:firebase_msg/controller/getx/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showAppBottomSheet(
    {required BuildContext context,
    required Widget child,
    bool? isDismissible,
    bool? transparent}) async {
  await showModalBottomSheet(
    elevation: 10,
    barrierColor: transparent == true ? Colors.transparent : null,
    isDismissible: isDismissible ?? true,
    sheetAnimationStyle: AnimationStyle(
        curve: Curves.ease,
        duration: const Duration(milliseconds: 500),
        reverseCurve: Curves.ease,
        reverseDuration: const Duration(milliseconds: 400)),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    transitionAnimationController:
        Get.find<GlobalController>().animationController,
    context: context,
    builder: (context) => child,
  );
}
