import 'package:chitchat/src/core/constants/colors.dart';
import 'package:chitchat/src/core/models/user_model.dart';
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
    return Scaffold(
      appBar: ChatAppBar(photo: receiver.photo, name: receiver.name),
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
    );
  }
}
