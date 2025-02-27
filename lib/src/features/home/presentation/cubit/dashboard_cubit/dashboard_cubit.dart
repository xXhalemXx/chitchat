import 'package:chitchat/src/features/home/presentation/pages/dashboard_pages/calls_page.dart';
import 'package:chitchat/src/features/home/presentation/pages/dashboard_pages/contacts_page.dart';
import 'package:chitchat/src/features/home/presentation/pages/dashboard_pages/messages_page.dart';
import 'package:chitchat/src/features/home/presentation/pages/dashboard_pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(const DashboardState());
  final PageController pageController = PageController();
  int dashboardIndex = 0;

  final List<Widget> homeBodes = const [
    MessagesPage(),
    CallsPage(),
    ContactsPage(),
    SettingsPage(),
  ];

  /// used to navigate throw pages.
  void changePage(int index) {
    pageController.jumpToPage(index);
    emit(state.copyWith(currentIndex: index));
  }
}
