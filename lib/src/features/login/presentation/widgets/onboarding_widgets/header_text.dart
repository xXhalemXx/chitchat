import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Connect friends easily & quickly',
            style: AppTextStyles.poppinsFont68White100Regular1_14),
        verticalSpace(54.h),
        Text(
            'Our chat app is the perfect way to stay connected with friends and family.',
            style: AppTextStyles.poppinsFont16White50Regular1_6),
      ],
    );
  }
}
