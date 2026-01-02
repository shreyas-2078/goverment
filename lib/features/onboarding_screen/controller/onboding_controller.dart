import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Onboarding Controller
class OnboardingController extends GetxController {
  int currentPage = 0;  // no Rx

  final PageController pageController = PageController();

  void nextPage() {
    if (currentPage < 3) {
      currentPage++;
      update();  // notify GetBuilder
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipToLast() {
    currentPage = 3;
    update(); // notify GetBuilder
    pageController.animateToPage(
      3,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
