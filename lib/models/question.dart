import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/position.dart';

/// The questions that form the challenge grid

class Question extends Equatable {
  /// {@macro question}
  const Question({
    required this.index,
    required this.position,
    required this.left,
    required this.right,
    this.isWhitespace = false,
  });

  /// Might be used as key or label, describes the position
  final int index;

  /// Position
  final Position position;

  /// Left multiplier
  final int left;

  /// Right multiplier
  final int right;

  /// Denotes if the [Tile] is the whitespace tile or not.
  final bool isWhitespace;

  /// Calculate answer
  int get answer => left * right;

  /// Renerate string for display
  String get questionStr => '${left} x ${right}';

  @override
  List<Object?> get props => [
    index,
    position,
    left,
    right,
    isWhitespace
  ];
}
