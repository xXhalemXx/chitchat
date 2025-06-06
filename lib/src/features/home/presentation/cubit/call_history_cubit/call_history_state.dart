part of 'call_history_cubit.dart';

class CallHistoryState extends Equatable {
  const CallHistoryState({
    this.callsHistory = const [],
  });
  CallHistoryState copyWith({
    List<CallHistoryModel>? callsHistory,
  }) {
    return CallHistoryState(
      callsHistory: callsHistory ?? this.callsHistory,
    );
  }

  final List<CallHistoryModel> callsHistory;

  @override
  List<Object> get props => [
        callsHistory,
      ];
}
