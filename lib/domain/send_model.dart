import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:vs1/entity/details.dart';
import 'package:vs1/entity/package.dart';
import 'package:vs1/entity/package_info.dart';
import 'package:vs1/presentation/navigation/navigate.dart';

class SendModel extends ChangeNotifier {
  String? connective;
  bool connectiveAlert = false;
  PackageInfo packageInfo = PackageInfo(
      originDetail: Details(address: '', state: '', number: '', others: ''),
      destinationDetails: [
        Details(address: '', state: '', number: '', others: '')
      ],
      package: PackageDetails(weight: '', items: '', worthItems: ''));

  void goToSendInfo(BuildContext context) {
    for (int i = 0; i < packageInfo.destinationDetails.length; i++) {
      if (packageInfo.destinationDetails[i].address.isEmpty ||
          packageInfo.destinationDetails[i].state.isEmpty ||
          packageInfo.destinationDetails[i].number.length != 11) {
        return;
      }
    }
    if (packageInfo.originDetail.address.isEmpty ||
        packageInfo.originDetail.number.length != 11 ||
        packageInfo.originDetail.state.isEmpty ||
        packageInfo.package.weight.isEmpty ||
        packageInfo.package.items.isEmpty ||
        packageInfo.package.worthItems.isEmpty) {
      return;
    }
    Uuid uuid = const Uuid();
    final code = uuid.v1();
    Navigator.of(context)
        .pushNamed(NavigateRoute.sendInfo, arguments: [code, packageInfo]);
  }

  SendModel() {
    _setup();
    getLocation();
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

  void getLocation() async {
    PermissionStatus status = await Permission.location.status;
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      packageInfo.originDetail.address =
          '${placemarks.first.street}  ${placemarks.first.name}  ${placemarks.first.locality} ';
      packageInfo.originDetail.state = '${placemarks.first.country}';
      notifyListeners();
    } else {
      PermissionStatus request = await Permission.location.request();
      if (request.isGranted) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        packageInfo.originDetail.address =
            '${placemarks.first.street}  ${placemarks.first.name}  ${placemarks.first.locality} ';
        packageInfo.originDetail.state = '${placemarks.first.country}';
        notifyListeners();
      } else if (request.isDenied) {
        // Пользователь отклонил запрос на доступ к геолокации
        return;
      }
    }
  }

  void addDestination() {
    packageInfo.destinationDetails
        .add(Details(address: '', state: '', number: '', others: ''));
    notifyListeners();
  }
}
