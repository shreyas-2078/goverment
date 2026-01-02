import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goverment_online/utils/extension/sized_box_extension.dart';
import '../../constants/app_colors.dart';
import '../../constants/local_storage_key_strings.dart';
import '../../themes/app_text_style.dart';
import '../buttons/primary_elevated_button.dart';
import 'package:go_router/go_router.dart';

class DataNotFoundButtonWidget extends StatelessWidget {
  final bool buttonActive;
  final String? title;
  const DataNotFoundButtonWidget({super.key, this.buttonActive = true, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/marketing_no_data_found.svg",
            colorFilter: const ColorFilter.mode(
              AppColors.parentBgColor,
              BlendMode.srcIn,
            ),
          ),
          10.height,
          Text(
           title ?? "No Data Available",
            style: AppTextStyle.mediumNormalText.copyWith(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          10.height,
          Column(
            children: [
              Icon(
                Icons.search_off,
                size: 64,
                color: AppColors.textGrayColor.withOpacity(0.5),
              ),
              8.height,
              Text(
                "No information is found ",
                style: AppTextStyle.mediumNormalText.copyWith(
                    color: AppColors.textGrayColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                    ),
              ),
              8.height,
              Text(
                'Try searching with different keywords',
                style: AppTextStyle.hintStyle.copyWith(
                    color: AppColors.textGrayColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600
                    ),
              ),
            ],
          ),
          20.height,
          if (buttonActive)
            PrimaryElevatedButton(
              label: "Go To DashBoard",
              buttonColor: AppColors.parentBgColor,
              onPressed: () {
                LocalStorageKeyStrings.appNavKey.currentContext?.pop();
              },
            ),
        ],
      ),
    );
  }
}
