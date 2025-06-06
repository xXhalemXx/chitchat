import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/incoming_call/incoming_call_wrapper.dart';
import 'package:chitchat/src/features/home/presentation/widgets/chat/chat_app_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/chat/chat_view.dart';
import 'package:chitchat/src/features/home/presentation/widgets/chat/message_sender.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
    required this.receiver,
  });

  final UserModel receiver;

  @override
  Widget build(BuildContext context) {
    return IncomingCallWrapper(
      child: PopScope(
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) {
            getIt<ChatCubit>().chatPageClosed();
          }
        },
        child: Scaffold(
          appBar: ChatAppBar(receiver: receiver),
          body: Column(
            children: [
              ChatView(receiver: receiver),
              Divider(
                height: 1,
                color: AppColor.lightBlue,
              ),
              MessageSender(receiver: receiver),
            ],
          ),
        ),
      ),
    );
  }
}
