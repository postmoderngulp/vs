import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vs1/entity/board.dart';

class BoardModel extends ChangeNotifier {
  PageController controller = PageController(initialPage: 0, keepPage: false);
  late int currentVal;
  List<board> listBoard = [
    board(
        title: 'Quick Delivery At Your Doorstep',
        label: 'Enjoy quick pick-up and delivery to your destination',
        picture: SvgPicture.asset('assets/image/first_board.svg')),
    board(
        title: 'Flexible Payment',
        label:
            'Different modes of payment either before and after delivery without stress',
        picture: SvgPicture.asset('assets/image/second_board.svg')),
    board(
        title: 'Real-time Tracking',
        label:
            'Track your packages/items from the comfort of your home till final destination',
        picture: SvgPicture.asset('assets/image/third_board.svg')),
  ];

  BoardModel() {
    currentVal = 0;
    controller.addListener(() {
      currentVal = controller.page!.round();
      notifyListeners();
    });
  }

  void remove() {
    listBoard.removeWhere((element) => element == listBoard.first);
    notifyListeners();
  }
}
