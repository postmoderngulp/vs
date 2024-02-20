import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';

class SuccessDeliveryModel extends ChangeNotifier {
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

  SuccessDeliveryModel() {
    gyroscopeEvents.listen(
      (GyroscopeEvent event) {
        if (event.y >= 0.1) {
          setStar();
        }
        if (event.y <= -0.1) {
          deleteStar();
        }
      },
    );
    _setup();
  }

  void sendFeedback(String body, BuildContext context) {
    SupaBaseService service = SupaBaseService();
    int count = 0;
    for (int i = 0; i < stars.length; i++) {
      if (stars[i] == true) {
        count++;
      }
    }
    service.sendFeedback(body, count);
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
