import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:flutter/material.dart';

class SettingsFields extends StatelessWidget {
  const SettingsFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Column(
            children: [
              CardWidget(
                icon: Icons.privacy_tip_outlined,
                label: 'Privacy',
                tap: () {
                  phoneVibration();
                },
              ),
              CardWidget(
                icon: Icons.chat_bubble_outline_outlined,
                label: 'Clear Chat',
                tap: () {
                  phoneVibration();
                },
                isRedText: true,
              ),
              const CardWidget(
                icon: Icons.notifications_active_outlined,
                label: 'Notification',
                action: true,
              ),
              CardWidget(
                icon: Icons.help_outline_outlined,
                label: 'Help',
                tap: () {
                  phoneVibration();
                },
              ),
              CardWidget(
                icon: Icons.group_outlined,
                label: 'Invite Friends',
                tap: () {
                  phoneVibration();
                },
              ),
              CardWidget(
                icon: Icons.account_circle_outlined,
                label: 'Delete Account',
                tap: () {
                  phoneVibration();
                },
                isRedText: true,
              ),
              CardWidget(
                icon: Icons.info_outline,
                label: 'About',
                tap: () {
                  phoneVibration();
                },
              ),
              CardWidget(
                icon: Icons.logout_outlined,
                label: 'Logout',
                tap: () {
                  phoneVibration();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 30, vertical: action == true ? 0 : 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: [
                Icon(icon,
                    color:
                        isRedText == true ? Colors.red[700] : Colors.black87),
                const SizedBox(width: 20),
                Text(
                  label,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color:
                          isRedText == true ? Colors.red[700] : Colors.black87),
                ),
              ],
            ),
            action == true
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
    );
  }
}
