import 'package:flutter/material.dart';
import 'package:vs1/entity/card.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';

class HomeModel extends ChangeNotifier {
  List<String> routes = ['', NavigateRoute.send, '', NavigateRoute.chats];
  String name = '';
  int val = 0;

  HomeModel() {
    _setup();
  }

  void _setup() async {
    SupaBaseService service = SupaBaseService();
    final profile = await service.getProfile();
    name = profile.name;
    notifyListeners();
  }

  List<card> cards = [
    card(
        picture: 'customer',
        title: 'Customer care',
        label:
            'Our customer care service line is available from 8 -9pm week days and 9 - 5 weekends - tap to call us today'),
    card(
        picture: 'send_package',
        title: 'Send a package',
        label:
            'Request for a driver to pick up or deliver your package for you'),
    card(
        picture: 'fund_wallet',
        title: 'Fund your wallet',
        label:
            'To fund your wallet is as easy as ABC, make use of our fast technology and top-up your wallet today'),
    card(
        picture: 'chats',
        title: 'Chats',
        label: 'Search for available rider within your area'),
  ];

  void setVal(int index) {
    val = index;
    notifyListeners();
  }

  void goToScreen(BuildContext context, String route) {
    if (route.isEmpty) return;
    Navigator.of(context).pushNamed(route);
  }
}
