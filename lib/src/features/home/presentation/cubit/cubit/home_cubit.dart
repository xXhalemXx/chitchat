import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chitchat/src/features/home/data/repo/repo.dart';
import 'package:chitchat/src/features/home/data/models/message_model.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/core/routes/names.dart';
import 'package:chitchat/src/features/home/data/models/user_with_last_message_model.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/calls_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/contacts/contacts_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/home_search_delegate.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/messages_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/settings/settings_body.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepository}) : super(HomeInitial());
  final HomeRepository homeRepository;

  // global variables to hold data to be used frequently without calling backend
  late UserModel currentUser;

  //**  chat page controllers  */
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

//**  messages page functions  */
  Stream<List<UserWithLastMessage>>? _chatHeaderStream;

  Future<dynamic> loadData() async {
    homeRepository.updateUserLastSeen(uId: currentUser.uId);
    _chatHeaderStream =
        homeRepository.fetchUsersWithLastMessage(userId: currentUser.uId);
    _chatHeaderStream!.listen(
      (usersWithLastMessage) {
        emit(HomeLoadedMassagesPage(usersHaveChatWith: usersWithLastMessage));
      },
    );
    Timer.periodic(const Duration(minutes: 1), (_) {
      emit(HomeUpdateLastSeen());
    });
  }

  Future<dynamic> searchForUser({required String searchText}) async {
    homeRepository.updateUserLastSeen(uId: currentUser.uId);

    emit(HomeLoading());
    List<UserModel> allUsers =
        await homeRepository.fetchAllUsers(currentUserId: currentUser.uId);
    List<UserModel> filteredUsers = [];
    if (searchText.isNotEmpty) {
      filteredUsers = allUsers
          .where((user) =>
              user.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
    emit(HomeLoadedMassagesSearchPage(filteredUsers: filteredUsers));
  }

  void navigateToChatScreen(
      {required UserModel receiver, required BuildContext context}) {
    Navigator.pushNamed(
      context,
      RoutesName.chat,
      arguments: receiver,
    ).then(
      (_) => {
        // to set state after closing chat screen
        loadData(),
      },
    );
  }

  Future<void> showSearchDelegate({
    required BuildContext context,
  }) async {
    await showSearch(
      context: context,
      delegate: HomeSearchDelegate(),
    ).then((_) {
      loadData();
    });
  }

  // Future<void> updateDifferenceDateEveryMinute() async {
  //   while (true) {
  //     await Future.delayed(const Duration(minutes: 1));
  //     emit(HomeUpdateLastSeen());
  //   }
  // }

//**  chat page functions  */
  Stream<List<MessageModel>>? _messagesStream;

  Future<dynamic> getAllMassages({
    required UserModel receiver,
  }) async {
    homeRepository.updateUserLastSeen(uId: currentUser.uId);

    _messagesStream = homeRepository.fetchMessages(
        receiver: receiver, userId: currentUser.uId);
    _messagesStream!.listen(
      (messages) {
        //scroll to the bottom of the chat list when new messages arrive
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
        homeRepository.markMessageSeen(
            userId: currentUser.uId, receiverUId: receiver.uId);
        emit(HomeGetChatMassages(allMessages: messages));
      },
    );
  }

  Future<void> sendMessage({
    required UserModel receiver,
  }) async {
    homeRepository.updateUserLastSeen(uId: currentUser.uId);

    homeRepository.sendMessage(
        receiver: receiver,
        messageText: messageController.text,
        userId: currentUser.uId);
    messageController.clear();
    getAllMassages(receiver: receiver);
  }
}
