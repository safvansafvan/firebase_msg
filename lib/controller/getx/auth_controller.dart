import 'dart:developer';

import 'package:firebase_msg/controller/getx/storage_ctrl.dart';
import 'package:firebase_msg/controller/utils/msg_bar.dart';
import 'package:firebase_msg/model/user_model.dart';
import 'package:firebase_msg/view/auth/signin.dart';
import 'package:firebase_msg/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCtrl extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  RxBool isSignUpLoading = false.obs;
  RxBool passwordVisible = true.obs;

  void showPassword() {
    passwordVisible.value = !passwordVisible.value;
  }

  Future<String> signUpWithEmailAndPassword(
      String email, String password) async {
    String result = '';
    isSignUpLoading = true.obs;
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = credential.user!.uid;
      UserModel userModel = UserModel(
        uid: uid,
        name: nameCtrl.text,
        email: email,
        userName: nameCtrl.text,
        photoUrl:
            'https://www.google.com/search?q=person+image+icon+cartoon&tbm=isch&ved=2ahUKEwjmt86Lp6-DAxUPhWMGHehQBYMQ2-cCegQIABAA&oq=person+image+icon+cartoon&gs_lcp=CgNpbWcQAzoECCMQJzoFCAAQgAQ6BggAEAcQHjoECAAQHjoGCAAQBRAeUI0OWMFEYNdHaABwAHgAgAGMAogBsAqSAQUyLjYuMZgBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=mO6LZeaLM4-KjuMP6KGVmAg&bih=695&biw=1536&rlz=1C1GCEA_enIN1068IN1068#imgrc=rVZxRvz_V5N2fM',
      );
      await Get.put(StorageCtrl().setStorageData(
          uid: uid,
          name: userModel.userName,
          email: email,
          url: userModel.photoUrl));
      await Get.put(StorageCtrl().addUserToStorage(model: userModel));

      result = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showMsgBar(msg: 'Password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        showMsgBar(msg: 'Account already exists');
      } else {
        showMsgBar(msg: e.code);
      }
    }
    isSignUpLoading = false.obs;
    return result;
  }

  RxBool isSignInLoading = false.obs;
  Future<String> signInWithEmailAndPasswords(
      String email, String password) async {
    isSignInLoading = true.obs;
    String result = '';
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      String uid = credential.user!.uid;
      UserModel userModel = UserModel(
        uid: uid,
        name: nameCtrl.text,
        email: email,
        userName: nameCtrl.text,
        photoUrl:
            'https://www.google.com/search?q=person+image+icon+cartoon&tbm=isch&ved=2ahUKEwjmt86Lp6-DAxUPhWMGHehQBYMQ2-cCegQIABAA&oq=person+image+icon+cartoon&gs_lcp=CgNpbWcQAzoECCMQJzoFCAAQgAQ6BggAEAcQHjoECAAQHjoGCAAQBRAeUI0OWMFEYNdHaABwAHgAgAGMAogBsAqSAQUyLjYuMZgBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=mO6LZeaLM4-KjuMP6KGVmAg&bih=695&biw=1536&rlz=1C1GCEA_enIN1068IN1068#imgrc=rVZxRvz_V5N2fM',
      );
      await Get.put(StorageCtrl().setStorageData(
          uid: uid,
          name: userModel.userName,
          email: email,
          url: userModel.photoUrl));
      result = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showMsgBar(msg: 'Password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        showMsgBar(msg: 'Account already exists');
      } else {
        showMsgBar(msg: e.code);
      }
    }
    isSignInLoading = false.obs;
    return result;
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
  }
}
