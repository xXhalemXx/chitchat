part of 'chat_cubit.dart';

class ChatState extends Equatable {
  final List<MessageModel> allMessages;
  const ChatState({
    this.allMessages = const [],
  });

  ChatState copyWith({
    List<MessageModel>? allMessages,
  }) {
    return ChatState(
      allMessages: allMessages ?? this.allMessages,
    );
  }

  @override
  List<Object?> get props => [allMessages];
}

// final class HomeInitial extends HomeState {}

// final class HomeLoading extends HomeState {}

// final class HomeLoadedMassagesPage extends HomeState {
//   final List<UserWithLastMessage> usersHaveChatWith;
//   HomeLoadedMassagesPage({required this.usersHaveChatWith});
// }

// final class HomeUpdateLastSeen extends HomeState {}

// final class HomeLoadedMassagesSearchPage extends HomeState {
//   final List<UserModel> filteredUsers;
//   HomeLoadedMassagesSearchPage({required this.filteredUsers});
// }

// final class HomeGetChatMassages extends HomeState {
//   HomeGetChatMassages({required this.allMessages});
// }
