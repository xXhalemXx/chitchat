import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/chat_header.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/status_circles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagesBody extends StatelessWidget {
  const MessagesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(60.h),
        GeneralHomeBar(
          title: 'Home',
          onTap: () {
            getIt<HomeCubit>().getAllUsers();
          },
          rightWidget: _circleAvatar(),
        ),
        verticalSpace(30.h),
        const StatusCircles(),
        verticalSpace(30.h),
        const GeneralHomeBody(
          body: ChatHeader(),
        ),
      ],
    );
  }

  Widget _circleAvatar() {
    return CircleAvatar(
      child: Image.asset('assets/images/person_1.png'),
    );
  }
}
