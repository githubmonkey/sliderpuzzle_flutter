// ignore_for_file: prefer_const_constructors, require_trailing_commas
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';

void main() {
  final position = Position(x: 1, y: 1);
  final tile1 = Tile(
    value: 1,
    correctPosition: position,
    currentPosition: position,
  );
  final tile2 = Tile(
    value: 2,
    correctPosition: position,
    currentPosition: position,
  );

  group('PuzzleEvent', () {
    group('PuzzleInitialized', () {
      test('supports value comparisons', () {
        expect(
          PuzzleInitialized(size: 2, encoding: AnswerEncoding.noop),
          equals(PuzzleInitialized(size: 2, encoding: AnswerEncoding.noop)),
        );

        expect(
          PuzzleInitialized(size: 2, encoding: AnswerEncoding.noop),
          isNot(PuzzleInitialized(size: 2, encoding: AnswerEncoding.noop)),
        );
      });
    });

    group('TileTapped', () {
      test('supports value comparisons', () {
        expect(TileTapped(tile1), equals(TileTapped(tile1)));
        expect(TileTapped(tile2), isNot(TileTapped(tile1)));
      });
    });

    group('PuzzleReset', () {
      test('supports value comparisons', () {
        expect(PuzzleReset(size: 2, encoding: AnswerEncoding.noop),
            equals(PuzzleReset(size: 2, encoding: AnswerEncoding.noop)));
      });
    });
  });
}
