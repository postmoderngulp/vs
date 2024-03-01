import 'dart:typed_data';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vs1/entity/message.dart';
import 'package:vs1/entity/profile.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';

class ChatsModel extends ChangeNotifier {
  List<Profile> users = [];
  String? connective;
  bool alertError = false;
  bool connectiveAlert = false;
  String? Error;

  List<Profile> _users = [];
  List<Uint8List?> images = [];

  ChatsModel() {
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
      final profile = await service.getProfile();
      users = profile.role == 'courier'
          ? await service.getClientProfiles()
          : await service.getCourierProfiles();
      _users = users;
      getAvatars(users);
    } catch (e) {
      Error = e.toString();
      notifyListeners();
      print(e);
    }

    notifyListeners();
  }

  void getAvatars(List<Profile> users) async {
    for (int i = 0; i < users.length; i++) {
      final data = await getAvatar(users[i].user_id);
      images.add(data);
    }
    notifyListeners();
  }

  Future<Uint8List?> getAvatar(String path) async {
    try {
      SupaBaseService service = SupaBaseService();
      final imageData = await service.downloadImage(path);
      return imageData;
    } catch (e) {
      print(e.toString());
      if (e.toString() !=
          'StorageException(message: Object not found, statusCode: 404, error: not_found)') {
        Error = e.toString();
      }

      notifyListeners();
      return null;
    }
  }

  List<Message> filterChat(List<Message>? chat, String id) {
    if (chat == null) return [];
    List<Message> filterChat = [];
    for (int i = 0; i < chat.length; i++) {
      if (chat[i].userTo == id ||
          chat[i].userTo ==
              Supabase.instance.client.auth.currentSession!.user.id) {
        filterChat.add(chat[i]);
      }
    }
    return filterChat;
  }

  int countRead(List<Message> list) {
    int count = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].isRead == false &&
          list[i].userTo ==
              Supabase.instance.client.auth.currentSession!.user.id) {
        count++;
      }
    }
    return count;
  }

  Stream<List<Message>> getMessages(String id) {
    SupaBaseService service = SupaBaseService();
    return service.getMessages(id);
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
