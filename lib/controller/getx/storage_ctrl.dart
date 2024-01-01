import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_msg/controller/utils/msg_bar.dart';
import 'package:firebase_msg/model/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageCtrl extends GetxController {
  Future<void> setStorageData(
      {required String uid,
      required String userName,
      required String email,
      required String url}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('uid', uid);
    await storage.setString('userName', userName);
    await storage.setString('email', email);
    await storage.setString('url', url);
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<UserModel> allUsers = <UserModel>[].obs;
  Future<void> addUserToStorage({required UserModel model}) async {
    try {
      await firestore.collection('users').doc(model.uid).set(model.toJson());
    } catch (e) {
      showMsgBar(msg: 'Wrong');
      log(e.toString());
    }
  }

  RxBool isLoadingGet = false.obs;
  Future<void> getAllUsers() async {
    isLoadingGet = true.obs;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await users();
    allUsers.clear();
    for (QueryDocumentSnapshot<Map<String, dynamic>> document
        in querySnapshot.docs) {
      Map<String, dynamic> data = document.data();
      allUsers.add(
        UserModel(
          uid: data['uid'],
          email: data['email'],
          userName: data['user_name'],
          photoUrl: data['photo_url'],
        ),
      );
    }
    isLoadingGet = false.obs;
    update();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> users() async {
    return await firestore.collection('users').get();
  }

  RxMap<dynamic, dynamic> userDetails = {}.obs;
  Future getPrefData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    userDetails['name'] = storage.getString('name');
    userDetails['email'] = storage.getString('email');
    userDetails['uid'] = storage.getString('uid');
    update();
  }
}
