import 'package:email_validator/email_validator.dart';
import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/controller/getx/connectivity_controller.dart';
import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/app_button.dart';
import 'package:firebase_msg/utils/show_toast_message.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:firebase_msg/view/auth/signUp/signup_stage_three.dart';
import 'package:firebase_msg/view/widget/auth_widget/login_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class SignUpScreenStageTwo extends StatefulWidget {
  const SignUpScreenStageTwo({super.key});

  @override
  State<SignUpScreenStageTwo> createState() => _SignUpScreenStageTwoState();
}

class _SignUpScreenStageTwoState extends State<SignUpScreenStageTwo> {
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
              'Step 2 Of 3',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[500]),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Form(
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
                              isPassword: true,
                              title: ' Set Password',
                              controller: authController.passwordController,
                              hint: 'Password',
                            ),
                            AuthTextFormField(
                              isEmail: true,
                              inputType: TextInputType.emailAddress,
                              title: ' Enter Email',
                              controller: authController.emailController,
                              hint: 'Email',
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.grey[500],
                                    size: 22,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      "Please enter all required fields. We'll send you an OTP via Email.",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[500],
                                          height: 1.2),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GetBuilder<AuthController>(builder: (login) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppButton(
                bagroundColor: login.passwordController.text.isNotEmpty &&
                        login.passwordController.text.length >= 8 &&
                        login.emailController.text.isNotEmpty &&
                        EmailValidator.validate(login.emailController.text)
                    ? greenColor
                    : Colors.grey[400]!,
                foregroundColor: Colors.white,
                text: 'Continue',
                onTap: () async {
                  final connectivity = Get.find<ConnectivityController>();
                  if (_formKey.currentState!.validate() &&
                      EmailValidator.validate(login.emailController.text)) {
                    phoneVibration();
                    authController.pinOTPController.clear();
                    await connectivity.checkConnection();
                    if (connectivity.hasInternet.value) {
                      authController.otpConfig();
                      await Get.to(() => const SignUpScreenStageThree(),
                          curve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 500),
                          transition: Transition.rightToLeft);
                    } else {
                      appSnackBarWidget(
                          title: 'Error', message: 'Check You Connectivtiy');
                    }
                  }
                },
              ),
            );
          })
        ],
      ),
    );
  }
}
