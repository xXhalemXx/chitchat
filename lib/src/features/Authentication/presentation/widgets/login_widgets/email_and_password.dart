import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/helpers/validators.dart';
import 'package:chitchat/src/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailAndPassword extends StatelessWidget {
  const EmailAndPassword(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.formKey});
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            AppTextFormField(
              hintText: 'Your email',
              validator: (value) {
                return Validators.emailValidator(value);
              },
              controller: emailController,
            ),
            verticalSpace(30.h),
            AppTextFormField(
              hintText: 'password',
              validator: (value) {
                return Validators.passwordValidator(value);
              },
              isObscureText: true,
              controller: passwordController,
            ),
          ],
        ),
      ),
    );
  }
}
