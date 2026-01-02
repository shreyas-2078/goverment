import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/themes/app_text_style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final InputBorder? border;
  final bool isPassword;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final AutovalidateMode? autovalidateMode;
  final bool obscureText;
  final FocusNode? focusNode;
  final int? maxLines;
  final bool expands;
  final bool? readOnly;
  final String? hintText;
  final Color? hintTextColor;
  final VoidCallback? onTap;
  final int? maxLength;
  final bool lettersOnly;
  final bool removeBorder;

  const CustomTextField({
    super.key,
    this.border,
    this.controller,
    this.isPassword = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.autovalidateMode,
    this.obscureText = true,
    this.focusNode,
    this.maxLines = 1,
    this.expands = false,
    this.readOnly,
    this.hintText,
    this.hintTextColor,
    this.onTap,
    this.maxLength,
    this.lettersOnly = false,
    this.prefixIcon,
    this.removeBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      inputFormatters: [
        if (lettersOnly)
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')), 
        ...?inputFormatters,
      ],
      autovalidateMode: autovalidateMode,
      validator: validator,
      obscureText: isPassword ? obscureText : false,
      keyboardType: keyboardType,
      style: AppTextStyle.mediumNormalText.copyWith(
        color: AppColors.textGrayColor,
        fontSize: 16,
      ),
      onChanged: onChanged,
      maxLines: isPassword ? 1 : maxLines,
      expands: expands,
      focusNode: focusNode,
      maxLength: maxLength,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText ?? "",
        hintStyle: AppTextStyle.mediumNormalText.copyWith(
          color: hintTextColor ?? AppColors.textGreyColor,
          fontSize: 14,
        ),
        isDense: removeBorder ? true : false,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: removeBorder ? 12 : 5,
        ),
        border: removeBorder ? InputBorder.none : null,
        enabledBorder: removeBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
        focusedBorder: removeBorder
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColors.blueSkyColor, width: 1.5),
              ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        counterText: "",
      ),
      onTap: onTap,
    );
  }
}
