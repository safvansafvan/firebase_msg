import 'package:firebase_msg/utils/scroll_behavior.dart';
import 'package:firebase_msg/view/widget/home_widget/users_chat_card.dart';
import 'package:firebase_msg/view/widget/home_widget/users_profiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeChat extends StatefulWidget {
  const HomeChat({
    super.key,
  });

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: ListView(
          children: [
            TextField(
              cursorColor: Colors.black87,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20),
                hintText: 'Search...',
                fillColor: Colors.grey[300],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const HorizontalProfileWidget(),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 30,
              itemBuilder: (context, index) =>
                  AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 400),
                child: const ScaleAnimation(
                  child: FadeInAnimation(
                    child: UsersChatCardWidget(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
