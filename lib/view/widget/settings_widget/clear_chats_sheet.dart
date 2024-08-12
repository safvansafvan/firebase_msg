import 'package:firebase_msg/utils/app_button.dart';
import 'package:firebase_msg/utils/app_lottie_view.dart';
import 'package:firebase_msg/utils/show_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

Future<void> clearBottomSheetWidget(BuildContext context) async {
  await showAppBottomSheet(
    context: context,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: AnimationLimiter(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 400),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: ScaleAnimation(
                child: widget,
              ),
            ),
            children: [
              Container(
                width: 60,
                height: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[400]),
              ),
              const AppLottieView(
                path: 'assets/lotties/warning.json',
                height: 100,
                repeat: true,
              ),
              const Text(
                'Are you sure ?',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              const SizedBox(height: 5),
              const Text(
                '''If you select Clear we will Clear your all historys on our server.
        
        Your app data will also be deleted and you won't be able to retrieve it.
        ''',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              AppButton(
                  onTap: () {},
                  text: 'Clear Chats',
                  bagroundColor: Colors.red[700]!,
                  foregroundColor: Colors.white)
            ],
          ),
        ),
      ),
    ),
  );
}
