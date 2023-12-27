import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCtrl ctrl = AuthCtrl();
    return GetMaterialApp(
      title: 'chat app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: ctrl.handleScreens(context),
      debugShowCheckedModeBanner: false,
    );
  }
}
