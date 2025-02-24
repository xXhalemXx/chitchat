import 'package:chitchat/src/features/home/presentation/widgets/calls/calls_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/contacts/contacts_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/messages/messages_body.dart';
import 'package:chitchat/src/features/home/presentation/widgets/settings/settings_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());
  final PageController pageController = PageController();
  int dashboardIndex = 0;

  final List<Widget> homeBodes = const [
    MessagesBody(),
    CallsBody(),
    ContactsBody(),
    SettingsBody(),
  ];

  /// used to navigate throw pages.
  void changePage(int index) {
    pageController.jumpToPage(index);
    emit(state.copyWith(currentIndex: index));
  }
}
