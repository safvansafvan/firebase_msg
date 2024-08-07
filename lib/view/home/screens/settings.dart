import 'package:firebase_msg/view/widget/profile_widget/settings_fields.dart';
import 'package:firebase_msg/view/widget/profile_widget/user_details_card.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [UserCard(), SettingsFields()],
    );
  }
}
