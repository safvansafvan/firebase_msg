import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/controller/getx/storage_ctrl.dart';
import 'package:firebase_msg/view/chat/chat.dart';
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
                height: screenSize.height / 5.5,
                width: screenSize.width,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: AlignmentDirectional.bottomEnd,
                  ),
                ),
                child: const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.0, left: 20, right: 20),
                    child: Text(
                      'Chats',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
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
                child: Obx(() {
                  if (sc.isLoadingGet.isTrue) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.builder(
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
                            title: Text(
                              allUsers.name,
                            ),
                            subtitle: Text(allUsers.email),
                            trailing: const Text('Date'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChatView(),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
