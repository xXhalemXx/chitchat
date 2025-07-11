import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneralAppBar extends StatelessWidget {
  const GeneralAppBar(
      {super.key, required this.title, required this.onTap, this.rightWidget});
  final String title;
  final VoidCallback onTap;
  final Widget? rightWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.white.withValues(alpha: 0.2)),
              child: Center(
                child: SvgPicture.asset(
                  Assets.assetsImagesSvgsSearch,
                  width: 22.w,
                  height: 22.h,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: AppTextStyles.poppinsFont20White100Medium1,
          ),
          SizedBox(
            width: 44.w,
            height: 44.h,
            child: rightWidget ?? const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
