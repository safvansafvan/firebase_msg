import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final ac = Get.put(AuthCtrl());
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
                )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 100),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      child: const ListTile(
                        leading: CircleAvatar(),
                        title: Text('Username'),
                        subtitle: Text('text'),
                        trailing: Text('Date'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () async {
          await ac.logout(context);
        },
      ),
    );
  }
}
