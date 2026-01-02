import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTextStyle {
  const AppTextStyle._();

  ///Font family
  static const String fontFamily = "Figtree";
  static TextStyle regularTextStyle = const TextStyle(fontFamily: 'Figtree');

  static TextStyle veryLargeHeader = const TextStyle(
    color: AppColors.black,
    fontSize: 24.0,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static TextStyle largeHeader = const TextStyle(
    color: AppColors.black,
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static TextStyle mediumHeader = const TextStyle(
    color: AppColors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  static TextStyle smallHeader = const TextStyle(
    color: AppColors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
  );

  static TextStyle largeNormalText = const TextStyle(
    color: AppColors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static TextStyle mediumNormalText = const TextStyle(
    color: AppColors.black,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static TextStyle smallNormalText = const TextStyle(
    color: AppColors.black,
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static TextStyle hintStyle = const TextStyle(
    color: AppColors.hintTextColor,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bodyStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static TextStyle labelStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );
}
