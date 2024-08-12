import 'package:firebase_msg/theme/colors.dart';
import 'package:flutter/material.dart';

ButtonStyle textButtonTheme = ButtonStyle(
  overlayColor: WidgetStatePropertyAll(Colors.grey[300]),
  foregroundColor: WidgetStatePropertyAll(textColor),
  textStyle: WidgetStatePropertyAll(
      TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: textColor)),
  shape: WidgetStatePropertyAll(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ),
);
