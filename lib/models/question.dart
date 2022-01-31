import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/pair.dart';
import 'package:very_good_slide_puzzle/models/position.dart';

/// The questions that form the challenge grid

class Question extends Equatable {
  /// {@macro question}
  const Question({
    required this.index,
    required this.position,
    required this.pair,
    this.isWhitespace = false,
  });

  /// Might be used as key or label, describes the position
  final int index;

  /// Position
  final Position position;

  /// Multipliers
  final Pair pair;

  /// Denotes if the [Tile] is the whitespace tile or not.
  final bool isWhitespace;

  @override
  List<Object?> get props => [
    index,
    position,
    pair,
    isWhitespace
  ];
}
