import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:chitchat/src/core/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailAndPassword extends StatelessWidget {
  const EmailAndPassword({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
      child: Form(
        key: getIt<AuthCubit>().loginFormKey,
        child: Column(
          children: [
            AppTextFormField(
              hintText: 'Your email',
              validator: (value) {
                return getIt<AuthCubit>().emailValidator(value);
              },
              controller: getIt<AuthCubit>().loginEmailController,
            ),
            verticalSpace(30),
            AppTextFormField(
              hintText: 'password',
              validator: (value) {
                return getIt<AuthCubit>().passwordValidator(value);
              },
              isObscureText: true,
              controller: getIt<AuthCubit>().loginPasswordController,
            ),
          ],
        ),
      ),
    );
  }
}
