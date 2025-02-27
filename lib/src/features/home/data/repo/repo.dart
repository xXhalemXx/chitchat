import 'package:chitchat/src/core/networking/models/call_history_model.dart';
import 'package:chitchat/src/core/networking/models/ice_candidate_model.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/features/home/data/models/message_model.dart';
import 'package:chitchat/src/features/home/data/models/user_with_last_message_model.dart';

import '../../../../core/networking/sources/sources.dart';

class HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  HomeRepository({required this.remoteDataSource});

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

  Stream<List<UserWithLastMessage>> fetchUsersWithLastMessage(
      {required String userId}) {
    return remoteDataSource.fetchUsersWithLastMessage(userId: userId);
  }

  Future<void> sendMessage(
      {required UserModel receiver,
      required String messageText,
      required String userId}) async {
    return await remoteDataSource.sendMessage(
        receiver: receiver, messageText: messageText, userId: userId);
  }

  Future<void> markMessageSeen(
      {required String userId, required String receiverUId}) async {
    await remoteDataSource.markAllMessagesSeen(
        userId: userId, receiverUId: receiverUId);
  }

  Future<void> updateUserLastSeen({required String uId}) async {
    await remoteDataSource.updateUserLastSeen(uId: uId);
  }

  Future<String> createCall(
      String callerId, String receiverId, String calleeName) async {
    return await remoteDataSource.createCall(callerId, receiverId, calleeName);
  }

  Future<void> sendOffer(String callId, Map<String, dynamic> offer) async {
    await remoteDataSource.sendOffer(callId, offer);
  }

  Future<void> sendAnswer(String callId, Map<String, dynamic> answer) async {
    await remoteDataSource.sendAnswer(callId, answer);
  }

  Future<void> addIceCandidate(
      String callId, IceCandidateModel candidate) async {
    await remoteDataSource.addIceCandidate(callId, candidate);
  }

  Future<Map<String, dynamic>?> getCallData(String callId) async {
    return await remoteDataSource.getCallData(callId);
  }

  Stream<Map<String, dynamic>?> onCallDataChanged(String callId) {
    return remoteDataSource.onCallDataChanged(callId);
  }

  Stream<Map<String, dynamic>> onNewCallCreated() {
    return remoteDataSource.onNewCallCreated();
  }

  Future<void> onCallEnd(
      String callId, String callerId, CallHistoryModel callData) async {
    await remoteDataSource.onCallEnd(callId, callerId, callData);
  }

  Future<void> updateCallStatus(String callId, int callStatus) async {
    await remoteDataSource.updateCallStatus(callId, callStatus);
  }
}
