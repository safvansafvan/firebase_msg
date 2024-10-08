import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_msg/controller/getx/message_sending_controller.dart';
import 'package:firebase_msg/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageSendingCard extends StatefulWidget {
  const MessageSendingCard({
    super.key,
  });

  @override
  State<MessageSendingCard> createState() => _MessageSendingCardState();
}

class _MessageSendingCardState extends State<MessageSendingCard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageSendingController>(builder: (controller) {
      return Column(
        children: [
          AnimatedContainer(
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 500),
            height: controller.isEmojiPickerVisible ? 250 : 0,
            width: double.infinity,
            child: controller.isEmojiPickerVisible
                ? EmojiPicker(
                    config: Config(
                      swapCategoryAndBottomBar: false,
                      categoryViewConfig: CategoryViewConfig(
                        backgroundColor: Colors.transparent,
                        backspaceColor: Colors.black,
                        iconColor: Colors.black,
                        iconColorSelected: ownChatCard,
                        indicatorColor: ownChatCard,
                        tabIndicatorAnimDuration:
                            const Duration(milliseconds: 1000),
                        dividerColor: ownChatCard,
                        recentTabBehavior: RecentTabBehavior.RECENT,
                      ),
                      bottomActionBarConfig:
                          const BottomActionBarConfig(enabled: false),
                      searchViewConfig: const SearchViewConfig(),
                    ),
                    onEmojiSelected: (category, emoji) {
                      controller.textController.text += emoji.emoji;
                    },
                  )
                : null,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[100]!),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 0.1,
                  spreadRadius: 0.1,
                  offset: Offset(1, 1),
                )
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
                      onPressed: () {
                        controller.focusNode.unfocus();
                        controller.showEmojiState();
                      },
                      icon: const Icon(Icons.emoji_emotions_outlined),
                    ),
                    SizedBox(
                      width: context.width - 160,
                      child: TextField(
                        onTap: () {
                          if (controller.isEmojiPickerVisible) {
                            controller.disableEmojiState();
                          }
                        },
                        focusNode: controller.focusNode,
                        controller: controller.textController,
                        cursorColor: ownChatCard,
                        decoration: const InputDecoration(
                            hintText: 'Type Something.....',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
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
          ),
        ],
      );
    });
  }
}
