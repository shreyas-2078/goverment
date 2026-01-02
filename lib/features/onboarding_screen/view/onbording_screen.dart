import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:goverment_online/features/onboarding_screen/widget/OnboardingPagewidget.dart';
import 'package:goverment_online/utils/constants/app_images.dart';
import 'package:goverment_online/utils/extension/sized_box_extension.dart';
import 'package:goverment_online/utils/navigation/app_routes.dart';
import 'package:goverment_online/utils/navigation/route_manager.dart';
import 'package:goverment_online/utils/themes/app_text_style.dart';

import '../../../utils/constants/app_colors.dart';
import '../controller/onboding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            GetBuilder<OnboardingController>(
              builder: (controller) =>
                  (controller.currentPage == 1 || controller.currentPage == 2)
                  ? Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () => controller.nextPage(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.blue),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Skip',
                            style: AppTextStyle.hintStyle.copyWith(
                              color: AppColors.blue,
                            ),
                          ),
                        ),
                      ),
                    )
                  : 56.height,
            ),

            // PageView
            Expanded(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.currentPage = index;
                  controller.update();
                },
                children: [
                  OnboardingPagewidget(
                    image: AppImages.onbordfirst,
                    title: 'Welcome to Citizen\nPortal',
                    description:
                        'Your direct line to city services. Report\n grievances, track status, and improve your \n neighborhood with just a few taps.',
                  ),
                  OnboardingPagewidget(
                    image: AppImages.onbordsecond,
                    title: 'Raise Grievances\nEasily',
                    description:
                        'Report civic issues directly from your phone \n  in seconds. No queues, no paperwork-just \n  quick action.',
                  ),
                  OnboardingPagewidget(
                    image: AppImages.onbordthird,
                    title: 'Track Tickets in\nReal-Time',
                    description:
                        'Never wonder about the status of your report. Get\n  instant notifications and watch your grievance move \n  from "Submitted" to "Resolved" directly from the app.',
                  ),
                  OnboardingPagewidget(
                    image: AppImages.onbordfour,
                    title: 'Empower Your\nCommunity',
                    description:
                        'Report issues, track progress, and stay\n informed in real-time. Lets make our city \n better, together.',
                    isLastPage: true,
                  ),
                ],
              ),
            ),

            // Page Indicator
            GetBuilder<OnboardingController>(
              builder: (controller) =>
                  (controller.currentPage == 1 || controller.currentPage == 2)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        4,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: controller.currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.currentPage == index
                                ? AppColors.blue
                                : AppColors.textGreyColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            24.height,

            // Bottom Buttons
            GetBuilder<OnboardingController>(
              builder: (controller) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: controller.currentPage == 0
                    ? Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => controller.nextPage(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Get Started',
                                style: AppTextStyle.hintStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                          12.height,
                          TextButton(
                            onPressed: () {
                              context.push(AppRoutes.signupscreen);
                            },
                            child: Text(
                              'Create an Account',
                              style: AppTextStyle.hintStyle.copyWith(
                                fontSize: 14,
                                color: AppColors.textGreyColor,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    : controller.currentPage < 3
                    ? SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => controller.nextPage(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Next',
                            style: AppTextStyle.hintStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.snackbar('Info', 'Navigate to Sign Up');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child:  TextButton(
                            onPressed: () {
                              context.push(AppRoutes.signupscreen);
                            },
                            child: Text(
                              'Create an Account',
                              style: AppTextStyle.hintStyle.copyWith(
                                fontSize: 14,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                            ),
                          ),
                          12.height,
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () {
                                context.push(AppRoutes.mainScreen);
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: AppColors.blue),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                'Log In',
                                style: AppTextStyle.hintStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blue,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            16.height,

            // Terms and Privacy (Last page only)
            GetBuilder<OnboardingController>(
              builder: (controller) => controller.currentPage == 3
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text.rich(
                        TextSpan(
                          text: 'By continuing, you agree to our ',
                          style: AppTextStyle.hintStyle.copyWith(
                            fontSize: 12,
                            color: AppColors.textGreyColor,
                          ),
                          children: [
                            TextSpan(
                              text: 'Terms',
                              style: AppTextStyle.hintStyle.copyWith(
                                color: AppColors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: ' & '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: AppTextStyle.hintStyle.copyWith(
                                color: AppColors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : const SizedBox(height: 16),
            ),
          ],
        ),
      ),
    );
  }
}
