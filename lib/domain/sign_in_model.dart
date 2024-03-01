import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInModel extends ChangeNotifier {
  String email = '';
  String password = '';
  bool isLoading = false;
  bool emailValid = false;
  bool isSaved = false;
  String? connective;
  String? Error;
  bool passwordValid = false;
  bool isObscurePassword = true;

  void setEmail(String email) {
    emailValid = emailValid =
        RegExp(r'^[a-z0-9]+@[a-z0-9]+\.[a-z]{2,}$').hasMatch(email);
    notifyListeners();
  }

  void signIn(String email, String password, BuildContext context) async {
    try {
      SupaBaseService service = SupaBaseService();
      await service.signIn(email, password);
      isLoading = false;
      goToHome(context);
    } catch (error) {
      isLoading = false;
      Error = error.toString();
      notifyListeners();
      print(error);
    }
  }

  SignInModel() {
    _setupCheck();
  }

  void googleLogIn(BuildContext context) async {
    SupaBaseService service = SupaBaseService();
    await service.googleSignIn();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(NavigateRoute.home, (route) => false);
  }

  void setPassword() {
    passwordValid = password.length >= 6 ? true : false;
    notifyListeners();
  }

  void setLoad() {
    isLoading = true;
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

  void _setupCheck() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final hash = await secureStorage.read(key: 'hashPassword');
    isSaved = hash == null ? false : true;
    notifyListeners();
  }

  void setCheck() async {
    if (isSaved) {
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      await secureStorage.write(key: 'hashPassword', value: null);
      isSaved = !isSaved;
    } else {
      FlutterSecureStorage secureStorage = const FlutterSecureStorage();
      final bytes = utf8.encode(password);
      final encodePass = sha512.convert(bytes);
      await secureStorage.write(
          key: 'hashPassword', value: encodePass.toString());
      isSaved = !isSaved;
    }
    notifyListeners();
  }
}
