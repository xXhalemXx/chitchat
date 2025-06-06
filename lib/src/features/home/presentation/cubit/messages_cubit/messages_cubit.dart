import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chitchat/src/core/helpers/extensions.dart';
import 'package:chitchat/src/core/models/user_data.dart';
import 'package:chitchat/src/core/networking/network_exceptions.dart';
import 'package:chitchat/src/features/home/data/repo/repo.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/core/routes/names.dart';
import 'package:chitchat/src/features/home/data/models/user_with_last_message_model.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/home_search_delegate.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit({required this.homeRepository}) : super(MessagesState());
  final HomeRepository homeRepository;

//**  messages page functions  */
  Stream<List<UserWithLastMessage>>? _chatHeaderStream;

  Future<dynamic> loadData() async {
    try {
      homeRepository.updateUserLastSeen(uId: UserData.currentUser!.uId);
      _chatHeaderStream = homeRepository.fetchUsersWithLastMessage(
          userId: UserData.currentUser!.uId);
      _chatHeaderStream!.listen(
        (usersWithLastMessage) {
          usersWithLastMessage.sortByLastMessageTime();
          emit(state.copyWith(usersHaveChatWith: usersWithLastMessage));
        },
      );
    } catch (error) {
      NetworkExceptions.showErrorDialog(error);
    }
  }

  void autoUpdateChatHeaders() {
    // to auto update last seen every 3 minutes
    Timer.periodic(const Duration(minutes: 3), (_) {
      emit(state.copyWith(updateLastSeen: !state.updateLastSeen));
    });
  }

  Future<dynamic> searchForUser({required String searchText}) async {
    try {
      homeRepository.updateUserLastSeen(uId: UserData.currentUser!.uId);

      emit(state.copyWith(isLoading: true));
      List<UserModel> allUsers = await homeRepository.fetchAllUsers(
          currentUserId: UserData.currentUser!.uId);
      List<UserModel> filteredUsers = [];
      if (searchText.isNotEmpty) {
        filteredUsers = allUsers
            .where((user) =>
                user.name.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      }
      emit(state.copyWith(filteredUsers: filteredUsers, isLoading: false));
    } catch (error) {
      NetworkExceptions.showErrorDialog(error);
      emit(state.copyWith(filteredUsers: [], isLoading: false));
    }
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

  String getTimeDifference({required String dateAndTime}) {
    // Function to check if two dates are on the same day
    bool isSameDate(DateTime a, DateTime b) {
      return a.year == b.year && a.month == b.month && a.day == b.day;
    }

    DateTime dateTime;
    dateTime = DateFormat("yyyy-MM-dd HH:mm").parse(dateAndTime);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);
    String timeDifference = '';
    if (difference.inSeconds < 60) {
      timeDifference = "Active now";
    } else if (difference.inMinutes < 60) {
      timeDifference = "${difference.inMinutes} mins ago";
    } else if (difference.inHours < 24) {
      timeDifference = "${difference.inHours} hours ago";
    } else if (isSameDate(dateTime, now)) {
      timeDifference = "at ${DateFormat('h:mm a').format(dateTime)}";
    } else {
      timeDifference = DateFormat('MMM dd, yyyy').format(dateTime);
    }

    return timeDifference;
  }

  bool isActiveNow(String dateAndTime) {
    DateTime dateTime = DateFormat("yyyy-MM-dd HH:mm").parse(dateAndTime);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);
    return difference.inSeconds < 60;
  }
}
