import 'package:firebase_msg/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageSendingCard extends StatelessWidget {
  const MessageSendingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: const [
          BoxShadow(
              color: Colors.grey,
              blurRadius: 0.1,
              spreadRadius: 0.1,
              offset: Offset(1, 1))
        ],
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Wrap(
            children: [
              IconButton(
                splashRadius: 20,
                onPressed: () {},
                icon: const Icon(Icons.emoji_emotions_outlined),
              ),
              SizedBox(
                width: context.width - 160,
                child: TextField(
                  cursorColor: ownChatCard,
                  decoration: const InputDecoration(
                      hintText: 'Type Something.....',
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                      border: InputBorder.none),
                ),
              ),
            ],
          ),
          IconButton(
              splashRadius: 20,
              onPressed: () {},
              icon: const Icon(Icons.mic_none_outlined)),
          CircleAvatar(
            backgroundColor: ownChatCard,
            radius: 20,
            child: Center(
              child: Image.asset(
                color: Colors.white,
                'assets/icons/send.png',
                height: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
