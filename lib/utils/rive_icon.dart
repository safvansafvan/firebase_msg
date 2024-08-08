import 'package:firebase_msg/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

Widget showRiveIcon({required RiveIcon icon, Color? color}) {
  return RiveAnimatedIcon(
    riveIcon: icon,
    width: 30,
    height: 30,
    color: color ?? profileGr1,
    strokeWidth: 10,
    loopAnimation: true,
  );
}
