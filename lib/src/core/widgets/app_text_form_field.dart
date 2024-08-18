import 'package:chitchat/src/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatefulWidget {
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
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.hintText,
            style: isValid
                ? AppTextStyles.poppinsFont14DarkBlue100Medium1
                : AppTextStyles.poppinsFont14Red100Medium1),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: widget.contentPadding ??
                EdgeInsets.symmetric(horizontal: 0.w, vertical: 17.h),
            hintStyle: widget.hintStyle ??
                AppTextStyles.poppinsFont14DarkBlue100Medium1,
            suffixIcon: widget.suffixIcon,
            fillColor: widget.backgroundColor ?? AppColor.white,
            filled: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.lightGray, width: 1.0),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.lightGray, width: 1.0),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.red, width: 2.0),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.red, width: 2.0),
            ),
            errorStyle: AppTextStyles.poppinsFont12Red100light1,
          ),
          obscureText: widget.isObscureText ?? false,
          style: AppTextStyles.poppinsFont16Black100Regular1,
          validator: (value) {
            if (widget.validator(value) == null ||
                widget.validator(value) == "") {
              setState(() {
                isValid = true;
              });
              return null;
            } else {
              setState(() {
                isValid = false;
              });
              return widget.validator(value);
            }
          },
        ),
      ],
    );
  }
}
