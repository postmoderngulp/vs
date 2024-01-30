// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:vs1/entity/board.dart';

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
      'Случай, когда очередь пустая, надпись на кнопке должна измениться на "Sing Up".',
      () {
    Queue queue = Queue(queue: []);
    String label = queue.buttonLabel();
    expect(label, 'Sign Up');
  });

  test(
      'Если очередь пустая и пользователь нажал на кнопку “Sing in”, происходит открытие пустого экрана «Holder» приложения. ',
      () {
    Queue queue = Queue(queue: []);
    String label = queue.goToHolder();
    expect(label, 'Go');
  });
}
