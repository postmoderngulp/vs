import 'package:flutter/material.dart';
import 'package:vs1/navigation/navigate.dart';

class NewPasswordModel extends ChangeNotifier {
  String password = '';
  String repeatPassword = '';

  bool passwordValid = false;
  bool repeatValid = false;

  bool isObscurePassword = true;
  bool isObscureConfirm = true;

  void setObscurePassword() {
    isObscurePassword = !isObscurePassword;
    notifyListeners();
  }

  void setObscureConfirm() {
    isObscureConfirm = !isObscureConfirm;
    notifyListeners();
  }

  void setPassword() {
    passwordValid = password.length >= 6 ? true : false;
    notifyListeners();
  }

  void setRepeatPassword() {
    repeatValid = repeatPassword == password ? true : false;
    notifyListeners();
  }

  void goToHome(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(NavigateRoute.home, ((route) => false));
  }
}
