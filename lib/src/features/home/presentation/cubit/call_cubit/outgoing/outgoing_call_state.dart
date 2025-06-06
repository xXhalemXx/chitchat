part of 'outgoing_call_cubit.dart';

class OutgoingCallState extends Equatable {
  final int callStatus;
  final bool isAudioOn;
  final bool isVideoOn;
  final bool isVideoOnUI;
  final bool isFrontCameraSelected;
  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;

  const OutgoingCallState({
    required this.callStatus,
    required this.isAudioOn,
    required this.isVideoOn,
    required this.isVideoOnUI,
    required this.isFrontCameraSelected,
    required this.localRenderer,
    required this.remoteRenderer,
  });

  factory OutgoingCallState.initial() {
    return OutgoingCallState(
      callStatus: 0,
      isAudioOn: true,
      isVideoOn: false,
      isVideoOnUI: false,
      isFrontCameraSelected: false,
      localRenderer: RTCVideoRenderer(),
      remoteRenderer: RTCVideoRenderer(),
    );
  }

  OutgoingCallState copyWith({
    int? callStatus,
    bool? isAudioOn,
    bool? isVideoOn,
    bool? isVideoOnUI,
    bool? isFrontCameraSelected,
    RTCVideoRenderer? localRenderer,
    RTCVideoRenderer? remoteRenderer,
  }) {
    return OutgoingCallState(
        callStatus: callStatus ?? this.callStatus,
        isAudioOn: isAudioOn ?? this.isAudioOn,
        isVideoOn: isVideoOn ?? this.isVideoOn,
        isFrontCameraSelected:
            isFrontCameraSelected ?? this.isFrontCameraSelected,
        localRenderer: localRenderer ?? this.localRenderer,
        remoteRenderer: remoteRenderer ?? this.remoteRenderer,
        isVideoOnUI: isVideoOnUI ?? this.isVideoOnUI);
  }

  OutgoingCallState reset() => OutgoingCallState.initial();

  @override
  List<Object?> get props => [
        callStatus,
        isAudioOn,
        isVideoOn,
        isVideoOnUI,
        isFrontCameraSelected,
        localRenderer,
        remoteRenderer,
      ];
}
