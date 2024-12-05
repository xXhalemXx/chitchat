import 'package:chitchat/src/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GeneralHomeBar extends StatelessWidget {
  const GeneralHomeBar(
      {super.key, required this.title, required this.onTap, this.rightWidget});
  final String title;
  final VoidCallback onTap;
  final Widget? rightWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327.w,
      height: 44.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 44.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.white.withOpacity(0.2)),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/svgs/search.svg',
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
            child: rightWidget ?? const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
