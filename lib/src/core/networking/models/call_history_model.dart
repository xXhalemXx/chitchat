class CallHistoryModel {
  String idOfOtherUser;
  DateTime callTime;

  /// call status can be 5 values
  /// 0: call is initiated
  /// 1: call is answered
  /// 2: call is rejected
  /// 3: user in not answering
  /// 4: user in another call
  int callStatus;

  CallHistoryModel({
    required this.idOfOtherUser,
    required this.callTime,
    required this.callStatus,
  });

  CallHistoryModel.fromJson(Map<String, dynamic> json)
      : idOfOtherUser = json['idOfOtherUser'],
        callTime = DateTime.parse(json['callTime']),
        callStatus = json['callStatus'];

  Map<String, dynamic> toJson() {
    return {
      'idOfOtherUser': idOfOtherUser,
      'callTime': callTime,
      'callStatus': callStatus,
    };
  }
}
