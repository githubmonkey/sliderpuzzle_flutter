// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';

void main() {
  group('DashatarPuzzleEvent', () {
    group('DashatarCountdownStarted', () {
      test('supports value comparisons', () {
        expect(
          DashatarCountdownStarted(),
          equals(DashatarCountdownStarted()),
        );
      });
    });

    group('DashatarCountdownTicked', () {
      test('supports value comparisons', () {
        expect(
          DashatarCountdownTicked(),
          equals(DashatarCountdownTicked()),
        );
      });
    });

    group('DashatarCountdownStopped', () {
      test('supports value comparisons', () {
        expect(
          DashatarCountdownStopped(),
          equals(DashatarCountdownStopped()),
        );
      });
    });

    group('DashatarCountdownRestart', () {
      test('supports value comparisons', () {
        expect(
          DashatarCountdownRestart(secondsToBegin: 3),
          equals(DashatarCountdownRestart(secondsToBegin: 3)),
        );

        expect(
          DashatarCountdownRestart(secondsToBegin: 3),
          isNot(DashatarCountdownRestart(secondsToBegin: 2)),
        );
      });
    });
  });
}
