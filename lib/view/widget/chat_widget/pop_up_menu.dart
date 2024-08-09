import 'dart:developer';
import 'package:firebase_msg/utils/rive_icon.dart';
import 'package:flutter/material.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class ChatPopUpMenu extends StatelessWidget {
  const ChatPopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      splashRadius: 20,
      popUpAnimationStyle: AnimationStyle(
        curve: Curves.ease,
        duration: const Duration(milliseconds: 1000),
      ),
      icon: showRiveIcon(icon: RiveIcon.menuDots),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      itemBuilder: (BuildContext bc) {
        return const [
          PopupMenuItem(
            value: 'profile',
            child: Text("View Profile"),
          ),
          PopupMenuItem(
            value: 'search',
            child: Text("Search"),
          ),
          PopupMenuItem(
            value: 'clear',
            child: Text("Clear Chat"),
          )
        ];
      },
      onSelected: (value) {
        log(value);
      },
    );
  }
}
