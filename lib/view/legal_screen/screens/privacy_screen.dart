import 'package:firebase_msg/theme/colors.dart';
import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: helpBg,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: helpBg,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
        ),
        centerTitle: false,
        title: const Text(
          'Privacy Policy',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.7),
        ),
      ),
    );
  }
}
