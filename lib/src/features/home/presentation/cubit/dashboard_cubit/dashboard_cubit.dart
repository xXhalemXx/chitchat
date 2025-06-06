import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/features/home/presentation/cubit/call_history_cubit/call_history_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/contacts_cubit/contacts_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/messages_cubit/messages_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/settings_cubit/settings_cubit.dart';
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
  bool enableOnChange = true;

  final List<Widget> homeBodes = [
    BlocProvider.value(
      value: getIt<MessagesCubit>()
        ..loadData()
        ..autoUpdateChatHeaders(),
      child: MessagesPage(),
    ),
    BlocProvider.value(
      value: getIt<CallHistoryCubit>()..getCallHistory(),
      child: CallsPage(),
    ),
    BlocProvider.value(
      value: getIt<ContactsCubit>(),
      child: ContactsPage(),
    ),
    BlocProvider.value(
      value: getIt<SettingsCubit>(),
      child: SettingsPage(),
    ),
  ];

  /// used to navigate throw pages.
  void changePage(int index) {
    if (index == 1) {
      // if the user is on calls page, we need to update the call history
      getIt<CallHistoryCubit>().getCallHistory();
    } else if (index == 2) {
      // if the user is on contacts page, we need to set the contacts
      getIt<ContactsCubit>().setContacts();
    }
    pageController.jumpToPage(index);
    emit(state.copyWith(currentIndex: index));
  }

  /// to prevent multiple calls to changePage
  void scrollChangePage(int index) {
    if (enableOnChange) {
      changePage(index);
    }
    enableOnChange = true;
  }

  navBarChangePage(int index) {
    enableOnChange = false;
    changePage(index);
  }
}
