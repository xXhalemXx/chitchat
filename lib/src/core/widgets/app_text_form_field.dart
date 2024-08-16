import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hintText, style: AppTextStyles.poppinsFont14DarkBlue100Medium1),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(horizontal: 0.w, vertical: 17.h),
            hintStyle:
                hintStyle ?? AppTextStyles.poppinsFont14DarkBlue100Medium1,
            suffixIcon: suffixIcon,
            fillColor: backgroundColor ?? AppColor.white,
            filled: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.lightGray, width: 1.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.lightGray, width: 1.0),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
            ),
          ),
          obscureText: isObscureText ?? false,
          style: AppTextStyles.poppinsFont16Black100Regular1,
          validator: (value) {
            return validator(value);
          },
        ),
      ],
    );
  }
}
