import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_msg/controller/utils/msg_bar.dart';
import 'package:firebase_msg/model/last_msg_model.dart';
import 'package:firebase_msg/model/msg_model.dart';
import 'package:firebase_msg/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageCtrl extends GetxController {
  Future<void> setStorageData({
    required String uid,
    required String userName,
    required String email,
  }) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('uid', uid);
    await storage.setString('userName', userName);
    await storage.setString('email', email);
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
    isLoadingGet.value = true;
    try {
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
          ),
        );
      }
    } finally {
      isLoadingGet.value = false;
    }
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

  Future<void> createChatRoom(
      {required String chatRoomId,
      required Map<String, dynamic> chatRoomInfoMap}) async {
    DocumentSnapshot data =
        await firestore.collection('chatroom').doc(chatRoomId).get();
    if (!data.exists) {
      await firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .set(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMeassages(
      {required String chatRoomId}) async {
    return firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .orderBy("time", descending: true)
        .snapshots();
  }

  Future<void> addMessage(
      {required String chatRoomId, required MsgModel messageInfo}) async {
    await firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .collection('chats')
        .doc(messageInfo.messageId)
        .set(
          messageInfo.toJson(),
        );
  }

  Future<void> updateLastMessage(
      {required String chatRoomId,
      required LastMessageModel lastMessageInfo}) async {
    await firestore
        .collection('chatroom')
        .doc(chatRoomId)
        .update(lastMessageInfo.toJson());
  }

  ////
  final TextEditingController messageController = TextEditingController();
  Stream? messageStream;

  getMessageStream({required String chatRoomId}) async {
    messageStream = await getChatRoomMeassages(chatRoomId: chatRoomId);
    update();
  }

  Future<void> addMsg(
      {required String message,
      required String currentUserName,
      required String profPic,
      required UserModel user}) async {
    if (message.isNotEmpty) {
      messageController.text = "";
      DateTime currentTime = DateTime.now();
      String formatedTime = DateFormat('h:mma').format(currentTime);
      String messageId = randomAlphaNumeric(10);
      MsgModel messageInfo = MsgModel(
        message: message,
        sendBy: currentUserName,
        formatedTime: formatedTime,
        time: FieldValue.serverTimestamp(),
        messageId: messageId,
      );
      String chatRoomId = getChatRoomIdByUserName(
          chatingUserName: user.userName, currentUserName: currentUserName);
      await addMessage(chatRoomId: chatRoomId, messageInfo: messageInfo).then(
        (value) async {
          LastMessageModel lastMessageInfo = LastMessageModel(
            lastMessage: message,
            lastmessageSendBy: currentUserName,
            lastMessageFormatedDate: formatedTime,
            lastMessageTime: FieldValue.serverTimestamp(),
          );
          await updateLastMessage(
              chatRoomId: chatRoomId, lastMessageInfo: lastMessageInfo);
        },
      );
    }
  }

  String getChatRoomIdByUserName(
      {required String chatingUserName, required String currentUserName}) {
    if (chatingUserName.substring(0, 1).codeUnitAt(0) >
        currentUserName.substring(0, 1).codeUnitAt(0)) {
      return "${currentUserName}_$chatingUserName";
    } else {
      return "${chatingUserName}_$currentUserName";
    }
  }
}
