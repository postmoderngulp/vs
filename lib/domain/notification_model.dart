import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';

class NotificationModel extends ChangeNotifier {
  String? connective;
  bool connectiveAlert = false;

  NotificationModel() {
    _setup();
  }

  void _setup() async {
    Connectivity().checkConnectivity().then((value) {
      connective = value.name;
      notifyListeners();
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connective = result.name;
      notifyListeners();
    });
  }
}
