import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/chat_header.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/home_search_delegate.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/status_circles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagesBody extends StatelessWidget {
  const MessagesBody({super.key});

  @override
  Widget build(BuildContext context) {
    // getIt<HomeCubit>().loadData();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            verticalSpace(60.h),
            GeneralHomeBar(
              title: 'Home',
              onTap: () async {
                await showSearch(
                  context: context,
                  delegate: HomeSearchDelegate(),
                ).then((_) {
                  getIt<HomeCubit>().loadData();
                });
              },
              rightWidget: _circleAvatar(),
            ),
            verticalSpace(30.h),
            const StatusCircles(),
            verticalSpace(30.h),
            GeneralHomeBody(
              body: (state is HomeLoadedMassagesPage)
                  ? ChatHeaders(
                      users: state.usersHaveChatWith,
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          ],
        );
      },
    );
  }

  Widget _circleAvatar() {
    String userPhoto = getIt<HomeCubit>().currentUser.photo;
    return CircleAvatar(
      backgroundImage: userPhoto == ''
          ? const AssetImage('assets/images/noProfilePic.png')
          : CachedNetworkImageProvider(userPhoto) as ImageProvider,
    );
  }
}
