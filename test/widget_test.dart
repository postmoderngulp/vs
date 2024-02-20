// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vs1/entity/board.dart';
import 'package:vs1/main.dart';
import 'package:vs1/repository/queue_save.dart';
import 'Queue.dart';

void main() {
  test('Изображение и текста из очереди извлекается правильно', () {
    Queue queue = Queue(queue: [
      board(
          title: 'title1',
          label: 'label1',
          picture: 'picture1',
          width: 300,
          height: 150),
      board(
          title: 'title2',
          label: 'label2',
          picture: 'picture2',
          width: 300,
          height: 150),
      board(
          title: 'title3',
          label: 'label3',
          picture: 'picture3',
          width: 300,
          height: 150),
    ]);

    board item = queue.extract();
    expect(
      item,
      board(
          title: 'title1',
          label: 'label1',
          picture: 'picture1',
          width: 300,
          height: 150),
    );
  });

  test('Корректное извлечение элементов из очереди ', () {
    Queue queue = Queue(queue: [
      board(
          title: 'title1',
          label: 'label1',
          picture: 'picture1',
          width: 300,
          height: 150),
      board(
          title: 'title2',
          label: 'label2',
          picture: 'picture2',
          width: 300,
          height: 150),
      board(
          title: 'title3',
          label: 'label3',
          picture: 'picture3',
          width: 300,
          height: 150),
    ]);

    queue.extract();
    expect(queue.queue.length, 2);
    String label = queue.buttonLabel();
    expect(label, 'Next');
  });

  test(
      'В случае, когда в очереди несколько картинок, устанавливается правильная надпись на кнопке.',
      () {
    Queue queue = Queue(queue: [
      board(
          title: 'title1',
          label: 'label1',
          picture: 'picture1',
          width: 300,
          height: 150),
      board(
          title: 'title2',
          label: 'label2',
          picture: 'picture2',
          width: 300,
          height: 150),
      board(
          title: 'title3',
          label: 'label3',
          picture: 'picture3',
          width: 300,
          height: 150),
    ]);
    String label = queue.buttonLabel();
    expect(label, 'Next');
  });

  test(
      'Случай, когда очередь пустая, надпись на кнопке должна измениться на "Sign Up".',
      () {
    Queue queue = Queue(queue: []);
    String label = queue.buttonLabel();
    expect(label, 'Sign Up');
  });

  testWidgets(
      'Если очередь пустая и пользователь нажал на кнопку “Sign in”, происходит открытие пустого экрана «Holder» приложения. ',
      (WidgetTester tester) async {
    Queue queue = Queue(queue: [
      board(
        title: 'Real-time Tracking',
        label:
            'Track your packages/items from the comfort of your home till final destination',
        picture: 'third_board',
        width: 400,
        height: 298,
      )
    ]);
    QueueSave queueSave = QueueSave();
    await queueSave.load([queue.queue.first.toJson()], 'queue');
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.byKey(const Key('Sign Up')));
    await tester.pump();
    expect(find.text('Create an account'), findsOneWidget);
  });
}
