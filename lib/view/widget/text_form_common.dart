import 'package:email_validator/email_validator.dart';
import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFormFieldCmn extends StatelessWidget {
  const TextFormFieldCmn(
      {super.key,
      required this.controller,
      required this.labelText,
      this.isEmail = false,
      this.isPass = false,
      this.prefixIcn,
      this.suffixIcn});

  final TextEditingController controller;
  final IconData? prefixIcn;
  final IconData? suffixIcn;
  final String labelText;
  final bool isPass;
  final bool isEmail;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(AuthCtrl());
    final suffix = Get.put(AuthCtrl().passwordVisible.value);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        validator: (value) {
          if (isPass) {
            if (value == null || value.isEmpty) {
              return "Password is required";
            }
          }
          if (isEmail) {
            if (value != null && !EmailValidator.validate(value)) {
              return "Enter valid email";
            }
          }
          return null;
        },
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: Icon(prefixIcn),
            suffixIcon: isPass
                ? IconButton(
                    splashRadius: 4,
                    onPressed: () {
                      ctrl.showPassword();
                    },
                    icon: suffix
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  )
                : const SizedBox(),
            label: Text(labelText),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey))),
        obscureText: isPass ? suffix : false,
      ),
    );
  }
}
