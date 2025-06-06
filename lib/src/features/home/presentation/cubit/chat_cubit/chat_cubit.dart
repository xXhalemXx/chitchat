import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chitchat/src/core/models/user_data.dart';
import 'package:chitchat/src/core/networking/network_exceptions.dart';
import 'package:chitchat/src/features/home/data/repo/repo.dart';
import 'package:chitchat/src/features/home/data/models/message_model.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.homeRepository}) : super(ChatState());
  final HomeRepository homeRepository;

  //**  chat page controllers  */
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

//**  chat page functions  */
  // StreamSubscription to stop listening to the stream when the chat page is closed
  // and free resources
  StreamSubscription<List<MessageModel>>? _subscription;
  Stream<List<MessageModel>>? _messagesStream;

  chatPageClosed() {
    _subscription?.cancel();
    _messagesStream?.drain();
    _subscription = null;
  }

  Future<dynamic> getAllMassages({
    required UserModel receiver,
  }) async {
    try {
      homeRepository.updateUserLastSeen(uId: UserData.currentUser!.uId);

      _messagesStream = homeRepository.fetchMessages(
          receiver: receiver, userId: UserData.currentUser!.uId);
      _subscription = _messagesStream!.listen(
        (messages) {
          //scroll to the bottom of the chat list when new messages arrive
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          });
          homeRepository.markMessageSeen(
              userId: UserData.currentUser!.uId, receiverUId: receiver.uId);
          emit(state.copyWith(allMessages: messages));
        },
      );
    } catch (error) {
      NetworkExceptions.showErrorDialog(error);
    }
  }

  Future<void> sendMessage({
    required UserModel receiver,
  }) async {
    try {
      homeRepository.updateUserLastSeen(uId: UserData.currentUser!.uId);

      homeRepository.sendMessage(
          receiver: receiver,
          messageText: messageController.text,
          userId: UserData.currentUser!.uId);
      messageController.clear();
      getAllMassages(receiver: receiver);
    } catch (error) {
      NetworkExceptions.showErrorDialog(error);
    }
  }

  bool isLastMessage(int index, List<MessageModel> messages) {
    if (index < messages.length - 1) {
      return formatDateTime(messages[index + 1].dateTime) !=
          formatDateTime(messages[index].dateTime);
    } else {
      return true;
    }
  }

  String formatDateTime(String dateTimeStr) {
    try {
      // Parse the input string to a DateTime object
      DateTime dateTime = DateTime.parse(dateTimeStr);

      // Create a DateFormat instance for desired format
      final DateFormat formatter = DateFormat('h:mm a');

      // Format the DateTime object
      return formatter.format(dateTime);
    } catch (e) {
      // Handle parsing errors
      return 'Invalid DateTime';
    }
  }
}
