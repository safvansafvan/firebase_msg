import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/app_button.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:firebase_msg/view/auth/signUp/signup_stage_two.dart';
import 'package:firebase_msg/view/widget/auth_widget/login_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class SignUpScreenStageOne extends StatefulWidget {
  const SignUpScreenStageOne({super.key});

  @override
  State<SignUpScreenStageOne> createState() => _SignUpScreenStageOneState();
}

class _SignUpScreenStageOneState extends State<SignUpScreenStageOne> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            phoneVibration();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
        ),
        title: Column(
          children: [
            const Text(
              'Create Account',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              'Step 1 Of 3',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500]),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            AnimationLimiter(
              child: Form(
                key: _formKey,
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 1000),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 50.0,
                      curve: Curves.easeOutSine,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: [
                      AuthTextFormField(
                        isName: true,
                        title: ' What is your name ?',
                        controller: authController.nameController,
                        hint: 'First And Last Name',
                      ),
                      AuthTextFormField(
                        title: ' Birthday',
                        controller: authController.birthdayController,
                        hint: '    /     / ',
                        isReadOnly: true,
                        isDatePicker: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            GetBuilder<AuthController>(builder: (login) {
              return AppButton(
                bagroundColor: login.birthdayController.text.isNotEmpty &&
                        login.nameController.text.isNotEmpty &&
                        login.nameController.text.length >= 4
                    ? greenColor
                    : Colors.grey[400]!,
                foregroundColor: Colors.white,
                text: 'Continue',
                onTap: () async {
                  if (_formKey.currentState!.validate() &&
                      login.birthdayController.text.isNotEmpty) {
                    phoneVibration();

                    await Get.to(() => const SignUpScreenStageTwo(),
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 500),
                        transition: Transition.rightToLeft);
                  }
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
