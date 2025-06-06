import 'package:chitchat/src/core/app_style/app_theme.dart';
import 'package:chitchat/src/core/routes/router.dart';

import 'src/core/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key, required this.initialRoute});
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, ch) => DismissKeyboard(
        child: MaterialApp(
          navigatorKey: AppRouter.navigatorKey,
          theme: lightTheme,
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          onGenerateRoute: AppRouter.generate,
        ),
      ),
    );
  }
}
