import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/controller/getx/connectivity_controller.dart';
import 'package:firebase_msg/theme/button_style.dart';
import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/app_button.dart';
import 'package:firebase_msg/utils/app_lottie_view.dart';
import 'package:firebase_msg/utils/linear_loading.dart';
import 'package:firebase_msg/utils/show_toast_message.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class SignUpScreenStageThree extends StatefulWidget {
  const SignUpScreenStageThree({super.key});

  @override
  State<SignUpScreenStageThree> createState() => _SignUpScreenStageThreeState();
}

class _SignUpScreenStageThreeState extends State<SignUpScreenStageThree> {
  @override
  void initState() {
    final authController = Get.find<AuthController>();
    authController.sendOtpToMail();
    super.initState();
  }

  @override
  void dispose() {
    final controller = Get.find<AuthController>();
    controller.timer?.cancel();
    controller.start = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
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
              'Step 3 Of 3',
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
                    Column(
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
                            'Confirm Your Email Address',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Enter the code was sent to\n${authController.emailController.text}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey[500]),
                            ),
                          ),
                          GetBuilder<AuthController>(builder: (authController) {
                            return Pinput(
                              controller: authController.pinOTPController,
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              showCursor: true,
                              animationCurve: Curves.ease,
                            );
                          }),
                          GetBuilder<AuthController>(builder: (authController) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: authController.otpLoading
                                  ? const AppLottieView(
                                      repeat: true,
                                      path: 'assets/lotties/loading.json',
                                      height: 150,
                                    )
                                  : Column(
                                      children: [
                                        authController.isOTPResentDisabled
                                            ? Text(
                                                'Resend via SMS in ${authController.start} Sec')
                                            : const SizedBox(),
                                        authController.isOTPResentDisabled
                                            ? const SizedBox()
                                            : TextButton(
                                                style: textButtonTheme,
                                                onPressed: () {
                                                  authController
                                                      .sendOtpToMail();
                                                },
                                                child: const Text('Resend OTP'))
                                      ],
                                    ),
                            );
                          })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
          GetBuilder<AuthController>(builder: (login) {
            return login.isSignUpLoading
                ? const LinearLoading()
                : AppButton(
                    bagroundColor: login.pinOTPController.length == 4
                        ? greenColor
                        : Colors.grey[400]!,
                    foregroundColor: Colors.white,
                    text: 'Verify',
                    onTap: () async {
                      final connectivity = Get.find<ConnectivityController>();
                      if (login.pinOTPController.length == 4) {
                        phoneVibration();
                        await connectivity.checkConnection();
                        if (connectivity.hasInternet.value) {
                          await login.verifyOtpGiven(context);
                        } else {
                          appSnackBarWidget(
                              title: 'Error',
                              message: 'Check You Connectivtiy');
                        }
                      }
                    },
                  );
          })
        ],
      ),
    );
  }
}
