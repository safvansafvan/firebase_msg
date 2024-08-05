import 'package:email_validator/email_validator.dart';
import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/app_button.dart';
import 'package:firebase_msg/utils/linear_loading.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:firebase_msg/view/widget/auth/login_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            phoneVibration();
            authController.loginClear();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            AnimationLimiter(
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
                      'Forgot Password',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 0.9),
                    ),
                    const SizedBox(height: 20),
                    AuthTextFormField(
                      isEmail: true,
                      title: ' Email Address',
                      controller: authController.emailController,
                      hint: 'Email',
                      inputType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.grey[500],
                            size: 22,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "Your verification code was sent via Email",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[500],
                                height: 1.2),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            GetBuilder<AuthController>(builder: (login) {
              return login.isForgotLoading
                  ? const LinearLoading()
                  : AppButton(
                      bagroundColor: (login.emailController.text.isNotEmpty &&
                              EmailValidator.validate(
                                  login.emailController.text))
                          ? greenColor
                          : Colors.grey[400]!,
                      foregroundColor: Colors.white,
                      text: 'Continue',
                      onTap: () async {
                        if (login.emailController.text.isNotEmpty &&
                            EmailValidator.validate(
                                login.emailController.text)) {
                          phoneVibration();

                          await login.forgotPassword(context);
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
