import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vs1/navigation/navigate.dart';

class OtpVerifyModel extends ChangeNotifier {
  String _otpCode = '';
  bool codeValid = false;
  List<String> otpList = ['', '', '', '', '', ''];
  late Timer timer;
  int time = 60;

  OtpVerifyModel() {
    countTime();
  }

  void countTime() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer) {
      time--;
      if (time == 0) timer.cancel();
      notifyListeners();
    });
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
