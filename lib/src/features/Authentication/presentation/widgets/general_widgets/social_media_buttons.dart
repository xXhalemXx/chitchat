import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
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
          socialElement(
              svgName: 'assets/images/svgs/facebook.svg',
              onTap: () {
                comingSoonSnakeBar(context, 'facebook');
              }),
          socialElement(
              svgName: 'assets/images/svgs/google.svg',
              onTap: () {
                getIt<AuthCubit>().signInWithGoogle();
              }),
          socialElement(
              svgName: backgroundColor == AppColor.white
                  ? 'assets/images/svgs/apple_black.svg'
                  : 'assets/images/svgs/apple.svg',
              onTap: () {
                comingSoonSnakeBar(context, 'apple');
              }),
        ],
      ),
    );
  }

  socialElement({required String svgName, required Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }

  comingSoonSnakeBar(BuildContext context, String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Coming soon",
          style: type == 'facebook'
              ? AppTextStyles.poppinsFont14White100Bold1
              : AppTextStyles.poppinsFont14DarkBlue100Bold1,
          textAlign: TextAlign.center,
        ),
        backgroundColor:
            type == 'facebook' ? AppColor.darkBlue : AppColor.white,
        duration: Duration(seconds: 1),
      ),
    );
  }
}
