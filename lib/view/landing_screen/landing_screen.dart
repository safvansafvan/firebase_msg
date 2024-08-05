import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/theme/colors.dart';
import 'package:firebase_msg/utils/app_lottie_view.dart';
import 'package:firebase_msg/utils/vibrate.dart';
import 'package:firebase_msg/view/auth/login/login.dart';
import 'package:firebase_msg/view/auth/signUp/signup_stage_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: AppLottieView(path: 'assets/lotties/splash.json'),
              ),
            ),
          ),
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
                  const GoogleLoginButton(),
                  const SingUPButton(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        const Text(
                          'Already Have An Account ? ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        InkWell(
                          onTap: () async {
                            phoneVibration();
                            Get.find<AuthController>().signUpClear();
                            await Get.to(() => const LoginScreen(),
                                curve: Curves.easeInOut,
                                duration: const Duration(milliseconds: 500),
                                transition: Transition.downToUp);
                          },
                          child: Text('Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: textColor)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SingUPButton extends StatefulWidget {
  const SingUPButton({
    super.key,
  });

  @override
  State<SingUPButton> createState() => _SingUPButtonState();
}

class _SingUPButtonState extends State<SingUPButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        phoneVibration();
        Get.find<AuthController>().loginClear();
        await Get.to(() => const SignUpScreenStageOne(),
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 500),
            transition: Transition.downToUp);
      },
      onTapDown: _onTapDown,
      onTapCancel: _onTapCancel,
      onTapUp: _onTapUp,
      child: ScaleTransition(
        scale: _animation,
        child: Card(
          color: greenColor,
          margin: const EdgeInsets.symmetric(vertical: 10),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            height: 48,
            width: context.width - 80,
            child: const Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleLoginButton extends StatefulWidget {
  const GoogleLoginButton({
    super.key,
  });

  @override
  State<GoogleLoginButton> createState() => _GoogleLoginButtonState();
}

class _GoogleLoginButtonState extends State<GoogleLoginButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        phoneVibration();
        Get.find<AuthController>().signInWithGoogle(context: context);
      },
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _animation,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: context.width - 80,
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/google.png', height: 20),
                const SizedBox(width: 10),
                const Text(
                  'Continue With Google',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
