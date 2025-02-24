import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/core/constants/assets.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:chitchat/src/features/home/presentation/cubit/dashboard_cubit/dashboard_cubit.dart';
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
    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: _boxDecorationFun(),
        child: PageView(
          controller: getIt<DashboardCubit>().pageController,
          children: getIt<DashboardCubit>().homeBodes,
          onPageChanged: (value) => getIt<DashboardCubit>().changePage(value),
        ),
      ),
      bottomNavigationBar: DashboardBottomBar(),
    );
  }

  BoxDecoration _boxDecorationFun() {
    return const BoxDecoration(
      image: DecorationImage(
          image: AssetImage(Assets.assetsImagesDashboardBackground),
          fit: BoxFit.cover),
    );
  }
}
