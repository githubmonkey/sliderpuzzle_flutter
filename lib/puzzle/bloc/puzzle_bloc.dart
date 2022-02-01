// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/models/pair.dart';
import 'package:very_good_slide_puzzle/models/question.dart';

part 'puzzle_event.dart';

part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc(this._size, {this.random}) : super(const PuzzleState()) {
    on<PuzzleInitialized>(_onPuzzleInitialized);
    on<TileTapped>(_onTileTapped);
    on<PuzzleReset>(_onPuzzleReset);
    on<PuzzleShuffleAnswers>(_onPuzzleShuffleAnswers);
  }

  final int _size;

  final Random? random;

  void _onPuzzleInitialized(
    PuzzleInitialized event,
    Emitter<PuzzleState> emit,
  ) {
    final puzzle = _generatePuzzle(
      _size,
      shuffle: event.shufflePuzzle,
      pinTrailingWhitespace: event.pinTrailingWhitespace,
    );
    emit(
      PuzzleState(
        puzzle: puzzle.sort(),
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
      ),
    );
  }

  void _onTileTapped(TileTapped event, Emitter<PuzzleState> emit) {
    final tappedTile = event.tile;
    if (state.puzzleStatus == PuzzleStatus.incomplete) {
      if (state.puzzle.isTileMovable(tappedTile)) {
        final mutablePuzzle = Puzzle(
          tiles: [...state.puzzle.tiles],
          questions: [...state.puzzle.questions],
        );
        final puzzle = mutablePuzzle.moveTiles(tappedTile, []);
        if (puzzle.isComplete()) {
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              puzzleStatus: PuzzleStatus.complete,
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
              numberOfMoves: state.numberOfMoves + 1,
              lastTappedTile: tappedTile,
            ),
          );
        } else {
          emit(
            state.copyWith(
              puzzle: puzzle.sort(),
              tileMovementStatus: TileMovementStatus.moved,
              numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
              numberOfMoves: state.numberOfMoves + 1,
              lastTappedTile: tappedTile,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
        );
      }
    } else {
      emit(
        state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
      );
    }
  }

  void _onPuzzleReset(PuzzleReset event, Emitter<PuzzleState> emit) {
    final puzzle = _generatePuzzle(_size);
    emit(
      PuzzleState(
        puzzle: puzzle.sort(),
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
      ),
    );
  }

  void _onPuzzleShuffleAnswers(
      PuzzleShuffleAnswers event, Emitter<PuzzleState> emit) {
    final puzzle = _shufflePuzzle(state.puzzle, pinTrailingWhitespace: true);
    emit(
      PuzzleState(
        puzzle: puzzle,
        numberOfCorrectTiles: puzzle.getNumberOfCorrectTiles(),
      ),
    );
  }

  List<Pair> _generateQuestionPairs(int size) {
    final set = Set<Pair>();
    final random = Random();

    while (set.length < (size * size)) {
      set.add(Pair(
        left: random.nextInt(10) + 1,
        right: random.nextInt(10) + 1,
      ));
    }
    return set.toList();
  }

  /// Build a randomized, solvable puzzle of the given size.
  Puzzle _generatePuzzle(
    int size, {
    bool shuffle = true,
    bool pinTrailingWhitespace = false,
  }) {
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final questions = <Question>[];
    final pairs = _generateQuestionPairs(size);

    // Create all possible board positions.
    int i = 1;
    for (var y = 1; y <= size; y++) {
      for (var x = 1; x <= size; x++) {
        final position = Position(x: x, y: y);
        correctPositions.add(position);
        currentPositions.add(position);

        if (x == size && y == size) {
          questions.add(Question(
            index: i++,
            position: position,
            pair: Pair(left: 0, right: 0),
            isWhitespace: true,
          ));
        } else {
          final pair = pairs[i];
          questions.add(Question(
            index: i++,
            position: position,
            pair: pair,
          ));
        }
      }
    }

    var tiles = _getTileListFromPositions(
      size,
      correctPositions,
      currentPositions,
      questions,
    );

    var puzzle = Puzzle(tiles: tiles, questions: questions);

    if (shuffle) {
      puzzle = _shufflePuzzle(
        puzzle,
        pinTrailingWhitespace: pinTrailingWhitespace,
      );
    }

    return puzzle;
  }

  /// Build a list of tiles - giving each tile their correct position and a
  /// current position.
  List<Tile> _shuffleTileList(List<Tile> tiles, bool pinTrailingWhitespace) {
    var size = sqrt(tiles.length).round();

    if (pinTrailingWhitespace && tiles.last.isWhitespace) {
      var whitetile = tiles.removeLast();
      tiles.shuffle(random);
      tiles.add(whitetile);
    } else {
      tiles.shuffle(random);
    }

    return tiles.asMap().entries.map((entry) {
      int i = entry.key;
      Tile t = entry.value;

      return t.copyWith(
          currentPosition:
              Position(x: ((i + 1) ~/ size + 1), y: ((i + 1) % size + 1)));
    }).toList();
  }

  // Assign the tiles new current positions until the puzzle is solvable and
  // zero tiles are in their correct position.
  Puzzle _shufflePuzzle(Puzzle puzzle, {bool pinTrailingWhitespace = true}) {
    while (true) {
      var shuffled = Puzzle(
        tiles: _shuffleTileList(puzzle.tiles, pinTrailingWhitespace),
        questions: puzzle.questions,
      );

      if (shuffled.isSolvable() && shuffled.getNumberOfCorrectTiles() == 0) {
        return shuffled;
      }
    }
  }

  /// Build a list of tiles - giving each tile their correct position and a
  /// current position.
  List<Tile> _getTileListFromPositions(
    int size,
    List<Position> correctPositions,
    List<Position> currentPositions,
    List<Question> questions,
  ) {
    final whitespacePosition = Position(x: size, y: size);
    return [
      for (int i = 1; i <= size * size; i++)
        if (i == size * size)
          Tile(
            value: i,
            // TODO: fix
            pair: questions[i - 1].pair,
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i - 1],
            isWhitespace: true,
          )
        else
          Tile(
            value: i,
            pair: questions[i - 1].pair,
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
          )
    ];
  }
}
