import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:goverment_online/utils/constants/app_colors.dart';
import 'package:goverment_online/utils/extension/sized_box_extension.dart';
import 'package:goverment_online/utils/themes/app_text_style.dart';


class ActionCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// SVG image (already styled)
            SvgPicture.asset(
              image,
              height: 48,
              width: 48,
              fit: BoxFit.contain,
            ),

            12.height,

            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyle.hintStyle.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
