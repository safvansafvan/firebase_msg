import 'package:firebase_msg/theme/colors.dart';
import 'package:flutter/material.dart';

ButtonStyle textButtonTheme = ButtonStyle(
  overlayColor: MaterialStatePropertyAll(Colors.grey[300]),
  foregroundColor: MaterialStatePropertyAll(textColor),
  textStyle: MaterialStatePropertyAll(
      TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: textColor)),
  shape: MaterialStatePropertyAll(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  ),
);
