import 'src/core/config/config.dart';
import 'package:flutter/material.dart';
import 'src/core/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, ch) => const DismissKeyboard(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: RoutesName.initial,
          onGenerateRoute: AppRoute.generate,
        ),
      ),
    );
  }
}
