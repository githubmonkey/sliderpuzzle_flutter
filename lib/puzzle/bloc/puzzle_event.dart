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
    //required this.shufflePuzzle,
    //required this.pinTrailingWhitespace,
  });

  final int size;
  final bool elevenToTwenty;

  @override
  List<Object> get props => [
        size,
        elevenToTwenty,
      ];
}

/// Tile tapped for sliding
class TileTapped extends PuzzleEvent {
  const TileTapped(this.tile);

  final Tile tile;

  @override
  List<Object> get props => [tile];
}

/// Tile kicked for swapping
class TileKicked extends PuzzleEvent {
  const TileKicked(this.tile);

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
