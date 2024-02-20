import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:vs1/entity/details.dart';
import 'package:vs1/entity/package.dart';
import 'package:vs1/entity/package_info.dart';
import 'package:vs1/presentation/navigation/navigate.dart';

class SendModel extends ChangeNotifier {
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

  void addDestination() {
    packageInfo.destinationDetails
        .add(Details(address: '', state: '', number: '', others: ''));
    notifyListeners();
  }
}
