import 'package:bloc/bloc.dart';
import 'package:chitchat/src/core/models/message_model.dart';
import 'package:chitchat/src/core/models/user_model.dart';
import 'package:chitchat/src/core/routes/names.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/massages_logic.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/calls_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/contacts/contacts_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/messages_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/settings/settings_body.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.massagesLogic}) : super(HomeInitial());
  final MassagesLogic massagesLogic;

  // global variables to hold data to be used frequently without calling backend
  late UserModel currentUser;

  //**  HomePage Variables */
  int homeIndex = 0;
  final List<Widget> homeBodes = const [
    MessagesBody(),
    CallsBody(),
    ContactsBody(),
    SettingsBody(),
  ];

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
//**  chat page functions  */

  Future<dynamic> getAllMassages({
    required UserModel receiver,
  }) async {
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
