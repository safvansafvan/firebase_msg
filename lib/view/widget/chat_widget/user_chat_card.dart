import 'package:firebase_msg/theme/colors.dart';
import 'package:flutter/material.dart';

class UserChatCardWidget extends StatelessWidget {
  const UserChatCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: chatCard,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: const Text(
          'Hello, I am feeling good',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }
}
