import 'package:bloc/bloc.dart';
import 'package:chitchat/src/core/models/user_data.dart';
import 'package:chitchat/src/core/networking/models/call_history_model.dart';
import 'package:chitchat/src/core/networking/network_exceptions.dart';
import 'package:chitchat/src/features/home/data/repo/repo.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'call_history_state.dart';

class CallHistoryCubit extends Cubit<CallHistoryState> {
  CallHistoryCubit({required this.homeRepository}) : super(CallHistoryState());
  HomeRepository homeRepository;

  Future<void> getCallHistory() async {
    try {
      List<CallHistoryModel> callsHistory = await homeRepository
          .getCallsHistory(userID: UserData.currentUser!.uId);
      emit(state.copyWith(
        callsHistory: callsHistory.reversed.toList(),
      ));
    } catch (e) {
      NetworkExceptions.showErrorDialog(e);
    }
    return;
  }

  String getTimeDifference({required String dateAndTime}) {
    // Function to check if two dates are on the same day
    bool isSameDate(DateTime a, DateTime b) {
      return a.year == b.year && a.month == b.month && a.day == b.day;
    }

    DateTime dateTime;
    dateTime = DateFormat("yyyy-MM-dd HH:mm").parse(dateAndTime);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);
    String timeDifference = '';
    if (difference.inSeconds < 60) {
      timeDifference = "seconds ago";
    } else if (difference.inMinutes < 60) {
      timeDifference = "${difference.inMinutes} mins ago";
    } else if (difference.inHours < 24) {
      timeDifference = "${difference.inHours} hours ago";
    } else if (isSameDate(dateTime, now)) {
      timeDifference = "at ${DateFormat('h:mm a').format(dateTime)}";
    } else {
      timeDifference = DateFormat('MMM dd, yyyy').format(dateTime);
    }

    return timeDifference;
  }
}
