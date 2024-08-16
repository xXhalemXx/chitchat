import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/widgets/common_button.dart';
import 'package:chitchat/src/features/login/presentation/widgets/general_widgets/or_with_lines.dart';
import 'package:chitchat/src/features/login/presentation/widgets/login_widgets/email_and_password.dart';
import 'package:chitchat/src/features/login/presentation/widgets/login_widgets/forgot_password.dart';
import 'package:chitchat/src/features/login/presentation/widgets/general_widgets/general_app_bar.dart';
import 'package:chitchat/src/features/login/presentation/widgets/login_widgets/login_header.dart';
import 'package:chitchat/src/features/login/presentation/widgets/general_widgets/social_media_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: const GeneralAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(60.h),
              const LoginHeader(),
              verticalSpace(30.h),
              SocialMediaButtons(backgroundColor: AppColor.white),
              verticalSpace(30.h),
              OrWithLines(
                textStyle: AppTextStyles.poppinsFont14Gray100Black1,
              ),
              verticalSpace(30.h),
              EmailAndPassword(
                emailController: emailController,
                passwordController: passwordController,
                formKey: formKey,
              ),
              verticalSpace(170.h),
              Padding(
                padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                child: AppTextButton(
                  buttonText: 'Log in',
                  textStyle: AppTextStyles.poppinsFont16White100Bold1,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print('worked');
                    } else {
                      print('not worked');
                    }
                  },
                ),
              ),
              verticalSpace(15.h),
              const ForgotPassword(),
              verticalSpace(20.h),
            ],
          ),
        ));
  }
}
