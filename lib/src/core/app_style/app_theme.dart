import 'package:chitchat/src/core/constants/colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColor.darkBlue),
  useMaterial3: true,
  scaffoldBackgroundColor: AppColor.white,
  appBarTheme: AppBarTheme(
    color: AppColor.white,
  ),
);
