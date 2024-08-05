// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:email_otp/email_otp.dart';
import 'package:firebase_msg/controller/firebase_service/auth_service.dart';
import 'package:firebase_msg/controller/firebase_service/user_service.dart';
import 'package:firebase_msg/model/user_model.dart';
import 'package:firebase_msg/utils/show_toast_message.dart';
import 'package:firebase_msg/view/home/home.dart';
import 'package:firebase_msg/view/landing_screen/landing_screen.dart';
import 'package:firebase_msg/view/widget/auth/failed_dialog.dart';
import 'package:firebase_msg/view/widget/auth/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class AuthController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController pinOTPController = TextEditingController();
  bool passwordVisible = false;
  Timer? timer;
  int start = 0;
  bool isOTPResentDisabled = true;

  @override
  void onInit() {
    super.onInit();
    controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    animation = Tween<double>(begin: 1.0, end: 0.95).animate(controller);
    nameController.addListener(_updateState);
    emailController.addListener(_updateState);
    birthdayController.addListener(_updateState);
    phoneNumberController.addListener(_updateState);
    pinOTPController.addListener(_updateState);
    passwordController.addListener(_updateState);
  }

  @override
  void onClose() {
    birthdayController.removeListener(_updateState);
    nameController.removeListener(_updateState);
    emailController.removeListener(_updateState);
    phoneNumberController.removeListener(_updateState);
    pinOTPController.removeListener(_updateState);
    passwordController.removeListener(_updateState);
    super.onClose();
  }

  void _updateState() {
    update();
  }

  void showPassword() {
    passwordVisible = !passwordVisible;
    update();
  }

  void startTimer() {
    start = 30;
    isOTPResentDisabled = true;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
          isOTPResentDisabled = false;
          update();
        } else {
          start--;
          update();
        }
      },
    );
  }

  void birthDateState(DateTime? date) {
    if (date != null) {
      String dt = DateFormat('dd/MM/yyyy').format(date);
      birthdayController.text = dt;
      log(dt);
      update();
    }
  }

  void loginClear() {
    emailController.clear();
    passwordController.clear();
  }

  void signUpClear() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    birthdayController.clear();
    phoneNumberController.clear();
    pinOTPController.clear();
  }

  Future<void> signInWithGoogle({required BuildContext context}) async {
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn(
        // clientId:
        //     '332255568777-n81us8h470ai1arfhp5q8n0emnmeocj6.apps.googleusercontent.com',
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ]);
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        if (user != null) {
          await UserFirestoreRes().addUserToFirestore(
            model: UserModel(
                email: user.email,
                name: user.displayName,
                uid: user.uid,
                datetime: DateFormat.yMMMMEEEEd().format(DateTime.now()),
                url: user.photoURL,
                lastUpdated: '',
                number: user.phoneNumber),
          );
          Get.off(() => const HomeScreen(),
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 400),
              transition: Transition.zoom);
        } else {
          appSnackBarWidget(title: 'Failed', message: 'Something Went Wrong');
        }
      } catch (e) {
        log(e.toString());
      }
    } else {
      log("account is doesn't exist");
    }
  }

  handleScreens(context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return Get.offAll(() => const HomeScreen(),
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 400),
          transition: Transition.zoom);
    } else {
      return Get.offAll(() => const LandingScreen(),
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 400),
          transition: Transition.zoom);
    }
  }

// -------------------------------------------------logout----------------------------------------------------
  Future<void> logout(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      await auth.signOut();
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      await Get.offAll(() => const LandingScreen(),
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 400),
          transition: Transition.zoom);
    } catch (e) {
      log('Error during logout: $e');
      appSnackBarWidget(title: 'Failed', message: e.toString());
    }
  }

  ///*************************** singup with email and password ***********************************************
  Future<void> signUpWithEmailAndPassword(BuildContext ctx) async {
    try {
      UserCredential credential = await AuthServices.signUP(
          emailController.text, passwordController.text);

      if (credential.user != null) {
        await UserFirestoreRes().addUserToFirestore(
          model: UserModel(
              email: emailController.text,
              name: nameController.text,
              uid: credential.user?.uid,
              datetime: DateFormat.yMMMMEEEEd().format(DateTime.now()),
              url: '',
              lastUpdated: '',
              birthDate: birthdayController.text,
              number: phoneNumberController.text),
        );

        await accountCreationSuccessDialog(ctx);
        await Future.delayed(const Duration(seconds: 3));
        signUpClear();
        return Get.offAll(() => const HomeScreen(),
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 400),
            transition: Transition.zoom);
      } else {
        await accountCreationFailedDialog(ctx);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        appSnackBarWidget(
            title: 'Error',
            message: 'The email address is already in use by another account.');
      } else {
        appSnackBarWidget(
            title: 'Error',
            message: 'Something Went Wrong , Try again later .');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isSignUpLoading = false;
      update();
    }
  }

  bool isSignUpLoading = false;
  bool otpLoading = false;
  void otpConfig() {
    EmailOTP.config(
      appName: 'Chat Wave',
      otpType: OTPType.numeric,
      expiry: 30000,
      emailTheme: EmailTheme.v6,
      appEmail: 'fluttertech654@gmail.com',
      otpLength: 4,
    );
  }

  Future<void> sendOtpToMail() async {
    otpLoading = true;
    bool value = await EmailOTP.sendOTP(email: emailController.text);
    if (value) {
      startTimer();
    }
    otpLoading = false;
    update();
  }

  Future<void> verifyOtpGiven(BuildContext context) async {
    isSignUpLoading = true;
    update();
    bool validateOtp = EmailOTP.verifyOTP(otp: pinOTPController.text);
    if (validateOtp) {
      await signUpWithEmailAndPassword(context);
    } else {
      appSnackBarWidget(
          title: 'Error', message: 'Given Otp Invalid Or Expired');
    }
  }

//*********************************************signin with email and password *******************************************
  bool isLoginLoading = false;
  Future<void> signInWithEmailAndPasswords(BuildContext ctx) async {
    isLoginLoading = true;
    update();
    try {
      UserCredential credential = await AuthServices.signIN(
          emailController.text, passwordController.text);
      if (credential.user != null) {
        loginClear();
        return Get.offAll(() => const HomeScreen(),
            curve: Curves.ease,
            duration: const Duration(milliseconds: 400),
            transition: Transition.zoom);
      } else {
        appSnackBarWidget(
            title: 'Error', message: 'Login Failed , Try again later');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        appSnackBarWidget(
            title: 'Error', message: 'Login credential is incorrect');
      } else {
        appSnackBarWidget(
            title: 'Error', message: 'Something Went Wrong , Try again later');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoginLoading = false;
      update();
    }
  }

  //*********************************************forgot password ***************************************

  bool isForgotLoading = false;
  Future<void> forgotPassword(context) async {
    isForgotLoading = true;
    update();
    try {
      AuthServices.forgotPassword(emailController.text).then((value) {
        emailController.clear();
      });

      appSnackBarWidget(title: 'Success', message: 'Check Your Email Inbox');
    } catch (e) {
      log(e.toString());
    } finally {
      isForgotLoading = false;
      update();
    }
  }

//----------------------------------------Delete account-----------------------------------------------------
  Future<void> deleteAccount(context) async {
    try {
      log('CALLED DELETE ACCOUNT ');
      bool status = await AuthServices.deleteUserAccount();
      if (status) {
        await UserFirestoreRes().deleteUserCollection();
        Get.offAll(() => const LandingScreen(),
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 400),
            transition: Transition.zoom);
      } else {
        appSnackBarWidget(
          title: 'Error',
          message:
              'Just Now You Create Account .\nLog in again before retrying this request.',
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
