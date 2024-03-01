import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

class CallRiderModel extends ChangeNotifier {
  Uint8List? avatar;
  String? connective;
  bool connectiveAlert = false;
  CallRiderModel(Uint8List? imageData) {
    avatar = imageData;
    notifyListeners();
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
}
