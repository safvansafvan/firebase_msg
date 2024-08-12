import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/scroll_behavior.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:firebase_msg/view/help_screen/help_screen.dart';
import 'package:firebase_msg/view/invite_firends_screen/invite_friends_screen.dart';
import 'package:firebase_msg/view/legal_screen/legal_screen.dart';
import 'package:firebase_msg/view/genaral_screen/genaral_screen.dart';
import 'package:firebase_msg/view/widget/settings_widget/clear_chats_sheet.dart';
import 'package:firebase_msg/view/widget/settings_widget/delete_account_sheet.dart';
import 'package:firebase_msg/view/widget/settings_widget/logout_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class SettingsFields extends StatelessWidget {
  const SettingsFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollConfiguration(
        behavior: NoGlowScrollBehavior(),
        child: SingleChildScrollView(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: AnimationLimiter(
              child: Column(
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 400),
                  childAnimationBuilder: (widget) => ScaleAnimation(
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    CardWidget(
                      icon: Icons.privacy_tip_outlined,
                      label: 'Legal',
                      tap: () {
                        phoneVibration();
                        Get.to(() => const LegalScreen(),
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 400),
                            transition: Transition.rightToLeft);
                      },
                    ),
                    CardWidget(
                      icon: Icons.chat_bubble_outline_outlined,
                      label: 'Clear Chat',
                      tap: () {
                        phoneVibration();
                        clearBottomSheetWidget(context);
                      },
                      isRedText: true,
                    ),
                    CardWidget(
                      icon: Icons.surround_sound,
                      label: 'Genaral',
                      tap: () {
                        phoneVibration();
                        Get.to(() => const GenaralScreen(),
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 400),
                            transition: Transition.rightToLeft);
                      },
                    ),
                    CardWidget(
                      icon: Icons.help_outline_outlined,
                      label: 'Help',
                      tap: () {
                        phoneVibration();
                        Get.to(() => const HelpScreen(),
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 400),
                            transition: Transition.rightToLeft);
                      },
                    ),
                    CardWidget(
                      icon: Icons.group_outlined,
                      label: 'Invite Friends',
                      tap: () {
                        phoneVibration();
                        Get.to(() => const InviteFriendsScreen(),
                            curve: Curves.easeInOut,
                            duration: const Duration(milliseconds: 400),
                            transition: Transition.rightToLeft);
                      },
                    ),
                    CardWidget(
                      icon: Icons.account_circle_outlined,
                      label: 'Delete Account',
                      tap: () {
                        phoneVibration();
                        deleteBottomSheetWidget(context);
                      },
                      isRedText: true,
                    ),
                    CardWidget(
                      icon: Icons.logout_outlined,
                      label: 'Logout',
                      tap: () {
                        phoneVibration();
                        logoutBottomSheetWidget(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatefulWidget {
  const CardWidget(
      {super.key,
      required this.icon,
      required this.label,
      this.tap,
      this.action,
      this.isRedText});

  final IconData icon;
  final String label;
  final Function()? tap;
  final bool? isRedText;
  final bool? action;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.95, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      highlightColor: Colors.transparent,
      onTap: widget.tap,
      onTapCancel: widget.tap != null ? _onTapCancel : null,
      onTapDown: widget.tap != null ? _onTapDown : null,
      onTapUp: widget.tap != null ? _onTapUp : null,
      child: ScaleTransition(
        scale: _animation,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: widget.action == true ? 16 : 30,
              vertical: widget.action == true ? 0 : 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: [
                  Icon(widget.icon,
                      color: widget.isRedText == true
                          ? Colors.red[700]
                          : Colors.black87),
                  const SizedBox(width: 20),
                  Text(
                    widget.label,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: widget.isRedText == true
                            ? Colors.red[700]
                            : Colors.black87),
                  ),
                ],
              ),
              widget.action == true
                  ? Switch(
                      activeColor: profileGr1,
                      hoverColor: Colors.blue[400],
                      inactiveThumbColor: Colors.grey[400],
                      splashRadius: 20,
                      value: false,
                      onChanged: (value) {},
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
