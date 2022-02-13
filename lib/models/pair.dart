import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/settings/bloc/settings_bloc.dart';

/// A par of multipliers. For comparison, use the solution only

class Pair extends Equatable {
  /// {@macro question}
  const Pair({
    required this.left,
    required this.right,
    required this.encoding,
  });

  /// Left multiplier
  final int left;

  /// Right multiplier
  final int right;

  /// The challenge type
  final AnswerEncoding encoding;

  /// Calculate answer
  int get answer =>
      encoding == AnswerEncoding.addition ? left + right : left * right;

  @override
  List<Object?> get props => [
        answer,
      ];

  /// static factory
  static Pair generatePair(
      Random random, AnswerEncoding encoding, bool elevenToTwenty) {
    if (encoding == AnswerEncoding.multi ||
        encoding == AnswerEncoding.addition) {
      return Pair(
        left: random.nextInt(10) + (elevenToTwenty ? 11 : 1),
        right: random.nextInt(10) + (elevenToTwenty ? 11 : 1),
        encoding: encoding,
      );
    } else {
      return Pair(
        left: random.nextInt(100) + 1,
        right: 1,
        encoding: encoding,
      );
    }
  }
}
