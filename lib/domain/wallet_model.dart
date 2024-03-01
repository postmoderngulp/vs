import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vs1/entity/history.dart';
import 'package:vs1/entity/profile.dart';
import 'package:vs1/entity/transaction.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';

class WalletModel extends ChangeNotifier {
  Uint8List? image;
  Profile? profile;
  bool alertError = false;
  bool connectiveAlert = false;
  String? connective;
  String? Error;
  List<TransactionClass> transactions = [
    TransactionClass(price: 2000, delivery: 'lalalla', date: 'July 7, 2022'),
    TransactionClass(price: -2000, delivery: 'lalalla', date: 'July 7, 2022'),
    TransactionClass(price: 4000, delivery: 'lalalla', date: 'July 7, 2022'),
    TransactionClass(price: 3000, delivery: 'lalalla', date: 'July 7, 2022'),
    TransactionClass(price: -500, delivery: 'lalalla', date: 'July 7, 2022'),
    TransactionClass(price: 2000, delivery: 'lalalla', date: 'July 7, 2022'),
    TransactionClass(price: 1200, delivery: 'lalalla', date: 'July 7, 2022'),
  ];
  bool isObscureBalance = false;
  List<TransactionHistory> history = [];
  void setObscureBalance() {
    isObscureBalance = !isObscureBalance;
    notifyListeners();
  }

  void goToPayment(BuildContext context) {
    Navigator.of(context).pushNamed(NavigateRoute.payment);
  }

  WalletModel() {
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
    try {
      SupaBaseService service = SupaBaseService();
      downloadImage();
      profile = await service.getProfile();
      history = profile!.transactions.where((item) {
        final date = DateTime.parse(item.created_at);
        final startDate = DateTime(2024, 1, 1);
        final endDate = DateTime(2030, 1, 1);
        return date.isAfter(startDate) && date.isBefore(endDate);
      }).toList();
      notifyListeners();
    } catch (e) {
      Error = e.toString();
      print(e);
      notifyListeners();
    }
  }

  Future<void> downloadImage() async {
    try {
      SupaBaseService service = SupaBaseService();
      image = await service
          .downloadImage(Supabase.instance.client.auth.currentSession!.user.id);
      notifyListeners();
    } catch (e) {
      getCacheImage();
      print(e.toString());
      if (e.toString() !=
          'StorageException(message: Object not found, statusCode: 404, error: not_found)') {
        Error = e.toString();
      }

      notifyListeners();
    }
  }

  void getCacheImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/my_image.png');
    image = await file.readAsBytes();
    notifyListeners();
  }
}
