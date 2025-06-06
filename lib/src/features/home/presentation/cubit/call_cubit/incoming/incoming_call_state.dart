part of 'incoming_call_cubit.dart';

class IncomingCallState extends Equatable {
  /// 0: user not accept the call,
  /// 1: user accept the call,
  /// 2: user decline the call
  final int responseCode;
  final bool userInCall;
  final UserCallModel? callerData;
  final bool isAudioOn;
  final bool isVideoOn;
  final bool isVideoOnUI;
  final bool isFrontCameraSelected;
  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;

  const IncomingCallState({
    required this.responseCode,
    required this.userInCall,
    required this.callerData,
    required this.isAudioOn,
    required this.isVideoOn,
    required this.isVideoOnUI,
    required this.isFrontCameraSelected,
    required this.localRenderer,
    required this.remoteRenderer,
  });

  factory IncomingCallState.initial() => IncomingCallState(
        responseCode: 0,
        userInCall: false,
        callerData: null,
        isAudioOn: true,
        isVideoOn: false,
        isVideoOnUI: false,
        isFrontCameraSelected: false,
        localRenderer: RTCVideoRenderer(),
        remoteRenderer: RTCVideoRenderer(),
      );

  IncomingCallState copyWith({
    int? responseCode,
    bool? userInCall,
    UserCallModel? callerData,
    bool? isAudioOn,
    bool? isVideoOn,
    bool? isVideoOnUI,
    bool? isFrontCameraSelected,
    RTCVideoRenderer? localRenderer,
    RTCVideoRenderer? remoteRenderer,
  }) =>
      IncomingCallState(
          responseCode: responseCode ?? this.responseCode,
          userInCall: userInCall ?? this.userInCall,
          callerData: callerData ?? this.callerData,
          isAudioOn: isAudioOn ?? this.isAudioOn,
          isVideoOn: isVideoOn ?? this.isVideoOn,
          isFrontCameraSelected:
              isFrontCameraSelected ?? this.isFrontCameraSelected,
          localRenderer: localRenderer ?? this.localRenderer,
          remoteRenderer: remoteRenderer ?? this.remoteRenderer,
          isVideoOnUI: isVideoOnUI ?? this.isVideoOnUI);

  IncomingCallState reset() => IncomingCallState.initial();

  @override
  List<Object?> get props => [
        responseCode,
        userInCall,
        callerData,
        isAudioOn,
        isVideoOn,
        isVideoOnUI,
        isFrontCameraSelected,
        localRenderer,
        remoteRenderer,
      ];
}
