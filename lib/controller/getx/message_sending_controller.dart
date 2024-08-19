import 'dart:developer';

import 'package:firebase_msg/utils/show_toast_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class MessageSendingController extends GetxController {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textController = TextEditingController();
  bool isEmojiPickerVisible = false;
  bool showRecordingAudio = false;

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
    if (isEmojiPickerVisible == true) {
      isEmojiPickerVisible = false;
      update();
    }
  }

  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<bool> recordAudio() async {
    try {
      bool hasPermission = await requestMicrophonePermission();
      final record = AudioRecorder();
      if (hasPermission) {
        await record.start(const RecordConfig(), path: 'recoding/chatify.m4a');
        return true;
      } else {
        appSnackBarWidget(
            title: 'Error', message: 'Please Enable App Need Permissions');
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<void> stopRecordings() async {
    final record = AudioRecorder();
    final path = await record.stop();
    await record.cancel();
    record.dispose();
  }
}
