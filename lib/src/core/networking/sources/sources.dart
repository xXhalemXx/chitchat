import 'dart:io';

import 'package:chitchat/src/core/networking/models/call_history_model.dart';
import 'package:chitchat/src/core/networking/models/ice_candidate_model.dart';
import 'package:chitchat/src/core/networking/models/user_call_model.dart';
import 'package:chitchat/src/features/home/data/models/message_model.dart';
import 'package:chitchat/src/core/networking/models/user_model.dart';
import 'package:chitchat/src/features/home/data/models/user_with_last_message_model.dart';

abstract class HomeRemoteDataSource {
  Future<UserModel?> signInWithGoogle();
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserModel> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });
  Future<List<UserModel>> fetchAllUsers({required String userId});
  Future<List<UserModel>> fetchUsersHaveChatWith({required String userId});
  Stream<List<UserWithLastMessage>> fetchUsersWithLastMessage(
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

  Future<void> updateUserLastSeen({required String uId});

  Future<String> createCall(
      UserCallModel callerData, String receiverId, String callType);
  Future<void> sendOffer(String callId, Map<String, dynamic> offer);
  Future<void> sendAnswer(String callId, Map<String, dynamic> answer);
  Future<void> addIceCandidate(String callId, IceCandidateModel candidate);
  Future<Map<String, dynamic>?> getCallData(String callId);
  Stream<Map<String, dynamic>?> onCallDataChanged(String callId);
  Stream<Map<String, dynamic>> onNewCallCreated();
  Future<void> onCallEnd(String callId);
  Future<void> addCallToUserHistory(
      {required String userID, required CallHistoryModel callData});
  Future<void> updateCallStatus(String callId, int callStatus);
  Stream<bool?> onCallDeleted(String callId);
  Future<List<CallHistoryModel>> getCallsHistory({required String userID});
  Future<String> uploadUserPhoto(
      {required File image, required String fileName});
  Future<void> updateUserBio({
    required String userId,
    required String bio,
  });
  Future<void> updateUserPhoto({
    required String userId,
    required String photoUrl,
  });
  Future<void> updateUserName({
    required String userId,
    required String name,
  });
}
