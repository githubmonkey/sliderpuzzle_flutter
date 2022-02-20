import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:leaders_api/leaders_api.dart';

/// A par of multipliers. For comparison, use the solution only

class Pair extends Equatable {
  /// {@macro question}
  const Pair({
    required this.left,
    required this.right,
    required this.game,
  });

  /// Left multiplier
  final int left;

  /// Right multiplier
  final int right;

  /// The challenge type
  final Game game;

  /// Calculate answer
  int get answer =>
      game == Game.addition ? left + right : left * right;

  @override
  List<Object?> get props => [
        answer,
      ];

  /// static factory
  static Pair generatePair(
    Random random,
    Game game,
    bool elevenToTwenty,
  ) {
    if (game == Game.multi ||
        game == Game.addition) {
      return Pair(
        left: random.nextInt(10) + (elevenToTwenty ? 11 : 1),
        right: random.nextInt(10) + (elevenToTwenty ? 11 : 1),
        game: game,
      );
    } else {
      return Pair(
        left: random.nextInt(100) + 1,
        right: 1,
        game: game,
      );
    }
  }
}
