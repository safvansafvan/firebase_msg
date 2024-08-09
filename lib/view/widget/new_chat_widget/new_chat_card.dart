import 'package:firebase_msg/utils/vibrate.dart';
import 'package:firebase_msg/view/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewChatCardWidget extends StatefulWidget {
  const NewChatCardWidget({super.key});

  @override
  State<NewChatCardWidget> createState() => _NewChatCardWidgetState();
}

class _NewChatCardWidgetState extends State<NewChatCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _animation =
        Tween<double>(end: 1, begin: 0.95).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTapCancel: _onTapCancel,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTap: () async {
        phoneVibration();
        await Get.to(() => const ChatScreen(),
            curve: Curves.ease,
            duration: const Duration(milliseconds: 400),
            transition: Transition.rightToLeft);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: ScaleTransition(
          scale: _animation,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[300],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Text('About Content')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
