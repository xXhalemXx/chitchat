import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/core/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      buttonWidth: 320.w,
      buttonHeight: 48.h,
      backgroundColor: AppColor.white.withOpacity(0.37),
      buttonText: 'Sign up within mail',
      textStyle: AppTextStyles.poppinsFont16White100Medium1,
      onPressed: () {
        Navigator.pushNamed(context, "/sign_up");
      },
    );
  }
}
