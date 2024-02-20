import 'package:flutter/material.dart';

class PaymentModel extends ChangeNotifier {
  int currentVal = 1;
  int currentCardVal = 1;

  void setVal(int val) {
    currentVal = val;
    notifyListeners();
  }

  void setCardVal(int val) {
    currentCardVal = val;
    notifyListeners();
  }
}
