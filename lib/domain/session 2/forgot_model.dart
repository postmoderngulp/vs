import 'package:flutter/material.dart';
import 'package:vs1/presentation/navigation/navigate.dart';

class ForgotModel extends ChangeNotifier {
  String email = '';
  bool emailValid = false;
  void setEmail(String email) {
    emailValid = emailValid =
        RegExp(r'^[a-z0-9]+@[a-z0-9]+\.[a-z]{2,}$').hasMatch(email);
    notifyListeners();
  }

  void goToOtp(BuildContext context) {
    Navigator.of(context).pushNamed(NavigateRoute.otp);
  }

  void goToLogIn(BuildContext context) {
    Navigator.of(context).pop();
  }

  // void forgot(String email) {
  //   SupaBaseService service = SupaBaseService();
  //   service.forgotPassword(email);
  // }
}
