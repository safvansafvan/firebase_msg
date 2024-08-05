import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';

Future<void> appShowDialog(
    {required context,
    required Widget child,
    Color? barrierColor,
    Color? bagroundColor,
    bool? barrierDismissible}) async {
  return await showAlignedDialog(
    barrierColor: barrierColor,
    followerAnchor: Alignment.center,
    targetAnchor: Alignment.center,
    barrierDismissible: barrierDismissible ?? true,
    duration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
    context: context,
    builder: (context) {
      return Dialog(
          backgroundColor: bagroundColor,
          elevation: 5,
          insetAnimationCurve: Curves.bounceOut,
          insetAnimationDuration: const Duration(seconds: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.grey[100]!),
          ),
          child: child);
    },
  );
}
