import 'package:firebase_msg/utils/show_dialog.dart';
import 'package:flutter/material.dart';

Future<void> deleteDialogWidget(BuildContext context) async {
  await appShowDialog(
    context: context,
    child: Column(
      children: [],
    ),
  );
}
