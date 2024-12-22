import 'package:bloc/bloc.dart';
import 'package:chitchat/src/features/home/data/implements/implements.dart';
import 'package:chitchat/src/features/home/data/models/message_model.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/core/routes/names.dart';
import 'package:chitchat/src/features/home/data/models/user_with_last_message_model.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/calls_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/contacts/contacts_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/messages_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/settings/settings_body.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.homeRepositoryImp}) : super(HomeInitial());
  final HomeRepositoryImp homeRepositoryImp;

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

  // Future<void> getAllUsers() async {
  //   await massagesLogic.getAllUsers();
  // }

//**  messages page functions  */
  Future<dynamic> loadData() async {
    // emit(HomeLoading());
    List<UserWithLastMessage> usersHaveChatWith = await homeRepositoryImp
        .fetchUsersWithLastMessage(userId: currentUser.uId);
    print("usersHaveChatWith: $usersHaveChatWith");
    emit(HomeLoadedMassagesPage(usersHaveChatWith: usersHaveChatWith));
  }

  Future<dynamic> searchForUser({required String searchText}) async {
    emit(HomeLoading());
    List<UserModel> allUsers =
        await homeRepositoryImp.fetchAllUsers(currentUserId: currentUser.uId);
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
  Stream<List<MessageModel>>? _messagesStream;

  Future<dynamic> getAllMassages({
    required UserModel receiver,
  }) async {
    _messagesStream = homeRepositoryImp.fetchMessages(
        receiver: receiver, userId: currentUser.uId);
    _messagesStream!.listen(
      (messages) {
        //scroll to the bottom of the chat list when new messages arrive
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
        homeRepositoryImp.markMessageSeen(
            userId: currentUser.uId, receiverUId: receiver.uId);
        emit(HomeGetChatMassages(allMessages: messages));
      },
    );
  }

  Future<void> sendMessage({
    required UserModel receiver,
  }) async {
    homeRepositoryImp.sendMessage(
        receiver: receiver,
        messageText: messageController.text,
        userId: currentUser.uId);
    messageController.clear();
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
