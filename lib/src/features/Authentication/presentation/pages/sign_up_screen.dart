import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/Authentication/presentation/cubit/auth_cubit.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/general_widgets/general_app_bar.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/sign_up_widgets/create_account_button.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/sign_up_widgets/name_email_and_password.dart';
import 'package:chitchat/src/features/Authentication/presentation/widgets/sign_up_widgets/sign_up_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: const GeneralAppBar(),
        body: PopScope(
          onPopInvokedWithResult: (didPop, _) {
            getIt.resetLazySingleton<AuthCubit>();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpace(30.h),
                  const SignUpHeaderText(),
                  verticalSpace(60.h),
                  const NameEmailAndPassword(),
                  verticalSpace(120.h),
                  const CreateAccountButton(),
                  verticalSpace(30.h),
                ],
              ),
            ),
          ),
        ));
  }
}
