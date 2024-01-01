import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/view/widget/text_form_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final ac = Get.put(AuthCtrl());
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          const SizedBox(height: 20),
          const Text(
            'Forgot Password ?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text('Please enter email address linked with your account',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          TextFormFieldCmn(
              isEmail: true,
              prefixIcn: Icons.email,
              controller: ac.forgotPasswordCtrl,
              labelText: 'Email'),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () async {
                await ac.forgotPassword(context);
              },
              child: const Text('Reset'))
        ],
      ),
    ));
  }
}
