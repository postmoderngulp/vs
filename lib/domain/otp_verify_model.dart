import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:vs1/presentation/navigation/navigate.dart';

class OtpVerifyModel extends ChangeNotifier {
  String? connective;
  String? Error;
  String _otpCode = '';
  bool codeValid = false;
  List<String> otpList = ['', '', '', '', '', ''];
  late Timer timer;
  bool isLoad = false;
  int time = 60;

  OtpVerifyModel() {
    _setup();
    countTime();
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

  void countTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer) {
      time--;
      if (time == 0) timer.cancel();
      notifyListeners();
    });
  }

  void setLoad() {
    isLoad = true;
    notifyListeners();
  }

  void resend() {
    time = 60;
    countTime();
    notifyListeners();
  }

  void setCode(String value) {
    if (_otpCode.length == 6) {
      return;
    }
    _otpCode = value;
    if (_otpCode.length == 6) {
      codeValid = true;
    }
    for (int i = 0; i < otpList.length; i++) {
      if (otpList[i].isEmpty) {
        otpList[i] = value[i];
        break;
      }
    }
    notifyListeners();
  }

  void goToNewPassword(BuildContext context) {
    Navigator.of(context).pushNamed(NavigateRoute.newPassword);
    timer.cancel();
  }
}
