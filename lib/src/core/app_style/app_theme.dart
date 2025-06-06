import 'package:chitchat/src/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColor.darkBlue),
  useMaterial3: true,
  scaffoldBackgroundColor: AppColor.white,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: AppColor.white,
  ),
);
