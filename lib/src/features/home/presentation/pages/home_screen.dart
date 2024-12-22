import 'package:chitchat/src/core/config/config.dart';
import 'package:chitchat/src/features/home/presentation/cubit/cubit/home_cubit.dart';
import 'package:chitchat/src/features/home/presentation/widgets/general_widgets/home_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// todo use cubit to mange state rather than stateful widget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // todo move it to main
    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: _boxDecorationFun(),
        child: getIt<HomeCubit>().homeBodes[getIt<HomeCubit>().homeIndex],
      ),
      bottomNavigationBar: HomeBottomBar(
        currentIndex: getIt<HomeCubit>().homeIndex,
        onTabTapped: (int index) {
          setState(() {
            getIt<HomeCubit>().homeIndex = index;
          });
        },
      ),
    );
  }

  BoxDecoration _boxDecorationFun() {
    return const BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/images/home_background.png"),
          fit: BoxFit.cover),
    );
  }
}
