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
    required this.encoding,
    this.elevenToTwenty = false,
  });

  final int size;
  final AnswerEncoding encoding;
  final bool elevenToTwenty;

  @override
  List<Object> get props => [size, encoding, elevenToTwenty];
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
  const PuzzleReset({required this.size, required this.encoding});

  final int size;

  final AnswerEncoding encoding;

  @override
  List<Object> get props => [size, encoding];
}

class PuzzleShuffleAnswers extends PuzzleEvent {
  const PuzzleShuffleAnswers();
}
