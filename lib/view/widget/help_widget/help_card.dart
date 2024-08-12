import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/rive_icon.dart';
import 'package:flutter/material.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class HelpCard extends StatelessWidget {
  const HelpCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});
  final RiveIcon icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: helpCircleBg,
            child: showRiveIcon(icon: icon),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: helpTextColor,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: helpSecondary,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
