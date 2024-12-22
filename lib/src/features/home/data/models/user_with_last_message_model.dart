import 'package:chitchat/src/core/networking/models/user_model.dart';

class UserWithLastMessage {
  final UserModel user;
  final String lastMessage;
  final int unreadCount;

  UserWithLastMessage({
    required this.user,
    required this.lastMessage,
    this.unreadCount = 0,
  });

  static UserWithLastMessage fromJson(Map<String, dynamic> map) {
    return UserWithLastMessage(
      user: UserModel.fromJson(map['user']),
      lastMessage: map['lastMessage'],
      unreadCount: map['unreadMessageCount'],
    );
  }

  toJson() {
    return {
      'user': user.toMap(),
      'lastMessage': lastMessage,
      'unreadMessageCount': unreadCount,
    };
  }
}
