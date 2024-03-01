import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';

class NewPasswordModel extends ChangeNotifier {
  String? connective;
  String? Error;
  String password = '';
  String repeatPassword = '';
  bool isLoad = false;

  bool passwordValid = false;
  bool repeatValid = false;

  bool isObscurePassword = true;
  bool isObscureConfirm = true;

  NewPasswordModel() {
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

  void setLoad() {
    isLoad = true;
    notifyListeners();
  }

  void goToHome(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(NavigateRoute.home, ((route) => false));
  }

  void newPassword(String password, BuildContext context) async {
    try {
      SupaBaseService service = SupaBaseService();
      await service.newPassword(password);
      goToHome(context);
    } catch (error) {
      isLoad = false;
      Error = error.toString();
      notifyListeners();
      print(error);
    }
  }
}
