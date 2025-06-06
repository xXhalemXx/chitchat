import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/widgets/app_bar_for_dark_background.dart';
import 'package:chitchat/src/core/widgets/general_background_wrapper.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/onboarding_widgets/header_text.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/general_widgets/or_with_lines.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/general_widgets/social_media_buttons.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/onboarding_widgets/sign_up_button.dart';
import 'package:flutter/material.dart';

import '../widgets/onboarding_widgets/login_text.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForDarkBackground(),
      extendBodyBehindAppBar: true,
      body: GeneralBackgroundWrapper(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(70),
              const HeaderText(),
              verticalSpace(30),
              SocialMediaButtons(
                backgroundColor: AppColor.white.withValues(alpha: 0.19),
                leftPadding: 66,
              ),
              verticalSpace(30),
              OrWithLines(
                textStyle: AppTextStyles.poppinsFont14White100Black1,
              ),
              verticalSpace(35),
              const SignUpButton(),
              verticalSpace(30),
              const LoginText(),
              verticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
