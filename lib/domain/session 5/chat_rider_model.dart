import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vs1/entity/message.dart';
import 'package:vs1/entity/profile.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/supabase_service.dart';

class ChatRiderModel extends ChangeNotifier {
  late Profile profile;
  Stream<List<Message>>? stream;
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
    SupaBaseService service = SupaBaseService();
    stream = service.getMessages(profile.user_id);
    notifyListeners();
  }

  void checkText() {
    hasText = controller.text.isNotEmpty;
    notifyListeners();
  }

  void sendMessage(String message) async {
    SupaBaseService service = SupaBaseService();
    service.sendMessage(message, profile.user_id);
  }

  Stream<List<Message>> getMessage(String message) {
    SupaBaseService service = SupaBaseService();
    return service.getMessages(profile.user_id);
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
    Navigator.of(context)
        .pushNamed(NavigateRoute.call, arguments: profile.name);
  }

  // void sendMessage(String message) {
  //   chats.add(message);
  //   controller.text = '';
  //   msg = '';
  //   notifyListeners();
  // }
}
