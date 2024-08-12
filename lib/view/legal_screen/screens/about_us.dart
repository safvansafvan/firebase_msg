import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: settingsBg,
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: settingsBg,
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            phoneVibration();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
        ),
        centerTitle: false,
        title: const Text(
          'About Us',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.7),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('App Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(
              'Developed By Muhammed Safvan',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            Text('Version : 1.0.0'),
          ],
        ),
      ),
    );
  }
}
