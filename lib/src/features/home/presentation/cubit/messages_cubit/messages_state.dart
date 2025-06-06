part of 'messages_cubit.dart';

class MessagesState extends Equatable {
  final List<UserWithLastMessage> usersHaveChatWith;
  final List<UserModel> filteredUsers;
  final bool isLoading;
  final bool updateLastSeen;
  const MessagesState({
    this.usersHaveChatWith = const [],
    this.filteredUsers = const [],
    this.isLoading = false,
    this.updateLastSeen = false,
  });

  MessagesState copyWith({
    List<UserWithLastMessage>? usersHaveChatWith,
    List<UserModel>? filteredUsers,
    bool? isLoading,
    bool? updateLastSeen,
  }) {
    return MessagesState(
      usersHaveChatWith: usersHaveChatWith ?? this.usersHaveChatWith,
      filteredUsers: filteredUsers ?? this.filteredUsers,
      isLoading: isLoading ?? this.isLoading,
      updateLastSeen: updateLastSeen ?? this.updateLastSeen,
    );
  }

  @override
  List<Object?> get props =>
      [usersHaveChatWith, filteredUsers, isLoading, updateLastSeen];
}
