import 'package:chitchat/src/core/networking/models/user_model.dart';

class UserWithLastMessage {
  final UserModel user;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;

  UserWithLastMessage({
    required this.lastMessageTime,
    required this.user,
    required this.lastMessage,
    this.unreadCount = 0,
  });

  static UserWithLastMessage fromJson(Map<String, dynamic> map) {
    return UserWithLastMessage(
      user: UserModel.fromJson(map['user']),
      lastMessage: map['lastMessage'],
      lastMessageTime: DateTime.parse(map['lastMessageTime']),
      unreadCount: map['unreadMessageCount'],
    );
  }

  toJson() {
    return {
      'user': user.toJson(),
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime.toIso8601String(),
      'unreadMessageCount': unreadCount,
    };
  }
}
