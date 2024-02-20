import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:vs1/entity/location.dart';
import 'package:vs1/entity/origin_locate.dart';
import 'package:vs1/entity/package_info.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/queue_save.dart';
import 'package:vs1/repository/supabase_service.dart';

class SendInfoModel extends ChangeNotifier {
  double total = 0;
  int deliveryCharges = 0;
  int instantDelivery = 0;
  double tax = 0;
  final _queueSave = QueueSave();
  late PackageInfo packageInfo;

  SendInfoModel(PackageInfo info) {
    packageInfo = info;
    _setup(info.destinationDetails.length);
    notifyListeners();
  }

  void _setup(int count) {
    _count(count);
  }

  void _count(int count) {
    Random random = Random();
    instantDelivery = random.nextInt(201) + 100;
    deliveryCharges = 2500 * count;
    tax = ((instantDelivery + deliveryCharges) / 100) * 5;
    total = tax + instantDelivery + deliveryCharges;
  }

  void makePayment(
      PackageInfo packageInfo, String code, BuildContext context) async {
    try {
      DateTime.now().toLocal();

      SupaBaseService service = SupaBaseService();
      MyLocation myLocation = await countPosition(packageInfo);

      String month = '';
      switch (DateTime.now().toLocal().month) {
        case 1:
          month = 'January';
          break;
        case 2:
          month = 'February';
          break;
        case 3:
          month = 'March';
          break;
        case 4:
          month = 'April';
          break;
        case 5:
          month = 'May';
          break;
        case 6:
          month = 'June';
          break;
        case 7:
          month = 'July';
          break;
        case 8:
          month = 'August';
          break;
        case 9:
          month = 'September';
          break;
        case 10:
          month = 'October';
          break;
        case 11:
          month = 'November';
          break;
        case 12:
          month = 'December';
          break;
      }
      String time =
          '$month ${DateTime.now().toLocal().day.toString()} ${DateTime.now().toLocal().year.toString()}  ${DateTime.now().toLocal().hour.toString()}:${DateTime.now().toLocal().minute > 9 ? DateTime.now().toLocal().minute : '0${DateTime.now().toLocal().minute}'}';
      service.makePayment(packageInfo, code, myLocation, total, time);
      service.addTransaction(
        '$month ${DateTime.now().toLocal().day}, ${DateTime.now().toLocal().year}',
        total,
        'Free',
      );
      goToTransaction(context);
    } catch (error) {
      print(error);
    }
  }

  Future<MyLocation> countPosition(PackageInfo packageInfo) async {
    late OriginLocate FirstLocation;
    List<OriginLocate> Locations = [];
    final location =
        await locationFromAddress(packageInfo.originDetail.address);
    if (location.isNotEmpty) {
      FirstLocation = OriginLocate(
          lat: location.first.latitude, long: location.first.longitude);
    }
    for (int i = 0; i < packageInfo.destinationDetails.length; i++) {
      final location =
          await locationFromAddress(packageInfo.destinationDetails[i].address);
      if (location.isNotEmpty) {
        Locations.add(OriginLocate(
            lat: location.first.latitude, long: location.first.longitude));
      }
    }
    return MyLocation(location: FirstLocation, locations: Locations);
  }

  void goToEdit(BuildContext context) {
    Navigator.of(context).pop();
  }

  void goToTransaction(BuildContext context) async {
    Navigator.of(context).pushNamed(NavigateRoute.transaction);
  }
}
