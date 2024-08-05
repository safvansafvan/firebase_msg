import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLottieView extends StatelessWidget {
  const AppLottieView(
      {super.key,
      required this.path,
      this.height,
      this.width,
      this.repeat = false});
  final String path;
  final double? height;
  final double? width;
  final bool? repeat;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(path,
        height: height,
        width: width,
        repeat: repeat,
        fit: BoxFit.cover,
        animate: true);
  }
}
