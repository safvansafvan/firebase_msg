import 'package:firebase_msg/controller/getx/global_controller.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Divider(
          color: Colors.grey[200],
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 10),
          child: GNav(
              onTabChange: (value) {
                phoneVibration();
                Get.find<GlobalController>().updateCurrentState(value);
              },
              textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.9)),
              hoverColor: Colors.grey[300]!,
              haptic: true,
              tabBorderRadius: 20,
              curve: Curves.ease,
              duration: const Duration(milliseconds: 900),
              gap: 10,
              color: Colors.black87,
              activeColor: Colors.white.withOpacity(0.8),
              iconSize: 24,
              tabBackgroundColor: Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              tabs: const [
                GButton(
                  icon: Icons.home_max_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.add_circle_outline_sharp,
                  text: 'New Chat',
                ),
                GButton(
                  icon: Icons.settings_rounded,
                  text: 'Settings',
                ),
              ]),
        ),
      ],
    );
  }
}
