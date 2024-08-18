import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:chitchat/src/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NameEmailAndPassword extends StatelessWidget {
  const NameEmailAndPassword(
      {super.key,
      required this.nameController,
      required this.emailController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.formKey});
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextFormField(
              controller: nameController,
              hintText: 'Your name',
              validator: (value) {
                return getIt<AuthCubit>().nameValidator(value);
              }),
          verticalSpace(30.h),
          AppTextFormField(
              controller: emailController,
              hintText: 'Your email',
              validator: (value) {
                return getIt<AuthCubit>().emailValidator(value);
              }),
          verticalSpace(30.h),
          AppTextFormField(
            controller: passwordController,
            hintText: 'password',
            validator: (value) {
              return getIt<AuthCubit>().passwordValidator(value);
            },
            isObscureText: true,
          ),
          verticalSpace(30.h),
          AppTextFormField(
            controller: confirmPasswordController,
            hintText: 'confirm password',
            validator: (value) {
              if (value == null || value.isEmpty || value == '') {
                return 'You need to fill this field';
              } else {
                if (passwordController.text != confirmPasswordController.text) {
                  return 'passwords do not match';
                } else {
                  return null;
                }
              }
            },
            isObscureText: true,
          ),
        ],
      ),
    );
  }
}
