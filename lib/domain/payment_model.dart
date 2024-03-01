import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class PaymentModel extends ChangeNotifier {
  int currentVal = 1;
  int currentCardVal = 1;
  bool connectiveAlert = false;
  String? connective;

  PaymentModel() {
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

  void setVal(int val) {
    currentVal = val;
    notifyListeners();
  }

  void setCardVal(int val) {
    currentCardVal = val;
    notifyListeners();
  }
}
