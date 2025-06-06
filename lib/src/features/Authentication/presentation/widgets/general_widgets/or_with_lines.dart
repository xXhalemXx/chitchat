import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrWithLines extends StatelessWidget {
  const OrWithLines({super.key, required this.textStyle});
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 315.w,
      child: Row(children: [
        Expanded(
            child: Divider(
          thickness: 1.h,
          color: textStyle.color == AppColor.gray
              ? AppColor.lighterGray
              : AppColor.white,
        )),
        horizontalSpace(15),
        Text('OR', style: textStyle),
        horizontalSpace(15),
        Expanded(
            child: Divider(
          thickness: 1.h,
          color: textStyle.color == AppColor.gray
              ? AppColor.lighterGray
              : AppColor.white,
        )),
      ]),
    );
  }
}
