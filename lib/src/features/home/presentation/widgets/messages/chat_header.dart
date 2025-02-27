import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/data/models/user_with_last_message_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/messages_cubit/messages_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/user_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatHeaders extends StatelessWidget {
  const ChatHeaders({super.key, required this.users});
  final List<UserWithLastMessage> users;

  @override
  Widget build(BuildContext context) {
    // log('last activity: ${users[0].user.lastActivity}');
    return users.isEmpty
        ? _noChatsYet()
        : ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return _chatEntity(
                userWithLastMessage: users[index],
                onTap: () {
                  getIt<MessagesCubit>().navigateToChatScreen(
                      receiver: users[index].user, context: context);
                },
              );
            },
          );
  }

  _noChatsYet() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Chats yet',
            style: AppTextStyles.poppinsFont20Black100Bold1,
          ),
          SizedBox(height: 16.h),
          Text(
            'Start chatting with your friends',
            style: AppTextStyles.poppinsFont16Black100Regular1,
          ),
        ],
      ),
    );
  }

  _chatEntity(
      {required UserWithLastMessage userWithLastMessage,
      required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 24.0.w, bottom: 30.h, right: 24.w),
        child: SizedBox(
          height: 52.h,
          child: Slidable(
            direction: Axis.horizontal,
            endActionPane: _endActionPane(),
            child: Row(
              children: [
                _avatarImage(
                    userPhoto: userWithLastMessage.user.photo,
                    lastActivity: userWithLastMessage.user.lastActivity),
                horizontalSpace(12.w),
                _avatarNameAndLastMessage(
                    name: userWithLastMessage.user.name,
                    lastMessage: userWithLastMessage.lastMessage),
                const Spacer(),
                _timeAndUnreadMessage(
                    unreadMessages: userWithLastMessage.unreadCount,
                    dateAndTime: userWithLastMessage.user.lastActivity),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatarImage(
      {required String userPhoto, required String lastActivity}) {
    return Stack(
      children: [
        UserCircleAvatar(
          userPhoto: userPhoto,
          size: 52,
        ),
        Positioned(
          bottom: 3.h,
          right: 3.w,
          child: Container(
            width: 10.w,
            height: 10.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: getIt<MessagesCubit>().isActiveNow(lastActivity)
                  ? AppColor.green
                  : AppColor.lightGray,
            ),
          ),
        ),
      ],
    );
  }

  Widget _avatarNameAndLastMessage(
      {required String name, required String lastMessage}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTextStyles.poppinsFont20Black100Medium1,
        ),
        verticalSpace(6.h),
        Text(
          lastMessage,
          style: AppTextStyles.poppinsFont12Gray50Regular1,
        )
      ],
    );
  }

  Widget _timeAndUnreadMessage(
      {required int unreadMessages, required String dateAndTime}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          getIt<MessagesCubit>().getTimeDifference(dateAndTime: dateAndTime),
          style: AppTextStyles.poppinsFont12Gray50Light1,
        ),
        verticalSpace(9.h),
        unreadMessages == 0
            ? const SizedBox.shrink()
            : Container(
                width: 22.w,
                height: 22.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.red,
                ),
                child: Center(
                  child: Text(
                    unreadMessages.toString(),
                    style: AppTextStyles.poppinsFont12White100Black1,
                  ),
                ),
              ),
      ],
    );
  }

  ActionPane _endActionPane() {
    return ActionPane(
      extentRatio: 0.35,
      motion: const ScrollMotion(),
      children: [
        horizontalSpace(16.w),
        _actionPaneButton(
            onTap: () {
              // print('tap bill');
            },
            svgName: Assets.assetsImagesSvgsBill,
            backgroundColor: AppColor.black),
        horizontalSpace(16.w),
        _actionPaneButton(
            onTap: () {
              // print('tap delete');
            },
            svgName: Assets.assetsImagesSvgsTrash,
            backgroundColor: AppColor.red),
      ],
    );
  }

  Widget _actionPaneButton(
      {required VoidCallback onTap,
      required String svgName,
      required Color backgroundColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.w,
        height: 36.h,
        decoration:
            BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
        child: Center(
          child: SvgPicture.asset(
            svgName,
          ),
        ),
      ),
    );
  }
}
