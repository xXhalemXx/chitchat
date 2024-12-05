import 'package:chitchat/src/core/config/injection.dart';
import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/core/widgets/common_button.dart';
import 'package:chitchat/src/core/widgets/error_dialog.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return Padding(
              padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
              child: const LoadingButton());
        } else {
          return Padding(
            padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
            child: AppTextButton(
              buttonText: 'Log in',
              textStyle: AppTextStyles.poppinsFont16White100Bold1,
              onPressed: () {
                getIt<AuthCubit>().loginWithEmailAndPassword(context: context);
              },
            ),
          );
        }
      },
    );
  }
}
