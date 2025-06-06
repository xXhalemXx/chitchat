import 'package:chitchat/src/features/home/data/models/user_with_last_message_model.dart';

extension StringExtension on String? {
  bool isNullOrEmpty() => this == null || this == "";
  bool isNotNullOrEmpty() => this != null && this != "";
}

extension ListExtension<T> on List<T>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension MapExtension<K, V> on Map<K, V>? {
  bool isNullOrEmpty() => this == null || this!.isEmpty;
}

extension ListUserWithLastMessageExtension on List<UserWithLastMessage>? {
  void sortByLastMessageTime() {
    // Check if the list is not null
    if (this != null) {
      // Sort the list based on the timestamp of the last message
      this!.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
    }
  }
}
