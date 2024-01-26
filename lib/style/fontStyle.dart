import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vs1/style/colors.dart';

abstract class fontStyle {
  static TextStyle main = TextStyle(
      fontSize: 24.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
  static TextStyle labelBoard = TextStyle(
      fontSize: 16.sp,
      color: colors.text4,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle skipBoard = TextStyle(
      fontSize: 14.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
  static TextStyle nextBoard = TextStyle(
      fontSize: 14.sp,
      color: Colors.white,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
}
