import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/presentation/home.dart';
import 'package:vs1/repository/supabase_service.dart';

class TransactionModel extends ChangeNotifier {
  double turns = 0.0;
  String? connective;
  bool alertError = false;
  bool connectiveAlert = false;
  String? Error;
  int time = 5;
  String uuid = '';

  TransactionModel() {
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
    getCode();
    Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time == 0) {
        timer.cancel();
        return;
      }
      _changeRotation();
      time--;
    });
  }

  void goTrack(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home(index: 2)),
        (route) => false);
  }

  void _changeRotation() {
    turns += 1.0 / 8.0;
    notifyListeners();
  }

  void goToHome(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(NavigateRoute.home, (r) => false);
  }

  void getCode() async {
    try {
      SupaBaseService service = SupaBaseService();
      final package = await service.getPackage();
      uuid = package.uuid;
      notifyListeners();
    } catch (error) {
      Error = error.toString();
      notifyListeners();
      print(error);
    }
  }
}
