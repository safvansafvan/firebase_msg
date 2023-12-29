import 'package:firebase_msg/controller/getx/auth_controller.dart';
import 'package:firebase_msg/controller/getx/connectivity_controller.dart';
import 'package:firebase_msg/controller/utils/msg_bar.dart';
import 'package:firebase_msg/view/auth/signin.dart';
import 'package:firebase_msg/view/home.dart';
import 'package:firebase_msg/view/widget/text_form_common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SignUpView extends StatelessWidget {
  SignUpView({super.key});

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
                        'SignUp',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'SignUp Your Account',
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
                                    controller: lc.nameCtrl,
                                    labelText: 'Username',
                                    prefixIcn: Icons.person,
                                  ),
                                  TextFormFieldCmn(
                                    controller: lc.emailCtrl,
                                    labelText: 'Email',
                                    prefixIcn: Icons.email,
                                  ),
                                  TextFormFieldCmn(
                                    controller: lc.passCtrl,
                                    labelText: 'password',
                                    prefixIcn: Icons.password,
                                    suffixIcn: Icons.remove_red_eye_rounded,
                                    isPass: true,
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                      onPressed: () async {
                                        await handleSignUp(context);
                                      },
                                      child: const Text('SignUp'))
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
                                builder: (context) => LoginView(),
                              ));
                        },
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "Already have an account ? ",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black)),
                          TextSpan(
                              text: "SignIn",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.deepPurple))
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

  Future<void> handleSignUp(context) async {
    final sc = Get.put(AuthCtrl());
    final ic = Get.put(ConnectivityCtrl());
    await ic.checkConnection();
    if (gkey.currentState!.validate()) {
      if (ic.hasInternet.value == false) {
        showMsgBar(msg: 'Internet is required');
      } else {
        String email = sc.emailCtrl.text.trim();
        String password = sc.passCtrl.text;
        await sc
            .signUpWithEmailAndPassword(email, password)
            .then((value) => sc.clearController());

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeView(),
            ),
            (route) => false);
      }
    } else {
      showMsgBar(msg: 'Empty Fields');
    }
  }
}
