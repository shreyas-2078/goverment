import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goverment_online/utils/constants/app_images.dart';
import 'package:goverment_online/utils/extension/sized_box_extension.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/themes/app_text_style.dart';
import '../widget/action_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.absentColor,
                        ),
                        10.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back,",
                              style: AppTextStyle.hintStyle.copyWith(
                                fontSize: 12,
                                color: AppColors.textGreyColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Alex Johnson",
                              style: AppTextStyle.hintStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SvgPicture.asset(AppImages.callIcon, height: 40, width: 40),
                  ],
                ),

                28.height,

                25.height,

                Text(
                  "Quick Action",
                  style: AppTextStyle.hintStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),

                12.height,

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ActionCard(
                        title: "Raise Issue",
                        image: AppImages.raiseIssueIcon,
                        onTap: () {},
                      ),
                      12.width,
                      ActionCard(
                        title: "Complaints",
                        image: AppImages.ticketIcon,
                        onTap: () {},
                      ),
                      12.width,
                      ActionCard(
                        title: "Notices",
                        image: AppImages.soundIcon,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
