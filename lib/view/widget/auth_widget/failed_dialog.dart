import 'package:firebase_msg/utils/app_lottie_view.dart';
import 'package:firebase_msg/utils/show_dialog.dart';
import 'package:flutter/material.dart';

Future<void> accountCreationFailedDialog(context) async {
  await appShowDialog(
    context: context,
    barrierColor: Colors.transparent,
    bagroundColor: Colors.white,
    child: SizedBox(
      height: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLottieView(
            repeat: false,
            path: 'assets/lotties/failed.json',
            height: 150,
          ),
          Text(
            'Failed',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.8,
                color: Colors.red[500]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Something Went Wrong!\nTry Aganin Later',
              textAlign: TextAlign.center,
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
  );
}
