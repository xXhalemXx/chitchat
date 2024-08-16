import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Login to ChitChat',
            style: AppTextStyles.poppinsFont18DarkBlue100Bold1),
        verticalSpace(20.h),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 293.w,
            child: Text(
                'Welcome back! Sign in using your social account or email to continue us',
                textAlign: TextAlign.center,
                style: AppTextStyles.poppinsFont14Gray100light1_4),
          ),
        ),
      ],
    );
  }
}
