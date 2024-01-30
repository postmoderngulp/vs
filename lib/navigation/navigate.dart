import 'package:flutter/material.dart';
import 'package:vs1/presentation/session%201/onBoard.dart';
import 'package:vs1/presentation/session%202/forgot.dart';
import 'package:vs1/presentation/session%202/home.dart';
import 'package:vs1/presentation/session%202/new_password.dart';
import 'package:vs1/presentation/session%202/otp_verify.dart';
import 'package:vs1/presentation/session%202/sign_in.dart';
import 'package:vs1/presentation/session%202/sign_up.dart';

abstract class NavigateRoute {
  static const initial = '/';
  static const signUp = '/signUp';
  static const pdf = '/signUp/pdf';
  static const signIn = '/signUp/signIn';
  static const forgot = '/signUp/signIn/forgot';
  static const otp = '/signUp/signIn/forgot/otp';
  static const newPassword = '/signUp/signIn/forgot/otp/newPassword';
  static const home = '/signUp/signIn/home';
}

class Navigate {
  final initialRoute = NavigateRoute.initial;

  final route = <String, Widget Function(BuildContext)>{
    NavigateRoute.initial: (context) => const OnBoard(),
    NavigateRoute.signUp: (context) => const SignUp(),
    NavigateRoute.signIn: (context) => const SignInWidget(),
    NavigateRoute.home: (context) => const Home(),
    NavigateRoute.forgot: (context) => const Forgot(),
    NavigateRoute.otp: (context) => const OtpVerify(),
    NavigateRoute.newPassword: (context) => const NewPassword(),
  };
}
