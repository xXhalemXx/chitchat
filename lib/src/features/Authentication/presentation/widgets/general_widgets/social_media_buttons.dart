import 'package:chitchat/src/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({super.key, required this.backgroundColor});
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      width: 185.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          socialElement(svgName: 'assets/images/svgs/facebook.svg'),
          socialElement(svgName: 'assets/images/svgs/google.svg'),
          socialElement(
              svgName: backgroundColor == AppColor.white
                  ? 'assets/images/svgs/apple_black.svg'
                  : 'assets/images/svgs/apple.svg'),
        ],
      ),
    );
  }

  socialElement({required String svgName}) {
    return Container(
      width: 48.w,
      height: 48.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Center(
        child: SvgPicture.asset(
          svgName,
          width: 24.w,
        ),
      ),
    );
  }
}
