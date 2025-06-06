import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/constants.dart';
import 'package:chitchat/src/core/models/user_data.dart';
import 'package:chitchat/src/features/home/data/models/message_model.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key, required this.receiver});
  final UserModel receiver;
  final double radiusValue = 10;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Flexible(
            child: ListView.builder(
              itemCount: state.allMessages.length,
              controller: getIt<ChatCubit>().scrollController,
              itemBuilder: (context, index) {
                MessageModel currentMessage = state.allMessages[index];
                if (currentMessage.sender == UserData.currentUser?.uId) {
                  return sendedMessage(
                    message: currentMessage,
                    isLastMessage: getIt<ChatCubit>()
                        .isLastMessage(index, state.allMessages),
                  );
                } else {
                  return receivedMessage(
                    message: currentMessage,
                    isLastMessage: getIt<ChatCubit>()
                        .isLastMessage(index, state.allMessages),
                  );
                }
              },
            ),
          );
        },
      );
    });
  }

  Widget sendedMessage({
    required MessageModel message,
    bool isLastMessage = false,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 4.h,
              right: 5.w,
              left: 10.w,
            ),
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: AppColor.darkerBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusValue),
                bottomRight: Radius.circular(radiusValue),
                bottomLeft: Radius.circular(radiusValue),
              ),
            ),
            child: Text(
              message.text,
              style: AppTextStyles.poppinsFont12White100Regular1,
              textAlign: TextAlign.right,
            ),
          ),
          isLastMessage
              ? Padding(
                  padding: EdgeInsets.only(right: 8.0.w, top: 2.h, bottom: 4.h),
                  child: Text(
                      getIt<ChatCubit>().formatDateTime(message.dateTime),
                      style: AppTextStyles.poppinsFont10Gray50Black1),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget receivedMessage({
    bool isLastMessage = false,
    required MessageModel message,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 4.h,
              left: 5.w,
              right: 10.w,
            ),
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: AppColor.lightBlueWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radiusValue),
                topRight: Radius.circular(radiusValue),
                bottomRight: Radius.circular(radiusValue),
              ),
            ),
            child: Text(
              message.text,
              style: AppTextStyles.poppinsFont12Black100Regular1,
              textAlign: TextAlign.left,
            ),
          ),
          isLastMessage
              ? Padding(
                  padding: EdgeInsets.only(left: 8.0.w, top: 2.h, bottom: 4.h),
                  child: Text(
                      getIt<ChatCubit>().formatDateTime(message.dateTime),
                      style: AppTextStyles.poppinsFont10Gray50Black1),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
