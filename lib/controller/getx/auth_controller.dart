import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_msg/controller/getx/storage_ctrl.dart';
import 'package:firebase_msg/controller/utils/msg_bar.dart';
import 'package:firebase_msg/model/user_model.dart';
import 'package:firebase_msg/view/auth/signin.dart';
import 'package:firebase_msg/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCtrl extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  RxBool passwordVisible = true.obs;

  void showPassword() {
    passwordVisible.value = !passwordVisible.value;
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = credential.user!.uid;
      UserModel userModel =
          UserModel(uid: uid, email: email, userName: nameCtrl.text);
      await Get.put(StorageCtrl().setStorageData(
        uid: uid,
        userName: userModel.userName,
        email: email,
      ));
      await Get.put(StorageCtrl().addUserToStorage(model: userModel));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showMsgBar(msg: 'Password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        showMsgBar(msg: 'Account already exists');
      } else {
        showMsgBar(msg: e.code);
      }
    }
  }

  Future<void> signInWithEmailAndPasswords(
      String email, String password, context) async {
    try {
      QuerySnapshot querySnapshot = await getUserByEmail(email);
      String name = querySnapshot.docs[0]['user_name'];

      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      String uid = credential.user!.uid;
      UserModel(
        uid: uid,
        email: email,
        userName: name,
      );
      await Get.put(
          StorageCtrl().setStorageData(uid: uid, userName: name, email: email));
      await Get.put(StorageCtrl())
          .getPrefData()
          .then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeView(),
              ),
              (route) => false));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showMsgBar(msg: 'Password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        showMsgBar(msg: 'Account already exists');
      } else {
        showMsgBar(msg: e.code);
      }
    }
  }

  TextEditingController forgotPasswordCtrl = TextEditingController();
  Future<void> forgotPassword(context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: forgotPasswordCtrl.text.trim())
          .then((value) {
        forgotPasswordCtrl.clear();
        showMsgBar(msg: 'Check Email Inbox');
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> logout(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      await auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
        (route) => false,
      );
      showMsgBar(msg: 'Logout');
    } catch (e) {
      log('Error during logout: $e');
    }
  }

  Widget handleScreens(context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const HomeView();
    } else {
      return LoginView();
    }
  }

  clearController() {
    passCtrl.clear();
    emailCtrl.clear();
    nameCtrl.clear();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<QuerySnapshot> getUserByEmail(String email) async {
    return firestore.collection('user').where('email', isEqualTo: email).get();
  }
}
