import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_msg/controller/getx/storage_ctrl.dart';
import 'package:firebase_msg/model/user_model.dart';
import 'package:firebase_msg/view/widget/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key, required this.user, required this.chatRoomId});
  final UserModel user;
  final String chatRoomId;

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final sc = Get.put(StorageCtrl());
  @override
  void initState() {
    sc.getMessageStream(chatRoomId: widget.chatRoomId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: screenSize.height,
        child: Stack(
          children: [
            Container(
              height: screenSize.height / 7.5,
              width: screenSize.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.topLeft,
                  end: AlignmentDirectional.bottomEnd,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 4),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new,
                            color: Colors.white),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset('assets/im.jpg',
                            height: 50, width: 50, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'unknown',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Obx(() => Column(
                    children: [
                      Expanded(
                          child: StreamBuilder(
                        stream: sc.messageStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: SizedBox(
                                width: 25,
                                height: 25,
                                child: CircularProgressIndicator.adaptive(
                                  strokeWidth: 3,
                                ),
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(
                              child: Text(
                                'No Chats',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            );
                          }
                          return ListView.separated(
                              reverse: true,
                              itemBuilder: (context, index) {
                                QueryDocumentSnapshot<Map<String, dynamic>>
                                    snap = snapshot.data!.docs[index];
                                return ChatCard(snap: snap);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 5),
                              itemCount: snapshot.data!.docs.length);
                        },
                      ))
                    ],
                  )),
            ),
            Positioned(
              bottom: 2,
              right: 1,
              left: 1,
              child: ListTile(
                leading: Container(
                  height: 50,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(330),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.emoji_emotions),
                ),
                title: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.send,
                              color: Colors.blue,
                            ),
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: 'Text Something ....',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
