import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/controller/getx/storage_ctrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  final sc = Get.put(StorageCtrl());
  final ac = Get.put(AuthCtrl());
  @override
  void initState() {
    sc.getPrefData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: CircleAvatar(
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new)),
                ),
              ),
              const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/im.jpg'),
              ),
              const SizedBox(height: 30),
              Obx(
                () => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        sc.userDetails['email'] ?? 'Unknown',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        sc.userDetails['name'] ?? 'Unknown',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: () async {
                    await ac.logout(context);
                  },
                  child: const Text('Logout'))
            ],
          ),
        ),
      ),
    );
  }
}
