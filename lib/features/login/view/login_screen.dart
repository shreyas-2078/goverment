import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:goverment_online/utils/navigation/app_routes.dart';
import '../controller/login_controller.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/themes/app_text_style.dart';
import '../../../utils/widgets/custom_text_fieldform_widget/custom_text_fieldform_widget.dart';
import '../../../utils/extension/sized_box_extension.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.only(top: 110,left: 22,right: 22),
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          "Citizen Portal",
                          style: AppTextStyle.hintStyle.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      4.height,
                      Center(
                        child: Text(
                          "Citizen Portal",
                          style: AppTextStyle.hintStyle.copyWith(
                            fontSize: 12,
                            color: AppColors.textGreyColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              60.height,
              ValueListenableBuilder<bool>(
                valueListenable: controller.isMobileLogin,
                builder: (context, isMobile, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isMobile) ...[
                        _label("Email"),
                        10.height,
                        CustomTextField(
                          controller: controller.emailController,
                          hintText: "Enter Email",
                        ),
                        24.height,
                        _label("Password"),
                            10.height,
                        CustomTextField(
                          controller: controller.passwordController,
                          hintText: "Enter Password",
                          obscureText: true,
                        ),
                      ],

                      if (isMobile) ...[
                        _label("Mobile No"),
                            10.height,
                        CustomTextField(
                          controller: controller.mobileController,
                          hintText: "Enter Number",
                          keyboardType: TextInputType.number,
                          maxLength: 10,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: controller.onMobileChanged,
                        ),
                      ],

                      ValueListenableBuilder<bool>(
                        valueListenable: controller.showOtp,
                        builder: (context, showOtp, _) {
                          if (!showOtp) return SizedBox();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              24.height,
                              _label("OTP"),
                              8.height,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(6, (index) {
                                  return SizedBox(
                                    width: 45,
                                    child: TextField(
                                      controller:
                                          controller.otpControllers[index],
                                      maxLength: 1,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.white,
                                           counterText: '',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      onChanged: (value) {
                                        if (value.isNotEmpty && index < 5) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),

              60.height,
              ValueListenableBuilder<bool>(
                valueListenable: controller.isMobileLogin,
                builder: (context, isMobile, _) {
                  return TextButton(
                    onPressed: controller.toggleLogin,
                    child: Text(
                      isMobile
                          ? "Login with Email"
                          : "Login with Mobile number",
                      style: AppTextStyle.hintStyle.copyWith(color: AppColors.blueColor),
                    ),
                  );
                },
              ),

              24.height,
              ValueListenableBuilder<bool>(
                valueListenable: controller.isMobileLogin,
                builder: (context, isMobile, _) {
                  return SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttoncolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (isMobile) {
                          debugPrint("OTP: ${controller.getOtp()}");
                        }
                        context.push(AppRoutes.mainScreen);
                      },
                      child: Text(
                        isMobile ? "Get OTP" : "Log In",
                        style: AppTextStyle.hintStyle.copyWith(fontSize: 16, color: AppColors.white),
                      ),
                    ),
                  );
                },
              ),

              24.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      context.push(AppRoutes.signupscreen);
                    },
                    child: Text(
                      "Sign Up",
                      style: AppTextStyle.hintStyle.copyWith(color: AppColors.blueColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: AppTextStyle.hintStyle.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
      ),
    );
  }
}
