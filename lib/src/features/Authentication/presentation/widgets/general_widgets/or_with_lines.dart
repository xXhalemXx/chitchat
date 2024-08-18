import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrWithLines extends StatelessWidget {
  OrWithLines({super.key, required this.textStyle});
  TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15.h,
      width: 315.w,
      child: Row(children: [
        Expanded(
            child: Divider(
          thickness: textStyle.color == AppColor.gray ? 0.55.h : 0.15.h,
          color: textStyle.color == AppColor.gray
              ? AppColor.lightGray
              : AppColor.white,
        )),
        horizontalSpace(15.w),
        Text('OR', style: textStyle),
        horizontalSpace(15.w),
        Expanded(
            child: Divider(
          thickness: textStyle.color == AppColor.gray ? 0.55.h : 0.15.h,
          color: textStyle.color == AppColor.gray
              ? AppColor.lightGray
              : AppColor.white,
        )),
      ]),
    );
  }
}
