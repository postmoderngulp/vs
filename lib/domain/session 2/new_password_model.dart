import 'package:flutter/material.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';

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

  void newPassword(String password, BuildContext context) {
    try {
      SupaBaseService service = SupaBaseService();
      service.newPassword(password);
      goToHome(context);
    } catch (error) {
      print(error);
    }
  }
}
