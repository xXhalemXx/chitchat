import 'package:chitchat/src/core/helpers/spacing.dart';
import 'package:chitchat/src/features/home/presentation/widgets/chats_view.dart';
import 'package:chitchat/src/features/home/presentation/widgets/home_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/home_bottom_bar.dart';
import 'package:chitchat/src/features/home/presentation/widgets/status_circles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light));
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: _boxDecorationFun(),
        child: Column(
          children: [
            verticalSpace(60.h),
            const HomeBar(),
            verticalSpace(40.h),
            const StatusCircles(),
            verticalSpace(30.h),
            const ChatsView(),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomBar(),
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
