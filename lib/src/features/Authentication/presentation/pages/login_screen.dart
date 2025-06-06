import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/general_widgets/or_with_lines.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/login_widgets/email_and_password.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/login_widgets/forgot_password.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/general_widgets/general_app_bar.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/login_widgets/login_button.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/login_widgets/login_header.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/general_widgets/social_media_buttons.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: const GeneralAppBar(),
        body: PopScope(
          onPopInvokedWithResult: (_, __) {
            getIt.resetLazySingleton<AuthCubit>();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(30),
                const LoginHeader(),
                verticalSpace(25),
                SocialMediaButtons(backgroundColor: AppColor.white),
                verticalSpace(30),
                OrWithLines(
                  textStyle: AppTextStyles.poppinsFont14Gray100Black1,
                ),
                verticalSpace(30),
                const EmailAndPassword(),
                verticalSpace(170),
                const LoginButton(),
                verticalSpace(15),
                const ForgotPassword(),
                verticalSpace(20),
              ],
            ),
          ),
        ));
  }
}
