import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:chitchat/src/core/models/message_model.dart';
import 'package:chitchat/src/core/models/user_model.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/massages_logic.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.massagesLogic}) : super(HomeInitial());
  final MassagesLogic massagesLogic;

  // global variables to hold data to be used frequently without calling backend
  late UserModel currentUser;

  //**  chat page controllers  */
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  Future<void> getAllUsers() async {
    await massagesLogic.getAllUsers();
  }

//**  messages page functions  */
  Future<dynamic> loadData() async {
    emit(HomeLoading());
    List<UserModel> usersHaveChatWith =
        await massagesLogic.getUsersHaveChatWith();
    emit(HomeLoadedMassagesPage(usersHaveChatWith: usersHaveChatWith));
  }

  Future<dynamic> searchForUser({required String searchText}) async {
    emit(HomeLoading());
    List<UserModel> allUsers = await massagesLogic.getAllUsers();
    List<UserModel> filteredUsers = [];
    if (searchText.isNotEmpty) {
      filteredUsers = allUsers
          .where((user) =>
              user.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
    emit(HomeLoadedMassagesSearchPage(filteredUsers: filteredUsers));
  }
//**  chat page functions  */

  Future<dynamic> getAllMassages({
    required UserModel receiver,
  }) async {
    //   emit(HomeLoading());
    await massagesLogic.getAllMessages(
      receiver: receiver,
      onMessagesFetched: (allMessages) {
        emit(HomeGetChatMassages(allMessages: allMessages));
      },
    );
  }

  Future<void> sendMessage({
    required UserModel receiver,
  }) async {
    massagesLogic.sendMessage(receiver: receiver);
    getAllMassages(receiver: receiver);
  }
}
