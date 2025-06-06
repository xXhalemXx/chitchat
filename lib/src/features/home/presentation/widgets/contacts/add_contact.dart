import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddContact extends StatelessWidget {
  const AddContact({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 44.w,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.white.withValues(alpha: 0.2)),
        child: Center(
          child: SvgPicture.asset(
            Assets.assetsImagesSvgsNewContact,
            width: 22.w,
            height: 22.h,
          ),
        ),
      ),
    );
  }
}
