// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:learning_flutter_animation/src/counter/counter.dart';

void main() {
  group('Testing Counter functionality', () {
    test('Counter initial value', () {
      final counter = Counter();
      expect(counter.value, 0);
    });

    test('Increment counter value', () {
      final counter = Counter();
      counter.increment();
      expect(counter.value, 1);
    });

    test('decrement counter value', () {
      final counter = Counter();
      counter.decrement();
      expect(counter.value, -1);
    });
  });
}
