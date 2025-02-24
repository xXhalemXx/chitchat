import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons(
      {super.key, required this.backgroundColor, this.leftPadding});
  final Color backgroundColor;
  final double? leftPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding ?? 0.w),
      child: SizedBox(
        height: 48.h,
        width: 185.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            socialElement(
                svgName: Assets.assetsImagesSvgsFacebook,
                onTap: () {
                  comingSoonSnakeBar(context, 'facebook');
                }),
            socialElement(
                svgName: Assets.assetsImagesSvgsGoogle,
                onTap: () {
                  getIt<AuthCubit>().signInWithGoogle(context: context);
                }),
            socialElement(
                svgName: backgroundColor == AppColor.white
                    ? Assets.assetsImagesSvgsAppleBlack
                    : Assets.assetsImagesSvgsApple,
                onTap: () {
                  comingSoonSnakeBar(context, 'apple');
                }),
          ],
        ),
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
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
