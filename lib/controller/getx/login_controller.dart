import 'dart:developer';

import 'package:firebase_msg/utils/msg_bar.dart';
import 'package:firebase_msg/view/auth/signin.dart';
import 'package:firebase_msg/view/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginCtrl extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();
  bool isSignUpLoading = false;
  RxBool passwordVisible = true.obs;

  void showPassword() {
    passwordVisible.value = !passwordVisible.value;
  }

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    isSignUpLoading = true;
    update();
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      isSignUpLoading = false;
      update();
      return credential.user;
    } catch (e) {
      log(e.toString());
    }
    isSignUpLoading = false;
    update();
    return null;
  }

  bool isSignInLoading = false;
  Future<User?> signInWithEmailAndPasswords(
      String email, String password) async {
    isSignInLoading = true;
    update();
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      isSignInLoading = false;
      update();
      return credential.user;
    } catch (e) {
      log(e.toString());
    }
    isSignInLoading = false;
    update();
    return null;
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

  handleScreens(context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return const HomeView();
    } else {
      return LoginView();
    }
  }

  void clearController() {
    passCtrl.clear();
    emailCtrl.clear();
  }
}
