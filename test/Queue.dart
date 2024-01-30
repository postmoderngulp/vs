// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:vs1/entity/board.dart';

class Queue {
  List<board> queue;
  Queue({
    required this.queue,
  });

  board extract() {
    board item = queue.first;
    queue.removeAt(0);
    return item;
  }

  String buttonLabel() {
    return queue.isEmpty ? 'Sign Up' : 'Next';
  }

  String goToHolder() {
    return queue.isEmpty ? 'Go' : 'NotGo';
  }
}
