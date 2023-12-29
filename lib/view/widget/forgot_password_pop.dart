import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/view/widget/text_form_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showModelBottomSheet(BuildContext context) {
  final ac = Get.put(AuthCtrl());
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return SizedBox(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
        ),
      );
    },
  );
}
