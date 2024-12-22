import 'package:chitchat/src/features/home/data/models/message_model.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/features/home/data/models/user_with_last_message_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<UserModel>> fetchAllUsers({required String userId});
  Future<List<UserModel>> fetchUsersHaveChatWith({required String userId});
  Future<List<UserWithLastMessage>> fetchUsersWithLastMessage(
      {required String userId});
  Stream<List<MessageModel>> fetchMessages({
    required UserModel receiver,
    required String userId,
  });

  Future<void> sendMessage({
    required UserModel receiver,
    required String messageText,
    required String userId,
  });

  Future<void> markAllMessagesSeen(
      {required String userId, required String receiverUId});
}
