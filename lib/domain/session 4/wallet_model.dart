import 'package:flutter/material.dart';
import 'package:vs1/entity/history.dart';
import 'package:vs1/entity/profile.dart';
import 'package:vs1/entity/transaction.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';

class WalletModel extends ChangeNotifier {
  Profile? profile;
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
    SupaBaseService service = SupaBaseService();
    profile = await service.getProfile();
    history = profile!.transactions.where((item) {
      final date = DateTime.parse(item.created_at);
      final startDate = DateTime(2024, 1, 1);
      final endDate = DateTime(2030, 1, 1);
      return date.isAfter(startDate) && date.isBefore(endDate);
    }).toList();
    notifyListeners();
  }
}
