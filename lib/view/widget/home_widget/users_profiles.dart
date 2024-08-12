import 'package:firebase_msg/utils/vibrate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HorizontalProfileWidget extends StatefulWidget {
  const HorizontalProfileWidget({super.key});

  @override
  State<HorizontalProfileWidget> createState() =>
      _HorizontalProfileWidgetState();
}

class _HorizontalProfileWidgetState extends State<HorizontalProfileWidget> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.isScrollingNotifier.value) {
      phoneVibration();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: AnimationLimiter(
        child: ListView.builder(
          controller: _scrollController,
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 400),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
