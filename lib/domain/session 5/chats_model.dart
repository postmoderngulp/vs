import 'package:flutter/material.dart';
import 'package:vs1/entity/profile.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';

class ChatsModel extends ChangeNotifier {
  List<Profile> users = [];
  List<Profile> _users = [];
  ChatsModel() {
    _setup();
  }

  void _setup() async {
    SupaBaseService service = SupaBaseService();
    users = await service.getProfiles();
    _users = users;
    notifyListeners();
  }

  void searchChat(String text) {
    users = _users
        .where((element) => element.name.toLowerCase().contains(text))
        .toList();
    notifyListeners();
  }

  void goToChatRider(BuildContext context, Profile profile) {
    Navigator.of(context)
        .pushNamed(NavigateRoute.chatRider, arguments: profile);
  }
}
