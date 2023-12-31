import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showMsgBar({required String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0);
}
