import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vs1/presentation/style/colors.dart';

abstract class fontStyle {
  static TextStyle main = TextStyle(
      fontSize: 24.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
  static TextStyle titleServices = TextStyle(
      fontSize: 14.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle littleTitle = TextStyle(
      fontSize: 20.sp,
      color: colors.text4,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle littleTitleWhite = TextStyle(
      fontSize: 20.sp,
      color: Colors.white,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle trackId = TextStyle(
      fontSize: 12.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle activeTrackId = TextStyle(
      fontSize: 14.sp,
      color: Colors.white,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle titleInfo = TextStyle(
      fontSize: 16.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle title = TextStyle(
      fontSize: 24.sp,
      color: colors.text4,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle titleProfile = TextStyle(
      fontSize: 24.sp,
      color: Colors.white,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle hint = TextStyle(
      fontSize: 14.sp,
      color: colors.gray1,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle hintSend = TextStyle(
      fontSize: 12.sp,
      color: colors.gray1,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle description = TextStyle(
      fontSize: 7.45.sp,
      color: colors.text4,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle activeDescription = TextStyle(
      fontSize: 7.45.sp,
      color: Colors.white,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle titleCall = TextStyle(
      fontSize: 18.67.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
  static TextStyle titleNumber = TextStyle(
      fontSize: 18.67.sp,
      color: colors.gray2,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
  static TextStyle hintSecondary = TextStyle(
      fontSize: 9.sp,
      color: colors.secondary,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle specialSecondary = TextStyle(
      fontSize: 14.sp,
      color: colors.secondary,
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
  static TextStyle labelBoardWhite = TextStyle(
      fontSize: 16.sp,
      color: Colors.white,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle titleLabel = TextStyle(
      fontSize: 14.sp,
      color: colors.text4,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle appBarTitle = TextStyle(
      fontSize: 16.sp,
      color: colors.gray2,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle skipBoard = TextStyle(
      fontSize: 14.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
  static TextStyle plus = TextStyle(
      fontSize: 16.sp,
      color: colors.good,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle minus = TextStyle(
      fontSize: 16.sp,
      color: colors.error,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
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
  static TextStyle serviceLabel = TextStyle(
      fontSize: 10.sp,
      color: colors.gray2,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle labelBlack = TextStyle(
      fontSize: 12.sp,
      color: colors.text4,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle labelGrayBlue = TextStyle(
      fontSize: 12.sp,
      color: colors.grayBlue,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle bigLabelBlack = TextStyle(
      fontSize: 14.sp,
      color: colors.text4,
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
  static TextStyle bottomLabelActive = TextStyle(
      fontSize: 12.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
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
  static TextStyle titleLabelWhite = TextStyle(
      fontSize: 14.sp,
      color: Colors.white,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
  static TextStyle titleLabelPrimary = TextStyle(
      fontSize: 14.sp,
      color: colors.primaryDark,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
  static TextStyle titleLabelMain = TextStyle(
      fontSize: 14.sp,
      color: colors.main,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
  static TextStyle titleBanner = TextStyle(
      fontSize: 16.sp,
      color: colors.text4,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700);
  static TextStyle labelTransaction = TextStyle(
      fontSize: 12.sp,
      color: colors.text4,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle titleDelivery = TextStyle(
      fontSize: 14.sp,
      color: Colors.white,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
  static TextStyle labelWhite = TextStyle(
      fontSize: 14.sp,
      color: Colors.white,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle countMsg = TextStyle(
      fontSize: 10.sp,
      color: Colors.white,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w400);
  static TextStyle myMsg = TextStyle(
      fontSize: 12.sp,
      color: Colors.white,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500);
}
