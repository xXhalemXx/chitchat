import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        "Forgot password?",
        style: AppTextStyles.poppinsFont14DarkBlue100Medium1,
      ),
    );
  }
}
