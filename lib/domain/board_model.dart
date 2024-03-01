import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vs1/entity/board.dart';
import 'package:vs1/presentation/navigation/navigate.dart';
import 'package:vs1/repository/queue_save.dart';

class BoardModel extends ChangeNotifier {
  final _queueSave = QueueSave();
  board item =
      board(title: '', label: '', picture: 'first_board', width: 0, height: 0);
  bool queueEmpty = false;
  // final PageController controller = PageController(
  //   initialPage: 0,
  // );
  // late List<board> listBoard = [];
  // bool val = true;
  // bool val2 = false;
  // late int currentVal;

  BoardModel(BuildContext context) {
    // currentVal = 0;
    _setup(context);
  }

  void _setup(BuildContext context) {
    _setupList(context);
  }

  void _setupList(BuildContext context) async {
    final List<String>? items = await _queueSave.unLoad('queue');
    if (items == null) {
      List<board> listBoard = [
        board(
          title: 'Quick Delivery At Your Doorstep',
          label: 'Enjoy quick pick-up and delivery to your destination',
          picture: 'first_board',
          width: 346.w,
          height: 346.h,
        ),
        board(
          title: 'Flexible Payment',
          label:
              'Different modes of payment either before and after delivery without stress',
          picture: 'second_board',
          width: 424.w,
          height: 316.h,
        ),
        board(
          title: 'Real-time Tracking',
          label:
              'Track your packages/items from the comfort of your home till final destination',
          picture: 'third_board',
          width: 400.w,
          height: 298.h,
        ),
      ];
      List<String> list = [];
      for (var element in listBoard) {
        list.add(element.toJson());
      }
      _queueSave.load(list, 'queue');
      _setupList(context);
    }
    if (items != null) {
      if (items.isEmpty) {
        final supabase = Supabase.instance.client;
        Session? session = supabase.auth.currentSession;

        bool val = false;
        session != null ? val = true : val = false;
        val ? goToHome(context) : goToHolder(context);
        return;
      }
      item = board.fromJson(items.first);
      items.removeWhere((element) => element == items.first);
      if (items.isEmpty) {
        queueEmpty = true;
      }
      _queueSave.load(items, 'queue');
      // for (int i = 0; i < items.length; i++) {
      //   listBoard.add(board.fromJson(items[i]));
      // }
      notifyListeners();
    }
  }

  void skip(BuildContext context) async {
    // listBoard.clear();
    _queueSave.load([], 'queue');
    goToHolder(context);
  }

  void next() async {
    final List<String>? items = await _queueSave.unLoad('queue');
    item = board.fromJson(items!.first);
    items.removeWhere((element) => element == items.first);
    _queueSave.load(items, 'queue');
    if (items.isEmpty) {
      queueEmpty = true;
    }
    notifyListeners();
    // controller.nextPage(
    //     duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  void signUp(BuildContext context) async {
    // listBoard.removeWhere((element) => element == listBoard.first);
    // List<String> list = [];
    // for (var element in listBoard) {
    //   list.add(element.toJson());
    // }
    // _queueSave.load(list);
    goToHolder(context);
  }

  void goToHolder(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(NavigateRoute.signUp, (route) => false);
  }

  void goToHome(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(NavigateRoute.home, (route) => false);
  }

  void remove() async {
    // if (val2) {
    //   listBoard.removeWhere((element) => element == listBoard.first);
    //   List<String> list = [];
    //   for (var element in listBoard) {
    //     list.add(element.toJson());
    //   }
    //   _queueSave.load(list);
    //   val2 = false;
    //   controller.jumpTo(0);
    //   currentVal = controller.page!.round();
    // }
    // if (val) {
    //   listBoard.removeWhere((element) => element == listBoard.first);
    //   List<String> list = [];
    //   for (var element in listBoard) {
    //     list.add(element.toJson());
    //   }
    //   _queueSave.load(list);
    //   val = false;
    //   controller.jumpTo(0);
    //   currentVal = controller.page!.round();
    //   val2 = true;
    // }
    notifyListeners();
  }
}
