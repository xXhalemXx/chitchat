import 'package:chitchat/src/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButton extends StatelessWidget {
  final double? borderRadius;
  final Color? backgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? buttonWidth;
  final double? buttonHeight;
  final String buttonText;
  final TextStyle textStyle;
  final VoidCallback onPressed;
  const AppTextButton({
    super.key,
    this.borderRadius,
    this.backgroundColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.buttonHeight,
    this.buttonWidth,
    required this.buttonText,
    required this.textStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: Container(
        width: buttonWidth ?? double.maxFinite,
        height: buttonHeight ?? 48.h,
        decoration: BoxDecoration(
          gradient: backgroundColor == null
              ? LinearGradient(
                  colors: [AppColor.black, AppColor.darkBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.0.r),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
        child: Center(
          child: Text(
            buttonText,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      onPressed: () {},
      child: Container(
          width: double.maxFinite,
          height: 48.h,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.black, AppColor.darkBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0.r),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: Center(
            child: SizedBox(
              width: 25.w,
              child: CircularProgressIndicator(
                color: AppColor.white,
              ),
            ),
          )),
    );
  }
}
