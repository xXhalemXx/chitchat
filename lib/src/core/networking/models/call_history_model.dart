import 'package:chitchat/src/core/networking/models/user_call_model.dart';

class CallHistoryModel {
  UserCallModel userData;
  String callTime;

  /// call status can be 5 values
  /// 0: call is initiated
  /// 1: call is answered
  /// 2: call is rejected
  /// 3: user in not answering
  /// 4: user in another call
  int callStatus;
  String callType;
  bool incoming;

  CallHistoryModel({
    required this.userData,
    required this.callTime,
    required this.callStatus,
    required this.callType,
    required this.incoming,
  });

  CallHistoryModel.fromJson(Map<String, dynamic> json)
      : userData = UserCallModel.fromJson(json['userData']),
        callTime = json['callTime'],
        callType = json['callType'],
        incoming = json['incoming'],
        callStatus = json['callStatus'];

  Map<String, dynamic> toJson() {
    return {
      'userData': userData.toJson(),
      'callTime': callTime,
      'callStatus': callStatus,
      'callType': callType,
      'incoming': incoming,
    };
  }
}
