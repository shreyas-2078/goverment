import 'package:flutter/widgets.dart';
import 'package:goverment_online/utils/extension/sized_box_extension.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/themes/app_text_style.dart';

class OnboardingPagewidget extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool isLastPage;

  const OnboardingPagewidget({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
    this.isLastPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.asset(image)],
              ),
            ],
          ),

          40.height,

          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyle.hintStyle.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              height: 1.1,
            ),
          ),

          16.height,

          Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyle.hintStyle.copyWith(
              fontSize: 12,
              color: AppColors.textGreyColor,
              height: 1,
            ),
          ),

          40.height,
        ],
      ),
    );
  }
}
