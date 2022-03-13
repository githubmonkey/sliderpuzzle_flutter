// ignore_for_file: prefer_const_constructors, require_trailing_commas
import 'package:flutter_test/flutter_test.dart';
import 'package:leaders_api/leaders_api.dart';
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
  final settingsA = Settings(
    boardSize: 2,
    game: Game.noop,
    elevenToTwenty: true,
  );
  final settingsB = Settings(
    boardSize: 3,
    game: Game.multi,
    elevenToTwenty: false,
  );

  group('PuzzleEvent', () {
    group('PuzzleInitialized', () {
      test('supports value comparisons', () {
        expect(
          PuzzleInitialized(settings: settingsA),
          equals(PuzzleInitialized(settings: settingsA)),
        );

        expect(
          PuzzleInitialized(settings: settingsB),
          isNot(PuzzleInitialized(settings: settingsA)),
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
        expect(PuzzleReset(settings: settingsA),
            equals(PuzzleReset(settings: settingsB)));
      });
    });
  });
}
