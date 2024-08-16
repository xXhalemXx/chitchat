import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/widgets/common_button.dart';
import 'package:chitchat/src/features/login/presentation/widgets/genral_widgets/or_with_lines.dart';
import 'package:chitchat/src/features/login/presentation/widgets/login_widgets/email_and_password.dart';
import 'package:chitchat/src/features/login/presentation/widgets/login_widgets/forgot_password.dart';
import 'package:chitchat/src/features/login/presentation/widgets/login_widgets/login_app_bar.dart';
import 'package:chitchat/src/features/login/presentation/widgets/login_widgets/login_header.dart';
import 'package:chitchat/src/features/login/presentation/widgets/genral_widgets/social_media_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: const LoginAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(60.h),
              const LoginHeader(),
              verticalSpace(30.h),
              SocialMediaButtons(
                  onPressed: () {}, backgroundColor: AppColor.white),
              verticalSpace(30.h),
              OrWithLines(
                textStyle: AppTextStyles.poppinsFont14Gray100Black1,
              ),
              verticalSpace(30.h),
              EmailAndPassword(),
              verticalSpace(170.h),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                child: AppTextButton(
                  buttonText: 'Log in',
                  textStyle: AppTextStyles.poppinsFont16White100Bold1,
                  onPressed: () {},
                ),
              ),
              verticalSpace(15.h),
              ForgotPassword(),
            ],
          ),
        ));
  }
}
