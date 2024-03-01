import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:vs1/entity/package_info.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';

class CheckInfoModel extends ChangeNotifier {
  PackageInfo? packageInfo;
  String? connective;
  bool alertError = false;
  bool connectiveAlert = false;
  String? Error;
  String uuid = '';
  double total = 0;
  int deliveryCharges = 0;
  int instantDelivery = 0;
  double tax = 0;

  CheckInfoModel() {
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
    getPackage();
  }

  void getPackage() async {
    try {
      SupaBaseService service = SupaBaseService();
      final package = await service.getPackage();
      uuid = package.uuid;
      packageInfo = PackageInfo(
          originDetail: package.origin_details,
          destinationDetails: package.destination_details,
          package: package.package_details);
      _count(packageInfo!.destinationDetails.length);
      notifyListeners();
    } catch (e) {
      Error = e.toString();
      notifyListeners();
      print(e);
    }
  }

  void _count(int count) {
    Random random = Random();
    instantDelivery = random.nextInt(201) + 100;
    deliveryCharges = 2500 * count;
    tax = ((instantDelivery + deliveryCharges) / 100) * 5;
    total = tax + instantDelivery + deliveryCharges;
  }

  void goToSuccess(BuildContext context) {
    Navigator.of(context).pushNamed(NavigateRoute.successDelivery);
  }
}
