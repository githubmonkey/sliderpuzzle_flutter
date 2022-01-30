import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/position.dart';

/// The questions that form the challenge grid

class Question extends Equatable {
  /// {@macro question}
  const Question({
    required this.value,
    required this.position,
    required this.left,
    required this.right
  });

  /// Might be used as key or label, decribes the position
  final int value;

  /// Position
  final Position position;

  /// Left multiplier
  final int left;

  /// Right multiplier
  final int right;

  @override
  List<Object?> get props => [
    value,
    position,
    left,
    right,
  ];
}