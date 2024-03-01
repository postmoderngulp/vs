import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';

class SuccessDeliveryModel extends ChangeNotifier {
  String? connective;
  bool alertError = false;
  bool connectiveAlert = false;
  String? Error;
  bool _valRate = false;
  String body = '';
  double turns = 0.0;
  List<bool> stars = [false, false, false, false, false];
  int time = 5;

  void setStar() {
    for (int i = 0; i < stars.length; i++) {
      if (stars[i] == false) {
        stars[i] = true;
        notifyListeners();
        return;
      }
    }
  }

  void deleteStar() {
    for (int i = 0; i < stars.length; i++) {
      if (stars[i] == false) {
        i == 0 ? null : stars[i - 1] = false;
        notifyListeners();
        return;
      } else if (stars[stars.length - 1] == true) {
        stars[stars.length - 1] = false;
        notifyListeners();
        return;
      }
    }
  }

  void closePackage() async {
    SupaBaseService service = SupaBaseService();
    await service.closePackage();
  }

  SuccessDeliveryModel() {
    Connectivity().checkConnectivity().then((value) {
      connective = value.name;
      notifyListeners();
    });
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connective = result.name;
      notifyListeners();
    });
    gyroscopeEvents.listen(
      (GyroscopeEvent event) {
        if (event.y <= 0.15 && event.y >= -0.15) {
          _valRate = true;
        }
        if (_valRate) {
          if (event.y >= 0.56) {
            setStar();
            _valRate = false;
          } else if (event.y <= -0.56) {
            deleteStar();
            _valRate = false;
          }
        }
      },
    );
    _setup();
  }

  void sendFeedback(String body, BuildContext context) async {
    SupaBaseService service = SupaBaseService();
    int count = 0;
    for (int i = 0; i < stars.length; i++) {
      if (stars[i] == true) {
        count++;
      }
    }
    try {
      await service.sendFeedback(body, count);
      closePackage();
    } catch (e) {
      Error = e.toString();
      notifyListeners();
      print(e);
    }
    gyroscopeEvents.drain();
    Navigator.pushNamedAndRemoveUntil(
        context, NavigateRoute.home, (route) => false);
  }

  void _setup() {
    Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time == 0) {
        timer.cancel();
        return;
      }
      _changeRotation();
      time--;
    });
  }

  void _changeRotation() {
    turns += 1.0 / 8.0;
    notifyListeners();
  }
}
