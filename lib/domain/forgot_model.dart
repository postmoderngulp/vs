import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:vs1/presentation/navigation/navigate.dart';

class ForgotModel extends ChangeNotifier {
  String email = '';
  bool isLoading = false;
  String? connective;
  String? Error;
  bool emailValid = false;
  void setEmail(String email) {
    emailValid = emailValid =
        RegExp(r'^[a-z0-9]+@[a-z0-9]+\.[a-z]{2,}$').hasMatch(email);
    notifyListeners();
  }

  ForgotModel() {
    _setup();
  }

  void _setup() {
    Connectivity().checkConnectivity().then((value) {
      connective = value.name;
      notifyListeners();
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connective = result.name;
      notifyListeners();
    });
  }

  void setLoad() {
    isLoading = true;
    notifyListeners();
  }

  void goToOtp(BuildContext context) {
    isLoading = false;
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
