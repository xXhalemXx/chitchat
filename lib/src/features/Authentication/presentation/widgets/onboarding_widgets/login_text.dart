import 'package:chitchat/src/core/constants/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 80.0.w),
      child: RichText(
          text: TextSpan(
              text: 'Existing account?',
              style: AppTextStyles.poppinsFont14White100Regular1,
              children: [
            TextSpan(
                text: ' Log in',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushNamed(context, '/login');
                  },
                style: AppTextStyles.poppinsFont14White100Bold1)
          ])),
    );
  }
}
