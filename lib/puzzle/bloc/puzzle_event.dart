// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

abstract class PuzzleEvent extends Equatable {
  const PuzzleEvent();

  @override
  List<Object> get props => [];
}

class PuzzleInitialized extends PuzzleEvent {
  const PuzzleInitialized({required this.settings});

  final Settings settings;

  @override
  List<Object> get props => [settings];
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
  const PuzzleReset({required this.settings});

  final Settings settings;

  @override
  List<Object> get props => [settings];
}

class PuzzleShuffleAnswers extends PuzzleEvent {
  const PuzzleShuffleAnswers({
    this.pinTrailingWhitespace = false,
    this.pinLeadingWhitespace = false,
    this.pinCorner = false,
  }) : assert(
          !pinTrailingWhitespace || !pinLeadingWhitespace,
          'must not both be set',
        );

  final bool pinTrailingWhitespace;
  final bool pinLeadingWhitespace;
  final bool pinCorner;
}
