import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/widgets/common_button.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/general_widgets/general_app_bar.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/sign_up_widgets/name_email_and_password.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/sign_up_widgets/sign_up_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: const GeneralAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpace(30.h),
                const SignUpHeaderText(),
                verticalSpace(60.h),
                NameEmailAndPassword(
                    nameController: nameController,
                    emailController: emailController,
                    passwordController: passwordController,
                    confirmPasswordController: confirmPasswordController,
                    formKey: formKey),
                verticalSpace(120.h),
                AppTextButton(
                  buttonText: 'Create an account',
                  textStyle: AppTextStyles.poppinsFont16White100Bold1,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      print('form is valid');
                    }
                  },
                ),
                verticalSpace(30.h),
              ],
            ),
          ),
        ));
  }
}
