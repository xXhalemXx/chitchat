import 'package:chitchat/src/features/home/data/models/message_model.dart';
import 'package:intl/intl.dart';

String getTimeDifference({required String dateAndTime}) {
  // Function to check if two dates are on the same day
  bool isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  DateTime dateTime;
  dateTime = DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").parse(dateAndTime);
  DateTime now = DateTime.now();
  Duration difference = now.difference(dateTime);
  String timeDifference = '';
  // print(difference.inSeconds);

  if (difference.inSeconds < 60) {
    timeDifference = "Active now";
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

String formatDateTime(String dateTimeStr) {
  try {
    // Parse the input string to a DateTime object
    DateTime dateTime = DateTime.parse(dateTimeStr);

    // Create a DateFormat instance for desired format
    final DateFormat formatter = DateFormat('h:mm a');

    // Format the DateTime object
    return formatter.format(dateTime);
  } catch (e) {
    // Handle parsing errors
    return 'Invalid DateTime';
  }
}

bool isLastMessage(int index, List<MessageModel> messages) {
  if (index < messages.length - 1) {
    return formatDateTime(messages[index + 1].dateTime) !=
        formatDateTime(messages[index].dateTime);
  } else {
    return true;
  }
}
