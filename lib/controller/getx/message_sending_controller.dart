import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageSendingController extends GetxController {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textController = TextEditingController();
  bool isEmojiPickerVisible = false;

  @override
  void onInit() {
    textController.addListener(stateUpdate);
    super.onInit();
  }

  @override
  void dispose() {
    textController.removeListener(stateUpdate);
    super.dispose();
  }

  void stateUpdate() {
    update();
  }

  void showEmojiState() {
    isEmojiPickerVisible = !isEmojiPickerVisible;
    update();
  }

  void disableEmojiState() {
    isEmojiPickerVisible = false;
    update();
  }
}
