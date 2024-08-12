import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    isEmojiPickerVisible = false;
    update();
  }

  Future<void> recordAudio() async {
    final record = AudioRecorder();
    if (await record.hasPermission()) {
      await record.start(const RecordConfig(), path: 'recoding/chatify.m4a');
      final stream = await record
          .startStream(const RecordConfig(encoder: AudioEncoder.pcm16bits));
    }
  }

  Future<void> storeRecordings() async {
    final record = AudioRecorder();
    final path = await record.stop();
    await record.cancel();
    record.dispose();
  }
}
