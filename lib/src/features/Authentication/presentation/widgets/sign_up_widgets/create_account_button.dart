import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/text_style.dart';
import 'package:chitchat/src/core/widgets/common_button.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (_, state) {
      if (state is AuthLoading) {
        return const LoadingButton();
      } else {
        return AppTextButton(
          buttonText: 'Create an account',
          textStyle: AppTextStyles.poppinsFont16White100Bold1,
          onPressed: () {
            getIt<AuthCubit>().registerUsingEmailAndPassword(context: context);
          },
        );
      }
    });
  }
}
