import 'package:chitchat/src/core/constants/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
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
        ]));
  }
}
