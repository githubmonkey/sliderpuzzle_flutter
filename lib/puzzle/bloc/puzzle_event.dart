// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

abstract class PuzzleEvent extends Equatable {
  const PuzzleEvent();

  @override
  List<Object> get props => [];
}

class PuzzleInitialized extends PuzzleEvent {
  const PuzzleInitialized({
    required this.shufflePuzzle,
    required this.pinTrailingWhitespace,
  });

  final bool shufflePuzzle;
  final bool pinTrailingWhitespace;

  @override
  List<Object> get props => [shufflePuzzle];
}

class TileTapped extends PuzzleEvent {
  const TileTapped(this.tile);

  final Tile tile;

  @override
  List<Object> get props => [tile];
}

class PuzzleReset extends PuzzleEvent {
  const PuzzleReset();
}

class PuzzleShuffleAnswers extends PuzzleEvent {
  const PuzzleShuffleAnswers();
}
