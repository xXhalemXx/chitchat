import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/features/home/data/models/message_model.dart';
import 'package:chitchat/src/features/home/data/models/user_with_last_message_model.dart';

import '../../../../core/networking/sources/sources.dart';

class HomeRepositoryImp {
  final HomeRemoteDataSource remoteDataSource;
  HomeRepositoryImp({required this.remoteDataSource});

  Future<List<UserModel>> fetchAllUsers({required String currentUserId}) async {
    return await remoteDataSource.fetchAllUsers(userId: currentUserId);
  }

  Stream<List<MessageModel>> fetchMessages(
      {required UserModel receiver, required String userId}) {
    return remoteDataSource.fetchMessages(receiver: receiver, userId: userId);
  }

  Future<List<UserModel>> fetchUsersHaveChatWith(
      {required String userId}) async {
    return await remoteDataSource.fetchUsersHaveChatWith(userId: userId);
  }

  Future<List<UserWithLastMessage>> fetchUsersWithLastMessage(
      {required String userId}) async {
    return await remoteDataSource.fetchUsersWithLastMessage(userId: userId);
  }

  Future<void> sendMessage(
      {required UserModel receiver,
      required String messageText,
      required String userId}) async {
    return await remoteDataSource.sendMessage(
        receiver: receiver, messageText: messageText, userId: userId);
  }

  getUsersHaveChatWith() {}

  Future<void> markMessageSeen(
      {required String userId, required String receiverUId}) async {
    await remoteDataSource.markAllMessagesSeen(
        userId: userId, receiverUId: receiverUId);
  }
}
