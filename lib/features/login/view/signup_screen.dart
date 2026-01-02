import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:goverment_online/utils/extension/sized_box_extension.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/navigation/app_routes.dart';
import '../../../utils/themes/app_text_style.dart';
import '../../../utils/widgets/custom_text_fieldform_widget/custom_text_fieldform_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 100, left: 22, right: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.height,
            Center(
              child: Text(
                "Sign Up",
                style: AppTextStyle.headingStyle.copyWith(
                  fontSize: 32,
                  color: AppColors.black,
                ),
              ),
            ),
            10.height,
            Center(
              child: RichText(
                text: TextSpan(
                  text: "Already have an account? ",
                  style: AppTextStyle.bodyStyle.copyWith(
                    color: AppColors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "Log In",
                      style: AppTextStyle.bodyStyle.copyWith(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.pop(AppRoutes.loginScreen);
                        },
                    ),
                  ],
                ),
              ),
            ),
            40.height,
            Text(
              "Email",
              style: AppTextStyle.labelStyle,
            ),
            4.height,
            CustomTextField(
              hintText: "Enter Email",
              keyboardType: TextInputType.emailAddress,
            ),

            20.height,
            Text(
              "Password",
              style: AppTextStyle.labelStyle,
            ),
            4.height,
            CustomTextField(
              hintText: "Enter Password",
              keyboardType: TextInputType.visiblePassword,
            ),

            20.height,
            Text(
              "Confirm Password",
              style: AppTextStyle.labelStyle,
            ),
            4.height,
            CustomTextField(
              hintText: "Confirm Password",
              keyboardType: TextInputType.visiblePassword,
            ),

            20.height,
            Text(
              "Address",
              style: AppTextStyle.labelStyle,
            ),
            4.height,
            CustomTextField(
              hintText: "Enter Address",
              keyboardType: TextInputType.text,
            ),

            40.height,

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttoncolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Registration",
                  style: AppTextStyle.buttonTextStyle.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
