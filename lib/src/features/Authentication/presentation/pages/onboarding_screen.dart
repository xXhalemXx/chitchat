import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/widgets/common_button.dart';
import 'package:chitchat/src/features/login/presentation/widgets/onboarding_widgets/header_text.dart';
import 'package:chitchat/src/features/login/presentation/widgets/general_widgets/or_with_lines.dart';
import 'package:chitchat/src/features/login/presentation/widgets/general_widgets/social_media_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/onboarding_widgets/login_text.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: boxDecorationFun(),
        child: Padding(
          padding: EdgeInsets.only(left: 26.0.w, top: 70.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderText(),
              verticalSpace(38.h),
              Padding(
                padding: EdgeInsets.only(left: 66.0.w),
                child: SocialMediaButtons(
                  backgroundColor: AppColor.white.withOpacity(0.19),
                ),
              ),
              verticalSpace(30.h),
              OrWithLines(
                textStyle: AppTextStyles.poppinsFont14White100Black1,
              ),
              verticalSpace(30.h),
              AppTextButton(
                  buttonWidth: 320.w,
                  buttonHeight: 48.h,
                  backgroundColor: AppColor.white.withOpacity(0.37),
                  buttonText: 'Sign up within mail',
                  textStyle: AppTextStyles.poppinsFont16White100Medium1,
                  onPressed: () {
                    Navigator.pushNamed(context, "/sign_up");
                  }),
              verticalSpace(46.h),
              const LoginText()
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration boxDecorationFun() {
    return const BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover),
    );
  }
}
