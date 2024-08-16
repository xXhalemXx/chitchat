library text_style;

import 'package:chitchat/src/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//
class FontWeightHelper {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

//
class AppTextStyles {
  // to calculate the height of the text use this ratio font height in design divided by font size

  // we add font family and size and color with percentage and type then font height
  static TextStyle poppinsFont68White100Regular1_14 = TextStyle(
    fontSize: 68.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeightHelper.regular,
    color: AppColor.white,
    height: 1.14.sp,
  );
  static TextStyle poppinsFont16White50Regular1_6 = TextStyle(
    fontSize: 16.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeightHelper.regular,
    color: AppColor.white.withOpacity(0.5),
    height: 1.6.sp,
  );
  static TextStyle poppinsFont14White100Bold1 = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeightHelper.bold,
    color: AppColor.white,
    height: 1.sp,
  );
  static TextStyle poppinsFont14Gray100Black1 = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeightHelper.black,
    color: AppColor.gray,
    height: 1.sp,
  );
  static TextStyle poppinsFont16White100Medium1 = TextStyle(
    fontSize: 16.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeightHelper.medium,
    color: AppColor.white,
    height: 1.sp,
  );
  static TextStyle poppinsFont16Black100Regular1 = TextStyle(
    fontSize: 16.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeightHelper.regular,
    color: AppColor.black,
    height: 1.sp,
  );
  static TextStyle poppinsFont14White100Regular1 = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeightHelper.regular,
    color: AppColor.white,
    height: 1.sp,
  );
  static TextStyle poppinsFont18DarkBlue100Bold1 = TextStyle(
    fontSize: 18.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeightHelper.bold,
    color: AppColor.darkerBlue,
    height: 1.sp,
  );
  static TextStyle poppinsFont16White100Bold1 = TextStyle(
    fontSize: 16.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeightHelper.bold,
    color: AppColor.white,
    height: 1.sp,
  );
  static TextStyle poppinsFont14DarkBlue100Medium1 = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeightHelper.medium,
    color: AppColor.darkerBlue,
    height: 1.sp,
  );
  static TextStyle poppinsFont14Gray100light1_4 = TextStyle(
    fontSize: 14.sp,
    fontFamily: 'Poppins',
    fontWeight: FontWeightHelper.light,
    color: AppColor.gray,
    height: 1.4.sp,
    letterSpacing: 0.1.sp,
  );
}
