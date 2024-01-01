import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/controller/getx/storage_ctrl.dart';
import 'package:firebase_msg/view/chat/chat.dart';
import 'package:firebase_msg/view/user_profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ac = Get.put(AuthCtrl());
  final StorageCtrl sc = Get.put(StorageCtrl());
  @override
  void initState() {
    sc.getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Chats',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const UserProfileView(),
                                  ));
                            },
                            icon: const Icon(Icons.person,
                                color: Colors.white, size: 40))
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
                child: Obx(
                  () => (sc.isLoadingGet.isTrue)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: sc.allUsers.length,
                          itemBuilder: (context, index) {
                            final allUsers = sc.allUsers[index];

                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 7),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(60),
                                  child: Image.asset('assets/im.jpg',
                                      height: 65, width: 65, fit: BoxFit.cover),
                                ),
                                title: allUsers.uid ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? Wrap(
                                        children: [
                                          Text(
                                            allUsers.userName,
                                          ),
                                          const Text(' [You]')
                                        ],
                                      )
                                    : Text(
                                        allUsers.userName,
                                      ),
                                subtitle: allUsers.uid ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? null
                                    : Text(allUsers.email),
                                trailing: const Text('Date'),
                                onTap: () async {
                                  String chatRoomId =
                                      sc.getChatRoomIdByUserName(
                                    currentUserName:
                                        sc.userDetails['name'] ?? '',
                                    chatingUserName: allUsers.userName,
                                  );
                                  Map<String, dynamic> chatRoomInfoMap = {
                                    "users": [
                                      sc.userDetails['user_name'],
                                      allUsers.userName
                                    ]
                                  };
                                  await sc.createChatRoom(
                                      chatRoomId: chatRoomId,
                                      chatRoomInfoMap: chatRoomInfoMap);
                                  if (context.mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatView(
                                            user: allUsers,
                                            chatRoomId: chatRoomId),
                                      ),
                                    );
                                  }
                                },
                              ),
                            );
                          },
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
