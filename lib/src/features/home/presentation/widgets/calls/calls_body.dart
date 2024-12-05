import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/call_details.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/new_call.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallsBody extends StatelessWidget {
  const CallsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        verticalSpace(60.h),
        GeneralHomeBar(
          title: 'Calls',
          onTap: () {},
          rightWidget: const NewCall(),
        ),
        verticalSpace(30.h),
        const GeneralHomeBody(
          body: CallDetails(),
          header: 'Recent',
        ),
      ],
    );
  }
}