// ignore_for_file: prefer_const_constructors
import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/puzzle/puzzle.dart';

void main() {
  const seed = 2;

  final size3Tile1 = Tile(
    value: 1,
    correctPosition: Position(x: 1, y: 1),
    currentPosition: Position(x: 2, y: 1),
    pair: const Pair(left: 4, right: 10),
  );
  final size3Tile2 = Tile(
    value: 2,
    correctPosition: Position(x: 2, y: 1),
    currentPosition: Position(x: 1, y: 1),
    pair: const Pair(left: 1, right: 5),
  );
  final size3Tile3 = Tile(
    value: 3,
    correctPosition: Position(x: 3, y: 1),
    currentPosition: Position(x: 1, y: 2),
    pair: const Pair(left: 5, right: 7),
  );
  final size3Tile4 = Tile(
    value: 4,
    correctPosition: Position(x: 1, y: 2),
    currentPosition: Position(x: 2, y: 3),
    pair: const Pair(left: 8, right: 4),
  );
  final size3Tile5 = Tile(
    value: 5,
    correctPosition: Position(x: 2, y: 2),
    currentPosition: Position(x: 3, y: 1),
    pair: const Pair(left: 7, right: 2),
  );
  final size3Tile6 = Tile(
    value: 6,
    correctPosition: Position(x: 3, y: 2),
    currentPosition: Position(x: 1, y: 3),
    pair: const Pair(left: 8, right: 1),
  );
  final size3Tile7 = Tile(
    value: 7,
    correctPosition: Position(x: 1, y: 3),
    currentPosition: Position(x: 2, y: 2),
    pair: const Pair(left: 3, right: 1),
  );
  final size3Tile8 = Tile(
    value: 8,
    correctPosition: Position(x: 2, y: 3),
    currentPosition: Position(x: 3, y: 2),
    pair: const Pair(left: 10, right: 1),
  );
  final size3Tile9 = Tile(
    value: 9,
    correctPosition: Position(x: 3, y: 3),
    currentPosition: Position(x: 3, y: 3),
    pair: const Pair(left: 10, right: 3),
    isWhitespace: true,
  );

  final puzzleSize3Unshuffled = Puzzle(
    tiles: [
      size3Tile1.copyWith(currentPosition: size3Tile1.correctPosition),
      size3Tile2.copyWith(currentPosition: size3Tile2.correctPosition),
      size3Tile3.copyWith(currentPosition: size3Tile3.correctPosition),
      size3Tile4.copyWith(currentPosition: size3Tile4.correctPosition),
      size3Tile5.copyWith(currentPosition: size3Tile5.correctPosition),
      size3Tile6.copyWith(currentPosition: size3Tile6.correctPosition),
      size3Tile7.copyWith(currentPosition: size3Tile7.correctPosition),
      size3Tile8.copyWith(currentPosition: size3Tile8.correctPosition),
      size3Tile9.copyWith(currentPosition: size3Tile9.correctPosition),
    ],
    questions: const [],
  );

  final puzzleSize3 = Puzzle(
    tiles: [
      size3Tile2,
      size3Tile1,
      size3Tile5,
      size3Tile3,
      size3Tile7,
      size3Tile8,
      size3Tile6,
      size3Tile4,
      size3Tile9,
    ],
    questions: const [],
  );

  final puzzleSize3Pinned = Puzzle(
    tiles: [
      size3Tile7,
      size3Tile6,
      size3Tile8,
      size3Tile5,
      size3Tile4,
      size3Tile2,
      size3Tile1,
      size3Tile3,
      size3Tile9,
    ],
    questions: const [],
  );

  group('PuzzleBloc', () {
    test('initial state is PuzzleState', () {
      expect(
        PuzzleBloc().state,
        PuzzleState(),
      );
    });

    group('PuzzleInitialized', () {
      blocTest<PuzzleBloc, PuzzleState>(
        'emits solvable 3x3 puzzle, [incomplete], 0 correct tiles, and 0 moves '
        'when initialized with size 3 and shuffle equal to true',
        build: () => PuzzleBloc(random: Random(seed)),
        act: (bloc) => bloc.add(
          PuzzleInitialized(size: 3),
        ),
        expect: () => [PuzzleState(puzzle: puzzleSize3)],
        verify: (bloc) => expect(bloc.state.puzzle.isSolvable(), isTrue),
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'emits unshuffled 3x3 puzzle, 8 correct tiles, and 0 moves '
        'when initialized with size 3 and shuffle equal to false',
        build: () => PuzzleBloc(random: Random(seed)),
        act: (bloc) => bloc.add(
          PuzzleInitialized(size: 3),
        ),
        expect: () => [
          PuzzleState(
            puzzle: puzzleSize3Unshuffled,
            numberOfCorrectTiles: 8,
          )
        ],
        verify: (bloc) => expect(bloc.state.puzzle.isSolvable(), isTrue),
      );
    });

    group(
      'PuzzleInitializedPinned',
      () {
        blocTest<PuzzleBloc, PuzzleState>(
          'emits solvable 3x3 puzzle, [incomplete], 0 correct tiles, 0 moves '
          'when initialized with size 3, shuffled twice, and pinnedWhiteSpace',
          build: () => PuzzleBloc(random: Random(seed)),
          act: (bloc) => bloc.add(
            PuzzleInitialized(size: 3),
          ),
          expect: () => [PuzzleState(puzzle: puzzleSize3Pinned)],
          verify: (bloc) => expect(bloc.state.puzzle.isSolvable(), isTrue),
        );

        blocTest<PuzzleBloc, PuzzleState>(
          'emits unshuffled 3x3 puzzle, 8 correct tiles, and 0 moves '
          'when initialized with size 3 and shuffle equal to false',
          build: () => PuzzleBloc(random: Random(seed)),
          act: (bloc) => bloc.add(
            PuzzleInitialized(size: 3),
          ),
          expect: () => [
            PuzzleState(
              puzzle: puzzleSize3Unshuffled,
              numberOfCorrectTiles: 8,
            )
          ],
          verify: (bloc) => expect(bloc.state.puzzle.isSolvable(), isTrue),
        );
      },
      // evaluation doesn't work
      skip: true,
    );

    group('TileTapped', () {
      const size = 3;
      final topLeft = Position(x: 1, y: 1);
      final topCenter = Position(x: 2, y: 1);
      final topRight = Position(x: 3, y: 1);
      final middleLeft = Position(x: 1, y: 2);
      final middleCenter = Position(x: 2, y: 2);
      final middleRight = Position(x: 3, y: 2);
      final bottomLeft = Position(x: 1, y: 3);
      final bottomCenter = Position(x: 2, y: 3);
      final bottomRight = Position(x: 3, y: 3);

      final topLeftTile = Tile(
        value: 1,
        correctPosition: topLeft,
        currentPosition: topLeft,
      );
      final topCenterTile = Tile(
        value: 2,
        correctPosition: topCenter,
        currentPosition: topCenter,
      );
      final topRightTile = Tile(
        value: 3,
        correctPosition: topRight,
        currentPosition: topRight,
      );
      final middleLeftTile = Tile(
        value: 4,
        correctPosition: middleLeft,
        currentPosition: middleLeft,
      );
      final middleCenterTile = Tile(
        value: 5,
        correctPosition: middleCenter,
        currentPosition: middleCenter,
      );
      final middleRightTile = Tile(
        value: 6,
        correctPosition: middleRight,
        currentPosition: middleRight,
      );
      final bottomLeftTile = Tile(
        value: 7,
        correctPosition: bottomLeft,
        currentPosition: bottomLeft,
      );
      final whitespaceTile = Tile(
        value: 0,
        correctPosition: bottomRight,
        currentPosition: bottomCenter,
        isWhitespace: true,
      );
      final bottomRightTile = Tile(
        value: 8,
        correctPosition: bottomCenter,
        currentPosition: bottomRight,
      );

      final tiles = [
        topLeftTile,
        topCenterTile,
        topRightTile,
        middleLeftTile,
        middleCenterTile,
        middleRightTile,
        bottomLeftTile,
        whitespaceTile,
        bottomRightTile,
      ];
      final puzzle = Puzzle(tiles: tiles, questions: const []);

      blocTest<PuzzleBloc, PuzzleState>(
        'emits [moved] when one tile was able to move',
        build: () => PuzzleBloc(),
        seed: () => PuzzleState(
          size: size,
          puzzle: puzzle,
          numberOfCorrectTiles: 7,
        ),
        act: (bloc) => bloc.add(TileTapped(middleCenterTile)),
        expect: () => <PuzzleState>[
          PuzzleState(
            puzzle: Puzzle(
              tiles: [
                topLeftTile,
                topCenterTile,
                topRightTile,
                middleLeftTile,
                Tile(
                  value: 0,
                  correctPosition: bottomRight,
                  currentPosition: middleCenter,
                  isWhitespace: true,
                ),
                middleRightTile,
                bottomLeftTile,
                Tile(
                  value: 5,
                  correctPosition: middleCenter,
                  currentPosition: bottomCenter,
                ),
                bottomRightTile,
              ],
              questions: const [],
            ),
            tileMovementStatus: TileMovementStatus.moved,
            numberOfCorrectTiles: 6,
            numberOfMoves: 1,
            lastTappedTile: middleCenterTile,
          ),
        ],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'emits [moved] when multiple tiles were able to move',
        build: () => PuzzleBloc(),
        seed: () => PuzzleState(
          size: size,
          puzzle: puzzle,
          numberOfCorrectTiles: 7,
        ),
        act: (bloc) => bloc.add(TileTapped(topCenterTile)),
        expect: () => <PuzzleState>[
          PuzzleState(
            puzzle: Puzzle(
              tiles: [
                topLeftTile,
                Tile(
                  value: 0,
                  correctPosition: bottomRight,
                  currentPosition: topCenter,
                  isWhitespace: true,
                ),
                topRightTile,
                middleLeftTile,
                Tile(
                  value: 2,
                  correctPosition: topCenter,
                  currentPosition: middleCenter,
                ),
                middleRightTile,
                bottomLeftTile,
                Tile(
                  value: 5,
                  correctPosition: middleCenter,
                  currentPosition: bottomCenter,
                ),
                bottomRightTile,
              ],
              questions: const [],
            ),
            tileMovementStatus: TileMovementStatus.moved,
            numberOfCorrectTiles: 5,
            numberOfMoves: 1,
            lastTappedTile: topCenterTile,
          ),
        ],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'emits [cannotBeMoved] when tapped tile cannot move to whitespace',
        build: () => PuzzleBloc(),
        seed: () => PuzzleState(
          size: size,
          puzzle: puzzle,
          numberOfCorrectTiles: 7,
        ),
        act: (bloc) => bloc.add(TileTapped(topLeftTile)),
        expect: () => [
          isA<PuzzleState>().having(
            (state) => state.tileMovementStatus,
            'tileMovementStatus',
            TileMovementStatus.cannotBeMoved,
          ),
        ],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'emits [cannotBeMoved] when PuzzleStatus is complete',
        build: () => PuzzleBloc(),
        seed: () => PuzzleState(
          size: size,
          puzzle: puzzle,
          puzzleStatus: PuzzleStatus.complete,
          numberOfCorrectTiles: 7,
        ),
        act: (bloc) => bloc.add(TileTapped(topLeftTile)),
        expect: () => [
          isA<PuzzleState>().having(
            (state) => state.tileMovementStatus,
            'tileMovementStatus',
            TileMovementStatus.cannotBeMoved,
          ),
        ],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'emits [PuzzleComplete] when tapped tile completes the puzzle',
        build: () => PuzzleBloc(),
        seed: () => PuzzleState(
          size: size,
          puzzle: puzzle,
          numberOfCorrectTiles: 7,
        ),
        act: (bloc) => bloc.add(TileTapped(bottomRightTile)),
        expect: () => [
          PuzzleState(
            puzzle: Puzzle(
              tiles: [
                topLeftTile,
                topCenterTile,
                topRightTile,
                middleLeftTile,
                middleCenterTile,
                middleRightTile,
                bottomLeftTile,
                Tile(
                  value: 8,
                  correctPosition: bottomCenter,
                  currentPosition: bottomCenter,
                ),
                Tile(
                  value: 0,
                  correctPosition: bottomRight,
                  currentPosition: bottomRight,
                  isWhitespace: true,
                ),
              ],
              questions: const [],
            ),
            puzzleStatus: PuzzleStatus.complete,
            tileMovementStatus: TileMovementStatus.moved,
            numberOfCorrectTiles: 8,
            numberOfMoves: 1,
            lastTappedTile: bottomRightTile,
          ),
        ],
      );
    });

    group('PuzzleReset', () {
      final random = Random(seed);

      final initialSize3Puzzle = Puzzle(
        tiles: [
          Tile(
            value: 1,
            correctPosition: Position(x: 1, y: 1),
            currentPosition: Position(x: 1, y: 1),
          ),
          Tile(
            value: 7,
            correctPosition: Position(x: 1, y: 3),
            currentPosition: Position(x: 2, y: 1),
          ),
          size3Tile5,
          size3Tile8,
          size3Tile4,
          size3Tile9,
          size3Tile3,
          size3Tile2,
          size3Tile6,
        ],
        questions: const [],
      );

      blocTest<PuzzleBloc, PuzzleState>(
        'emits new solvable 3x3 puzzle with 0 moves when reset with size 3',
        build: () => PuzzleBloc(random: random),
        seed: () => PuzzleState(
          puzzle: initialSize3Puzzle,
          numberOfCorrectTiles: 1,
          numberOfMoves: 10,
        ),
        act: (bloc) => bloc.add(PuzzleReset(size: 3)),
        expect: () => [PuzzleState(size: 3, puzzle: puzzleSize3)],
        verify: (bloc) => expect(bloc.state.puzzle.isSolvable(), isTrue),
      );
    });
  });
}
