import 'package:flutter/material.dart';
import 'package:vs1/navigation/navigate.dart';

class SignUpModel extends ChangeNotifier {
  String name = '';
  String number = '';
  String email = '';
  String password = '';
  String repeatPassword = '';

  bool nameValid = false;
  bool numberValid = false;
  bool emailValid = false;
  bool passwordValid = false;
  bool repeatValid = false;

  bool isChecked = false;
  bool isObscurePassword = true;
  bool isObscureConfirm = true;

  void setName() {
    nameValid = name.length >= 4 ? true : false;
    notifyListeners();
  }

  void setNumber() {
    numberValid = number.length == 11 ? true : false;
    notifyListeners();
  }

  void setEmail(String email) {
    emailValid = emailValid =
        RegExp(r'^[a-z0-9]+@[a-z0-9]+\.[a-z]{2,}$').hasMatch(email);
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

  void setCheck() {
    isChecked = !isChecked;
    notifyListeners();
  }

  void setObscurePassword() {
    isObscurePassword = !isObscurePassword;
    notifyListeners();
  }

  void setObscureConfirm() {
    isObscureConfirm = !isObscureConfirm;
    notifyListeners();
  }

  void goToLogIn(BuildContext context) {
    Navigator.of(context).pushNamed(NavigateRoute.signIn);
  }
}
