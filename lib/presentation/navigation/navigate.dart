import 'package:flutter/material.dart';
import 'package:vs1/domain/call_rider_model.dart';
import 'package:vs1/presentation/onBoard.dart';
import 'package:vs1/presentation/forgot.dart';
import 'package:vs1/presentation/home.dart';
import 'package:vs1/presentation/new_password.dart';
import 'package:vs1/presentation/otp_verify.dart';
import 'package:vs1/presentation/sign_in.dart';
import 'package:vs1/presentation/sign_up.dart';
import 'package:vs1/presentation/call_rider.dart';
import 'package:vs1/presentation/chat_rider.dart';
import 'package:vs1/presentation/chats.dart';
import 'package:vs1/presentation/notificate.dart';
import 'package:vs1/presentation/check_send_info.dart';
import 'package:vs1/presentation/delivery_success.dart';
import 'package:vs1/presentation/payment_method.dart';
import 'package:vs1/presentation/send_package.dart';
import 'package:vs1/presentation/send_package_info.dart';
import 'package:vs1/presentation/transcation.dart';

abstract class NavigateRoute {
  static const initial = '/';
  static const signUp = '/signUp';
  static const pdf = '/signUp/pdf';
  static const signIn = '/signUp/signIn';
  static const forgot = '/signUp/signIn/forgot';
  static const otp = '/signUp/signIn/forgot/otp';
  static const newPassword = '/signUp/signIn/forgot/otp/newPassword';
  static const home = '/signUp/signIn/home';
  static const checkInfo = '/signUp/signIn/home/checkInfo';
  static const successDelivery =
      '/signUp/signIn/home/checkInfo/successDelivery';
  static const payment = '/signUp/signIn/home/payment';
  static const notification = '/signUp/signIn/home/notification';
  static const send = '/signUp/signIn/home/send';
  static const chats = '/signUp/signIn/home/chats';
  static const call = '/signUp/signIn/home/chats/call';
  static const chatRider = '/signUp/signIn/home/chats/chatRider';
  static const sendInfo = '/signUp/signIn/home/send/sendInfo';
  static const transaction = '/signUp/signIn/home/send/sendInfo/transaction';
}

class Navigate {
  final initialRoute = NavigateRoute.initial;

  final route = <String, Widget Function(BuildContext)>{
    NavigateRoute.initial: (context) => const OnBoard(),
    NavigateRoute.signUp: (context) => const SignUp(),
    NavigateRoute.signIn: (context) => const SignInWidget(),
    NavigateRoute.home: (context) => Home(
          index: 0,
        ),
    NavigateRoute.forgot: (context) => const Forgot(),
    NavigateRoute.otp: (context) => const OtpVerify(),
    NavigateRoute.newPassword: (context) => const NewPassword(),
    NavigateRoute.payment: (context) => const PaymentMethod(),
    NavigateRoute.notification: (context) => const NotificationScreen(),
    NavigateRoute.send: (context) => const SendPackage(),
    NavigateRoute.sendInfo: (context) => const SendPackageInfo(),
    NavigateRoute.transaction: (context) => const Transaction(),
    NavigateRoute.checkInfo: (context) => const CheckInfo(),
    NavigateRoute.successDelivery: (context) => const SuccessDelivery(),
    NavigateRoute.chats: (context) => const Chats(),
    NavigateRoute.chatRider: (context) => const ChatRider(),
    NavigateRoute.call: (context) => const CallRider(),
  };
}
