// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vs1/entity/board.dart';
import 'package:vs1/main.dart';
import 'package:vs1/presentation/onBoard.dart';
import 'package:vs1/repository/queue_save.dart';

void main() async {
  SharedPreferences.setMockInitialValues({});
  test('Изображение и текста из очереди извлекается правильно', () async {
    QueueSave queueSave = QueueSave();
    final queue = [
      board(
          title: 'title1',
          label: 'label1',
          picture: 'picture1',
          width: 300,
          height: 150),
    ];
    List<String> supportQueue = [];
    queue.forEach((element) {
      supportQueue.add(element.toJson());
    });
    await queueSave.load(supportQueue, 'queue');
    supportQueue = (await queueSave.unLoad('queue'))!;
    board el = board.fromJson(supportQueue.first);
    supportQueue.remove(supportQueue.first);
    queueSave.load(supportQueue, 'queue');
    expect(
      el,
      board(
          title: 'title1',
          label: 'label1',
          picture: 'picture1',
          width: 300,
          height: 150),
    );
  });

  test('Корректное извлечение элементов из очереди ', () async {
    QueueSave queueSave = QueueSave();
    final queue = [
      board(
          title: 'title1',
          label: 'label1',
          picture: 'picture1',
          width: 300,
          height: 150),
    ];
    List<String> supportQueue = [];
    queue.forEach((element) {
      supportQueue.add(element.toJson());
    });
    await queueSave.load(supportQueue, 'queue');
    supportQueue = (await queueSave.unLoad('queue'))!;
    supportQueue.remove(supportQueue.first);
    queueSave.load(supportQueue, 'queue');
    expect(supportQueue.length, 0);
  });

  testWidgets(
      'В случае, когда в очереди несколько картинок, устанавливается правильная надпись на кнопке.',
      (WidgetTester tester) async {
    await tester.runAsync(() async {
      QueueSave queueSave = QueueSave();
      final queue = [
        board(
          title: 'Quick Delivery At Your Doorstep',
          label: 'Enjoy quick pick-up and delivery to your destination',
          picture: 'first_board',
          width: 300,
          height: 100,
        ),
        board(
          title: 'Flexible Payment',
          label:
              'Different modes of payment either before and after delivery without stress',
          picture: 'second_board',
          width: 300,
          height: 100,
        ),
      ];
      List<String> supportQueue = [];
      queue.forEach((element) {
        supportQueue.add(element.toJson());
      });
      await queueSave.load(supportQueue, 'queue');
      await tester.pumpWidget(const MyApp());
      await tester.pumpWidget(const OnBoard());
      await tester.tap(find.byKey(const Key('Next')));
      await tester.pump();
      expect(find.text('Sign Up'), findsOneWidget);
    });
  });

  // test(
  //     'Случай, когда очередь пустая, надпись на кнопке должна измениться на "Sign Up".',
  //     () {
  //   Queue queue = Queue(queue: []);
  //   String label = queue.buttonLabel();
  //   expect(label, 'Sign Up');
  // });

  // testWidgets(
  //     'Если очередь пустая и пользователь нажал на кнопку “Sign in”, происходит открытие пустого экрана «Holder» приложения. ',
  //     (WidgetTester tester) async {
  //   Queue queue = Queue(queue: [
  //     board(
  //       title: 'Real-time Tracking',
  //       label:
  //           'Track your packages/items from the comfort of your home till final destination',
  //       picture: 'third_board',
  //       width: 400,
  //       height: 298,
  //     )
  //   ]);
  //   QueueSave queueSave = QueueSave();
  //   await queueSave.load([queue.queue.first.toJson()], 'queue');
  //   await tester.pumpWidget(const MyApp());
  //   await tester.tap(find.byKey(const Key('Sign Up')));
  //   await tester.pump();
  //   expect(find.text('Create an account'), findsOneWidget);
  // });
}
