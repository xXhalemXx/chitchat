part of 'home_cubit.dart';

class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoadedMassagesPage extends HomeState {
  final List<UserModel> usersHaveChatWith;
  HomeLoadedMassagesPage({required this.usersHaveChatWith});
}

final class HomeLoadedMassagesSearchPage extends HomeState {
  final List<UserModel> filteredUsers;
  HomeLoadedMassagesSearchPage({required this.filteredUsers});
}

final class HomeGetChatMassages extends HomeState {
  final List<MessageModel> allMessages;
  HomeGetChatMassages({required this.allMessages});
}
