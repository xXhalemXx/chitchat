part of 'call_cubit.dart';

class CallState extends Equatable {
  final Map<String, dynamic>? currentCallOffer;
  final RTCVideoRenderer localRenderer;
  final RTCVideoRenderer remoteRenderer;

  /// call status can be 5 values
  /// 0: call is initiated
  /// 1: call is answered
  /// 2: call is rejected
  /// 3: user in not answering
  /// 4: user in another call
  final int callStatus;
  final bool? acceptIncomingCall;
  final bool isThereIncomingCall;

  const CallState({
    required this.currentCallOffer,
    required this.localRenderer,
    required this.remoteRenderer,
    required this.callStatus,
    required this.acceptIncomingCall,
    required this.isThereIncomingCall,
  });

  factory CallState.initial() {
    return CallState(
      currentCallOffer: null,
      localRenderer: RTCVideoRenderer(),
      remoteRenderer: RTCVideoRenderer(),
      acceptIncomingCall: null,
      callStatus: 0,
      isThereIncomingCall: false,
    );
  }

  CallState copyWith({
    Map<String, dynamic>? currentCallOffer,
    RTCVideoRenderer? localRenderer,
    RTCVideoRenderer? remoteRenderer,
    int? callStatus,
    bool? acceptIncomingCall,
    String? callId,
    bool? isThereIncomingCall,
  }) {
    return CallState(
      currentCallOffer: currentCallOffer ?? this.currentCallOffer,
      localRenderer: localRenderer ?? this.localRenderer,
      remoteRenderer: remoteRenderer ?? this.remoteRenderer,
      acceptIncomingCall: acceptIncomingCall ?? this.acceptIncomingCall,
      callStatus: callStatus ?? this.callStatus,
      isThereIncomingCall: isThereIncomingCall ?? this.isThereIncomingCall,
    );
  }

  @override
  List<Object> get props => [
        currentCallOffer ?? '',
        localRenderer,
        remoteRenderer,
        callStatus,
        acceptIncomingCall ?? '',
        isThereIncomingCall
      ];
}
