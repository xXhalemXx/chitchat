import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/models/user_data.dart';
import 'package:chitchat/src/features/home/presentation/cubit/messages_cubit/messages_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/user_circle_avatar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/chat_header.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/status_circles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessagesCubit, MessagesState>(
      builder: (context, state) {
        return Column(
          children: [
            verticalSpace(60.h),
            GeneralAppBar(
              title: 'Home',
              onTap: () async {
                getIt<MessagesCubit>().showSearchDelegate(context: context);
              },
              rightWidget: UserCircleAvatar(
                userPhoto: UserData.currentUser!.photo,
              ),
            ),
            verticalSpace(30.h),
            const StatusCircles(),
            verticalSpace(30.h),
            GeneralHomeBody(
              body: ChatHeaders(
                users: state.usersHaveChatWith,
              ),
            ),
          ],
        );
      },
    );
  }
}
