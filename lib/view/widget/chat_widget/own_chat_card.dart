import 'package:firebase_msg/theme/colors.dart';
import 'package:flutter/material.dart';

class OwnChatCardWidget extends StatelessWidget {
  const OwnChatCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: ownChatCard,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: const Text(
          'Hello , How Are You',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }
}
