import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/app_lottie_view.dart';
import 'package:firebase_msg/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> accountCreationSuccessDialog(BuildContext context) async {
  appShowDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    bagroundColor: Colors.white,
    child: SizedBox(
      height: 320,
      width: context.width - 150,
      child: Center(
        child: Column(
          children: [
            const AppLottieView(
              repeat: false,
              path: 'assets/lotties/success.json',
              height: 150,
            ),
            Text(
              'Success',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 0.8,
                  color: greenColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Account Created Successfully',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    letterSpacing: 0.8,
                    color: Colors.grey[400]),
              ),
            ),
            const AppLottieView(
              path: 'assets/lotties/loading.json',
              height: 100,
              repeat: true,
            )
          ],
        ),
      ),
    ),
  );
  Future.delayed(const Duration(seconds: 3), () {
    Navigator.of(context).pop();
  });
}
