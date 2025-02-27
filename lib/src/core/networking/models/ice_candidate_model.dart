class IceCandidateModel {
  String? candidate;
  String? sdpMid;
  int? sdpMLineIndex;

  IceCandidateModel(
      {required this.candidate,
      required this.sdpMid,
      required this.sdpMLineIndex});

  factory IceCandidateModel.fromJson(Map<String, dynamic> json) {
    return IceCandidateModel(
      sdpMid: json['sdpMid'],
      sdpMLineIndex: json['sdpMLineIndex'],
      candidate: json['candidate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidate': candidate,
      'sdpMid': sdpMid,
      'sdpMLineIndex': sdpMLineIndex,
    };
  }
}
