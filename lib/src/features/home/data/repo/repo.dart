import 'dart:io';

import 'package:chitchat/src/core/networking/models/call_history_model.dart';
import 'package:chitchat/src/core/networking/models/ice_candidate_model.dart';
import 'package:chitchat/src/core/networking/models/user_call_model.dart';
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
      UserCallModel callerData, String receiverId, String callType) async {
    return await remoteDataSource.createCall(callerData, receiverId, callType);
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
    String callId,
  ) async {
    await remoteDataSource.onCallEnd(
      callId,
    );
  }

  Future<void> addCallToUserHistory(
      {required String userID, required CallHistoryModel callData}) async {
    await remoteDataSource.addCallToUserHistory(
        userID: userID, callData: callData);
  }

  Future<void> updateCallStatus(String callId, int callStatus) async {
    await remoteDataSource.updateCallStatus(callId, callStatus);
  }

  Stream<bool?> onCallDeleted(String callId) {
    return remoteDataSource.onCallDeleted(callId);
  }

  Future<List<CallHistoryModel>> getCallsHistory({required String userID}) {
    return remoteDataSource.getCallsHistory(userID: userID);
  }

  Future<String> uploadUserPhoto(
      {required File image, required String fileName}) async {
    return await remoteDataSource.uploadUserPhoto(
        image: image, fileName: fileName);
  }

  Future<void> updateUserBio({
    required String userId,
    required String bio,
  }) async {
    await remoteDataSource.updateUserBio(userId: userId, bio: bio);
  }

  Future<void> updateUserPhoto({
    required String userId,
    required String photoUrl,
  }) async {
    await remoteDataSource.updateUserPhoto(userId: userId, photoUrl: photoUrl);
  }

  Future<void> updateUserName({
    required String userId,
    required String name,
  }) async {
    await remoteDataSource.updateUserName(userId: userId, name: name);
  }
}
