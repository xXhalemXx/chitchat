import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/onboarding_widgets/header_text.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/general_widgets/or_with_lines.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/general_widgets/social_media_buttons.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/onboarding_widgets/sign_up_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/onboarding_widgets/login_text.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: _boxDecorationFun(),
        child: Padding(
          padding: EdgeInsets.only(left: 26.0.w, top: 70.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderText(),
              verticalSpace(38.h),
              SocialMediaButtons(
                backgroundColor: AppColor.white.withOpacity(0.19),
                leftPadding: 66,
              ),
              verticalSpace(30.h),
              OrWithLines(
                textStyle: AppTextStyles.poppinsFont14White100Black1,
              ),
              verticalSpace(30.h),
              const SignUpButton(),
              verticalSpace(25.h),
              const LoginText()
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecorationFun() {
    return const BoxDecoration(
      image: DecorationImage(
          image: AssetImage(Assets.assetsImagesSplashBackground),
          fit: BoxFit.cover),
    );
  }
}
