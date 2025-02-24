import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/general_home_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/chat_header.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/status_circles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagesBody extends StatelessWidget {
  const MessagesBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is HomeLoadedMassagesPage,
      builder: (context, state) {
        return Column(
          children: [
            verticalSpace(60.h),
            GeneralAppBar(
              title: 'Home',
              onTap: () async {
                getIt<HomeCubit>().showSearchDelegate(context: context);
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
                  // dead state screen rebuild only if state HomeLoadedMassagesPage
                  : const Center(child: SizedBox.shrink()),
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
          ? const AssetImage(Assets.assetsImagesNoProfilePic)
          : CachedNetworkImageProvider(userPhoto) as ImageProvider,
    );
  }
}
