import 'dart:developer';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AuthTextFormField extends StatelessWidget {
  const AuthTextFormField({
    super.key,
    required this.controller,
    required this.title,
    required this.hint,
    this.isName = false,
    this.isEmail = false,
    this.isPassword = false,
    this.isNumber = false,
    this.isReadOnly = false,
    this.isDatePicker = false,
    this.inputType = TextInputType.name,
  });
  final TextEditingController controller;
  final String hint;
  final String title;
  final bool isName;
  final bool isEmail;
  final bool isPassword;
  final bool isNumber;
  final TextInputType inputType;
  final bool isReadOnly;
  final bool isDatePicker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(title,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          ),
          GetBuilder<AuthController>(builder: (authController) {
            return TextFormField(
              onTap: () async {
                if (isDatePicker == true) {
                  DateTime? date = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1980),
                    lastDate: DateTime(DateTime.now().year - 16),
                  );
                  log(date.toString());
                  Get.find<AuthController>().birthDateState(date);
                }
              },
              cursorOpacityAnimates: true,
              readOnly: isReadOnly,
              keyboardType: inputType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller,
              cursorColor: greenColor,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              inputFormatters: isNumber
                  ? [LengthLimitingTextInputFormatter(10)]
                  : [LengthLimitingTextInputFormatter(30)],
              decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  errorStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                      color: Colors.red),
                  contentPadding: const EdgeInsets.only(left: 10),
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  suffixIcon: isPassword
                      ? GestureDetector(
                          onTap: () {
                            authController.showPassword();
                          },
                          child: authController.passwordVisible
                              ? const Icon(Icons.visibility_outlined,
                                  color: Colors.grey)
                              : const Icon(Icons.visibility_off_outlined,
                                  color: Colors.grey),
                        )
                      : const SizedBox(),
                  prefix: isNumber
                      ? const Text(
                          '+91 ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        )
                      : const SizedBox(width: 0)),
              validator: (value) {
                if (isName) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Your Name';
                  }
                  if (value.length < 4) {
                    return 'Minimum 4 Charectors';
                  }
                }

                if (isPassword) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Password';
                  }
                  if (value.length < 8) {
                    return 'Minimum 8 Charectors';
                  }
                }

                if (isNumber) {
                  final RegExp phoneRegex = RegExp(r'^[6-9]\d{9}$');
                  if (value == null || value.isEmpty) {
                    return 'Enter Number';
                  }
                  if (value.length < 10) {
                    return 'Enter 10 Digits Number';
                  }
                  if (!phoneRegex.hasMatch(value)) {
                    return 'Enter Valid Number';
                  }
                }

                if (isEmail) {
                  if (value == null || value.isEmpty) {
                    return 'Your Email Address';
                  }
                  if (!EmailValidator.validate(value)) {
                    return 'Enter Valid Email Address';
                  }
                }

                return null;
              },
              obscureText: isPassword ? authController.passwordVisible : false,
            );
          }),
        ],
      ),
    );
  }
}
