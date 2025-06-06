import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_cubit/outgoing/outgoing_call_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key, required this.receiver});
  final UserModel receiver;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      shadowColor: AppColor.lightestGray,
      backgroundColor: AppColor.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent),
      // leadingWidth: 25,
      titleSpacing: -6,
      actions: [
        GestureDetector(
          onTap: () {
            getIt<OutgoingCallCubit>().initiateCall(
              userModelReceiver: receiver,
              voiceCall: true,
            );
          },
          child: SvgPicture.asset(
            Assets.assetsImagesSvgsPhone,
            width: 18.w,
            height: 18.h,
            colorFilter: ColorFilter.mode(AppColor.black, BlendMode.srcIn),
          ),
        ),
        horizontalSpace(16),
        GestureDetector(
          onTap: () {
            getIt<OutgoingCallCubit>().initiateCall(
              userModelReceiver: receiver,
              voiceCall: false,
            );
          },
          child: SvgPicture.asset(
            Assets.assetsImagesSvgsVideoCall,
            width: 24.w,
            height: 24.h,
            colorFilter: ColorFilter.mode(AppColor.black, BlendMode.srcIn),
          ),
        ),
        horizontalSpace(24),
      ],
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            getIt<ChatCubit>().chatPageClosed();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 16.w,
          )),
      title: Row(
        children: [
          UserCircleAvatar(
            userPhoto: receiver.photo,
            size: 32,
          ),
          Text(' ${receiver.name}'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
