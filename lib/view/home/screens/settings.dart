import 'package:firebase_msg/view/widget/settings_widget/settings_fields.dart';
import 'package:firebase_msg/view/widget/settings_widget/user_details_card.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [UserCard(), SettingsFields()],
    );
  }
}
