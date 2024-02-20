import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vs1/entity/profile.dart';
import 'package:vs1/entity/service.dart';
import 'package:vs1/main.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';

class ProfileModel extends ChangeNotifier {
  Profile? profile;
  List<Service> services = [
    Service(
        picture: 'assets/image/edit_profile.svg',
        title: 'Edit Profile',
        label: 'Name, phone no, address, email ...',
        path: ''),
    Service(
        picture: 'assets/image/statement.svg',
        title: 'Statements & Reports',
        label: 'Download transaction details, orders, deliveries',
        path: NavigateRoute.send),
    Service(
        picture: 'assets/image/notification.svg',
        title: 'Notification Settings',
        label: 'mute, unmute, set location & tracking setting',
        path: ''),
    Service(
        picture: 'assets/image/cardbank.svg',
        title: 'Card & Bank account settings',
        label: 'change cards, delete card details',
        path: ''),
    Service(
        picture: 'assets/image/referrals.svg',
        title: 'Referrals',
        label: 'check no of friends and earn',
        path: ''),
    Service(
        picture: 'assets/image/about.svg',
        title: 'About Us',
        label: 'know more about us, terms and conditions',
        path: ''),
    Service(
        picture: 'assets/image/log_out.svg',
        title: 'Log Out',
        label: '',
        path: ''),
  ];
  bool isObscureBalance = false;
  bool saveVal = false;

  ProfileModel(BuildContext context) {
    _setup(context);
  }

  void _setup(BuildContext context) async {
    SupaBaseService service = SupaBaseService();
    getThemeVal();
    profile = await service.getProfile();
    notifyListeners();
  }

  void setObscureBalance() {
    isObscureBalance = !isObscureBalance;
    notifyListeners();
  }

  void logOut(BuildContext context) {
    SupaBaseService service = SupaBaseService();
    service.logOut();
    GoToLogIn(context);
  }

  void setVal(BuildContext context) async {
    MyApp.of(context).changeTheme(
        Theme.of(context).brightness == Brightness.dark
            ? ThemeMode.light
            : ThemeMode.dark);
    saveVal = !saveVal;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool('themeValue', saveVal);
    notifyListeners();
  }

  void GoToService(String path, BuildContext context) {
    Navigator.of(context).pushNamed(path);
  }

  void getThemeVal() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? val = sharedPreferences.getBool('themeValue');
    if (val == null) {
      sharedPreferences.setBool('themeValue', false);
      getThemeVal();
    }
    if (val != null) {
      saveVal = val;
      notifyListeners();
    }
  }

  void GoToLogIn(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(NavigateRoute.signIn, (route) => false);
  }
}
