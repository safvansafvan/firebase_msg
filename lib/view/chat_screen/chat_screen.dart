import 'package:firebase_msg/controller/getx/message_sending_controller.dart';
import 'package:firebase_msg/utils/rive_icon.dart';
import 'package:firebase_msg/utils/scroll_behavior.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:firebase_msg/view/widget/chat_widget/message_sending_card.dart';
import 'package:firebase_msg/view/widget/chat_widget/own_chat_card.dart';
import 'package:firebase_msg/view/widget/chat_widget/pop_up_menu.dart';
import 'package:firebase_msg/view/widget/chat_widget/user_chat_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive_animated_icon/rive_animated_icon.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final controller = Get.find<MessageSendingController>();
        controller.focusNode.unfocus();
        controller.disableEmojiState();
      },
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 5,
          centerTitle: false,
          leadingWidth: 35,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: InkWell(
                highlightColor: Colors.transparent,
                onTap: () {
                  phoneVibration();
                  Navigator.pop(context);
                },
                child: const Icon(Icons.chevron_left)),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                radius: 25,
              ),
              const SizedBox(width: 10),
              const Text(
                'User Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          actions: [
            showRiveIcon(icon: RiveIcon.call),
            const Padding(
                padding: EdgeInsets.only(right: 16, left: 10),
                child: ChatPopUpMenu())
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ScrollConfiguration(
                  behavior: NoGlowScrollBehavior(),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return index.isEven
                          ? const OwnChatCardWidget()
                          : const UserChatCardWidget();
                    },
                  ),
                ),
              ),
            ),
            const MessageSendingCard()
          ],
        ),
      ),
    );
  }
}
