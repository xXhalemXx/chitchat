import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MessageSender extends StatelessWidget {
  const MessageSender({
    super.key,
    required this.receiver,
  });
  final UserModel receiver;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: Row(
        children: [
          horizontalSpace(24),
          // An SVG icon for the message sending button
          SvgPicture.asset(
            Assets.assetsImagesSvgsAttachment,
            width: 26.w,
            height: 26.h,
          ),
          horizontalSpace(11),
          // A flexible widget to expand the input field
          Flexible(
            child: messageTextField(),
          ),
          horizontalSpace(16),
          SvgPicture.asset(
            Assets.assetsImagesSvgsCamera,
            width: 26.w,
            height: 26.h,
          ),
          // A button to send the message
          IconButton(
            icon: Icon(
              Icons.send,
              color: AppColor.black.withValues(alpha: 0.4),
            ), // Use an icon for the send button
            onPressed: () {
              getIt<ChatCubit>().sendMessage(
                receiver: receiver,
              );
            }, // Call the _sendMessage method when pressed
          ),
        ],
      ),
    );
  }

  Widget messageTextField() {
    return SizedBox(
      height: 40.h,
      child: TextField(
        controller: getIt<ChatCubit>()
            .messageController, // Use the controller for the text field
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.lightGrayGreen,
          contentPadding: EdgeInsetsDirectional.only(start: 12.w),
          hintText: 'Write your message',
          hintStyle: AppTextStyles.poppinsFont12Gray50Light1,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
