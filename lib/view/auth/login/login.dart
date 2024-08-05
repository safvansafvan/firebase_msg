import 'package:email_validator/email_validator.dart';
import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/theme/button_style.dart';
import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/app_button.dart';
import 'package:firebase_msg/utils/linear_loading.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:firebase_msg/view/auth/forgot_password_pop.dart';
import 'package:firebase_msg/view/widget/auth/login_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
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
                              const Text(
                                'Login',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22,
                                  letterSpacing: 0.9,
                                ),
                              ),
                              AuthTextFormField(
                                isEmail: true,
                                title: ' Email Address',
                                controller: authController.emailController,
                                hint: 'Email',
                                inputType: TextInputType.emailAddress,
                              ),
                              AuthTextFormField(
                                isPassword: true,
                                title: ' Account Password',
                                controller: authController.passwordController,
                                hint: 'Password',
                              ),
                              TextButton(
                                style: textButtonTheme,
                                onPressed: () async {
                                  phoneVibration();
                                  authController.loginClear();
                                  await Get.to(
                                      () => const ForgotPasswordScreen(),
                                      curve: Curves.easeInOut,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      transition: Transition.rightToLeft);
                                },
                                child: const Text('Forgot Password ? '),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GetBuilder<AuthController>(
              builder: (login) {
                return login.isLoginLoading
                    ? const LinearLoading()
                    : AppButton(
                        bagroundColor: login.emailController.text.isNotEmpty &&
                                EmailValidator.validate(
                                    login.emailController.text) &&
                                login.passwordController.text.length >= 8
                            ? greenColor
                            : Colors.grey[400]!,
                        foregroundColor: Colors.white,
                        text: 'LOGIN',
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            phoneVibration();
                            await login.signInWithEmailAndPasswords(context);
                          }
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
