import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/controller/getx/connectivity_controller.dart';
import 'package:firebase_msg/controller/utils/msg_bar.dart';
import 'package:firebase_msg/view/auth/signUp.dart';
import 'package:firebase_msg/view/widget/forgot_password_pop.dart';
import 'package:firebase_msg/view/widget/text_form_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  LoginView({super.key});

  GlobalKey<FormState> gkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final lc = Get.put(AuthCtrl());
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          child: Stack(
            children: [
              Container(
                height: screenSize.height / 3.5,
                width: screenSize.width,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: AlignmentDirectional.bottomEnd,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(screenSize.width, 100.0),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      Text(
                        'SignIn',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Login Your Account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Material(
                          elevation: 6.0,
                          shadowColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? Colors.black
                                  : Colors.grey.shade500,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 18),
                            height: screenSize.height / 2,
                            width: screenSize.width,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Form(
                              key: gkey,
                              child: Column(
                                children: [
                                  TextFormFieldCmn(
                                    controller: lc.emailCtrl,
                                    labelText: 'Email',
                                    prefixIcn: Icons.email,
                                    isEmail: true,
                                  ),
                                  TextFormFieldCmn(
                                    controller: lc.passCtrl,
                                    labelText: 'password',
                                    prefixIcn: Icons.password,
                                    suffixIcn: Icons.remove_red_eye_rounded,
                                    isPass: true,
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ForgotPassword()));
                                      },
                                      child: const Text(
                                        'Forgot password ?',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                      onPressed: () async {
                                        if (gkey.currentState!.validate()) {
                                          await handleSignIn(context);
                                        } else {
                                          showMsgBar(msg: 'Empty Fields');
                                        }
                                      },
                                      child: const Text('SignIn'))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpView(),
                              ));
                        },
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "Don't have an account ? ",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                          TextSpan(
                            text: "SignUp",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w700),
                          )
                        ])),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> handleSignIn(context) async {
    final sc = Get.put(AuthCtrl());
    final ic = Get.put(ConnectivityCtrl());
    await ic.checkConnection();

    if (ic.hasInternet.value == false) {
      showMsgBar(msg: 'Internet is required');
    } else {
      String email = sc.emailCtrl.text.trim();
      String password = sc.passCtrl.text;
      await sc
          .signInWithEmailAndPasswords(email, password, context)
          .then((value) {
        sc.clearController();
        email = '';
        password = '';
      });
    }
  }
}
