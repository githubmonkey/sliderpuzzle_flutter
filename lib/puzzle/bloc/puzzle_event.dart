// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

abstract class PuzzleEvent extends Equatable {
  const PuzzleEvent();

  @override
  List<Object> get props => [];
}

class PuzzleInitialized extends PuzzleEvent {
  const PuzzleInitialized({
    required this.size,
    this.elevenToTwenty = false,
    required this.shufflePuzzle,
    required this.pinTrailingWhitespace,
  });

  final int size;
  final bool elevenToTwenty;
  final bool shufflePuzzle;
  final bool pinTrailingWhitespace;

  @override
  List<Object> get props => [
        size,
        elevenToTwenty,
        shufflePuzzle,
        pinTrailingWhitespace,
      ];
}

class TileTapped extends PuzzleEvent {
  const TileTapped(this.tile);

  final Tile tile;

  @override
  List<Object> get props => [tile];
}

class PuzzleReset extends PuzzleEvent {
  const PuzzleReset({required this.size});

  final int size;

  @override
  List<Object> get props => [size];
}

class PuzzleShuffleAnswers extends PuzzleEvent {
  const PuzzleShuffleAnswers();
}
