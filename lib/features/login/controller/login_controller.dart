import 'package:flutter/material.dart';

class LoginController {
  final ValueNotifier<bool> isMobileLogin = ValueNotifier(false);
  final ValueNotifier<bool> showOtp = ValueNotifier(false);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());

  void toggleLogin() {
    isMobileLogin.value = !isMobileLogin.value;
    showOtp.value = false;
    emailController.clear();
    passwordController.clear();
    mobileController.clear();
    for (var c in otpControllers) {
      c.clear();
    }
  }

  void onMobileChanged(String value) {
    showOtp.value = value.length == 10;
  }

  String getOtp() {
    return otpControllers.map((e) => e.text).join();
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    mobileController.dispose();
    for (var c in otpControllers) {
      c.dispose();
    }
  }
}
