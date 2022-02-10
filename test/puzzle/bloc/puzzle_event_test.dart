// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

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
          PuzzleInitialized(size: 2),
          equals(
            PuzzleInitialized(size: 2),
          ),
        );

        expect(
          PuzzleInitialized(size: 2),
          isNot(
            PuzzleInitialized(size: 2),
          ),
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
        expect(PuzzleReset(size: 2), equals(PuzzleReset(size: 2)));
      });
    });
  });
}
