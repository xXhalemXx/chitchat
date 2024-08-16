import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpHeaderText extends StatelessWidget {
  const SignUpHeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Sign up with Email',
            style: AppTextStyles.poppinsFont18DarkBlue100Bold1),
        verticalSpace(20.h),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 293.w,
            child: Text(
                'Get chatting with friends and family today by signing up for our chat app!',
                textAlign: TextAlign.center,
                style: AppTextStyles.poppinsFont14Gray100light1_4),
          ),
        ),
      ],
    );
  }
}
