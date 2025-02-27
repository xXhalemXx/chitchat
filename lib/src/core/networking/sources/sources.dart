import 'package:chitchat/src/core/networking/models/call_history_model.dart';
import 'package:chitchat/src/core/networking/models/ice_candidate_model.dart';
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
      String callerId, String calleeId, String calleeName);
  Future<void> sendOffer(String callId, Map<String, dynamic> offer);
  Future<void> sendAnswer(String callId, Map<String, dynamic> answer);
  Future<void> addIceCandidate(String callId, IceCandidateModel candidate);
  Future<Map<String, dynamic>?> getCallData(String callId);
  Stream<Map<String, dynamic>?> onCallDataChanged(String callId);
  Stream<Map<String, dynamic>> onNewCallCreated();
  Future<void> onCallEnd(
      String callId, String callerId, CallHistoryModel callData);
  Future<void> updateCallStatus(String callId, int callStatus);
}
