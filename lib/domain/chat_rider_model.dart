import 'dart:typed_data';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vs1/entity/message.dart';
import 'package:vs1/entity/profile.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';

class ChatRiderModel extends ChangeNotifier {
  late Profile profile;
  Stream<List<Message>>? stream;
  String? connective;
  bool alertError = false;
  bool connectiveAlert = false;
  String? Error;
  Uint8List? avatar;
  String msg = '';

  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool hasText = false;

  ChatRiderModel(Profile profiile) {
    profile = profiile;
    notifyListeners();
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
      getAvatar();
      stream = service.getMessages(profile.user_id);
      notifyListeners();
    } catch (e) {
      Error = e.toString();
      notifyListeners();
      print(e);
    }
  }

  void getAvatar() async {
    try {
      SupaBaseService service = SupaBaseService();
      final imageData = await service.downloadImage(profile.user_id);
      avatar = imageData;
      notifyListeners();
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

  void setRead(int id) async {
    try {
      SupaBaseService service = SupaBaseService();
      await service.makeRead(id);
    } catch (e) {
      Error = e.toString();
      notifyListeners();
      print(e);
    }
  }

  void checkText() {
    hasText = controller.text.isNotEmpty;
    notifyListeners();
  }

  void sendMessage(String message) async {
    try {
      SupaBaseService service = SupaBaseService();
      await service.sendMessage(message, profile.user_id);
    } catch (e) {
      Error = e.toString();
      notifyListeners();
      print(e);
    }
  }

  Stream<List<Message>>? getMessage(String message) {
    try {
      SupaBaseService service = SupaBaseService();
      return service.getMessages(profile.user_id);
    } catch (e) {
      Error = e.toString();
      notifyListeners();
      print(e);
      return null;
    }
  }

  List<Message> filterChat(List<Message>? chat) {
    List<Message> filterChat = [];
    for (int i = 0; i < chat!.length; i++) {
      if (chat[i].userTo == profile.user_id ||
          chat[i].userTo ==
              Supabase.instance.client.auth.currentSession!.user.id) {
        filterChat.add(chat[i]);
      }
    }
    return filterChat;
  }

  void goToCall(BuildContext context) {
    Navigator.of(context).pushNamed(NavigateRoute.call,
        arguments: [profile.name, profile.phone, avatar]);
  }
}
