import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/app_button.dart';
import 'package:firebase_msg/utils/app_lottie_view.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:flutter/material.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

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
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            Text(
              'Share With Firends',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, color: greenColor),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Expand your chat circle by inviting friends to join the conversation. Share the joy and stay connected with your favorite people!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: helpTextColor),
              ),
            ),
            const AppLottieView(path: 'assets/lotties/invite.json'),
            AppButton(
                onTap: () {},
                text: 'Invite Now',
                bagroundColor: greenColor,
                foregroundColor: Colors.white)
          ],
        ),
      ),
    );
  }
}
