import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_msg/controller/utils/msg_bar.dart';
import 'package:firebase_msg/model/user_model.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageCtrl extends GetxController {
  Future<void> setStorageData(
      {required String uid,
      required String name,
      required String email,
      required String url}) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('uid', uid);
    await storage.setString('name', name);
    await storage.setString('email', email);
    await storage.setString('url', url);
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> addUserToStorage({required UserModel model}) async {
    try {
      await firestore.collection('users').doc(model.uid).set(model.toJson());
    } catch (e) {
      showMsgBar(msg: 'Wrong');
    }
  }
}
