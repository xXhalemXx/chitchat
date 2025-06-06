import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/widgets/app_bar_for_dark_background.dart';
import 'package:chitchat/src/core/widgets/general_background_wrapper.dart';
import 'package:chitchat/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/calls/incoming_call/incoming_call_wrapper.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/dashboard_bottom_bar.dart';
import 'package:flutter/material.dart';

// todo use cubit to mange state rather than stateful widget
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    // todo move it to main
    return IncomingCallWrapper(
      child: Scaffold(
        appBar: AppBarForDarkBackground(),
        extendBodyBehindAppBar: true,
        body: GeneralBackgroundWrapper(
          child: PageView(
            controller: getIt<DashboardCubit>().pageController,
            children: getIt<DashboardCubit>().homeBodes,
            onPageChanged: (value) =>
                getIt<DashboardCubit>().scrollChangePage(value),
          ),
        ),
        bottomNavigationBar: DashboardBottomBar(),
      ),
    );
  }
}
