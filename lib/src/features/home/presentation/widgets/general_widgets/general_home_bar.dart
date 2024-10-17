import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327.w,
      height: 44.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 44.w,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColor.white.withOpacity(0.2)),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/svgs/search.svg',
                width: 22.w,
                height: 22.h,
              ),
            ),
          ),
          Text(
            'Home',
            style: AppTextStyles.poppinsFont20White100Medium1,
          ),
          SizedBox(
            width: 44.w,
            child: CircleAvatar(
              child: Image.asset('assets/images/person_1.png'),
            ),
          )
        ],
      ),
    );
  }
}
