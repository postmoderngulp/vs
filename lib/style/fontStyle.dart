import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vs1/style/colors.dart';

abstract class fontStyle {
  static TextStyle main = TextStyle(
      fontSize: 24.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
  static TextStyle title = TextStyle(
      fontSize: 24.sp,
      color: colors.text4,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle hint = TextStyle(
      fontSize: 14.sp,
      color: colors.gray1,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle field = TextStyle(
      fontSize: 14.sp,
      color: colors.text4,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
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
  static TextStyle labelGreyBoard = TextStyle(
      fontSize: 14.sp,
      color: colors.gray2,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
  static TextStyle otpLabel = TextStyle(
      fontSize: 14.sp,
      color: colors.black,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle termsLabel = TextStyle(
      fontSize: 12.sp,
      color: colors.gray2,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle termsLabelWarning = TextStyle(
      fontSize: 12.sp,
      color: colors.warning,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle label = TextStyle(
      fontSize: 12.sp,
      color: colors.gray2,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle mainLabel = TextStyle(
      fontSize: 12.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle labelGreyBoardMedium = TextStyle(
      fontSize: 14.sp,
      color: colors.gray2,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle timeLabel = TextStyle(
      fontSize: 14.sp,
      color: colors.gray2,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle timeLabelResend = TextStyle(
      fontSize: 14.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle nextBoard = TextStyle(
      fontSize: 14.sp,
      color: Colors.white,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
}
