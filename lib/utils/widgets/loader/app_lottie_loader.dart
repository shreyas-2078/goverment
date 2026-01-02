import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class AppLottieLoader extends StatelessWidget {
  const AppLottieLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter:
          const ColorFilter.mode(AppColors.parentBgColor, BlendMode.srcIn),
     
    );
  }
}
