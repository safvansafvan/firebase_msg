import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:firebase_msg/view/widget/profile_widget/upate_profile_sheet.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[400],
                radius: 50,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () async {
                    phoneVibration();
                    await updateProfileBottomSheet(context);
                  },
                  child: const CircleAvatar(
                    radius: 17,
                    child: Icon(Icons.camera_alt_outlined),
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
                fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
