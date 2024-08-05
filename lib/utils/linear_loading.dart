import 'package:firebase_msg/theme/colors.dart';
import 'package:flutter/material.dart';

class LinearLoading extends StatelessWidget {
  const LinearLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 30),
      child: LinearProgressIndicator(
        borderRadius: BorderRadius.circular(10),
        backgroundColor: greenColor,
        color: Colors.black38,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
