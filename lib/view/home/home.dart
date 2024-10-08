import 'package:firebase_msg/controller/getx/global_controller.dart';
import 'package:firebase_msg/utils/app_bottom_nav.dart';
import 'package:firebase_msg/utils/rive_icon.dart';
import 'package:firebase_msg/view/home/screens/home_chat.dart';
import 'package:firebase_msg/view/home/screens/new_chat.dart';
import 'package:firebase_msg/view/home/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List body = [const HomeChat(), const NewChat(), const Settings()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Chatify',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.8,
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16),
              child: showRiveIcon(icon: RiveIcon.bell)),
        ],
      ),
      body: GetBuilder<GlobalController>(
        builder: (controller) {
          return body[controller.currentIndex];
        },
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}
