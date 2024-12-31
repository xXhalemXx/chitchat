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
  print(difference.inSeconds);

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
