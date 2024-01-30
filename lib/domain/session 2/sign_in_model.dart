import 'package:flutter/material.dart';
import 'package:vs1/navigation/navigate.dart';

class SignInModel extends ChangeNotifier {
  String email = '';
  String password = '';
  bool emailValid = false;
  bool isChecked = false;
  bool passwordValid = false;
  bool isObscurePassword = true;

  void setEmail(String email) {
    emailValid = emailValid =
        RegExp(r'^[a-z0-9]+@[a-z0-9]+\.[a-z]{2,}$').hasMatch(email);
    notifyListeners();
  }

  void setPassword() {
    passwordValid = password.length >= 6 ? true : false;
    notifyListeners();
  }

  void setObscurePassword() {
    isObscurePassword = !isObscurePassword;
    notifyListeners();
  }

  void goToHome(BuildContext context) {
    Navigator.of(context).pushNamed(NavigateRoute.home);
  }

  void goToSignUp(BuildContext context) {
    Navigator.of(context).pop();
  }

  void goToForgot(BuildContext context) {
    Navigator.of(context).pushNamed(
      NavigateRoute.forgot,
    );
  }

  void setCheck() {
    isChecked = !isChecked;
    notifyListeners();
  }
}
