import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/app_lottie_view.dart';
import 'package:firebase_msg/utils/rive_icon.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:firebase_msg/view/widget/settings_widget/upate_profile_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: RadialGradient(
            radius: 10,
            tileMode: TileMode.clamp,
            center: Alignment.bottomRight,
            colors: [
              profileGr1,
              profileGr2,
              Colors.black,
            ]),
      ),
      child: AnimationLimiter(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 400),
            childAnimationBuilder: (widget) => ScaleAnimation(
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 50,
                    child: const AppLottieView(
                      path: 'assets/lotties/profile_image.json',
                      repeat: true,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () async {
                        phoneVibration();
                        await updateProfileBottomSheet(context);
                      },
                      child: CircleAvatar(
                        radius: 17,
                        child: showRiveIcon(
                            icon: RiveIcon.edit, color: Colors.white70),
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Safvan Mhd',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
              const Text(
                'saju@gmail.com',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
