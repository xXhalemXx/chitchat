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
            shape: BoxShape.circle, color: AppColor.white.withOpacity(0.2)),
        child: Center(
          child: SvgPicture.asset(
            'assets/images/svgs/new_contact.svg',
            width: 22.w,
            height: 22.h,
          ),
        ),
      ),
    );
  }
}
