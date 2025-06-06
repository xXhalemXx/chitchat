import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:chitchat/src/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';

class NameEmailAndPassword extends StatelessWidget {
  const NameEmailAndPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: getIt<AuthCubit>().signUpFormKey,
      child: Column(
        children: [
          AppTextFormField(
              controller: getIt<AuthCubit>().signUpNameController,
              hintText: 'Your name',
              validator: (value) {
                return getIt<AuthCubit>().nameValidator(value);
              }),
          verticalSpace(30),
          AppTextFormField(
              controller: getIt<AuthCubit>().signUpEmailController,
              hintText: 'Your email',
              validator: (value) {
                return getIt<AuthCubit>().emailValidator(value);
              }),
          verticalSpace(30),
          AppTextFormField(
            controller: getIt<AuthCubit>().signUpPasswordController,
            hintText: 'password',
            validator: (value) {
              return getIt<AuthCubit>().passwordValidator(value);
            },
            isObscureText: true,
          ),
          verticalSpace(30),
          AppTextFormField(
            controller: getIt<AuthCubit>().signUpConfirmPasswordController,
            hintText: 'confirm password',
            validator: (value) {
              return getIt<AuthCubit>().conformPasswordValidator(
                  getIt<AuthCubit>().signUpPasswordController.text, value);
            },
            isObscureText: true,
          ),
        ],
      ),
    );
  }
}
