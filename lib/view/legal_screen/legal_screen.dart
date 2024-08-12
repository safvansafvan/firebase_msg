import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:firebase_msg/view/legal_screen/screens/about_us.dart';
import 'package:firebase_msg/view/legal_screen/screens/privacy_screen.dart';
import 'package:firebase_msg/view/legal_screen/screens/terms_conditions.dart';
import 'package:firebase_msg/view/widget/legal_widget/legal_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

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
          'Legal',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.7),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            LegalCard(
              icon: Icons.description_outlined,
              title: 'Privacy Policy',
              subtitle: 'Effective Jan 24',
              tap: () {
                phoneVibration();
                Get.to(() => const PrivacyScreen(),
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 400),
                    transition: Transition.rightToLeft);
              },
            ),
            LegalCard(
              icon: Icons.description_outlined,
              title: 'Terms And Conditions',
              subtitle: 'Effective Jan 24',
              tap: () {
                phoneVibration();
                Get.to(() => const TermsConditionsScreen(),
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 400),
                    transition: Transition.rightToLeft);
              },
            ),
            LegalCard(
              icon: Icons.info_outline,
              title: 'About Us',
              subtitle: 'About',
              tap: () {
                phoneVibration();
                Get.to(() => const AboutUsScreen(),
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 400),
                    transition: Transition.rightToLeft);
              },
            )
          ],
        ),
      ),
    );
  }
}
