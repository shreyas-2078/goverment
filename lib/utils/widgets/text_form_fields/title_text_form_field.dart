import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goverment_online/utils/extension/sized_box_extension.dart';
import '../../constants/app_colors.dart';
import '../../themes/app_text_style.dart';

class TitleTextFormField extends StatelessWidget {
  final String? title;
  final bool? isStarTitleRequired;
  final bool? isOptional;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final Color? borderColor;
  final String? hintText;
  final void Function()? onTap;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputBorder? border;
  final bool? obscureText;
  final TextStyle? usertextStyle;
  final TextStyle? errorTextstyle;
  final bool? readOnly;
  final int? maxLines;
  final bool showCalenderIcon;
  final Color? hintTextColor;

  const TitleTextFormField({
    super.key,
    this.inputFormatters,
    this.validator,
    this.contentPadding,
    this.borderColor,
    this.hintText,
    this.onTap,
    this.onChanged,
    this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.border,
    this.obscureText,
    this.title,
    this.isStarTitleRequired = false,
    this.isOptional = false,
    this.usertextStyle,
    this.errorTextstyle,
    this.readOnly,
    this.maxLines,
    this.showCalenderIcon = false,
    this.hintTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: borderColor ?? AppColors.textGreyColor),
    );
    final OutlineInputBorder redBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.redColor),

    );
    final InputDecoration inputDecoration = InputDecoration(
        contentPadding: const EdgeInsets.all(10.0),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        errorBorder: redBorder,
        focusedBorder: outlineInputBorder,
        errorMaxLines: 1,
        focusedErrorBorder: redBorder,
        suffixIcon: showCalenderIcon
            ? IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.grey),
                onPressed: onTap,
              )
            : null,
        hintText: hintText ?? "Write here...",
        hintStyle: AppTextStyle.largeNormalText.copyWith(
            fontWeight: FontWeight.w400,
            color: hintTextColor ?? AppColors.textGreyColor));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (isStarTitleRequired ?? false)
              Text("* ",
                  style: AppTextStyle.largeNormalText
                      .copyWith(color: AppColors.redColorDark)),
            Text(
              title ?? "",
              style: AppTextStyle.mediumNormalText
                  .copyWith(color: AppColors.textGreyColor),
            ),
            if (isOptional ?? false)
              Text(
                " (Optional)",
                style: AppTextStyle.mediumNormalText
                    .copyWith(color: AppColors.textGreyColor),
              )
          ],
        ),
        8.height,
        TextFormField(
          readOnly: readOnly ?? false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: maxLines ?? 1,
          inputFormatters: inputFormatters ??
              [FilteringTextInputFormatter.deny(RegExp(r'^\s+'))],
          controller: controller,
          validator: validator,
          obscureText: obscureText ?? false,
          cursorColor: AppColors.parentBgColor,
          cursorErrorColor: AppColors.parentBgColor,

          /// onTap: onTap,
          onChanged: onChanged,
          keyboardType: keyboardType,
          style: usertextStyle ??
              AppTextStyle.mediumHeader.copyWith(
                  color: hintTextColor ?? AppColors.white, fontSize: 14),
          decoration: inputDecoration,
        ),

        /// const SizedBox(height: 16),
      ],
    );
  }
}
