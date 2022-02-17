import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';
import 'package:very_good_slide_puzzle/settings/settings.dart';

/// {@template tile}
/// Model for a puzzle tile.
/// {@endtemplate}
class Tile extends Equatable {
  /// {@macro tile}
  const Tile({
    required this.value,
    required this.correctPosition,
    required this.currentPosition,
    this.pair = const Pair(left: -1, right: -1, encoding: AnswerEncoding.hex),
    this.isWhitespace = false,
  });

  /// Value representing the correct position of [Tile] in a list.
  final int value;

  /// The correct 2D [Position] of the [Tile]. All tiles must be in their
  /// correct position to complete the puzzle.
  final Position correctPosition;

  /// The current 2D [Position] of the [Tile].
  final Position currentPosition;

  /// The value according to the question in the correct position.
  final Pair pair;

  /// Denotes if the [Tile] is the whitespace tile or not.
  final bool isWhitespace;

  /// Create a copy of this [Tile] with updated current position.
  Tile copyWith({required Position currentPosition}) {
    return Tile(
      value: value,
      pair: pair,
      correctPosition: correctPosition,
      currentPosition: currentPosition,
      isWhitespace: isWhitespace,
    );
  }

  @override
  List<Object> get props => [
        value,
        pair,
        correctPosition,
        currentPosition,
        isWhitespace,
      ];

  // Use this to get more verbose output
  // @override
  // String toString() {
  //   return 'tile i($value) p($pair) '
  //   'cur(${currentPosition.x},${currentPosition.y}) '
  //   'fin(${correctPosition.x},${correctPosition.y})${isWhitespace ? '*' : ''} ';
  // }
}
